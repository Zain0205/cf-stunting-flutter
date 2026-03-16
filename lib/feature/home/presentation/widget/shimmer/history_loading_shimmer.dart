import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Animated shimmer placeholder shown while history data is loading.
class HistoryLoadingShimmer extends StatefulWidget {
  final ResponsiveHelper r;

  const HistoryLoadingShimmer({super.key, required this.r});

  @override
  State<HistoryLoadingShimmer> createState() => _HistoryLoadingShimmerState();
}

class _HistoryLoadingShimmerState extends State<HistoryLoadingShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, widget.r.sp(16), 20, 0),
      child: AnimatedBuilder(
        animation: _anim,
        builder: (_, __) {
          final opacity = 0.4 + _anim.value * 0.3;
          return Column(
            children: List.generate(3, (i) {
              return Container(
                margin: EdgeInsets.only(bottom: widget.r.sp(12)),
                height: 82,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(opacity),
                  borderRadius: BorderRadius.circular(18),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
