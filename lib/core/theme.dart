import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IRecognizeTheme {
  static const Color background = Color(0xFF090A0C);
  static const Color primary = Color(0xFFC9A66B);
  static const Color secondary = Color(0xFF8DA99A);
  static const Color tertiary = Color(0xFFD9C9A9);
  
  static const Color surface = Color(0xFF111418);
  static const Color surfaceDim = Color(0xFF090A0C);
  static const Color surfaceContainerLow = Color(0xFF15191D);
  static const Color surfaceContainer = Color(0xFF1A1F23);
  static const Color surfaceContainerHigh = Color(0xFF22282C);
  static const Color surfaceContainerHighest = Color(0xFF2B3235);
  static const Color surfaceContainerLowest = Color(0xFF101315);
  
  static const Color onSurface = Color(0xFFF2EEE5);
  static const Color onSurfaceVariant = Color(0xFFB5B0A5);
  static const Color outline = Color(0xFFA49D90);
  static const Color outlineVariant = Color(0xFF514F49);
  
  static const Color primaryContainer = Color(0xFF3A3020);
  static const Color onPrimaryContainer = Color(0xFFE8D3A8);
  static const Color secondaryContainer = Color(0xFF27362E);
  static const Color onSecondaryContainer = Color(0xFFD3E6D9);
  static const Color onPrimary = Color(0xFF17140F);
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
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
