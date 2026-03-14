import 'package:flutter/material.dart';

/// Centralized text style factory using Poppins font.
abstract class AppTextStyles {
  static const String _font = 'Poppins';

  static TextStyle heading(double fontSize) => TextStyle(
    fontFamily: _font,
    fontSize: fontSize,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    letterSpacing: -0.4,
  );

  static TextStyle title(
    double fontSize, {
    Color color = const Color(0xFF0F172A),
  }) => TextStyle(
    fontFamily: _font,
    fontSize: fontSize,
    fontWeight: FontWeight.w700,
    color: color,
  );

  static TextStyle label(double fontSize, {Color color = Colors.white}) =>
      TextStyle(
        fontFamily: _font,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle body(double fontSize, {Color color = Colors.white}) =>
      TextStyle(fontFamily: _font, fontSize: fontSize, color: color);

  static TextStyle muted(double fontSize) =>
      TextStyle(fontFamily: _font, fontSize: fontSize, color: Colors.white54);
}
