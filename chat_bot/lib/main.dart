import 'dart:async';
import 'package:chat_bot/chat_screen.dart';
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
              fontFamily: 'Montserrat',
              appBarTheme: const AppBarTheme(color: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700),
                actionsIconTheme: IconThemeData(color: Colors.black),
              ),
              colorScheme: const ColorScheme.light(),
              dividerColor: Colors.grey
            );
            final materialDarkTheme = ThemeData(
              fontFamily: 'Montserrat',
              appBarTheme: const AppBarTheme(color: Colors.black,
                  iconTheme: IconThemeData(color: Colors.white),
                  titleTextStyle: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                  actionsIconTheme: IconThemeData(color: Colors.white)
              ),
                colorScheme: const ColorScheme.dark(),
                dividerColor: Colors.white
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
                onThemeModeChanged: (themeMode) {
                  debugPrint("on theme mode changed");
                },
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
                    '/setting_language': (context) => SettingLanguageScreen()
                  }
                ),
              )
            );
            /*return MaterialApp(
              title: 'Flutter Demo',
              themeMode: (currentThemeMode) == 0 ? ThemeMode.system : (currentThemeMode == 1 ? ThemeMode.light : ThemeMode.dark),
              theme: ThemeData(primarySwatch: Colors.blue,
                fontFamily: 'Montserrat',
                appBarTheme: const AppBarTheme(color: Colors.blueAccent,
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
                )
              ),
              darkTheme: ThemeData(primarySwatch: Colors.blueGrey,
                fontFamily: 'Montserrat',
                appBarTheme: const AppBarTheme(color: Colors.blueGrey,
                    iconTheme: IconThemeData(color: Colors.white),
                    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)
                )
              ),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('vi', 'VN'),
              ],
              locale: Locale(langCode.data ?? Utils.instance.currentLangCode),
              initialRoute: '/',
              routes: {
                '/': (context) => ChatScreen(),
                '/setting': (context) => SettingScreen()
              }
            );*/
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      // var myAppState = MyApp.of(context);
      // if (myAppState.getLanguageCode() == "vi") {
      //   myAppState.setLanguageCode("en");
      // } else {
      //   myAppState.setLanguageCode("vi");
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).home_title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(S.of(context).home_push),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
