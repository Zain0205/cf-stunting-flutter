import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

import 'grid_painter.dart';

/// Persistent gradient header that stays fixed at the top while scrolling.
///
/// Uses a [Stack] overlay approach instead of [SliverAppBar], so the gradient
/// and back button are always visible regardless of scroll position.
class PengertianHeader extends StatelessWidget {
  final ResponsiveHelper r;

  const PengertianHeader({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final headerHeight = topPad + (r.isSmall ? 80.0 : 96.0);

    return SizedBox(
      height: headerHeight,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A1628), Color(0xFF1E3A8A)],
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
        ),
        child: Stack(
          children: [
            // Grid texture
            Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
                child: CustomPaint(painter: const GridPainter()),
              ),
            ),

            // Decorative orbs
            Positioned(
              top: -30,
              right: -20,
              child: _Orb(
                size: 130,
                color: const Color(0xFF3B82F6),
                opacity: 0.22,
              ),
            ),
            Positioned(
              top: -20,
              left: -20,
              child: _Orb(
                size: 80,
                color: const Color(0xFF06B6D4),
                opacity: 0.15,
              ),
            ),

            // Content row
            Positioned(
              left: 16,
              right: 16,
              top: topPad + r.sp(10),
              bottom: r.sp(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _BackButton(onTap: () => Navigator.of(context).pop()),
                  const SizedBox(width: 14),
                  Expanded(child: _TitleColumn(r: r)),
                  _EdukasiChip(r: r),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _Orb extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;

  const _Orb({required this.size, required this.color, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withOpacity(opacity), color.withOpacity(0.0)],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.14),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.20), width: 1),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}

class _TitleColumn extends StatelessWidget {
  final ResponsiveHelper r;

  const _TitleColumn({required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Apa Itu Stunting?',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(18),
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Edukasi Kesehatan Ibu & Anak',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(11),
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}

class _EdukasiChip extends StatelessWidget {
  final ResponsiveHelper r;

  const _EdukasiChip({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF059669).withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF059669).withOpacity(0.40),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.school_rounded, size: 12, color: Color(0xFF6EE7B7)),
          const SizedBox(width: 4),
          Text(
            'Edukasi',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(10),
              color: const Color(0xFF6EE7B7),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
