import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoloLevelingTheme {
  // Colors derived from index.css (Dark Mode - True Dark Grayscale)
  static const Color background = Color(0xFF1A1A1A); // hsl(0, 0%, 10%)
  static const Color surface = Color(0xFF212121);    // hsl(0, 0%, 13%)
  static const Color primary = Color(0xFFE6E6E6);    // hsl(0, 0%, 90%)
  static const Color secondary = Color(0xFF212121);  // hsl(0, 0%, 13%)
  static const Color muted = Color(0xFF292929);      // hsl(0, 0%, 16%)
  static const Color mutedForeground = Color(0xFF8F8F8F); // hsl(0, 0%, 56%)
  static const Color border = Color(0xFF2E2E2E);     // hsl(0, 0%, 18%)
  static const Color error = Color(0xFFD93025);      // Standard error red

  // Custom System Colors
  static const Color systemGlow = Color(0xFFBDBDBD); // hsl(0, 0%, 74%)
  static const Color systemAccent = Color(0xFFBDBDBD);
  static const Color systemBarBg = Color(0xFF292929);
  static const Color systemBarFill = Color(0xFFBDBDBD);

  // Text Styles
  static TextStyle get gothicFont => GoogleFonts.cinzel();
  static TextStyle get systemFont => GoogleFonts.rajdhani();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        background: background,
        error: error,
        onPrimary: background,
        onSecondary: primary,
        onSurface: primary,
        onBackground: primary,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: gothicFont.copyWith(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: primary,
          letterSpacing: 2.0,
        ),
        displayMedium: gothicFont.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: primary,
        ),
        titleLarge: systemFont.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primary,
          letterSpacing: 1.2,
        ),
        bodyLarge: systemFont.copyWith(
          fontSize: 16,
          color: primary,
        ),
        bodyMedium: systemFont.copyWith(
          fontSize: 14,
          color: mutedForeground,
        ),
        labelSmall: systemFont.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          color: mutedForeground,
        ),
      ),

      // Card Theme
      // FIXED: Using CardThemeData instead of CardTheme to match environment types
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: border, width: 1),
        ),
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: primary,
        size: 24,
      ),
    );
  }
}