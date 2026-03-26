import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

class CountInfoRow extends StatelessWidget {
  final int total;
  final int criticalCount;
  final ResponsiveHelper r;

  const CountInfoRow({
    super.key,
    required this.total,
    required this.criticalCount,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$total faktor risiko',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(12),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF475569),
          ),
        ),
        if (criticalCount > 0) ...[
          const SizedBox(width: 8),
          _CriticalBadge(count: criticalCount, r: r),
        ],
        const Spacer(),
        Text(
          'Tap untuk detail',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(10),
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}

class _CriticalBadge extends StatelessWidget {
  final int count;
  final ResponsiveHelper r;

  const _CriticalBadge({required this.count, required this.r});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: const Color(0xFFEF4444).withOpacity(0.10),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.priority_high_rounded,
          size: 11,
          color: Color(0xFFEF4444),
        ),
        Text(
          ' $count kritis',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(10),
            color: const Color(0xFFEF4444),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
