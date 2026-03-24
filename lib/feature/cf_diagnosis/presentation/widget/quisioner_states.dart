import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Animated shimmer skeleton shown while question data loads.
/// Reuses the same shimmer pattern as [HistoryLoadingShimmer] from home.
class QuisionerLoadingShimmer extends StatefulWidget {
  final ResponsiveHelper r;

  const QuisionerLoadingShimmer({super.key, required this.r});

  @override
  State<QuisionerLoadingShimmer> createState() =>
      _QuisionerLoadingShimmerState();
}

class _QuisionerLoadingShimmerState extends State<QuisionerLoadingShimmer>
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
    final r = widget.r;
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        final op = 0.4 + _anim.value * 0.3;
        return Column(
          children: [0, 1, 2, 3]
              .map(
                (i) => Container(
                  margin: EdgeInsets.only(bottom: r.sp(14)),
                  height: i == 0 ? 56 : 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(op),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

/// Error card shown when question fetch fails.
/// Reuses the same styling as [ErrorCard] from history feature.
class QuisionerErrorCard extends StatelessWidget {
  final String message;
  final ResponsiveHelper r;

  const QuisionerErrorCard({super.key, required this.message, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFECACA), width: 1),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Color(0xFFEF4444),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Terjadi kesalahan: $message',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(12.5),
                color: const Color(0xFFB91C1C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
