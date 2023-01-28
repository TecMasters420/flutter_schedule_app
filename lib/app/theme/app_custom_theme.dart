import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/constants.dart';

class AppCustomTheme {
  static ThemeData lightMode = ThemeData(
    backgroundColor: backgroundColor,
    unselectedWidgetColor: grey,
    colorScheme: const ColorScheme(
      primary: blueAccent, // Accent
      background: backgroundColor, // Color de fondo
      surface: containerBg, // Color de fondo para backgrounds

      brightness: Brightness.light,
      error: red,
      errorContainer: Colors.red,

      secondary: Colors.white,
      onSecondary: Colors.white,
      onError: red,
      onBackground: backgroundColor,
      onSurface: backgroundColor,
      onPrimary: Colors.white,
    ),
    iconTheme: const IconThemeData(color: black),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: black),
      displaySmall: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white),
    ),
    scaffoldBackgroundColor: backgroundColor,
  );

  static ThemeData darkMode = lightMode.copyWith(
    scaffoldBackgroundColor: backgroundColorDark,
    iconTheme: const IconThemeData(color: textTitleColor),
    colorScheme: lightMode.colorScheme.copyWith(
      surface: containerBgDark,
      brightness: Brightness.dark,
    ),
    textTheme: lightMode.textTheme.copyWith(
      titleLarge: const TextStyle(color: textTitleColor),
      displaySmall: const TextStyle(color: textTitleColor),
    ),
  );
}
