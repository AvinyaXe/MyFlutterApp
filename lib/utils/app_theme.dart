import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF0A2540), // Deep Blue
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF0A2540), // Deep Blue
      secondary: const Color(0xFF635BFF), // Neon Blue
      surface: const Color(0xFFF5F7FA), // Soft White
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
        titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black54),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0A2540),
      elevation: 0,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: const Color(0xFF635BFF),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF0A2540), // Deep Blue
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF0A2540),
      secondary: const Color(0xFF635BFF),
      surface: const Color(0xFF121826),
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white70),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.white60),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0A2540),
      elevation: 0,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}
