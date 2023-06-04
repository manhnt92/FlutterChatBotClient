import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/screens/chat_screen.dart';
import 'package:chat_bot/screens/chat_vm.dart';
import 'package:chat_bot/screens/conversation_screen.dart';
import 'package:chat_bot/screens/home_screen.dart';
import 'package:chat_bot/screens/premium_screen.dart';
import 'package:chat_bot/screens/setting_language_screen.dart';
import 'package:chat_bot/screens/setting_screen.dart';
import 'package:chat_bot/screens/webview_screen.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AppNavigator {

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  static final _routes = {
    '/': (context, params) => MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ChatViewModel()),
    ],
    child: const HomeScreen()),
    '/conversations': (context, params) => const ConversationsScreen(),
    '/chat': (context, params) {
      Conversation? conv;
      if (params != null) {
        conv = params as Conversation;
      }
      return MultiProvider(providers: [
          ChangeNotifierProvider(create: (_) => ChatViewModel())
        ],
        child: ChatScreen(conversation: conv));
    },
    '/setting': (context, params) => const SettingScreen(),
    '/setting_language': (context, params) => const SettingLanguageScreen(),
    '/premium': (context, params) => PremiumScreen(showRewardAdsOption: params),
    '/privacy': (context, params) => WebViewScreen(url: Utils.urlPolicy),
    '/term': (context, params) => WebViewScreen(url: Utils.urlTerm),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return CupertinoPageRoute(settings: settings, builder: (context) => _routes[settings.name]!(context, settings.arguments));
  }

  static Future<dynamic>? goToConversationsScreen() {
    return navigatorKey.currentState?.pushNamed('/conversations');
  }

  static void goToChatScreen(Conversation? conversation) {
    navigatorKey.currentState?.pushNamed('/chat', arguments: conversation);
  }

  static void goToSettingScreen() {
    navigatorKey.currentState?.pushNamed('/setting');
  }

  static void goToSettingLanguageScreen() {
    navigatorKey.currentState?.pushNamed('/setting_language');
  }

  static void goToPremiumScreen(bool showAdsOption) {
    navigatorKey.currentState?.pushNamedIfNotCurrent('/premium', arguments: showAdsOption);
  }

  static void goToContactUs() async {
    final Uri params = Uri(
      scheme: Utils.urlMailToScheme,
      path: Utils.urlMailTo);
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      debugPrint('Could not launch $params');
    }
  }

  static void goToPrivacy() async {
    if (Utils.isMobile) {
      // navigatorKey.currentState?.pushNamed('/privacy');
      final Uri params = Uri(
          scheme: Utils.urlPolicyScheme,
          path: Utils.urlPolicy);
      if (await canLaunchUrl(params)) {
        await launchUrl(params, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch $params');
      }
    }
  }

  static void goToTerm() async {
    if (Utils.isMobile) {
      // navigatorKey.currentState?.pushNamed('/term');
      final Uri params = Uri(
          scheme: Utils.urlTermScheme,
          path: Utils.urlTerm);
      if (await canLaunchUrl(params)) {
        await launchUrl(params, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch $params');
      }
    }
  }

  static void goBack() {
    navigatorKey.currentState?.pop();
  }

}

extension NavigatorStateExtension on NavigatorState {

  void pushNamedIfNotCurrent( String routeName, {Object? arguments} ) {
    if (!isCurrent(routeName)) {
      pushNamed( routeName, arguments: arguments );
    }
  }

  bool isCurrent(String routeName) {
    bool isCurrent = false;
    popUntil( (route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    } );
    return isCurrent;
  }

}