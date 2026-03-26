import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/ciri/ciri_header.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/ciri/detail_section.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/ciri/summary_strip.dart';

class SignCard extends StatelessWidget {
  final SignItem sign;
  final bool isExpanded;
  final ResponsiveHelper r;
  final VoidCallback onTap;

  const SignCard({
    super.key,
    required this.sign,
    required this.isExpanded,
    required this.r,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isExpanded
                ? sign.gradient[0].withOpacity(0.35)
                : const Color(0xFFE8F0FE),
            width: isExpanded ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isExpanded
                  ? sign.gradient[0].withOpacity(0.15)
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
              _AccentBar(gradient: sign.gradient, isExpanded: isExpanded),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(r.sp(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CardHeader(sign: sign, isExpanded: isExpanded, r: r),
                      if (isExpanded) _CardDetail(sign: sign, r: r),
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

  const _AccentBar({required this.gradient, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isExpanded
              ? gradient
              : [Colors.grey.shade200, Colors.grey.shade200],
        ),
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  final SignItem sign;
  final bool isExpanded;
  final ResponsiveHelper r;

  const _CardHeader({
    required this.sign,
    required this.isExpanded,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final catColor = CategoryMeta.colors[sign.category]!;
    final catLabel = CategoryMeta.labels[sign.category]!;
    final catIcon = CategoryMeta.icons[sign.category]!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _EmojiBadge(sign: sign, r: r),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _CategoryChip(
                    label: catLabel,
                    icon: catIcon,
                    color: catColor,
                    r: r,
                  ),
                  if (sign.isUrgent) ...[
                    const SizedBox(width: 5),
                    _UrgentChip(r: r),
                  ],
                ],
              ),
              SizedBox(height: r.sp(4)),
              Text(
                sign.title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(14),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: r.sp(2)),
              Text(
                sign.shortDesc,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(11.5),
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
        _ExpandArrow(gradient: sign.gradient, isExpanded: isExpanded, r: r),
      ],
    );
  }
}

class _EmojiBadge extends StatelessWidget {
  final SignItem sign;
  final ResponsiveHelper r;

  const _EmojiBadge({required this.sign, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            sign.gradient[0].withOpacity(0.12),
            sign.gradient[0].withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: sign.gradient[0].withOpacity(0.20), width: 1),
      ),
      child: Center(
        child: Text(sign.emoji, style: TextStyle(fontSize: r.fs(22))),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final ResponsiveHelper r;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(9),
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _UrgentChip extends StatelessWidget {
  final ResponsiveHelper r;

  const _UrgentChip({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withOpacity(0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.priority_high_rounded,
            size: 10,
            color: Color(0xFFEF4444),
          ),
          Text(
            'Urgent',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(9),
              fontWeight: FontWeight.w600,
              color: const Color(0xFFEF4444),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpandArrow extends StatelessWidget {
  final List<Color> gradient;
  final bool isExpanded;
  final ResponsiveHelper r;

  const _ExpandArrow({
    required this.gradient,
    required this.isExpanded,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: AnimatedRotation(
        turns: isExpanded ? 0.5 : 0,
        duration: const Duration(milliseconds: 220),
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: isExpanded
                ? gradient[0].withOpacity(0.10)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: isExpanded ? gradient[0] : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}

class _CardDetail extends StatelessWidget {
  final SignItem sign;
  final ResponsiveHelper r;

  const _CardDetail({required this.sign, required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: r.sp(14)),
        Container(height: 1, color: sign.gradient[0].withOpacity(0.10)),
        SizedBox(height: r.sp(14)),
        DetailSection(
          icon: Icons.info_outline_rounded,
          label: 'Penjelasan',
          color: sign.gradient[0],
          text: sign.detail,
          r: r,
        ),
        SizedBox(height: r.sp(12)),
        DetailSection(
          icon: Icons.biotech_rounded,
          label: 'Mengapa Bisa Terjadi?',
          color: const Color(0xFF8B5CF6),
          text: sign.whyItHappens,
          r: r,
        ),
        SizedBox(height: r.sp(12)),
        _TapHint(color: sign.gradient[0], r: r),
      ],
    );
  }
}

class _TapHint extends StatelessWidget {
  final Color color;
  final ResponsiveHelper r;

  const _TapHint({required this.color, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: r.sp(12), vertical: r.sp(8)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.touch_app_rounded,
            size: 14,
            color: color.withOpacity(0.7),
          ),
          const SizedBox(width: 6),
          Text(
            'Tap untuk menutup',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(10.5),
              color: color.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
