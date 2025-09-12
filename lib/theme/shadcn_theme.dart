import 'package:flutter/material.dart';

/// Shadcn-inspired design system for Flutter
/// Provides consistent design tokens and theme configuration
class ShadcnTheme {
  // Design tokens - inspired by shadcn/ui
  static const double space1 = 4.0;
  static const double space2 = 8.0;
  static const double space3 = 12.0;
  static const double space4 = 16.0;
  static const double space5 = 20.0;
  static const double space6 = 24.0;
  static const double space8 = 32.0;
  static const double space10 = 40.0;
  static const double space12 = 48.0;
  static const double space16 = 64.0;
  static const double space20 = 80.0;

  // Border radius tokens
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;

  // Font sizes
  static const double fontSizeXs = 12.0;
  static const double fontSizeSm = 14.0;
  static const double fontSizeBase = 16.0;
  static const double fontSizeLg = 18.0;
  static const double fontSizeXl = 20.0;
  static const double fontSize2xl = 24.0;
  static const double fontSize3xl = 30.0;

  // Line heights
  static const double lineHeightTight = 1.25;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.75;

  // Colors - inspired by shadcn/ui color palette
  static const Color background = Color(0xFFFFFFFF);
  static const Color foreground = Color(0xFF0F172A);
  static const Color muted = Color(0xFFF1F5F9);
  static const Color mutedForeground = Color(0xFF64748B);
  static const Color popover = Color(0xFFFFFFFF);
  static const Color popoverForeground = Color(0xFF0F172A);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardForeground = Color(0xFF0F172A);
  static const Color border = Color(0xFFE2E8F0);
  static const Color input = Color(0xFFE2E8F0);
  static const Color primary = Color(0xFF0F172A);
  static const Color primaryForeground = Color(0xFFF8FAFC);
  static const Color secondary = Color(0xFFF1F5F9);
  static const Color secondaryForeground = Color(0xFF0F172A);
  static const Color accent = Color(0xFFF1F5F9);
  static const Color accentForeground = Color(0xFF0F172A);
  static const Color destructive = Color(0xFFEF4444);
  static const Color destructiveForeground = Color(0xFFF8FAFC);
  static const Color ring = Color(0xFF0F172A);

  // LGU-specific colors
  static const Color lguBlue = Color(0xFF1E40AF);
  static const Color lguGreen = Color(0xFF059669);
  static const Color lguOrange = Color(0xFFEA580C);
  static const Color lguRed = Color(0xFFDC2626);

  // Shadows
  static const List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 4,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 6,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> shadowLg = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 15,
      offset: Offset(0, 10),
    ),
  ];

  /// Creates a shadcn-inspired theme
  static ThemeData createTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primary,
        onPrimary: primaryForeground,
        secondary: secondary,
        onSecondary: secondaryForeground,
        surface: background,
        onSurface: foreground,
        background: background,
        onBackground: foreground,
        error: destructive,
        onError: destructiveForeground,
        outline: border,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: fontSize3xl,
          fontWeight: FontWeight.bold,
          color: foreground,
          height: lineHeightTight,
        ),
        displayMedium: TextStyle(
          fontSize: fontSize2xl,
          fontWeight: FontWeight.bold,
          color: foreground,
          height: lineHeightTight,
        ),
        displaySmall: TextStyle(
          fontSize: fontSizeXl,
          fontWeight: FontWeight.bold,
          color: foreground,
          height: lineHeightTight,
        ),
        headlineLarge: TextStyle(
          fontSize: fontSizeLg,
          fontWeight: FontWeight.semiBold,
          color: foreground,
          height: lineHeightNormal,
        ),
        headlineMedium: TextStyle(
          fontSize: fontSizeBase,
          fontWeight: FontWeight.semiBold,
          color: foreground,
          height: lineHeightNormal,
        ),
        headlineSmall: TextStyle(
          fontSize: fontSizeSm,
          fontWeight: FontWeight.semiBold,
          color: foreground,
          height: lineHeightNormal,
        ),
        bodyLarge: TextStyle(
          fontSize: fontSizeBase,
          fontWeight: FontWeight.normal,
          color: foreground,
          height: lineHeightNormal,
        ),
        bodyMedium: TextStyle(
          fontSize: fontSizeSm,
          fontWeight: FontWeight.normal,
          color: foreground,
          height: lineHeightNormal,
        ),
        bodySmall: TextStyle(
          fontSize: fontSizeXs,
          fontWeight: FontWeight.normal,
          color: mutedForeground,
          height: lineHeightNormal,
        ),
        labelLarge: TextStyle(
          fontSize: fontSizeSm,
          fontWeight: FontWeight.medium,
          color: foreground,
          height: lineHeightNormal,
        ),
        labelMedium: TextStyle(
          fontSize: fontSizeXs,
          fontWeight: FontWeight.medium,
          color: foreground,
          height: lineHeightNormal,
        ),
        labelSmall: TextStyle(
          fontSize: fontSizeXs,
          fontWeight: FontWeight.medium,
          color: mutedForeground,
          height: lineHeightNormal,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: primaryForeground,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: space4,
            vertical: space2,
          ),
          textStyle: const TextStyle(
            fontSize: fontSizeSm,
            fontWeight: FontWeight.medium,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: foreground,
          side: const BorderSide(color: border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: space4,
            vertical: space2,
          ),
          textStyle: const TextStyle(
            fontSize: fontSizeSm,
            fontWeight: FontWeight.medium,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: space4,
            vertical: space2,
          ),
          textStyle: const TextStyle(
            fontSize: fontSizeSm,
            fontWeight: FontWeight.medium,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: input),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: input),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: ring, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: destructive),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: space3,
          vertical: space2,
        ),
      ),
      cardTheme: CardTheme(
        color: card,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          side: const BorderSide(color: border),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: foreground,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontSize: fontSizeLg,
          fontWeight: FontWeight.semiBold,
          color: foreground,
        ),
      ),
    );
  }
}

/// Extension to access design tokens from BuildContext
extension ShadcnThemeExtension on BuildContext {
  ShadcnTheme get shadcn => ShadcnTheme();
}
