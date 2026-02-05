import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoloLevelingTheme {
  // ===========================================================================
  // LIGHT MODE CONSTANTS (Source of Truth)
  // ===========================================================================
  static const Color _lightBackground = Color(0xFFFFFFFF);
  static const Color _lightForeground = Color(0xFF383838);
  static const Color _lightCard = Color(0xFFFBFBF7);
  static const Color _lightMuted = Color(0xFFFBFBF7);
  static const Color _lightMutedForeground = Color(0xFF6B6B6B);
  static const Color _lightAccent = Color(0xFFF0F0F0);
  static const Color _lightBorder = Color(0xFFE6E6E6);
  static const Color _error = Color(0xFFD93025);

  // ===========================================================================
  // GLOBAL GETTERS (Restored for Backward Compatibility)
  // ===========================================================================
  // These are static const so they can be used as default values in constructors
  static const Color background = _lightBackground;
  static const Color surface = _lightCard;
  static const Color primary = _lightForeground;
  static const Color secondary = _lightForeground;
  static const Color accent = _lightAccent;
  static const Color muted = _lightMuted;
  static const Color mutedForeground = _lightMutedForeground;
  static const Color border = _lightBorder;
  static const Color error = _error;

  // Custom System Colors (Mapped to Light Mode)
  static const Color systemGlow = _lightForeground;
  static const Color systemAccent = _lightMutedForeground;
  static const Color systemBarBg = _lightBorder;
  static const Color systemBarFill = _lightForeground;

  // Fonts
  static TextStyle get gothicFont => GoogleFonts.cinzel();
  static TextStyle get systemFont => GoogleFonts.rajdhani();

  // ===========================================================================
  // THEME DATA
  // ===========================================================================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _lightBackground,
      primaryColor: _lightForeground,

      colorScheme: const ColorScheme.light(
        primary: _lightForeground,
        onPrimary: _lightBackground,
        secondary: _lightAccent,
        onSecondary: _lightForeground,
        surface: _lightCard,
        onSurface: _lightForeground,
        background: _lightBackground,
        onBackground: _lightForeground,
        error: _error,
        outline: _lightBorder,
      ),

      textTheme: TextTheme(
        displayLarge: gothicFont.copyWith(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: _lightForeground
        ),
        displayMedium: gothicFont.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: _lightForeground
        ),
        titleLarge: systemFont.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: _lightForeground
        ),
        bodyLarge: systemFont.copyWith(
            fontSize: 16,
            color: _lightForeground
        ),
        bodyMedium: systemFont.copyWith(
            fontSize: 14,
            color: _lightMutedForeground
        ),
        labelSmall: systemFont.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: _lightMutedForeground
        ),
      ),

      cardTheme: CardThemeData(
        color: _lightCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: _lightBorder, width: 1),
        ),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: _lightBackground,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: _lightMutedForeground),
      ),

      iconTheme: const IconThemeData(
        color: _lightMutedForeground,
        size: 24,
      ),

      dividerTheme: const DividerThemeData(
        color: _lightBorder,
        thickness: 1,
      ),
    );
  }
}