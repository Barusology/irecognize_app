import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IRecognizeTheme {
  static const Color background = Color(0xFFFBF9F4);
  static const Color primary = Color(0xFF4E6073);
  static const Color secondary = Color(0xFF26686A);
  static const Color tertiary = Color(0xFF655E52);
  
  static const Color surface = Color(0xFFFBF9F4);
  static const Color surfaceDim = Color(0xFFD9DBCF);
  static const Color surfaceContainerLow = Color(0xFFF5F4ED);
  static const Color surfaceContainer = Color(0xFFEFEEE6);
  static const Color surfaceContainerHigh = Color(0xFFE8E9E0);
  static const Color surfaceContainerHighest = Color(0xFFE2E3D9);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  
  static const Color onSurface = Color(0xFF31332C);
  static const Color onSurfaceVariant = Color(0xFF5E6058);
  static const Color outline = Color(0xFF797C73);
  static const Color outlineVariant = Color(0xFFB1B3A9);
  
  static const Color primaryContainer = Color(0xFFD1E4FB);
  static const Color onPrimaryContainer = Color(0xFF415366);
  static const Color secondaryContainer = Color(0xFFAEEEF0);
  static const Color onSecondaryContainer = Color(0xFF125B5D);
  static const Color onPrimary = Color(0xFFF4F8FF);
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: Colors.white,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: Colors.white,
        error: Color(0xFF9F403D),
        onError: Colors.white,
        background: background,
        onBackground: onSurface,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.newsreader(color: onSurface, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.newsreader(color: onSurface, fontWeight: FontWeight.bold),
        displaySmall: GoogleFonts.newsreader(color: onSurface, fontWeight: FontWeight.bold),
        headlineLarge: GoogleFonts.newsreader(color: onSurface, fontWeight: FontWeight.bold),
        headlineMedium: GoogleFonts.newsreader(color: onSurface, fontWeight: FontWeight.bold),
        headlineSmall: GoogleFonts.newsreader(color: onSurface, fontWeight: FontWeight.bold),
        
        bodyLarge: GoogleFonts.inter(color: onSurface),
        bodyMedium: GoogleFonts.inter(color: onSurface),
        bodySmall: GoogleFonts.inter(color: onSurface),
        
        labelLarge: GoogleFonts.manrope(color: onSurface, fontWeight: FontWeight.w600),
        labelMedium: GoogleFonts.manrope(color: onSurface, fontWeight: FontWeight.w600),
        labelSmall: GoogleFonts.manrope(color: onSurface, fontWeight: FontWeight.w600),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent, 
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: onSurface),
      ),
    );
  }
}
