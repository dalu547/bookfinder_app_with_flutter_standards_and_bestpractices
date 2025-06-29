import 'package:flutter/material.dart';

class ThemeManager {
  static final ThemeData appTheme = ThemeData(
    primaryColor: const Color(0xFF1DBBC5),
    scaffoldBackgroundColor: Colors.white,
    dividerColor: Colors.grey.shade400,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1DBBC5),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF1DBBC5), width: 2),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color(0xFF1DBBC5),
      onPrimary: Colors.white,
      secondary: Colors.teal,
    ),
  );
}
