import 'dart:async';
import 'dart:convert';
import 'package:chat_bot/utils/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:google_fonts/google_fonts.dart';

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

class CustomStyle {

  /// The 2018 spec has thirteen text styles:
  ///
  /// | NAME       | SIZE |  WEIGHT |  SPACING |             |
  /// |------------|------|---------|----------|-------------|
  /// | headline1  | 96.0 | light   | -1.5     |             |
  /// | headline2  | 60.0 | light   | -0.5     |             |
  /// | headline3  | 48.0 | regular |  0.0     |             |
  /// | headline4  | 34.0 | regular |  0.25    |             |
  /// | headline5  | 24.0 | regular |  0.0     |             |
  /// | headline6  | 20.0 | medium  |  0.15    |             |
  /// | subtitle1  | 16.0 | regular |  0.15    |             |
  /// | subtitle2  | 14.0 | medium  |  0.1     |             |
  /// | body1      | 16.0 | regular |  0.5     | (bodyText1) |
  /// | body2      | 14.0 | regular |  0.25    | (bodyText2) |
  /// | button     | 14.0 | medium  |  1.25    |             |
  /// | caption    | 12.0 | regular |  0.4     |             |
  /// | overline   | 10.0 | regular |  1.5     |             |
  /// ...where "light" is `FontWeight.w300`, "regular" is `FontWeight.w400` and
  /// "medium" is `FontWeight.w500`.

  static TextStyle headline1 = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 96.0, fontWeight: FontWeight.w300, letterSpacing: -1.5));
  static TextStyle headline2 = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 60.0, fontWeight: FontWeight.w300, letterSpacing: -0.5));
  static TextStyle headline3 = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.w400, letterSpacing: 0.0));
  static TextStyle headlineLarge = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.w400));
  static TextStyle headline4 = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 34.0, fontWeight: FontWeight.w400, letterSpacing: 0.25));
  static TextStyle headline5 = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400, letterSpacing: 0.0));
  static TextStyle headline6 = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, letterSpacing: 0.15));
  static TextStyle subtitle1 = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.15));
  static TextStyle subtitle2 = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.1));
  static TextStyle body1 = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.5));
  static TextStyle body2 = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: 0.25));
  static TextStyle button = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 1.25));
  static TextStyle caption = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, letterSpacing: 0.4));
  static TextStyle labelMedium = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400));
  static TextStyle overline = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400, letterSpacing: 1.5));

  static TextStyle headline1I = headline1.apply(fontStyle: FontStyle.italic);
  static TextStyle headline2I = headline2.apply(fontStyle: FontStyle.italic);
  static TextStyle headline3I = headline3.apply(fontStyle: FontStyle.italic);
  static TextStyle headlineLargeI = headlineLarge.apply(fontStyle: FontStyle.italic);
  static TextStyle headline4I = headline4.apply(fontStyle: FontStyle.italic);
  static TextStyle headline5I = headline5.apply(fontStyle: FontStyle.italic);
  static TextStyle headline6I = headline6.apply(fontStyle: FontStyle.italic);
  static TextStyle subtitle1I = subtitle1.apply(fontStyle: FontStyle.italic);
  static TextStyle subtitle2I = subtitle2.apply(fontStyle: FontStyle.italic);
  static TextStyle body1I = body1.apply(fontStyle: FontStyle.italic);
  static TextStyle body2I = body2.apply(fontStyle: FontStyle.italic);
  static TextStyle buttonI = button.apply(fontStyle: FontStyle.italic);
  static TextStyle captionI = caption.apply(fontStyle: FontStyle.italic);
  static TextStyle labelMediumI = labelMedium.apply(fontStyle: FontStyle.italic);
  static TextStyle overlineI = overline.apply(fontStyle: FontStyle.italic);

  static TextStyle headline1B = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 96.0, fontWeight: FontWeight.w600, letterSpacing: -1.5));
  static TextStyle headline2B = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 60.0, fontWeight: FontWeight.w600, letterSpacing: -0.5));
  static TextStyle headline3B = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.w700, letterSpacing: 0.0));
  static TextStyle headlineLargeB = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700));
  static TextStyle headline4B = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 34.0, fontWeight: FontWeight.w700, letterSpacing: 0.25));
  static TextStyle headline5B = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, letterSpacing: 0.0));
  static TextStyle headline6B = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800, letterSpacing: 0.15));
  static TextStyle subtitle1B = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, letterSpacing: 0.15));
  static TextStyle subtitle2B = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800, letterSpacing: 0.1));
  static TextStyle body1B = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, letterSpacing: 0.5));
  static TextStyle body2B = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, letterSpacing: 0.25));
  static TextStyle buttonB = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800, letterSpacing: 1.25));
  static TextStyle captionB = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, letterSpacing: 0.4));
  static TextStyle labelMediumB = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700));
  static TextStyle overlineB = GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, letterSpacing: 1.5));

  static TextStyle headline1BI = headline1B.apply(fontStyle: FontStyle.italic);
  static TextStyle headline2BI = headline2B.apply(fontStyle: FontStyle.italic);
  static TextStyle headline3BI = headline3B.apply(fontStyle: FontStyle.italic);
  static TextStyle headlineLargeBI = headlineLargeB.apply(fontStyle: FontStyle.italic);
  static TextStyle headline4BI = headline4B.apply(fontStyle: FontStyle.italic);
  static TextStyle headline5BI = headline5B.apply(fontStyle: FontStyle.italic);
  static TextStyle headline6BI = headline6B.apply(fontStyle: FontStyle.italic);
  static TextStyle subtitle1BI = subtitle1B.apply(fontStyle: FontStyle.italic);
  static TextStyle subtitle2BI = subtitle2B.apply(fontStyle: FontStyle.italic);
  static TextStyle body1BI = body1B.apply(fontStyle: FontStyle.italic);
  static TextStyle body2BI = body2B.apply(fontStyle: FontStyle.italic);
  static TextStyle buttonBI = buttonB.apply(fontStyle: FontStyle.italic);
  static TextStyle captionBI = captionB.apply(fontStyle: FontStyle.italic);
  static TextStyle labelMediumBI = labelMediumB.apply(fontStyle: FontStyle.italic);
  static TextStyle overlineBI = overlineB.apply(fontStyle: FontStyle.italic);

  static TextTheme textTheme() {
    /*var color = Colors.black;
    return TextTheme(displayLarge: headline1.apply(color: color),
      displayMedium: headline2.apply(color: color),
      displaySmall: headline3.apply(color: color),
      headlineLarge: headlineLarge.apply(color: color),
      headlineMedium: headline4.apply(color: color),
      headlineSmall: headline5.apply(color: color),
      titleLarge: headline6.apply(color: color),
      titleMedium: subtitle1.apply(color: color),
      titleSmall: subtitle2.apply(color: color),
      bodyLarge: body1.apply(color: color),
      bodyMedium: body2.apply(color: color),
      bodySmall: caption.apply(color: color),
      labelLarge: button.apply(color: color),
      labelMedium: labelMedium.apply(color: color),
      labelSmall: overline.apply(color: color)
    );*/
    return TextTheme(displayLarge: headline1,
        displayMedium: headline2,
        displaySmall: headline3,
        headlineLarge: headlineLarge,
        headlineMedium: headline4,
        headlineSmall: headline5,
        titleLarge: headline6,
        titleMedium: subtitle1,
        titleSmall: subtitle2,
        bodyLarge: body1,
        bodyMedium: body2,
        bodySmall: caption,
        labelLarge: button,
        labelMedium: labelMedium,
        labelSmall: overline
    );
  }

  static TextTheme textThemeDark() {
    /*var color = Colors.white;
    return TextTheme(displayLarge: headline1.apply(color: color),
        displayMedium: headline2.apply(color: color),
        displaySmall: headline3.apply(color: color),
        headlineLarge: headlineLarge.apply(color: color),
        headlineMedium: headline4.apply(color: color),
        headlineSmall: headline5.apply(color: color),
        titleLarge: headline6.apply(color: color),
        titleMedium: subtitle1.apply(color: color),
        titleSmall: subtitle2.apply(color: color),
        bodyLarge: body1.apply(color: color),
        bodyMedium: body2.apply(color: color),
        bodySmall: caption.apply(color: color),
        labelLarge: button.apply(color: color),
        labelMedium: labelMedium.apply(color: color),
        labelSmall: overline.apply(color: color)
    );*/
    return TextTheme(displayLarge: headline1,
        displayMedium: headline2,
        displaySmall: headline3,
        headlineLarge: headlineLarge,
        headlineMedium: headline4,
        headlineSmall: headline5,
        titleLarge: headline6,
        titleMedium: subtitle1,
        titleSmall: subtitle2,
        bodyLarge: body1,
        bodyMedium: body2,
        bodySmall: caption,
        labelLarge: button,
        labelMedium: labelMedium,
        labelSmall: overline
    );
  }

  // static const MaterialColor primarySwatch = MaterialColor(0xFF386A20, {
  //   50: Color(0xFFF6F8F4),
  //   100: Color(0xFFECF1E9),
  //   200: Color(0xFFCEDAC8),
  //   300: Color(0xFFAEC2A4),
  //   400: Color(0xFF749763),
  //   500: Color(0xFF386A20),
  //   600: Color(0xFF325F1D),
  //   700: Color(0xFF224014),
  //   800: Color(0xFF1A300F),
  //   900: Color(0xFF111F0A),
  // });
  //
  // static const MaterialColor primarySwatchDark = MaterialColor(0xFF1A1C18, {
  //   50: Color(0xFFF4F4F4),
  //   100: Color(0xFFE9E9E8),
  //   200: Color(0xFFC6C7C6),
  //   300: Color(0xFFA2A2A1),
  //   400: Color(0xFF5F615E),
  //   500: Color(0xFF1A1C18),
  //   600: Color(0xFF181916),
  //   700: Color(0xFF10110F),
  //   800: Color(0xFF0C0D0B),
  //   900: Color(0xFF080907),
  // });

  static ColorScheme colorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF006A6A),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF6FF7F6),
    onPrimaryContainer: Color(0xFF002020),
    secondary: Color(0xFF00696F),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFF79F5FF),
    onSecondaryContainer: Color(0xFF002022),
    tertiary: Color(0xFF596400),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFDDEB78),
    onTertiaryContainer: Color(0xFF1A1E00),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFFFBFF),
    onBackground: Color(0xFF3E0021),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF3E0021),
    surfaceVariant: Color(0xFFDAE5E4),
    onSurfaceVariant: Color(0xFF3F4948),
    outline: Color(0xFF6F7979),
    onInverseSurface: Color(0xFFFFECF0),
    inverseSurface: Color(0xFF5D1137),
    inversePrimary: Color(0xFF4CDADA),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF006A6A),
    outlineVariant: Color(0xFFBEC9C8),
    scrim: Color(0xFF000000),
  );

  static ColorScheme colorSchemeDark = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF4CDADA),
    onPrimary: Color(0xFF003737),
    primaryContainer: Color(0xFF004F4F),
    onPrimaryContainer: Color(0xFF6FF7F6),
    secondary: Color(0xFF4DD9E4),
    onSecondary: Color(0xFF00363A),
    secondaryContainer: Color(0xFF004F54),
    onSecondaryContainer: Color(0xFF79F5FF),
    tertiary: Color(0xFFC1CF5F),
    onTertiary: Color(0xFF2D3400),
    tertiaryContainer: Color(0xFF434B00),
    onTertiaryContainer: Color(0xFFDDEB78),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF3E0021),
    onBackground: Color(0xFFFFD9E4),
    surface: Color(0xFF3E0021),
    onSurface: Color(0xFFFFD9E4),
    surfaceVariant: Color(0xFF3F4948),
    onSurfaceVariant: Color(0xFFBEC9C8),
    outline: Color(0xFF889392),
    onInverseSurface: Color(0xFF3E0021),
    inverseSurface: Color(0xFFFFD9E4),
    inversePrimary: Color(0xFF006A6A),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF4CDADA),
    outlineVariant: Color(0xFF3F4948),
    scrim: Color(0xFF000000),
  );

}