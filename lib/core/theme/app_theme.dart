import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color deepTeal = Color(0xFF3D8D7A); // Primary
  static const Color mintGreen = Color(0xFFB3D8A8); // Secondary / Success
  static const Color cream = Color(0xFFFBFFE4); // Background
  static const Color sage = Color(0xFFA3D1C6); // Accent

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: cream,
      primaryColor: deepTeal,
      colorScheme: ColorScheme.fromSeed(
        seedColor: deepTeal,
        primary: deepTeal,
        secondary: mintGreen,
        surface: cream, // Was background
        error: const Color(0xFFE57373),
      ),

      // Text Theme
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: const TextStyle(
          color: deepTeal,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: const TextStyle(
          color: deepTeal,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: const TextStyle(color: Color(0xFF2C3E50)),
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: deepTeal,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: deepTeal, width: 2),
        ),
      ),
    );
  }
}
