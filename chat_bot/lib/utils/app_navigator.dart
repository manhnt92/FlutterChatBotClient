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
import 'package:provider/provider.dart';

class AppNavigator {

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  static final _routes = {
    '/': (context) => MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ChatViewModel()),
    ],
    child: const HomeScreen()),
    '/conversations': (context) => const ConversationsScreen(),
    // '/chat': (context) => const ChatScreen(),
    '/setting': (context) => const SettingScreen(),
    '/setting_language': (context) => const SettingLanguageScreen(),
    '/premium': (context) => const PremiumScreen(),
    '/privacy': (context) => WebViewScreen(url: Utils.urlPolicy),
    '/term': (context) => WebViewScreen(url: Utils.urlTerm),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {

    if (settings.name == '/chat') {
      return CupertinoPageRoute(builder: (context) {
        Conversation? conv;
        if (settings.arguments != null) {
          conv = settings.arguments as Conversation;
        }
        return MultiProvider(providers: [
          ChangeNotifierProvider(create: (_) => ChatViewModel())
        ],
        child: ChatScreen(conversation: conv));
      });
    }
    return CupertinoPageRoute(builder: (context) => _routes[settings.name]!(context));
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

  static void goToPremiumScreen() {
    navigatorKey.currentState?.pushNamed('/premium');
  }

  static void goToPrivacy() {
    if (Utils.isMobile) {
      navigatorKey.currentState?.pushNamed('/privacy');
    }
  }

  static void goToTerm() {
    if (Utils.isMobile) {
      navigatorKey.currentState?.pushNamed('/term');
    }
  }

  static void goBack() {
    navigatorKey.currentState?.pop();
  }

}