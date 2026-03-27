import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/ciri/detail_section.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pencegahan/checkable_action_item.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pencegahan/pencegahan_filter_bar.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pencegahan/pencegahan_header.dart';

/// Expandable prevention step card with inline action checklist and progress bar.
///
/// [checkedActions] uses a flattened key = [index * 100 + actionIndex]
/// to avoid key collisions across multiple cards.
class StepCard extends StatelessWidget {
  final PreventionStep step;
  final int index;
  final bool isExpanded;
  final Map<int, bool> checkedActions;
  final ResponsiveHelper r;
  final VoidCallback onTap;
  final void Function(int key, bool value) onCheckAction;

  const StepCard({
    super.key,
    required this.step,
    required this.index,
    required this.isExpanded,
    required this.checkedActions,
    required this.r,
    required this.onTap,
    required this.onCheckAction,
  });

  int get _doneCount => step.actions
      .asMap()
      .keys
      .where((i) => checkedActions[index * 100 + i] == true)
      .length;

  bool get _allDone => _doneCount == step.actions.length;

  @override
  Widget build(BuildContext context) {
    final phaseColor = PhaseMeta.color(step.phase);
    final phaseLabel = PhaseMeta.label(step.phase);
    final done = _doneCount;
    final total = step.actions.length;
    final allDone = _allDone;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: allDone
                ? const Color(0xFF059669).withOpacity(0.40)
                : isExpanded
                ? step.gradient[0].withOpacity(0.35)
                : const Color(0xFFE8F0FE),
            width: (isExpanded || allDone) ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: allDone
                  ? const Color(0xFF059669).withOpacity(0.12)
                  : isExpanded
                  ? step.gradient[0].withOpacity(0.14)
                  : Colors.black.withOpacity(0.04),
              blurRadius: isExpanded ? 20 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _AccentBar(
                gradient: step.gradient,
                isExpanded: isExpanded,
                allDone: allDone,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(r.sp(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CardHeader(
                        step: step,
                        phaseLabel: phaseLabel,
                        phaseColor: phaseColor,
                        isExpanded: isExpanded,
                        allDone: allDone,
                        done: done,
                        total: total,
                        r: r,
                      ),
                      SizedBox(height: r.sp(10)),
                      _ProgressBar(
                        done: done,
                        total: total,
                        gradient: step.gradient,
                        allDone: allDone,
                      ),
                      if (isExpanded)
                        _ExpandedContent(
                          step: step,
                          index: index,
                          done: done,
                          allDone: allDone,
                          checkedActions: checkedActions,
                          r: r,
                          onCheckAction: onCheckAction,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _AccentBar extends StatelessWidget {
  final List<Color> gradient;
  final bool isExpanded;
  final bool allDone;
  const _AccentBar({
    required this.gradient,
    required this.isExpanded,
    required this.allDone,
  });

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    width: 5,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: allDone
            ? [const Color(0xFF059669), const Color(0xFF047857)]
            : isExpanded
            ? gradient
            : [Colors.grey.shade200, Colors.grey.shade200],
      ),
      borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
    ),
  );
}

class _CardHeader extends StatelessWidget {
  final PreventionStep step;
  final String phaseLabel;
  final Color phaseColor;
  final bool isExpanded;
  final bool allDone;
  final int done;
  final int total;
  final ResponsiveHelper r;

  const _CardHeader({
    required this.step,
    required this.phaseLabel,
    required this.phaseColor,
    required this.isExpanded,
    required this.allDone,
    required this.done,
    required this.total,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Emoji badge
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                step.gradient[0].withOpacity(0.12),
                step.gradient[0].withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: step.gradient[0].withOpacity(0.20),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(step.emoji, style: TextStyle(fontSize: r.fs(22))),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 5,
                children: [
                  _SmallChip(label: phaseLabel, color: phaseColor, r: r),
                  if (step.isPriority)
                    _SmallChip(
                      label: '⭐ Prioritas',
                      color: const Color(0xFF059669),
                      r: r,
                    ),
                  if (allDone)
                    _SmallChip(
                      label: '✅ Selesai',
                      color: const Color(0xFF059669),
                      r: r,
                    ),
                ],
              ),
              SizedBox(height: r.sp(4)),
              Text(
                step.title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(13.5),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: r.sp(2)),
              Text(
                step.subtitle,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(11.5),
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 220),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isExpanded
                      ? step.gradient[0].withOpacity(0.10)
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: isExpanded ? step.gradient[0] : Colors.grey.shade400,
                ),
              ),
            ),
            SizedBox(height: r.sp(4)),
            Text(
              '$done/$total',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(10),
                fontWeight: FontWeight.w700,
                color: allDone ? const Color(0xFF059669) : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final int done;
  final int total;
  final List<Color> gradient;
  final bool allDone;
  const _ProgressBar({
    required this.done,
    required this.total,
    required this.gradient,
    required this.allDone,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(4),
    child: Stack(
      children: [
        Container(height: 4, color: Colors.grey.shade100),
        FractionallySizedBox(
          widthFactor: total > 0 ? done / total : 0,
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: allDone ? const Color(0xFF059669) : gradient[0],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    ),
  );
}

class _ExpandedContent extends StatelessWidget {
  final PreventionStep step;
  final int index;
  final int done;
  final bool allDone;
  final Map<int, bool> checkedActions;
  final ResponsiveHelper r;
  final void Function(int, bool) onCheckAction;

  const _ExpandedContent({
    required this.step,
    required this.index,
    required this.done,
    required this.allDone,
    required this.checkedActions,
    required this.r,
    required this.onCheckAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: r.sp(14)),
        Container(height: 1, color: step.gradient[0].withOpacity(0.10)),
        SizedBox(height: r.sp(12)),
        // ✅ Reuse DetailSection from ciri feature
        DetailSection(
          icon: Icons.lightbulb_outline_rounded,
          label: 'Mengapa Penting?',
          color: step.gradient[0],
          text: step.whyImportant,
          r: r,
        ),
        SizedBox(height: r.sp(12)),
        Row(
          children: [
            Icon(Icons.checklist_rounded, size: 13, color: step.gradient[0]),
            const SizedBox(width: 6),
            Text(
              'Checklist Tindakan',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(11),
                fontWeight: FontWeight.w700,
                color: step.gradient[0],
              ),
            ),
            const Spacer(),
            Text(
              '$done/${step.actions.length} selesai',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(10),
                color: allDone ? const Color(0xFF059669) : Colors.grey.shade400,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: r.sp(8)),
        ...step.actions.asMap().entries.map((entry) {
          final actionKey = index * 100 + entry.key;
          return Padding(
            padding: EdgeInsets.only(bottom: r.sp(8)),
            child: CheckableActionItem(
              label: entry.value,
              isDone: checkedActions[actionKey] == true,
              r: r,
              onTap: () => onCheckAction(
                actionKey,
                !(checkedActions[actionKey] ?? false),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _SmallChip extends StatelessWidget {
  final String label;
  final Color color;
  final ResponsiveHelper r;
  const _SmallChip({required this.label, required this.color, required this.r});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.10),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: r.fs(9.5),
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}
