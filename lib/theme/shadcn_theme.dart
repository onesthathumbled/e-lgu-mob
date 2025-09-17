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

  // Border radius tokens - More rounded for modern look
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radius2xl = 24.0;

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

  // Colors - Modern Clean Design
  // Primary: Bright Green (#34C759), Clean whites and grays
  static const Color background = Color(0xFFFFFFFF); // Pure white
  static const Color foreground = Color(0xFF1A1A1A); // Dark gray for text
  static const Color muted = Color(0xFFF8F9FA); // Very light gray
  static const Color mutedForeground = Color(0xFF6B7280); // Medium gray
  static const Color popover = Color(0xFFFFFFFF); // White
  static const Color popoverForeground = Color(0xFF1A1A1A); // Dark gray
  static const Color card = Color(0xFFFFFFFF); // White
  static const Color cardForeground = Color(0xFF1A1A1A); // Dark gray
  static const Color border = Color(0xFFE5E7EB); // Light border
  static const Color input = Color(0xFFF3F4F6); // Light input background
  static const Color primary = Color(0xFF34C759); // Bright Green - Primary
  static const Color primaryForeground = Color(0xFFFFFFFF); // White text on green
  static const Color secondary = Color(0xFFF3F4F6); // Light gray
  static const Color secondaryForeground = Color(0xFF1A1A1A); // Dark text on gray
  static const Color accent = Color(0xFF34C759); // Same as primary
  static const Color accentForeground = Color(0xFFFFFFFF); // White text
  static const Color destructive = Color(0xFFDC2626); // Red for errors
  static const Color destructiveForeground = Color(0xFFFFFFFF); // White text
  static const Color ring = Color(0xFF34C759); // Bright Green

  // Modern accent colors for variety
  static const Color success = Color(0xFF34C759); // Green for success
  static const Color warning = Color(0xFFF59E0B); // Orange for warnings
  static const Color info = Color(0xFF3B82F6); // Blue for info
  
  // Task/Icon colors for variety
  static const Color taskOrange = Color(0xFFEA580C); // Orange for tasks
  static const Color taskBlue = Color(0xFF3B82F6); // Blue for tasks
  static const Color taskPink = Color(0xFFEC4899); // Pink for tasks
  static const Color taskPurple = Color(0xFF8B5CF6); // Purple for tasks
  
  // Filipino Flag specific colors (kept for cultural elements)
  static const Color filipinoBlue = Color(0xFF0038A8); // Official Philippine Flag Blue
  static const Color filipinoRed = Color(0xFFCE1126); // Official Philippine Flag Red
  static const Color filipinoWhite = Color(0xFFFFFFFF); // White
  static const Color filipinoYellow = Color(0xFFFCD116); // Official Philippine Flag Yellow
  
  // LGU themed colors (updated to match modern design)
  static const Color lguBlue = Color(0xFF0038A8); // Keep for government elements
  static const Color lguGreen = Color(0xFF34C759); // Updated to match primary
  static const Color lguOrange = Color(0xFFEA580C); // Keep orange for warnings
  static const Color lguRed = Color(0xFFCE1126); // Keep red for alerts

  // Shadows - Softer, more modern shadows
  static const List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Color(0x08000000),
      blurRadius: 4,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> shadowLg = [
    BoxShadow(
      color: Color(0x0C000000),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> shadowXl = [
    BoxShadow(
      color: Color(0x10000000),
      blurRadius: 24,
      offset: Offset(0, 8),
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
          fontWeight: FontWeight.w600,
          color: foreground,
          height: lineHeightNormal,
        ),
        headlineMedium: TextStyle(
          fontSize: fontSizeBase,
          fontWeight: FontWeight.w600,
          color: foreground,
          height: lineHeightNormal,
        ),
        headlineSmall: TextStyle(
          fontSize: fontSizeSm,
          fontWeight: FontWeight.w600,
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
          fontWeight: FontWeight.w500,
          color: foreground,
          height: lineHeightNormal,
        ),
        labelMedium: TextStyle(
          fontSize: fontSizeXs,
          fontWeight: FontWeight.w500,
          color: foreground,
          height: lineHeightNormal,
        ),
        labelSmall: TextStyle(
          fontSize: fontSizeXs,
          fontWeight: FontWeight.w500,
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
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: space6,
            vertical: space3,
          ),
          textStyle: const TextStyle(
            fontSize: fontSizeBase,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: foreground,
          side: const BorderSide(color: border, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: space6,
            vertical: space3,
          ),
          textStyle: const TextStyle(
            fontSize: fontSizeBase,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: space6,
            vertical: space3,
          ),
          textStyle: const TextStyle(
            fontSize: fontSizeBase,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: input,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: ring, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: destructive, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: space4,
          vertical: space3,
        ),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          side: const BorderSide(color: border, width: 0.5),
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
          fontWeight: FontWeight.w600,
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

