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

class MainViewModel with ChangeNotifier {

  String currentLangCode = "en";
  ThemeMode currentThemeMode = ThemeMode.system;
  late StreamSubscription<dynamic> _socketListener;
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
    AppWebSocket.instance.init();
    _socketListener = AppWebSocket.instance.getWebSocketStream().listen((event) {
      var message = PBCommonMessage.fromBuffer(event);
      if (message.id == 10002) {
        var loginResponse = PBLoginResponse.fromBuffer(message.dataBytes);
        // debugPrint('login response : ${loginResponse.toDebugString()}');
      } else if (message.id == 11113) {
        var config = PBConfig.fromBuffer(message.dataBytes);
        // debugPrint('config : $config');
        suggest.clear();
        suggest.addAll(config.suggestList);
        notifyListeners();
      }
    });

    _getUdId((token) {
      var message = PBCommonMessage();
      message.id = 20002;
      message.params['type'] = _createIntValue(4);
      message.params['platform'] = _createStringValue(Utils.osName);
      message.params['token'] = _createStringValue(token);
      AppWebSocket.instance.setPBCommonMessage(message);
    });
  }

  PBValue _createIntValue(int v) {
    var value = PBValue();
    value.intValue = v;
    return value;
  }

  PBValue _createStringValue(String v) {
    var value = PBValue();
    value.stringValue = v;
    return value;
  }

  void disconnectSocket() {
    _socketListener.cancel();
    AppWebSocket.instance.dispose();
  }

  void _getUdId(Function(String) callback) {
    if (Utils.isMobile) {
      FlutterUdid.consistentUdid.then((value) {
        callback(value);
      });
    } else {
      callback('984725b6c4f55963cc52fca0f943f9a8060b1c71900d542c79669b6dc718a64b');
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

}