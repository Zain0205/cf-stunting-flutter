import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';

/// Decorative card wrapper that adds shadow and border styling
/// around each [HistoryCard].
class HistoryCardWrapper extends StatelessWidget {
  final Widget child;

  const HistoryCardWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.borderLight, width: 1),
      ),
      child: child,
    );
  }
}
