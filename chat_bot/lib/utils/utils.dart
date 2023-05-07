import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Utils {

  static const String urlWebSocket = "wss://ketqualive.vnnplus.vn:8443/one2many";
  static const String prefLanguageCode = "pref_language_code";
  static const String prefThemeMode = "pref_theme_mode";

  static const List<Locale> supportedLocale = [
    Locale('en', 'US'),
    Locale('vi', 'VN')
  ];
  static const double defaultListViewItemHeight = 50;

  static final Utils instance = Utils._internal();

  late StreamController<ThemeMode> _themeMode;
  late StreamController<String> _languageCode;
  late WebSocketChannel _wsChannel;
  late Stream _wsChannelStream;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String currentLangCode = "";
  ThemeMode currentThemeMode = ThemeMode.system;

  factory Utils() {
    return instance;
  }

  Utils._internal();

  void init() {
    _languageCode = StreamController.broadcast();
    _themeMode = StreamController.broadcast();
    _wsChannel = WebSocketChannel.connect(Uri.parse(Utils.urlWebSocket));
    _wsChannelStream = _wsChannel.stream.asBroadcastStream();

    SharedPreferences.getInstance().then((value) {
      setLangCode(value.getString(Utils.prefLanguageCode) ?? "en");
      int? theme = value.getInt(Utils.prefThemeMode);
      if (theme != null) {
        if (theme == ThemeMode.system.index) {
          setThemeMode(ThemeMode.system);
        } else if (theme == ThemeMode.light.index) {
          setThemeMode(ThemeMode.light);
        } else {
          setThemeMode(ThemeMode.dark);
        }
      } else {
        setThemeMode(ThemeMode.system);
      }
    });
  }

  void dispose() {
    _wsChannel.sink.close();
    _languageCode.close();
    _themeMode.close();
  }

  void setLangCode(String code) {
    debugPrint("current lang code = $code");
    currentLangCode = code;
    _languageCode.sink.add(code);
    SharedPreferences.getInstance().then((value) {
      value.setString(Utils.prefLanguageCode, code);
    });
  }

  void setThemeMode(ThemeMode mode) {
    debugPrint("current theme mode = ${mode == ThemeMode.system ? "system" : mode == ThemeMode.light ? "light" : "dark" }");
    currentThemeMode = mode;
    _themeMode.sink.add(mode);
    SharedPreferences.getInstance().then((value) {
      value.setInt(Utils.prefThemeMode, mode.index);
    });
  }

  void sendSocketMessage(Map<String, dynamic> map) {
    debugPrint("send socket message: $map");
    _wsChannel.sink.add(jsonEncode(map));
  }

  Stream getWebSocketStream() {
    return _wsChannelStream;
  }

  Stream<String> getLangCodeStream() {
    return _languageCode.stream;
  }

  Stream<ThemeMode> getThemeModeStream() {
    return _themeMode.stream;
  }

  void goToSettingScreen() {
    navigatorKey.currentState?.pushNamed('/setting');
  }

  void goToSettingLanguageScreen() {
    navigatorKey.currentState?.pushNamed('/setting_language');
  }

  void goToPremiumScreen() {
    navigatorKey.currentState?.pushNamed('/premium');
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }

}