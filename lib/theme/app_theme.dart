import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // New Color Palette
  static const Color primary1 = Color(0xFF4F47E5);
  static const Color accent1 = Color(0xFF22D3C5);
  static const Color accent2 = Color(0xFF6A5AE0);
  static const Color warning = Color(0xFFFF7A45);
  static const Color glassTint = Color(0xFFB3FFF3);
  static const Color neutralWhite = Color(0xFFFFFFFF);
  static const Color backgroundBase = Color(0xFF1E1E2F);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary1, accent1],
  );

  static const LinearGradient neonBorderGradient = LinearGradient(
    colors: [primary1, accent1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Typography
  static TextTheme get _textTheme => TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      fontSize: 32,
      height: 1.2,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      fontSize: 24,
      height: 1.2,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: 1.2,
    ),
    titleMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.4,
    ),
    bodyLarge: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.5,
    ),
    bodyMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.5,
    ),
  );

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: primary1,
    scaffoldBackgroundColor: neutralWhite,
    colorScheme: ColorScheme.light(
      primary: primary1,
      secondary: accent1,
      tertiary: accent2,
      error: warning,
      surface: neutralWhite,
      onPrimary: neutralWhite,
      onSecondary: neutralWhite,
      onSurface: backgroundBase,
    ),
    textTheme: _textTheme.apply(
      bodyColor: backgroundBase,
      displayColor: backgroundBase,
    ),
    iconTheme: const IconThemeData(color: backgroundBase),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: backgroundBase),
      titleTextStyle: _textTheme.headlineSmall?.copyWith(color: backgroundBase),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary1,
        foregroundColor: neutralWhite,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: primary1,
    scaffoldBackgroundColor: backgroundBase,
    colorScheme: ColorScheme.dark(
      primary: primary1,
      secondary: accent1,
      tertiary: accent2,
      error: warning,
      surface: const Color(0xFF2D2D44),
      onPrimary: neutralWhite,
      onSecondary: backgroundBase,
      onSurface: neutralWhite,
    ),
    textTheme: _textTheme.apply(
      bodyColor: neutralWhite,
      displayColor: neutralWhite,
    ),
    iconTheme: const IconThemeData(color: neutralWhite),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: neutralWhite),
      titleTextStyle: _textTheme.headlineSmall?.copyWith(color: neutralWhite),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary1,
        foregroundColor: neutralWhite,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  );

  // Updated Glassmorphic style constants
  static BoxDecoration glassDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.white.withOpacity(0.10), Colors.white.withOpacity(0.05)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(18),
    // Border handled in widget for gradient effect, this is fallback
    border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1), // Soft diffused shadow
        blurRadius: 24,
        offset: const Offset(0, 8),
        spreadRadius: -4,
      ),
    ],
  );
}
