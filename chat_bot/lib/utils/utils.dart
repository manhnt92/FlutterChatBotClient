import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:chat_bot/data/app_database.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Utils {

  static const String prefLanguageCode = "pref_language_code";
  static const String prefThemeMode = "pref_theme_mode";
  static const String prefHistory = "pref_chat_history";

  static bool isWeb = kIsWeb;
  static bool isWin32 = Platform.isWindows;
  static bool isAndroid = Platform.isAndroid;
  static bool isIOS = Platform.isIOS;
  static bool isMobile = isAndroid || isIOS;
  static bool isDebug = kDebugMode;
  static String osName = isWeb ? 'web': (isWin32 ? 'win32': (isAndroid ? 'android': 'iOS'));

  static String rewardAdUnitId = isAndroid ? 'ca-app-pub-6832904884201522/2366638181' : 'ca-app-pub-3940256099942544/1712485313';
  // static String rewardAdUnitId = isAndroid ? 'ca-app-pub-3940256099942544/5224354917' : 'ca-app-pub-3940256099942544/1712485313';

  static const List<Locale> supportedLocale = [
    Locale('en', 'US'),
    Locale('vi', 'VN')
  ];
  static const double defaultListViewItemHeight = 45;
  static const double conversationItemHeight = 110;
  static const double conversationItemWidth = 250;
  static const String urlMailToScheme = "mailto";
  static const String urlMailTo = "vegaaicompany@gmail.com";
  static const String urlPolicyScheme = "http";
  static const String urlPolicy = "h2ksolution.com/privacypolicy/vega";
  static const String urlTermScheme = "http";
  static const String urlTerm = "h2ksolution.com/privacypolicy/tosvega";
  static const int chatMaxLength = 500;

}

