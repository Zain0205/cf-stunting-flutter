import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pencegahan/pencegahan_header.dart';

class PencegahanFilterBar extends StatelessWidget {
  final PreventionPhase? selected;
  final ValueChanged<PreventionPhase?> onSelect;
  final ResponsiveHelper r;

  const PencegahanFilterBar({
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
          ...PreventionPhase.values.map(
            (p) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _PhaseChip(
                phase: p,
                isSelected: selected == p,
                r: r,
                onTap: () => onSelect(selected == p ? null : p),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(horizontal: r.sp(12), vertical: r.sp(8)),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF0A1628) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xFF0A1628) : Colors.grey.shade200,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
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

class _PhaseChip extends StatelessWidget {
  final PreventionPhase phase;
  final bool isSelected;
  final ResponsiveHelper r;
  final VoidCallback onTap;
  const _PhaseChip({
    required this.phase,
    required this.isSelected,
    required this.r,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = PhaseMeta.color(phase);
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
            Text(PhaseMeta.emoji(phase), style: TextStyle(fontSize: r.fs(13))),
            const SizedBox(width: 5),
            Text(
              PhaseMeta.label(phase),
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

abstract class PhaseMeta {
  static const Map<PreventionPhase, (String, String, Color)> data = {
    PreventionPhase.prahamil: ('🌸', 'Pra-Kehamilan', Color(0xFFEC4899)),
    PreventionPhase.hamil: ('🤰', 'Saat Hamil', Color(0xFF8B5CF6)),
    PreventionPhase.bayi: ('👶', 'Bayi 0–12 Bln', Color(0xFF3B82F6)),
    PreventionPhase.balita: ('🧒', 'Balita 1–5 Thn', Color(0xFF059669)),
    PreventionPhase.keluarga: (
      '🏠',
      'Keluarga & Lingkungan',
      Color(0xFF06B6D4),
    ),
  };

  static String emoji(PreventionPhase p) => data[p]!.$1;
  static String label(PreventionPhase p) => data[p]!.$2;
  static Color color(PreventionPhase p) => data[p]!.$3;
}
