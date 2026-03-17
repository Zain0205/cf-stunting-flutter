import 'package:flutter/material.dart';

/// Subtle dot-grid background painter used in the header.
class GridPainter extends CustomPainter {
  const GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF1E3A5F).withOpacity(0.28)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const gap = 38.0;

    for (double x = 0; x < size.width + gap; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y < size.height + gap; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    final orbPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              const Color(0xFF3B82F6).withOpacity(0.20),
              const Color(0xFF3B82F6).withOpacity(0.0),
            ],
          ).createShader(
            Rect.fromCircle(center: Offset(size.width + 20, -20), radius: 140),
          );

    canvas.drawCircle(Offset(size.width + 20, -20), 140, orbPaint);
  }

  @override
  bool shouldRepaint(GridPainter _) => false;
}
