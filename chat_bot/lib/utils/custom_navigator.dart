import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomNavigator {

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void goToConversationHistory() {

  }

  static void goToSettingScreen() {
    navigatorKey.currentState?.pushNamed('/setting');
  }

  static void goToSettingLanguageScreen() {
    navigatorKey.currentState?.pushNamed('/setting_language');
  }

  static void goToPremiumScreen() {
    navigatorKey.currentState?.pushNamed('/premium');
  }

  static void goToPrivacy() {
    if (Utils.instance.os == Platforms.android || Utils.instance.os == Platforms.iOS) {
      navigatorKey.currentState?.pushNamed('/privacy');
    }
  }

  static void goToTerm() {
    if (Utils.instance.os == Platforms.android || Utils.instance.os == Platforms.iOS) {
      navigatorKey.currentState?.pushNamed('/term');
    }
  }

  static void goBack() {
    navigatorKey.currentState?.pop();
  }

}