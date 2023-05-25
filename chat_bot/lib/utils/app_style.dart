import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chat_bot/utils/hexcolor.dart';

class AppStyle {

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

  static TextStyle headline1 = getTextStyle(textStyle: const TextStyle(fontSize: 96.0, fontWeight: FontWeight.w300, letterSpacing: -1.5));
  static TextStyle headline2 = getTextStyle(textStyle: const TextStyle(fontSize: 60.0, fontWeight: FontWeight.w300, letterSpacing: -0.5));
  static TextStyle headline3 = getTextStyle(textStyle: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.w400, letterSpacing: 0.0));
  static TextStyle headlineLarge = getTextStyle(textStyle: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.w400));
  static TextStyle headline4 = getTextStyle(textStyle: const TextStyle(fontSize: 34.0, fontWeight: FontWeight.w400, letterSpacing: 0.25));
  static TextStyle headline5 = getTextStyle(textStyle: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400, letterSpacing: 0.0));
  static TextStyle headline6 = getTextStyle(textStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, letterSpacing: 0.15));
  static TextStyle subtitle1 = getTextStyle(textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.15));
  static TextStyle subtitle2 = getTextStyle(textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.1));
  static TextStyle body1 = getTextStyle(textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.5));
  static TextStyle body2 = getTextStyle(textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: 0.25));
  static TextStyle button = getTextStyle(textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 1.25));
  static TextStyle caption = getTextStyle(textStyle: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, letterSpacing: 0.4));
  static TextStyle labelMedium = getTextStyle(textStyle: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400));
  static TextStyle overline = getTextStyle(textStyle: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400, letterSpacing: 1.5));

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

  static TextStyle headline1B = getTextStyle(textStyle: const TextStyle(fontSize: 96.0, fontWeight: FontWeight.w600, letterSpacing: -1.5));
  static TextStyle headline2B = getTextStyle(textStyle: const TextStyle(fontSize: 60.0, fontWeight: FontWeight.w600, letterSpacing: -0.5));
  static TextStyle headline3B = getTextStyle(textStyle: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.w700, letterSpacing: 0.0));
  static TextStyle headlineLargeB = getTextStyle(textStyle: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700));
  static TextStyle headline4B = getTextStyle(textStyle: const TextStyle(fontSize: 34.0, fontWeight: FontWeight.w700, letterSpacing: 0.25));
  static TextStyle headline5B = getTextStyle(textStyle: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, letterSpacing: 0.0));
  static TextStyle headline6B = getTextStyle(textStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800, letterSpacing: 0.15));
  static TextStyle subtitle1B = getTextStyle(textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, letterSpacing: 0.15));
  static TextStyle subtitle2B = getTextStyle(textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800, letterSpacing: 0.1));
  static TextStyle body1B = getTextStyle(textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, letterSpacing: 0.5));
  static TextStyle body2B = getTextStyle(textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, letterSpacing: 0.25));
  static TextStyle buttonB = getTextStyle(textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800, letterSpacing: 1.25));
  static TextStyle captionB = getTextStyle(textStyle: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, letterSpacing: 0.4));
  static TextStyle labelMediumB = getTextStyle(textStyle: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700));
  static TextStyle overlineB = getTextStyle(textStyle: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, letterSpacing: 1.5));

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

  static TextStyle getTextStyle({required TextStyle textStyle}) {
    return GoogleFonts.montserrat(textStyle: textStyle);
  }

  static TextTheme textTheme(bool darkMode) {
    /*var color = isDark ? Colors.white : Colors.black;
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

  // static ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 106, 106), brightness: Brightness.light);
  static ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: HexColor("#141227"), brightness: Brightness.light);
  // static ColorScheme colorSchemeDark = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 106, 106), brightness: Brightness.dark);
  static ColorScheme colorSchemeDark = ColorScheme.fromSeed(seedColor: HexColor("#141227"), brightness: Brightness.dark);

  static Color colorBgElevatedButton(BuildContext context, bool isSelected) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      return isSelected ? AppStyle.colorSchemeDark.surfaceTint.withAlpha(48) : AppStyle.colorSchemeDark.surfaceTint.withAlpha(12);
    }
    return isSelected ? AppStyle.colorScheme.surfaceTint.withAlpha(48) : AppStyle.colorScheme.surfaceTint.withAlpha(12);
  }

  static Color colorExpandableTextField(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      return AppStyle.colorSchemeDark.surfaceTint.withAlpha(48);
    }
    return AppStyle.colorScheme.surfaceTint.withAlpha(48);
  }

  static Color bgColorButton(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      return AppStyle.colorSchemeDark.primary;
    }
    return AppStyle.colorScheme.primary;
  }

  static Color colorBorder(BuildContext context, bool isSelected) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      return isSelected ? AppStyle.colorSchemeDark.surfaceTint.withAlpha(122) : Colors.transparent;
    }
    return isSelected ? AppStyle.colorScheme.surfaceTint.withAlpha(122) : Colors.transparent;
  }

}