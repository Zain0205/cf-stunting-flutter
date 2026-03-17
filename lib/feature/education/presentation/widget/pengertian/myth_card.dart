import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/stats_grid.dart';

/// Expandable card showing a myth on top and the correcting fact below.
class MythCard extends StatelessWidget {
  final MythItem item;
  final bool isExpanded;
  final ResponsiveHelper r;
  final VoidCallback onTap;

  const MythCard({
    super.key,
    required this.item,
    required this.isExpanded,
    required this.r,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isExpanded
                ? const Color(0xFF3B82F6).withOpacity(0.30)
                : const Color(0xFFE8F0FE),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isExpanded
                  ? const Color(0xFF3B82F6).withOpacity(0.10)
                  : Colors.black.withOpacity(0.04),
              blurRadius: isExpanded ? 16 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MythRow(myth: item.myth, isExpanded: isExpanded, r: r),
            if (isExpanded) ...[
              Container(height: 1, color: const Color(0xFFE8F0FE)),
              _FactRow(fact: item.fact, r: r),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _MythRow extends StatelessWidget {
  final String myth;
  final bool isExpanded;
  final ResponsiveHelper r;

  const _MythRow({
    required this.myth,
    required this.isExpanded,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(r.sp(14)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Center(
              child: Text('🚫', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mitos',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(9.5),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFEF4444),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  myth,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(13),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          AnimatedRotation(
            turns: isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 220),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: isExpanded
                  ? const Color(0xFF3B82F6)
                  : Colors.grey.shade400,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}

class _FactRow extends StatelessWidget {
  final String fact;
  final ResponsiveHelper r;

  const _FactRow({required this.fact, required this.r});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(r.sp(14)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Center(
              child: Text('✅', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fakta',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(9.5),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF059669),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  fact,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(12.5),
                    color: const Color(0xFF374151),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
