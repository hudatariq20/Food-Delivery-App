import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Color(0xFFF5F5F5),
    colorScheme: ColorScheme(
      primary: Color(0xFF22A45D),
      //primaryVariant: Color(0xFFFE3C5B),
      secondary: Color(0xFFEF9920),
     // secondaryVariant: Color(0xFFe84545),
      background: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      error: Color(0x000000),
      brightness: Brightness.light,
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onError: Color(0xFF2b2e4a),
      onBackground: Color(0xFF2b2e4a),
      onSurface: Color(0xFF2b2e4a),
    ),
    fontFamily: 'Futura',
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      displayMedium: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      displaySmall: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headlineMedium: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headlineSmall: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      titleLarge: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      bodyMedium: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
    ),
  );
}