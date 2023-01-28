import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/constants.dart';

class AppCustomTheme {
  static ThemeData lightMode = ThemeData(
    backgroundColor: backgroundColor,
    colorScheme: const ColorScheme(
      primary: blueAccent, // Accent
      background: backgroundColor, // Color de fondo
      surface: containerBg, // Color de fondo para backgrounds

      brightness: Brightness.light,
      error: red,
      errorContainer: Colors.red,

      secondary: darkBlueAccent,
      onSecondary: darkBlueAccent,
      onError: red,
      onBackground: backgroundColor,
      onSurface: backgroundColor,
      onPrimary: Color(0xFF0A0E21),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: black),
    ),
    scaffoldBackgroundColor: backgroundColor,
  );

  static ThemeData darkMode = lightMode.copyWith(
    scaffoldBackgroundColor: backgroundColorDark,
    colorScheme: lightMode.colorScheme.copyWith(
      surface: containerBgDark,
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white),
    ),
  );
}
