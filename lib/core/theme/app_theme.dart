








import 'package:flutter/material.dart';

class AppTheme {
  // Golden Brown / Beige Interior Design Palette
  static const Color primaryDark = Color(0xFF1A120B); // Deep brown
  static const Color secondaryDark = Color(0xFF3C2A21); // Chocolate brown
  static const Color cardDark = Color(0xFFD4A574); // Beige
  static const Color accentGold = Color(0xFFB68D40); // Gold
  static const Color accentCream = Color(0xFFF5E8C7); // Cream
  static const Color accentWarm = Color(0xFFA27B5C); // Warm brown
  static const Color textLight = Color(0xFFF5F5F0); // Off-white
  static const Color textMuted = Color(0xFFD6C6B2); // Muted beige
  static const Color errorRed = Color(0xFFD4A5A5);
  static const Color successGreen = Color(0xFFA5C9A5);
  static const Color warningOrange = Color(0xFFE6B87C);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [accentGold, accentWarm],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient subtleGradient = LinearGradient(
    colors: [Color(0xFF3C2A21), Color(0xFF1A120B)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [accentCream, Color(0xFFE5D9B6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Theme Data
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryDark,
      
      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: accentCream),
        titleTextStyle: const TextStyle(
          color: accentCream,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'PlayfairDisplay',
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentGold,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
          shadowColor: accentGold.withOpacity(0.5),
        ),
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: accentCream,
          fontFamily: 'PlayfairDisplay',
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: accentCream,
          fontFamily: 'PlayfairDisplay',
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: accentCream,
          fontFamily: 'PlayfairDisplay',
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: accentCream,
          fontFamily: 'Inter',
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: accentCream,
          fontFamily: 'Inter',
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textLight,
          fontFamily: 'Inter',
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textMuted,
          fontFamily: 'Inter',
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: accentCream,
          fontFamily: 'Inter',
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondaryDark.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: accentGold.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: accentGold.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: accentGold, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: errorRed),
        ),
        labelStyle: TextStyle(color: textMuted),
        hintStyle: TextStyle(color: textMuted.withOpacity(0.7)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      
      // Color Scheme
      colorScheme: ColorScheme.dark(
        primary: accentGold,
        secondary: accentWarm,
        surface: secondaryDark,
        error: errorRed,
        onPrimary: Colors.white,
        onSecondary: accentCream,
        onSurface: accentCream,
        onError: Colors.white,
      ),
    );
  }
  
  // Box Shadows
  static List<BoxShadow> glowShadow({Color? color}) {
    return [
      BoxShadow(
        color: (color ?? accentGold).withOpacity(0.2),
        blurRadius: 20,
        spreadRadius: 2,
        offset: const Offset(0, 8),
      ),
    ];
  }
  
  // Elegant Border
  static BoxDecoration elegantBorder({Color? color, double radius = 20}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: (color ?? accentGold).withOpacity(0.3),
        width: 1.5,
      ),
      boxShadow: glowShadow(color: color),
    );
  }
  
  // Card Decoration
  static BoxDecoration cardDecoration({double radius = 20}) {
    return BoxDecoration(
      gradient: cardGradient,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }
  
  // Gradient Container
  static BoxDecoration gradientContainer({double radius = 20}) {
    return BoxDecoration(
      gradient: primaryGradient,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: glowShadow(),
    );
  }
  
  // Pattern Background
  static BoxDecoration patternBackground() {
    return BoxDecoration(
      gradient: subtleGradient,
      image: const DecorationImage(
        image: AssetImage('assets/patterns/geometric.png'),
        opacity: 0.05,
        fit: BoxFit.cover,
      ),
    );
  }
}