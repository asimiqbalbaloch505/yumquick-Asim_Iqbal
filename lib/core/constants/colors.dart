import 'package:flutter/material.dart';

class AppColors {
  // Original Base Palette
  static const Color primary = Color(0xFFE95322);
  static const Color secondary = Color(0xFFF5A623);
  static const Color accentYellow = Color(0xFFF3E9B5);
  static const Color background = Color(0xFFFFF8ED);
  static const Color white = Colors.white;
  static const Color textDark = Color(0xFF333333);
  static const Color textMuted = Color(0xFF8C8C8C);
  static const Color inputBackground = Color(0xFFF7F7F7);
  static const Color border = Color(0xFFE2E2E2);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);

  // Screen Aliases (for explicit Figma screen mapping)
  static const Color splashBackground = secondary;      // #F5A623 (Yellow)
  static const Color welcomeBackground = primary;        // #E95322 (Orange)
  static const Color buttonLight = accentYellow;         // #F3E9B5 (Cream/Yellow)
}