import 'package:flutter/material.dart';

class AppColors {
  // Neutral Colors
  static const Color color = Color(0xFFD9D9D9);
  static const Color background = Color(0xFFF8FCFE);
  static const Color darkGray = Color(0xFF202020);
  static const Color darkGrey = Color(0xFF413E3E);
  static const Color mediumGray = Color(0xFF404040);
  static const Color grey = Color(0xFF979797);
  static const Color greyMedium = Color(0xFF8A8A8A);
  static const Color mediumGrey = Color(0xFFAEAEAE);
  static const Color lightGrey = Color(0xFFEAF2FF);
  static const Color lighterGrey = Color(0xFFF5F5F5);

  // Blue Shades
  static const Color blues = Color(0xFF0066AE);
  static const Color darkestBlue = Color(0xFF001D39);
  static const Color darkerBlue = Color(0xFF0A4174);
  static const Color baseBlue = Color(0xFF49769F);
  static const Color blue14559D = Color(0xFF14559D);
  static const Color lighterBlue = Color(0xFF7CBCE8);
  static const Color lightestBlue = Color(0xFFBDD8E9);
  static const Color skyBlue = Color(0xFFE5F8FF);
  static const Color notificationBlue = Color(0xFFD4ECF6);

  // Teal
  static const Color baseTeal = Color(0xFF4E8EA2);
  static const Color teal = Color(0xFF6EA1B2);
  static const Color tealBlue = Color(0xFF1559A4);
  static const Color tealBlueAlt = Color(0xFF1559A3);

  // Primary Colors
  static const Color primaryDarkest = Color(0xFF25478E);
  static const Color primaryBase = Color(0xFF3B78EB);
  static const Color lightPrimaryBase = Color(0xFFCCDEFF);

  // Status Colors
  static const Color green = Color(0xFF4EA258);
  static const Color primaryGreen = Color(0xFF02B174);
  static const Color lightGreen = Color(0xFF4EA26E);
  static const Color red = Color(0xFFA24E4E);
  static const Color primaryRed = Color(0xFFCA3433);
  static const Color primaryYellow = Color(0xFFE9A82C);
  static const Color violationRed = Color(0xFFFF6362);
  static const Color achievementYellow = Color(0xFFF1B748);

  // Card Colors
  static const Color cardGreen = Color(0xFFC2FFFB);
  static const Color cardRed = Color(0xFFFFE2DE);
  static const Color cardYellow = Color(0xFFFFF6B8);

  // Badge Colors
  static const Color badgeGreen = Color(0xFF4ECBC7);
  static const Color badgeRed = Color(0xFFFFA79D);
  static const Color badgeYellow = Color(0xFFFFDC5F);
  static const Color badgeYellow2 = Color(0xFFFFD746);

  // Common Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color pureBlack = Color(0xFF000000);
  static const Color blackSecondary = Color(0xFF121212);
  static const Color transparent = Colors.transparent;

  // Shadow Colors
  static const Color shadowColor = Color(0xFF181C1F);

  // Gradients
  static LinearGradient get blueGradient => LinearGradient(
    colors: [Color(0xFF092646), Color(0xFF165DAC)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
