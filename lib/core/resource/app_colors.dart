import 'package:flutter/material.dart';

/// Centralized app color palette.
abstract class AppColors {
  // Primary
  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);

  // Background
  static const Color background = Color(0xFFF0F4FF);
  static const Color surface = Colors.white;

  // Header gradient
  static const Color headerStart = Color(0xFF0A1628);
  static const Color headerEnd = Color(0xFF1E3A8A);

  // Status
  static const Color success = Color(0xFF34D399);
  static const Color info = Color(0xFF60A5FA);
  static const Color purple = Color(0xFFA78BFA);
  static const Color danger = Color(0xFFEF4444);
  static const Color dangerLight = Color(0xFFFCA5A5);

  // Text
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textMuted = Colors.white54;

  // Borders
  static const Color borderLight = Color(0xFFE8F0FE);
  static const Color errorBorder = Color(0xFFFECACA);
  static const Color errorBackground = Color(0xFFFEF2F2);
  static const Color errorText = Color(0xFFB91C1C);

  static const Color white = Colors.white;
}
