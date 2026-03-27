import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Single tappable action row with animated check circle.
/// Used in both [StepCard] and [DailyChecklist].
class CheckableActionItem extends StatelessWidget {
  final String label;
  final bool isDone;
  final ResponsiveHelper r;
  final VoidCallback onTap;

  const CheckableActionItem({
    super.key,
    required this.label,
    required this.isDone,
    required this.r,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: r.sp(12), vertical: r.sp(10)),
        decoration: BoxDecoration(
          color: isDone
              ? const Color(0xFF059669).withOpacity(0.06)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDone
                ? const Color(0xFF059669).withOpacity(0.25)
                : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CheckCircle(isDone: isDone),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  color: isDone
                      ? const Color(0xFF059669)
                      : const Color(0xFF374151),
                  height: 1.5,
                  decoration: isDone ? TextDecoration.lineThrough : null,
                  decorationColor: const Color(0xFF059669),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckCircle extends StatelessWidget {
  final bool isDone;
  const _CheckCircle({required this.isDone});

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    width: 22,
    height: 22,
    decoration: BoxDecoration(
      color: isDone ? const Color(0xFF059669) : Colors.white,
      shape: BoxShape.circle,
      border: Border.all(
        color: isDone ? const Color(0xFF059669) : Colors.grey.shade300,
        width: 1.5,
      ),
      boxShadow: isDone
          ? [
              BoxShadow(
                color: const Color(0xFF059669).withOpacity(0.30),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ]
          : [],
    ),
    child: isDone
        ? const Icon(Icons.check_rounded, color: Colors.white, size: 13)
        : null,
  );
}
