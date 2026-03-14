import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Small pill-shaped chip showing an icon + label.
/// Used in the header to display user category and phone.
class InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final ResponsiveHelper r;

  const InfoChip({
    super.key,
    required this.icon,
    required this.label,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: Colors.white60),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(10),
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}
