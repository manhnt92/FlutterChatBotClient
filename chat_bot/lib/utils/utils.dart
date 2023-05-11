import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:chat_bot/utils/sqlite.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum Platforms {
  web, android, iOS, win32
}

class Utils {

  static final Utils instance = Utils._internal();
  factory Utils() => instance;
  Utils._internal();

  static const String urlWebSocket = "wss://ketqualive.vnnplus.vn:8443/one2many";
  static const String prefLanguageCode = "pref_language_code";
  static const String prefThemeMode = "pref_theme_mode";
  static const String prefHistory = "pref_chat_history";

  static const List<Locale> supportedLocale = [
    Locale('en', 'US'),
    Locale('vi', 'VN')
  ];
  static const double defaultListViewItemHeight = 45;
  static const double conversationItemHeight = 110;
  static const double conversationItemWidth = 250;
  static const String urlPolicy = "https://flutter.dev";
  static const String urlTerm = "https://google.com.vn";
  static const int chatMaxLength = 500;

  late StreamController<ThemeMode> _themeMode;
  late StreamController<String> _languageCode;
  late WebSocketChannel _wsChannel;
  late Stream _wsChannelStream;

  String currentLangCode = "en";
  ThemeMode currentThemeMode = ThemeMode.system;
  late Platforms os;
  late String osName;

  Future<void> init() async {
    if (kIsWeb) {
      os = Platforms.web;
      osName = 'web';
    } else {
      if (Platform.isWindows) {
        os = Platforms.win32;
        osName = 'win32';
      } else if (Platform.isAndroid) {
        os = Platforms.android;
        osName = 'android';
      } else if (Platform.isIOS) {
        os = Platforms.iOS;
        osName = 'ios';
      }
    }
    _languageCode = StreamController.broadcast();
    _themeMode = StreamController.broadcast();
    _wsChannel = WebSocketChannel.connect(Uri.parse(Utils.urlWebSocket));
    _wsChannelStream = _wsChannel.stream.asBroadcastStream();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    setLangCode(preferences.getString(Utils.prefLanguageCode) ?? "en");
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
      setThemeMode(ThemeMode.system);
    }
    await SQLite.instance.init();
  }

  void dispose() {
    _wsChannel.sink.close();
    _languageCode.close();
    _themeMode.close();
    SQLite.instance.dispose();
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

  void getUDID(Function(String) callback) {
    if (os == Platforms.iOS || os == Platforms.android) {
      FlutterUdid.consistentUdid.then((value) {
        callback(value);
      });
    } else {
      callback('984725b6c4f55963cc52fca0f943f9a8060b1c71900d542c79669b6dc718a64b');
    }
  }

}

