import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Boxed section with a label and body text.
/// Used inside [SignCard] for "Penjelasan" and "Mengapa Bisa Terjadi?".
class DetailSection extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final String text;
  final ResponsiveHelper r;

  const DetailSection({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.text,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(12)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.15), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(11),
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(8)),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(12.5),
              color: const Color(0xFF374151),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
