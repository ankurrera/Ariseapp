import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoloLevelingTheme {
  // Colors derived from index.css (Dark Mode - True Dark Grayscale)
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF171717);
  static const Color primary = Color(0xFFE6E6E6);
  static const Color accent = Color(0xFF404040);

  static const Color muted = Color(0xFF262626);
  static const Color mutedForeground = Color(0xFFA3A3A3);
  static const Color border = Color(0xFF262626);
  static const Color error = Color(0xFFD93025);

  // Text Styles
  static TextStyle get gothicFont => GoogleFonts.cinzel();
  static TextStyle get systemFont => GoogleFonts.rajdhani();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: accent,
        surface: surface,
        background: background,
        error: error,
      ),
      textTheme: TextTheme(
        displayLarge: gothicFont.copyWith(fontSize: 48, fontWeight: FontWeight.bold, color: primary),
        bodyLarge: systemFont.copyWith(fontSize: 16, color: primary),
        bodyMedium: systemFont.copyWith(fontSize: 14, color: mutedForeground),
      ),
      // FIXED: Using CardThemeData instead of CardTheme for Flutter 3.27+
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: border, width: 1),
        ),
      ),
      iconTheme: const IconThemeData(color: mutedForeground),
    );
  }
}