import 'dart:async';
import 'package:chat_bot/data/app_database.dart';
import 'package:chat_bot/data/app_web_socket.dart';
import 'package:chat_bot/models/aiapp.pb.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:flutter/material.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainViewModel with ChangeNotifier, SocketEventListener {

  String currentLangCode = "en";
  ThemeMode currentThemeMode = ThemeMode.system;
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
      MobileAds.instance.initialize();
    }
  }

  @override
  void dispose() {
    super.dispose();
    disconnectSocket();
    AppDatabase.instance.dispose();
  }

  void setLangCode(String code) {
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

  void connectSocket() {
    AppWebSocket.instance.connect();
    AppWebSocket.instance.registerEventListener(this);
  }

  void disconnectSocket() {
    AppWebSocket.instance.disconnect();
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
      debugPrint('login success: id=${loginResponse.user.dbId}');
      // debugPrint('login response : ${loginResponse.toDebugString()}');
    } else if (pbMsg.id == 11113) {
      debugPrint('config response');
      var config = PBConfig.fromBuffer(pbMsg.dataBytes);
      // debugPrint('config : $config');
      suggest.clear();
      suggest.addAll(config.suggestList);
      notifyListeners();
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

}