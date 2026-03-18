import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_history_entity.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/grid_painter.dart';

class HistoryDetailHeader extends StatelessWidget {
  final DiagnosisHistoryEntity history;
  final ResponsiveHelper r;

  const HistoryDetailHeader({
    super.key,
    required this.history,
    required this.r,
  });

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

            // Blue orb
            Positioned(
              top: -30,
              right: -20,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF3B82F6).withOpacity(0.22),
                      Colors.transparent,
                    ],
                  ),
                ),
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
                  Expanded(
                    child: _TitleColumn(history: history, r: r),
                  ),
                  _RiwayatChip(r: r),
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

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
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

class _TitleColumn extends StatelessWidget {
  final DiagnosisHistoryEntity history;
  final ResponsiveHelper r;
  const _TitleColumn({required this.history, required this.r});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Detail Skrining',
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
        DateFormat('dd MMM yyyy • HH:mm').format(history.createdAt),
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(11),
          color: Colors.white60,
        ),
      ),
    ],
  );
}

class _RiwayatChip extends StatelessWidget {
  final ResponsiveHelper r;
  const _RiwayatChip({required this.r});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: const Color(0xFF3B82F6).withOpacity(0.25),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: const Color(0xFF3B82F6).withOpacity(0.35),
        width: 1,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.history_rounded, size: 12, color: Color(0xFF93C5FD)),
        const SizedBox(width: 4),
        Text(
          'Riwayat',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(10),
            color: const Color(0xFF93C5FD),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
