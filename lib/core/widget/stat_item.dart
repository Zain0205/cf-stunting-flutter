import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// A single stat column (icon + value + label) used inside the header stats row.
class StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final ResponsiveHelper r;

  const StatItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: r.isSmall ? 16 : 18, color: color),
          SizedBox(height: r.sp(4)),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(12),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(9.5),
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}

/// Thin vertical divider between stat items.
class StatDivider extends StatelessWidget {
  const StatDivider({super.key});

  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 36, color: Colors.white.withOpacity(0.12));
}
