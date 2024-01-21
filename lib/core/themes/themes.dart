import 'package:flutter/material.dart';

import 'colors/dark_theme_colors.dart';
import 'colors/light_theme_colors.dart';
import 'text_style/text_styles.dart';

abstract class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: DarkThemeColors.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: DarkThemeColors.appbarColor,
      actionsIconTheme: const IconThemeData(color: DarkThemeColors.textColor),
      titleTextStyle: Styles.textStyle20.copyWith(
          color: DarkThemeColors.textColor, fontWeight: FontWeight.w500),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
        primary: DarkThemeColors.greenColor,
        primaryContainer: LightThemeColors.greenColor,
    ),
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: LightThemeColors.backgroundColor,
    appBarTheme: AppBarTheme(
        backgroundColor: LightThemeColors.appbarColor,
        actionsIconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: Styles.textStyle20),
    colorScheme: const ColorScheme.light().copyWith(
        primary: LightThemeColors.backgroundColor,
        primaryContainer: LightThemeColors.greenColor),
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
    ),
  );
}
