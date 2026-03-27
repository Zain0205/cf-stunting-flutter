import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

class StepCountRow extends StatelessWidget {
  final int total;
  final int priorityCount;
  final ResponsiveHelper r;

  const StepCountRow({
    super.key,
    required this.total,
    required this.priorityCount,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$total langkah',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(12),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF475569),
          ),
        ),
        if (priorityCount > 0) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF059669).withOpacity(0.10),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star_rounded,
                  size: 11,
                  color: Color(0xFF059669),
                ),
                Text(
                  ' $priorityCount prioritas',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(10),
                    color: const Color(0xFF059669),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
        const Spacer(),
        Text(
          'Tap untuk detail & checklist',
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
