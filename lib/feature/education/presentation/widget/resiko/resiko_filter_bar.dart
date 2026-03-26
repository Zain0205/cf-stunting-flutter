import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/resiko/resiko_header.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/resiko/resiko_summary_strip.dart';

class ResikoFilterBar extends StatelessWidget {
  final RiskGroup? selected;
  final ValueChanged<RiskGroup?> onSelect;
  final ResponsiveHelper r;

  const ResikoFilterBar({
    super.key,
    required this.selected,
    required this.onSelect,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _AllChip(
            isSelected: selected == null,
            r: r,
            onTap: () => onSelect(null),
          ),
          const SizedBox(width: 8),
          ...RiskGroup.values.map(
            (g) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _GroupChip(
                group: g,
                isSelected: selected == g,
                r: r,
                onTap: () => onSelect(selected == g ? null : g),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Private chip widgets ──────────────────────────────────────────────────────

class _AllChip extends StatelessWidget {
  final bool isSelected;
  final ResponsiveHelper r;
  final VoidCallback onTap;

  const _AllChip({
    required this.isSelected,
    required this.r,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: r.sp(12), vertical: r.sp(8)),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0A1628) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF0A1628) : Colors.grey.shade200,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.20),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.apps_rounded,
              size: 13,
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
            const SizedBox(width: 5),
            Text(
              'Semua',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(11.5),
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupChip extends StatelessWidget {
  final RiskGroup group;
  final bool isSelected;
  final ResponsiveHelper r;
  final VoidCallback onTap;

  const _GroupChip({
    required this.group,
    required this.isSelected,
    required this.r,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = GroupMeta.color(group);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: r.sp(12), vertical: r.sp(8)),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade200,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.30),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(GroupMeta.emoji(group), style: TextStyle(fontSize: r.fs(13))),
            const SizedBox(width: 5),
            Text(
              GroupMeta.label(group),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(11),
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
