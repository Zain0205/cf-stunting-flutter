import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/tab_ibu_hamil.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/tab_bayi_baru.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/tab_umum.dart';

/// Animated switcher that renders the correct tab content
/// based on [activeIndex] with a fade + slide transition.
class TabContent extends StatelessWidget {
  final int activeIndex;
  final ResponsiveHelper r;

  const TabContent({super.key, required this.activeIndex, required this.r});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.05, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: KeyedSubtree(
        key: ValueKey(activeIndex),
        child: switch (activeIndex) {
          1 => TabIbuHamil(r: r),
          2 => TabBayiBaru(r: r),
          _ => TabUmum(r: r),
        },
      ),
    );
  }
}
