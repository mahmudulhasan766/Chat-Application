import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  const AppTheme._();

   static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff335c67),
      surface: const Color(0xfff7f8f5),
    ),
    scaffoldBackgroundColor: const Color(0xfff7f8f5),
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xffd8ded9)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xffd8ded9)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xff335c67), width: 1.5),
      ),
    ),
  );
   static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff8fc1b5),
      brightness: Brightness.dark,
      surface: const Color(0xff172326),
    ),
    scaffoldBackgroundColor: const Color(0xff101719),
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xff1b292c),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

}
