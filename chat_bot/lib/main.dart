import 'package:chat_bot/main_view_model.dart';
import 'package:chat_bot/screens/chat_vm.dart';
import 'package:chat_bot/utils/app_navigator.dart';
import 'package:chat_bot/utils/custom_scroll_behavior.dart';
import 'package:chat_bot/utils/app_style.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Utils.isWin32) {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow(null, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  var viewModel = MainViewModel();
  await viewModel.init();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => viewModel)
          ],
          child: const MyApp()
      )
  );
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver, WindowListener {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      WidgetsBinding.instance.addObserver(this);
      if (Utils.isWin32) {
        windowManager.addListener(this);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final materialLightTheme = ThemeData(
        useMaterial3: true,
        textTheme: AppStyle.textTheme(false),
        colorScheme: AppStyle.colorScheme,
        appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light)
    );
    final materialDarkTheme = ThemeData(
        useMaterial3: true,
        textTheme: AppStyle.textTheme(true),
        colorScheme: AppStyle.colorSchemeDark,
        appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark)
    );
    final cupertinoLightTheme = MaterialBasedCupertinoThemeData(materialTheme: materialLightTheme);
    final cupertinoDarkTheme = MaterialBasedCupertinoThemeData(materialTheme: materialDarkTheme);
    return PlatformProvider(
        settings: PlatformSettingsData(
          iosUsesMaterialWidgets: true,
          iosUseZeroPaddingForAppbarPlatformIcon: true,
        ),
        builder: (context) => PlatformTheme(
          themeMode: context.watch<MainViewModel>().currentThemeMode,
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
            scrollBehavior: CustomScrollBehavior(),
            supportedLocales: Utils.supportedLocale,
            locale: Locale(context.watch<MainViewModel>().currentLangCode),
            navigatorKey: AppNavigator.navigatorKey,
            navigatorObservers: [ AppNavigator.routeObserver ],
            initialRoute: '/',
            onGenerateRoute: (settings) => AppNavigator.generateRoute(settings),
          ),
        )
    );

  }

  @override
  void onWindowMinimize() {
    super.onWindowMinimize();
    context.read<MainViewModel>().disconnectSocket();
  }

  @override
  void onWindowRestore() {
    super.onWindowRestore();
    context.read<MainViewModel>().connectSocket();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      context.read<MainViewModel>().disconnectSocket();
    } else if (state == AppLifecycleState.resumed) {
      context.read<MainViewModel>().connectSocket();
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    if (Utils.isWin32) {
      windowManager.removeListener(this);
    }
  }

}
