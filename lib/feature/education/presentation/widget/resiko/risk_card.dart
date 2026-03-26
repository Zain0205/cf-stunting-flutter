import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/ciri/detail_section.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/resiko/resiko_header.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/resiko/resiko_summary_strip.dart';

class RiskCard extends StatelessWidget {
  final RiskItem risk;
  final bool isExpanded;
  final ResponsiveHelper r;
  final VoidCallback onTap;

  const RiskCard({
    super.key,
    required this.risk,
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
                ? risk.gradient[0].withOpacity(0.35)
                : const Color(0xFFE8F0FE),
            width: isExpanded ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isExpanded
                  ? risk.gradient[0].withOpacity(0.14)
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
              _AccentBar(gradient: risk.gradient, isExpanded: isExpanded),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(r.sp(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CardHeader(risk: risk, isExpanded: isExpanded, r: r),
                      if (isExpanded) _CardDetail(risk: risk, r: r),
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
  Widget build(BuildContext context) => AnimatedContainer(
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

class _CardHeader extends StatelessWidget {
  final RiskItem risk;
  final bool isExpanded;
  final ResponsiveHelper r;

  const _CardHeader({
    required this.risk,
    required this.isExpanded,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final groupColor = GroupMeta.color(risk.group);
    final groupLabel = GroupMeta.label(risk.group);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _EmojiBadge(risk: risk, r: r),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 5,
                children: [
                  _SmallChip(label: groupLabel, color: groupColor, r: r),
                  if (risk.isCritical)
                    _SmallChip(
                      label: '⚠ Kritis',
                      color: const Color(0xFFEF4444),
                      r: r,
                    ),
                ],
              ),
              SizedBox(height: r.sp(4)),
              Text(
                risk.title,
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
                risk.shortDesc,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(11.5),
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
        _ExpandArrow(gradient: risk.gradient, isExpanded: isExpanded, r: r),
      ],
    );
  }
}

class _EmojiBadge extends StatelessWidget {
  final RiskItem risk;
  final ResponsiveHelper r;

  const _EmojiBadge({required this.risk, required this.r});

  @override
  Widget build(BuildContext context) => Container(
    width: 46,
    height: 46,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          risk.gradient[0].withOpacity(0.12),
          risk.gradient[0].withOpacity(0.05),
        ],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: risk.gradient[0].withOpacity(0.20), width: 1),
    ),
    child: Center(
      child: Text(risk.emoji, style: TextStyle(fontSize: r.fs(22))),
    ),
  );
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
  Widget build(BuildContext context) => Padding(
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

class _CardDetail extends StatelessWidget {
  final RiskItem risk;
  final ResponsiveHelper r;

  const _CardDetail({required this.risk, required this.r});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: r.sp(14)),
      Container(height: 1, color: risk.gradient[0].withOpacity(0.10)),
      SizedBox(height: r.sp(12)),
      // ✅ Reuse DetailSection from ciri feature
      DetailSection(
        icon: Icons.info_outline_rounded,
        label: 'Dampak & Penjelasan',
        color: risk.gradient[0],
        text: risk.detail,
        r: r,
      ),
      SizedBox(height: r.sp(10)),
      DetailSection(
        icon: Icons.biotech_rounded,
        label: 'Mekanisme Ilmiah',
        color: const Color(0xFF8B5CF6),
        text: risk.mechanism,
        r: r,
      ),
      SizedBox(height: r.sp(10)),
      _TapHint(color: risk.gradient[0], r: r),
    ],
  );
}

class _TapHint extends StatelessWidget {
  final Color color;
  final ResponsiveHelper r;

  const _TapHint({required this.color, required this.r});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: r.sp(10), vertical: r.sp(6)),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.touch_app_rounded, size: 13, color: color.withOpacity(0.7)),
        const SizedBox(width: 5),
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
