import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Displays an error message inside a styled card.
class ErrorCard extends StatelessWidget {
  final String message;
  final ResponsiveHelper r;

  const ErrorCard({super.key, required this.message, required this.r});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: r.sp(16)),
      child: Container(
        padding: EdgeInsets.all(r.sp(16)),
        decoration: BoxDecoration(
          color: AppColors.errorBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.errorBorder, width: 1),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.danger,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  color: AppColors.errorText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
