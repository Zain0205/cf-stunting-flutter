import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Animated progress card showing milestones and gap toward 2025/2029 targets.
class TargetCard extends StatefulWidget {
  final ResponsiveHelper r;

  const TargetCard({super.key, required this.r});

  @override
  State<TargetCard> createState() => _TargetCardState();
}

class _TargetCardState extends State<TargetCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  static const _progressPct = 0.7565; // 17.4 / 23.0

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.r;

    return Container(
      padding: EdgeInsets.all(r.sp(18)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8F0FE), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.07),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Milestones
          Row(
            children: [
              _Milestone(
                '2024',
                '19.8%',
                const Color(0xFF3B82F6),
                isCurrent: true,
                r: r,
              ),
              _MilestoneArrow(),
              _Milestone('2025', '18.8%', const Color(0xFFF59E0B), r: r),
              _MilestoneArrow(),
              _Milestone('2029', '14.2%', const Color(0xFF059669), r: r),
              _MilestoneArrow(),
              _Milestone('2045', '5%', const Color(0xFF8B5CF6), r: r),
            ],
          ),
          SizedBox(height: r.sp(18)),

          // Animated progress bar
          AnimatedBuilder(
            animation: _anim,
            builder: (_, __) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress menuju target 2029',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11.5),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      '${(_progressPct * _anim.value * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(12),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF3B82F6),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: r.sp(8)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Container(height: 12, color: Colors.grey.shade100),
                      FractionallySizedBox(
                        widthFactor: _progressPct * _anim.value,
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3B82F6), Color(0xFF059669)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF3B82F6,
                                ).withOpacity(0.35),
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
                SizedBox(height: r.sp(5)),
                Row(
                  children: [
                    Text(
                      'Baseline 2013: 37.2%',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(9.5),
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Target 2029: 14.2%',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(9.5),
                        color: const Color(0xFF059669),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: r.sp(14)),
          Container(height: 1, color: Colors.grey.shade100),
          SizedBox(height: r.sp(12)),

          Row(
            children: [
              Expanded(
                child: _GapChip(
                  label: 'Gap ke 2025',
                  value: '−1.0%',
                  color: const Color(0xFFF59E0B),
                  r: r,
                ),
              ),
              SizedBox(width: r.sp(10)),
              Expanded(
                child: _GapChip(
                  label: 'Gap ke 2029',
                  value: '−5.6%',
                  color: const Color(0xFFEF4444),
                  r: r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Milestone extends StatelessWidget {
  final String year;
  final String value;
  final Color color;
  final bool isCurrent;
  final ResponsiveHelper r;
  const _Milestone(
    this.year,
    this.value,
    this.color, {
    this.isCurrent = false,
    required this.r,
  });

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: r.sp(8), horizontal: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(isCurrent ? 0.12 : 0.05),
        borderRadius: BorderRadius.circular(10),
        border: isCurrent
            ? Border.all(color: color.withOpacity(0.35), width: 1.5)
            : null,
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(13),
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          Text(
            year,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(9.5),
              color: Colors.grey.shade500,
            ),
          ),
          if (isCurrent)
            Container(
              margin: const EdgeInsets.only(top: 3),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Kini',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(8),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

class _MilestoneArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Icon(
      Icons.arrow_forward_ios_rounded,
      size: 10,
      color: Colors.grey.shade300,
    ),
  );
}

class _GapChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final ResponsiveHelper r;
  const _GapChip({
    required this.label,
    required this.value,
    required this.color,
    required this.r,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(r.sp(12)),
    decoration: BoxDecoration(
      color: color.withOpacity(0.07),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.18), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(16),
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(10.5),
            color: Colors.grey.shade500,
          ),
        ),
      ],
    ),
  );
}
