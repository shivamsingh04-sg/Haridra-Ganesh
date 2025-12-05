import 'package:flutter/material.dart';

class TempleColors {
  // Primary Colors
  static const Color saffron = Color(0xFFFF9933);
  static const Color goldenSaffron = Color(0xFFFFB84D);
  static const Color warmGold = Color(0xFFD4A574);

  // Background Colors
  static const Color softCream = Color(0xFFFFF8F0);
  static const Color lightSaffronTint = Color(0xFFFFF5E6);
  static const Color lightPeach = Color(0xFFFFE5CC);
  static const Color softBeige = Color(0xFFFFF0DC);

  // Text Colors
  static const Color primaryBrown = Color(0xFF8B4513);
  static const Color secondaryBrown = Color(0xFF6B5B4B);

  // Accent Colors
  static const Color accentRed = Color(0xFFFF6B6B);
  static const Color white = Colors.white;

  // Opacity helpers
  static Color saffronLight(double opacity) => saffron.withOpacity(opacity);
  static Color warmGoldLight(double opacity) => warmGold.withOpacity(opacity);
}
