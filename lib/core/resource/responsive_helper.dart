import 'package:flutter/material.dart';

/// Responsive helper that scales sizes based on screen dimensions.
///
/// Usage:
/// ```dart
/// final r = ResponsiveHelper(context);
/// Text('Hello', style: TextStyle(fontSize: r.fs(16)));
/// SizedBox(height: r.sp(12));
/// ```
class ResponsiveHelper {
  final double w;
  final double h;

  ResponsiveHelper(BuildContext context)
    : w = MediaQuery.of(context).size.width,
      h = MediaQuery.of(context).size.height;

  double fs(double size) => (size * w / 390).clamp(size * 0.78, size * 1.18);

  double sp(double size) => (size * h / 844).clamp(size * 0.58, size * 1.22);

  bool get isSmall => h < 680;
  bool get isTiny => h < 600;
}
