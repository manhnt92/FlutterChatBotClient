import 'dart:async';
import 'package:chat_bot/data/app_database.dart';
import 'package:chat_bot/data/app_web_socket.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/models/aiapp.pb.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/models/user.dart';
import 'package:chat_bot/utils/app_navigator.dart';
import 'package:chat_bot/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainViewModel with ChangeNotifier, SocketEventListener {

  String currentLangCode = "en";
  ThemeMode currentThemeMode = ThemeMode.system;
  // int userId = 0;
  // int freeMessageLeft = 0;
  // bool isPurchased = false;

  List<PBSuggest> suggest = [];
  final List<Conversation> conversations = [];

  Future<void> init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setLangCode(preferences.getString(Utils.prefLanguageCode) ?? "vi");
    int? theme = preferences.getInt(Utils.prefThemeMode);
    if (theme != null) {
      if (theme == ThemeMode.system.index) {
        setThemeMode(ThemeMode.system);
      } else if (theme == ThemeMode.light.index) {
        setThemeMode(ThemeMode.light);
      } else {
        setThemeMode(ThemeMode.dark);
      }
    } else {
      setThemeMode(ThemeMode.system); //default light
    }
    connectSocket();
    await AppDatabase.instance.init();
    if (Utils.isMobile) {
      var configuration = RequestConfiguration(testDeviceIds: [ 'F9278F0B381C12CA1012A6DB03191AF3']);
      MobileAds.instance.initialize();
      MobileAds.instance.updateRequestConfiguration(configuration);
    }
  }

  @override
  void dispose() {
    super.dispose();
    disconnectSocket();
    AppDatabase.instance.dispose();
  }

  void setLangCode(String code) {
    code = "en";
    debugPrint("current lang code = $code");
    currentLangCode = code;
    notifyListeners();
    SharedPreferences.getInstance().then((value) {
      value.setString(Utils.prefLanguageCode, code);
    });
  }

  void setThemeMode(ThemeMode mode) {
    debugPrint("current theme mode = ${mode == ThemeMode.system ? "system" : mode == ThemeMode.light ? "light" : "dark" }");
    currentThemeMode = mode;
    notifyListeners();
    SharedPreferences.getInstance().then((value) {
      value.setInt(Utils.prefThemeMode, mode.index);
    });
  }

  @override
  void onInternetConnection(bool connected) {
    if (AppNavigator.scaffoldMessengerKey.currentState == null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        onInternetConnection(connected);
      });
      return;
    }
    if (connected) {
      AppNavigator.scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    } else {
      _showSnackBar(message: S.current.toast_no_internet_connection, duration: const Duration(days: 365));
    }
  }

  void connectSocket() {
    AppWebSocket.instance.registerEventListener(this);
    AppWebSocket.instance.init();
  }

  void disconnectSocket() {
    AppWebSocket.instance.dispose();
    AppWebSocket.instance.unregisterEventListener(this);
  }

  @override
  void onWebSocketOpen() {
    if (Utils.isMobile) {
      FlutterUdid.consistentUdid.then((value) {
        AppWebSocket.instance.sendLogin(value);
      });
    } else {
      AppWebSocket.instance.sendLogin('984725b6c4f55963cc52fca0f943f9a8060b1c71900d542c79669b6dc718a64b');
    }
  }

  @override
  void onWebSocketMessage(message) {
    var pbMsg = PBCommonMessage.fromBuffer(message);
    if (pbMsg.id == 10002) {
      var loginResponse = PBLoginResponse.fromBuffer(pbMsg.dataBytes);
      User.instance.onLoginResponse(loginResponse);
      // userId = loginResponse.user.dbId;
      // freeMessageLeft = loginResponse.user.freeMsgLeft;
      // isPurchased = loginResponse.user.isPurchased;
      notifyListeners();
      if (!User.instance.isPurchased) {
        Future.delayed(const Duration(seconds: 1), () {
          AppNavigator.goToPremiumScreen(false);
        });
      }
    } else if (pbMsg.id == 11113) {
      debugPrint('config response');
      var config = PBConfig.fromBuffer(pbMsg.dataBytes);
      // debugPrint('config : $config');
      suggest.clear();
      suggest.addAll(config.suggestList);
      notifyListeners();
    } else if (pbMsg.id == 11114) {
      var userInfo = PBUser.fromBuffer(pbMsg.dataBytes);
      User.instance.updateUserInfo(userInfo);
      notifyListeners();
    } else if (pbMsg.id == 10003) { //chat response
      if (!User.instance.isPurchased && User.instance.freeMessageLeft == 0) {
        Future.delayed(const Duration(seconds: 1), () {
          AppNavigator.goToPremiumScreen(true);
        });
      }
    } else if (pbMsg.id == 11111) {
      var errorMsg = PBErrorMessage.fromBuffer(pbMsg.dataBytes);
      if (errorMsg.messageType == 1) {
        _showSnackBar(message: errorMsg.messageContent);
      }
    }
  }

  void getAllConversation() {
    AppDatabase.instance.getAllConversation().then((value) {
      conversations.clear();
      conversations.addAll(value);
      notifyListeners();
    });
  }

  void updateConversation(Conversation conv, String newTitle) {
    conv.title = newTitle;
    AppDatabase.instance.updateConversation(conv);
    notifyListeners();
  }

  void deleteConversation(Conversation conv) {
    AppDatabase.instance.deleteConversation(conv);
    conversations.remove(conv);
    notifyListeners();
  }

  void deleteAllConversation() {
    AppDatabase.instance.deleteAllConversation();
    conversations.clear();
    notifyListeners();
  }

  void _showSnackBar({required String message, Duration duration = const Duration(seconds: 3)}) {
    AppNavigator.scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(message, style: AppStyle.body2), duration: duration)
    );
  }

}