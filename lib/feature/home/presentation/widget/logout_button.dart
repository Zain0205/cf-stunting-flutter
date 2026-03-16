import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Compact logout button shown in the header beside the user avatar.
class LogoutButton extends StatelessWidget {
  final ResponsiveHelper r;
  final VoidCallback onTap;

  const LogoutButton({super.key, required this.r, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: r.sp(10), vertical: r.sp(6)),
        decoration: BoxDecoration(
          color: AppColors.danger.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.danger.withOpacity(0.35),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.logout_rounded,
              size: r.isSmall ? 13 : 14,
              color: AppColors.dangerLight,
            ),
            const SizedBox(width: 5),
            Text(
              'Logout',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(11),
                fontWeight: FontWeight.w600,
                color: AppColors.dangerLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
