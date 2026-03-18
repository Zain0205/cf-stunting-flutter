import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_domain_entity.dart';

class DomainCard extends StatefulWidget {
  final DiagnosisDomainEntity domain;
  final int index;
  final ResponsiveHelper r;

  const DomainCard({
    super.key,
    required this.domain,
    required this.index,
    required this.r,
  });

  @override
  State<DomainCard> createState() => _DomainCardState();
}

class _DomainCardState extends State<DomainCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _barAnim;

  @override
  void initState() {
    super.initState();
    final target = widget.domain.cfValue.clamp(0.0, 1.0);
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _barAnim = Tween<double>(
      begin: 0,
      end: target,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    Future.delayed(Duration(milliseconds: 150 + widget.index * 80), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  static Color _barColor(double v) {
    if (v >= 0.7) return const Color(0xFFEF4444);
    if (v >= 0.4) return const Color(0xFFF59E0B);
    return const Color(0xFF059669);
  }

  static String _levelLabel(double v) {
    if (v >= 0.7) return 'Tinggi';
    if (v >= 0.4) return 'Sedang';
    return 'Rendah';
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    final value = widget.domain.cfValue.clamp(0.0, 1.0);
    final barColor = _barColor(value);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFE8F0FE), width: 1),
      ),
      padding: EdgeInsets.all(r.sp(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Code + animated CF value
          Row(
            children: [
              _DomainCodeChip(
                code: widget.domain.domainCode,
                value: value,
                r: r,
              ),
              const Spacer(),
              AnimatedBuilder(
                animation: _barAnim,
                builder: (_, __) => _CfValueBadge(
                  value: value,
                  color: barColor,
                  label: _levelLabel(value),
                  r: r,
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(14)),

          // Animated bar
          AnimatedBuilder(
            animation: _barAnim,
            builder: (_, __) => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: _barAnim.value,
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [barColor.withOpacity(0.7), barColor],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: barColor.withOpacity(0.35),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: r.sp(6)),
                Text(
                  '${(_barAnim.value * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(10),
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DomainCodeChip extends StatelessWidget {
  final String code;
  final double value;
  final ResponsiveHelper r;
  const _DomainCodeChip({
    required this.code,
    required this.value,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final color = value >= 0.7
        ? const Color(0xFFEF4444)
        : value >= 0.4
        ? const Color(0xFFF59E0B)
        : const Color(0xFF059669);
    final bg = value >= 0.7
        ? const Color(0xFFFEF2F2)
        : value >= 0.4
        ? const Color(0xFFFFFBEB)
        : const Color(0xFFF0FDF4);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25), width: 1),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(12),
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _CfValueBadge extends StatelessWidget {
  final double value;
  final Color color;
  final String label;
  final ResponsiveHelper r;
  const _CfValueBadge({
    required this.value,
    required this.color,
    required this.label,
    required this.r,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withOpacity(0.15), color.withOpacity(0.08)],
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.25), width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value.toStringAsFixed(2),
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(13),
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(width: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(9),
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}
