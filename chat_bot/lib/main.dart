import 'dart:async';
import 'package:chat_bot/chat_screen.dart';
import 'package:chat_bot/premium_screen.dart';
import 'package:chat_bot/setting_language_screen.dart';
import 'package:chat_bot/setting_sreen.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'dart:io' show Platform;

void main() async {
  Utils.instance.init();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();

}

class MyAppState extends State<MyApp> {

  late StreamSubscription<dynamic> _socketListener;

  @override
  void initState() {
    super.initState();
    _socketListener = Utils.instance.getWebSocketStream().listen((event) {
      //debugPrint("receive event $event");
    });
    if (Platform.isWindows) {
      Map<String, dynamic> loginRq = <String, dynamic>{};
      loginRq['id'] = 'loginguest';
      loginRq['token'] = '984725b6c4f55963cc52fca0f943f9a8060b1c71900d542c79669b6dc718a64b';
      loginRq['os'] = 'android';
      Utils.instance.sendSocketMessage(loginRq);
    } else {
      FlutterUdid.consistentUdid.then((value) {
        debugPrint("token = $value");
        // Map<String, dynamic> loginRq = <String, dynamic>{};
        // loginRq['id'] = 'loginguest';
        // loginRq['token'] = value;
        // loginRq['os'] = 'android';
        // _wsChannel.sink.add(loginRq);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: Utils.instance.getLangCodeStream(),
      builder: (context, langCode) {
        return StreamBuilder<ThemeMode>(
          stream: Utils.instance.getThemeModeStream(),
          builder: (context, themeMode) {
            ThemeMode currentThemeMode = themeMode.data ?? Utils.instance.currentThemeMode;
            final materialLightTheme = ThemeData(
              useMaterial3: true,
              textTheme: CustomStyle.textTheme(),
              appBarTheme: AppBarTheme(titleTextStyle: CustomStyle.headline5B),
              colorScheme: CustomStyle.colorScheme
            );
            final materialDarkTheme = ThemeData(
              useMaterial3: true,
              textTheme: CustomStyle.textThemeDark(),
              appBarTheme: AppBarTheme(titleTextStyle: CustomStyle.headline5B),
                colorScheme: CustomStyle.colorSchemeDark
            );
            final cupertinoLightTheme = MaterialBasedCupertinoThemeData(materialTheme: materialLightTheme);
            final cupertinoDarkTheme = MaterialBasedCupertinoThemeData(materialTheme: materialDarkTheme);
            
            return PlatformProvider(
              settings: PlatformSettingsData(
                iosUsesMaterialWidgets: true,
                iosUseZeroPaddingForAppbarPlatformIcon: true,
              ),
              builder: (context) => PlatformTheme(
                themeMode: currentThemeMode,
                materialLightTheme: materialLightTheme,
                materialDarkTheme: materialDarkTheme,
                cupertinoLightTheme: cupertinoLightTheme,
                cupertinoDarkTheme: cupertinoDarkTheme,
                matchCupertinoSystemChromeBrightness: true,
                builder: (context) => PlatformApp(
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: Utils.supportedLocale,
                  locale: Locale(langCode.data ?? Utils.instance.currentLangCode),
                  navigatorKey: Utils.instance.navigatorKey,
                  initialRoute: '/setting',
                  routes: {
                    '/': (context) => ChatScreen(),
                    '/setting': (context) => SettingScreen(),
                    '/setting_language': (context) => SettingLanguageScreen(),
                    '/premium': (context) => const PremiumScreen()
                  }
                ),
              )
            );
          }
        );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _socketListener.cancel();
    Utils.instance.dispose();
  }

}
