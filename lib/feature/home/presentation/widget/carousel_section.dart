import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/core/widget/section_header.dart';
import 'package:mobile_flutter/routes/route_path.dart';

import 'carousel_card.dart';

/// Horizontally swipeable education card carousel with dot indicator.
class CarouselSection extends StatelessWidget {
  final PageController controller;
  final int currentIndex;
  final ResponsiveHelper r;
  final ValueChanged<int> onPageChanged;

  const CarouselSection({
    super.key,
    required this.controller,
    required this.currentIndex,
    required this.r,
    required this.onPageChanged,
  });

  double get _cardHeight {
    if (r.isTiny) return 140.0;
    if (r.isSmall) return 155.0;
    return 172.0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, r.sp(20), 20, r.sp(12)),
          child: SectionHeader(title: 'Edukasi Kesehatan', r: r),
        ),
        SizedBox(
          height: _cardHeight,
          child: PageView.builder(
            controller: controller,
            itemCount: carouselItems.length,
            onPageChanged: onPageChanged,
            itemBuilder: (_, index) => CarouselCard(
              onTap: () {
                if (index == 0) {
                  context.push(RoutePath.pengertian);
                } else if (index == 1) {
                  context.push(RoutePath.ciri);
                } else if (index == 2) {
                  context.push(RoutePath.data);
                } else if (index == 3) {
                  context.push(RoutePath.resiko);
                } else if (index == 4) {
                  context.push(RoutePath.pencegahan);
                }
              },
              item: carouselItems[index],
              r: r,
              height: _cardHeight,
            ),
          ),
        ),
        SizedBox(height: r.sp(12)),
        _DotIndicator(currentIndex: currentIndex, r: r),
      ],
    );
  }
}

// ── Private sub-widget ────────────────────────────────────────────────────────

class _DotIndicator extends StatelessWidget {
  final int currentIndex;
  final ResponsiveHelper r;

  const _DotIndicator({required this.currentIndex, required this.r});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(carouselItems.length, (i) {
        final isActive = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          width: isActive ? 20 : 7,
          height: 7,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: isActive
                ? carouselItems[currentIndex].gradient[0]
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
