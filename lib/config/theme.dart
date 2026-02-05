import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoloLevelingTheme {
  // ===========================================================================
  // LIGHT MODE COLORS (Matching index.css :root variables)
  // ===========================================================================
  static const Color lightBackground = Color(0xFFFFFFFF);      // --background: 0 0% 100%
  static const Color lightForeground = Color(0xFF383838);      // --foreground: 0 0% 22%

  static const Color lightCard = Color(0xFFFBFBF7);            // --card: 30 17% 97% (Notion-style warm off-white)
  static const Color lightCardForeground = Color(0xFF383838);

  static const Color lightMuted = Color(0xFFFBFBF7);           // --muted: 30 17% 97%
  static const Color lightMutedForeground = Color(0xFF6B6B6B); // --muted-foreground: 0 0% 42%

  static const Color lightAccent = Color(0xFFF0F0F0);          // --accent: 0 0% 94%
  static const Color lightBorder = Color(0xFFE6E6E6);          // --border: 0 0% 90%
  static const Color error = Color(0xFFD93025);

  // Keep Dark Mode colors for reference/switching
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color darkSurface = Color(0xFF212121);

  // Fonts
  static TextStyle get gothicFont => GoogleFonts.cinzel();
  static TextStyle get systemFont => GoogleFonts.rajdhani();

  // ===========================================================================
  // THEME DATA DEFINITION
  // ===========================================================================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: lightForeground,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: lightForeground,
        onPrimary: lightBackground,
        secondary: lightAccent,
        onSecondary: lightForeground,
        surface: lightCard,
        onSurface: lightForeground,
        background: lightBackground,
        onBackground: lightForeground,
        error: error,
        outline: lightBorder,
      ),

      // Typography
      textTheme: TextTheme(
        displayLarge: gothicFont.copyWith(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: lightForeground
        ),
        displayMedium: gothicFont.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: lightForeground
        ),
        titleLarge: systemFont.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: lightForeground
        ),
        bodyLarge: systemFont.copyWith(
            fontSize: 16,
            color: lightForeground
        ),
        bodyMedium: systemFont.copyWith(
            fontSize: 14,
            color: lightMutedForeground
        ),
        labelSmall: systemFont.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: lightMutedForeground
        ),
      ),

      // Card Theme (Notion-style)
      cardTheme: CardThemeData(
        color: lightCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: lightBorder, width: 1),
        ),
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: lightBackground,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: lightMutedForeground),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: lightMutedForeground,
        size: 24,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: lightBorder,
        thickness: 1,
      ),
    );
  }
}