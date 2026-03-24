import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Soft, organic background with slow-breathing blobs and a subtle grid.
/// Much warmer and calmer than the previous version.
class OnboardingBgPainter extends CustomPainter {
  final double progress;
  final Color accent;

  const OnboardingBgPainter({required this.progress, required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ── Warm dark base ──────────────────────────────────────────────────
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D1B2A), Color(0xFF112236), Color(0xFF0A1628)],
          stops: [0.0, 0.55, 1.0],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    // ── Subtle dot grid ──────────────────────────────────────────────────
    final dotPaint = Paint()
      ..color = const Color(0xFF1E3A5F).withOpacity(0.18)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    const gs = 44.0;
    for (double x = gs; x < w; x += gs) {
      for (double y = gs; y < h; y += gs) {
        canvas.drawCircle(
          Offset(x, y),
          1.0,
          dotPaint..style = PaintingStyle.fill,
        );
      }
    }

    // ── Breathing accent blob — top centre ─────────────────────────────
    final pulse = 0.82 + math.sin(progress * math.pi * 2) * 0.08;
    final blobPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.0, -0.7),
        radius: 0.55 * pulse,
        colors: [accent.withOpacity(0.13), accent.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), blobPaint);

    // ── Soft bottom warm glow ───────────────────────────────────────────
    final bottomGlow = Paint()
      ..shader = const RadialGradient(
        center: Alignment(0.0, 1.6),
        radius: 0.70,
        colors: [Color(0x14FFFFFF), Color(0x00FFFFFF)],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), bottomGlow);
  }

  @override
  bool shouldRepaint(OnboardingBgPainter old) =>
      old.progress != progress || old.accent != accent;
}
