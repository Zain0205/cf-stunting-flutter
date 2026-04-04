import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/data-stunting/trend_chart.dart';

// ── Burden note ───────────────────────────────────────────────────────────────

class BurdenNote extends StatelessWidget {
  final ResponsiveHelper r;
  const BurdenNote({super.key, required this.r});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(r.sp(12)),
    decoration: BoxDecoration(
      color: const Color(0xFFFEF2F2),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFFECACA), width: 1),
    ),
    child: Row(
      children: [
        const Icon(
          Icons.info_outline_rounded,
          color: Color(0xFFEF4444),
          size: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '50% balita stunting nasional terkonsentrasi di 6 provinsi berikut ini — menjadi prioritas utama pemerintah.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(11.5),
              color: const Color(0xFFB91C1C),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ── Burden 6 bar chart ────────────────────────────────────────────────────────

class Burden6Card extends StatefulWidget {
  final ResponsiveHelper r;
  const Burden6Card({super.key, required this.r});

  @override
  State<Burden6Card> createState() => _Burden6CardState();
}

class _Burden6CardState extends State<Burden6Card>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    Future.delayed(const Duration(milliseconds: 300), () {
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
    final maxVal = StuntingData.burden6
        .map((b) => b.$3.toDouble())
        .reduce(math.max);

    return Container(
      padding: EdgeInsets.all(r.sp(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8F0FE), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEF4444).withOpacity(0.07),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: StuntingData.burden6.asMap().entries.map((e) {
          final i = e.key;
          final item = e.value;
          final isLast = i == StuntingData.burden6.length - 1;
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : r.sp(14)),
            child: AnimatedBuilder(
              animation: _anim,
              builder: (_, __) => Row(
                children: [
                  Text(item.$1, style: TextStyle(fontSize: r.fs(20))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.$2,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: r.fs(12.5),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              '${((item.$3 * _anim.value) / 1000).toStringAsFixed(0)} ribu',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: r.fs(12),
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFEF4444),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: r.sp(5)),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Stack(
                            children: [
                              Container(height: 8, color: Colors.grey.shade100),
                              FractionallySizedBox(
                                widthFactor: (item.$3 / maxVal) * _anim.value,
                                child: Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(
                                          0xFFEF4444,
                                        ).withOpacity(0.7),
                                        const Color(0xFFEF4444),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFFEF4444,
                                        ).withOpacity(0.25),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── Global comparison ─────────────────────────────────────────────────────────

class GlobalComparison extends StatefulWidget {
  final ResponsiveHelper r;
  const GlobalComparison({super.key, required this.r});

  @override
  State<GlobalComparison> createState() => _GlobalComparisonState();
}

class _GlobalComparisonState extends State<GlobalComparison>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  static const _countries = [
    ('🇵🇰', 'Pakistan', 37.6, Color(0xFF991B1B)),
    ('🇮🇳', 'India', 35.5, Color(0xFFB91C1C)),
    ('🇧🇩', 'Bangladesh', 28.0, Color(0xFFDC2626)),
    ('🌍', 'Rata² Dunia', 22.3, Color(0xFF3B82F6)),
    ('🇮🇩', 'Indonesia', 19.8, Color(0xFF10B981)),
    ('🇹🇭', 'Thailand', 11.4, Color(0xFF059669)),
    ('🇸🇬', 'Singapura', 4.1, Color(0xFF047857)),
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    Future.delayed(const Duration(milliseconds: 300), () {
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
    final maxVal = _countries.map((c) => c.$3).reduce(math.max);

    return Container(
      padding: EdgeInsets.all(r.sp(16)),
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
        children: _countries.asMap().entries.map((e) {
          final i = e.key;
          final c = e.value;
          final isIndo = c.$2 == 'Indonesia';
          return Padding(
            padding: EdgeInsets.only(
              bottom: i < _countries.length - 1 ? r.sp(12) : 0,
            ),
            child: AnimatedBuilder(
              animation: _anim,
              builder: (_, __) => Row(
                children: [
                  Text(c.$1, style: TextStyle(fontSize: r.fs(18))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  c.$2,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: r.fs(12.5),
                                    fontWeight: isIndo
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isIndo
                                        ? c.$4
                                        : const Color(0xFF374151),
                                  ),
                                ),
                                if (isIndo) ...[
                                  const SizedBox(width: 5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: c.$4,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '2024',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: r.fs(8),
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              '${(c.$3 * _anim.value).toStringAsFixed(1)}%',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: r.fs(12),
                                fontWeight: FontWeight.w700,
                                color: c.$4,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: r.sp(4)),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Stack(
                            children: [
                              Container(
                                height: isIndo ? 9 : 7,
                                color: Colors.grey.shade100,
                              ),
                              FractionallySizedBox(
                                widthFactor: (c.$3 / maxVal) * _anim.value,
                                child: Container(
                                  height: isIndo ? 9 : 7,
                                  decoration: BoxDecoration(
                                    color: isIndo
                                        ? c.$4
                                        : c.$4.withOpacity(0.65),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── Social gap card ───────────────────────────────────────────────────────────

class SocialGapCard extends StatelessWidget {
  final ResponsiveHelper r;
  const SocialGapCard({super.key, required this.r});

  static const _quintiles = [
    ('Q1 Termiskin', 29.8, Color(0xFFDC2626)),
    ('Q2', 24.5, Color(0xFFEF4444)),
    ('Q3 Menengah', 20.2, Color(0xFFF59E0B)),
    ('Q4', 16.8, Color(0xFF10B981)),
    ('Q5 Terkaya', 12.0, Color(0xFF059669)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(16)),
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
          _SocialGapHeader(r: r),
          SizedBox(height: r.sp(14)),
          ..._quintiles.asMap().entries.map((e) {
            final i = e.key;
            final q = e.value;
            return Padding(
              padding: EdgeInsets.only(
                bottom: i < _quintiles.length - 1 ? r.sp(10) : 0,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: r.w * 0.28,
                    child: Text(
                      q.$1,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11.5),
                        color: const Color(0xFF374151),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Stack(
                        children: [
                          Container(height: 8, color: Colors.grey.shade100),
                          FractionallySizedBox(
                            widthFactor: q.$2 / 35,
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: q.$3,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${q.$2}%',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.fs(11.5),
                      fontWeight: FontWeight.w700,
                      color: q.$3,
                    ),
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: r.sp(12)),
          Container(
            padding: EdgeInsets.all(r.sp(12)),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFDDD6FE), width: 1),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Color(0xFF7C3AED),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Anak dari keluarga termiskin 2.5× lebih berisiko stunting dibanding keluarga terkaya.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.fs(11.5),
                      color: const Color(0xFF5B21B6),
                      height: 1.45,
                    ),
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

class _SocialGapHeader extends StatelessWidget {
  final ResponsiveHelper r;
  const _SocialGapHeader({required this.r});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.bar_chart_rounded,
          color: Colors.white,
          size: 17,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          'Kesenjangan Sosial-Ekonomi (SSGI 2024)',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(13),
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
      ),
    ],
  );
}

// ── Sources card ──────────────────────────────────────────────────────────────

class SourcesCard extends StatelessWidget {
  final ResponsiveHelper r;
  const SourcesCard({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF059669).withOpacity(0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_rounded,
                      size: 12,
                      color: Color(0xFF059669),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Data Terverifikasi',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(10),
                        color: const Color(0xFF059669),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Sumber Data',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF475569),
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(10)),
          ...StuntingData.sources.map(
            (s) => Padding(
              padding: EdgeInsets.only(bottom: r.sp(6)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      s,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11),
                        color: const Color(0xFF64748B),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
