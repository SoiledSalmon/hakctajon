import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appThemeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

class AppTheme {
  static const Color primary1 = Color(0xFF4F47E5);
  static const Color primary2 = Color(0xFF22D3C5);
  static const Color primary3 = Color(0xFF6A5AE0);

  static const Color accent1 = Color(0xFFFF7A45);
  static const Color accent2 = Color(0xFFB3FFF3);

  static const Color neutralWhite = Color(0xFFFFFFFF);
  static const Color neutralDark = Color(0xFF1E1E2F);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary1, primary2],
    transform: GradientRotation(3 * 3.1415926 / 4), // 135 degrees
  );

  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: primary1,
        scaffoldBackgroundColor: neutralWhite,
        colorScheme: ColorScheme.light(
          primary: primary1,
          secondary: accent1,
          surface: neutralWhite,
          onPrimary: neutralWhite,
          onSecondary: neutralWhite,
          onSurface: neutralDark,
        ),
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 32, color: neutralDark),
          headlineMedium: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 24, color: neutralDark),
          headlineSmall: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 20, color: neutralDark),
          bodyLarge: GoogleFonts.inter(
              fontWeight: FontWeight.w400, fontSize: 16, color: neutralDark),
          bodyMedium: GoogleFonts.inter(
              fontWeight: FontWeight.w400, fontSize: 14, color: neutralDark),
          labelMedium: GoogleFonts.inter(
              fontWeight: FontWeight.w500, fontSize: 14, color: neutralDark),
        ),
        iconTheme: const IconThemeData(color: neutralDark),
        appBarTheme: const AppBarTheme(
          backgroundColor: neutralWhite,
          elevation: 0,
          iconTheme: IconThemeData(color: neutralDark),
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: neutralDark,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary1,
            foregroundColor: neutralWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
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
        scaffoldBackgroundColor: neutralDark,
        colorScheme: ColorScheme.dark(
          primary: primary1,
          secondary: accent1,
          surface: Color(0xFF2B2B42),
          onPrimary: neutralWhite,
          onSecondary: neutralWhite,
          onSurface: neutralWhite,
        ),
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 32, color: neutralWhite),
          headlineMedium: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 24, color: neutralWhite),
          headlineSmall: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 20, color: neutralWhite),
          bodyLarge: GoogleFonts.inter(
              fontWeight: FontWeight.w400, fontSize: 16, color: neutralWhite),
          bodyMedium: GoogleFonts.inter(
              fontWeight: FontWeight.w400, fontSize: 14, color: neutralWhite),
          labelMedium: GoogleFonts.inter(
              fontWeight: FontWeight.w500, fontSize: 14, color: neutralWhite),
        ),
        iconTheme: const IconThemeData(color: neutralWhite),
        appBarTheme: const AppBarTheme(
          backgroundColor: neutralDark,
          elevation: 0,
          iconTheme: IconThemeData(color: neutralWhite),
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: neutralWhite,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary1,
            foregroundColor: neutralWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      );

  // Glassmorphic style constants
  static BoxDecoration glassDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.white.withOpacity(0.15),
        Colors.white.withOpacity(0.05),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: Colors.white.withOpacity(0.2),
      width: 1.0,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 4),
      ),
    ],
  );
}
