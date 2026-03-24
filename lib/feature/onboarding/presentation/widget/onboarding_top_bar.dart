import 'package:flutter/material.dart';
import 'package:mobile_flutter/feature/onboarding/presentation/widget/onboarding_data.dart';

class _R {
  final double w;
  final double h;
  _R(BuildContext ctx)
    : w = MediaQuery.of(ctx).size.width,
      h = MediaQuery.of(ctx).size.height;
  double fs(double s) => (s * w / 390).clamp(s * 0.78, s * 1.18);
  double sp(double s) => (s * h / 844).clamp(s * 0.58, s * 1.22);
  bool get isSmall => h < 680;
}

/// Minimal top bar: brand mark on left, optional skip button on right.
class OnboardingTopBar extends StatelessWidget {
  final OnboardingSlide slide;
  final bool showSkip;
  final VoidCallback onSkip;

  const OnboardingTopBar({
    super.key,
    required this.slide,
    required this.showSkip,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final r = _R(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(22, r.sp(14), 22, 0),
      child: Row(
        children: [
          // Brand icon — small, unfussy
          Container(
            width: r.isSmall ? 34 : 40,
            height: r.isSmall ? 34 : 40,
            decoration: BoxDecoration(
              color: slide.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(11),
              border: Border.all(
                color: slide.accent.withOpacity(0.25),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.medical_services_rounded,
              color: slide.accent,
              size: r.isSmall ? 16 : 19,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Sistem Informasi Kesehatan',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(14),
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.85),
              letterSpacing: -0.2,
            ),
          ),
          const Spacer(),

          // Skip — only shown when not on last page
          if (showSkip)
            GestureDetector(
              onTap: onSkip,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.12),
                    width: 1,
                  ),
                ),
                child: Text(
                  'Lewati',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(12),
                    color: Colors.white.withOpacity(0.55),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
