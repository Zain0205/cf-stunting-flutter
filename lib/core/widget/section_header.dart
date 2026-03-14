import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Section title with a blue vertical accent bar on the left.
///
/// Optionally accepts a [trailing] widget (e.g., a button).
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final ResponsiveHelper r;

  const SectionHeader({
    super.key,
    required this.title,
    required this.r,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Accent bar
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(15),
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        if (trailing != null) ...[const Spacer(), trailing!],
      ],
    );
  }
}
