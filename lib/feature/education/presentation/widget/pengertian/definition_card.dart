import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Dark gradient card explaining the WHO definition of stunting.
class DefinitionCard extends StatelessWidget {
  final ResponsiveHelper r;

  const DefinitionCard({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A1628), Color(0xFF1E3A8A)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D4ED8).withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          _DecorCircle(right: -15, top: -15, size: 100, opacity: 0.06),
          _DecorCircle(left: -10, bottom: -10, size: 70, opacity: 0.04),
          Padding(
            padding: EdgeInsets.all(r.sp(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DefinitionHeader(r: r),
                SizedBox(height: r.sp(16)),
                Container(height: 1, color: Colors.white.withOpacity(0.15)),
                SizedBox(height: r.sp(14)),
                Text(
                  'Stunting adalah kondisi gagal tumbuh pada anak balita akibat kekurangan gizi kronis dan infeksi berulang, terutama pada 1000 Hari Pertama Kehidupan (HPK). Ditandai dengan tinggi badan anak yang lebih pendek dari standar usianya (z-score < -2 SD).',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(13),
                    color: Colors.white.withOpacity(0.85),
                    height: 1.65,
                  ),
                ),
                SizedBox(height: r.sp(14)),
                _IndicatorBox(r: r),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _DecorCircle extends StatelessWidget {
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final double size;
  final double opacity;

  const _DecorCircle({
    this.left,
    this.right,
    this.top,
    this.bottom,
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(opacity),
        ),
      ),
    );
  }
}

class _DefinitionHeader extends StatelessWidget {
  final ResponsiveHelper r;

  const _DefinitionHeader({required this.r});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.20), width: 1),
          ),
          child: const Icon(
            Icons.menu_book_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Definisi WHO',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(11),
                  color: Colors.white60,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Stunting',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(20),
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IndicatorBox extends StatelessWidget {
  final ResponsiveHelper r;

  const _IndicatorBox({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(12)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.straighten_rounded,
            color: Color(0xFF60A5FA),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Indikator: Tinggi/Panjang Badan menurut Umur (TB/U atau PB/U) < -2 Standar Deviasi',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(11.5),
                color: const Color(0xFF93C5FD),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
