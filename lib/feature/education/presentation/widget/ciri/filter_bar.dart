import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/ciri/ciri_header.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/ciri/summary_strip.dart';

class FilterBar extends StatelessWidget {
  final SignCategory? selected;
  final ValueChanged<SignCategory?> onSelect;
  final ResponsiveHelper r;

  const FilterBar({
    super.key,
    required this.selected,
    required this.onSelect,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.fromLTRB(16, r.sp(12), 16, r.sp(4)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            // "Semua" chip — deselects any active category
            _FilterChip(
              label: 'Semua',
              icon: Icons.apps_rounded,
              color: const Color(0xFF475569),
              isSelected: selected == null,
              onTap: () => onSelect(null),
              r: r,
            ),
            const SizedBox(width: 8),
            ...SignCategory.values.map(
              (cat) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _FilterChip(
                  label: CategoryMeta.labels[cat]!,
                  icon: CategoryMeta.icons[cat]!,
                  color: CategoryMeta.colors[cat]!,
                  isSelected: selected == cat,
                  onTap: () => onSelect(selected == cat ? null : cat),
                  r: r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private chip widget ───────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final ResponsiveHelper r;

  const _FilterChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
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
            width: isSelected ? 0 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.30),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: isSelected ? Colors.white : color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(11.5),
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
