import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_history_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_answer_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_domain_entity.dart';

// ─────────────────────────────────────────────
// RESPONSIVE HELPER
// ─────────────────────────────────────────────
class _R {
  final double w;
  final double h;
  _R(BuildContext context)
    : w = MediaQuery.of(context).size.width,
      h = MediaQuery.of(context).size.height;
  double fs(double size) => (size * w / 390).clamp(size * 0.78, size * 1.18);
  double sp(double size) => (size * h / 844).clamp(size * 0.58, size * 1.22);
  bool get isSmall => h < 680;
}

// ─────────────────────────────────────────────
// HISTORY DETAIL SCREEN
// ─────────────────────────────────────────────
class HistoryDetailScreen extends StatefulWidget {
  final DiagnosisHistoryEntity history;

  const HistoryDetailScreen({super.key, required this.history});

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();

    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.75, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
        );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = _R(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Stack(
        children: [
          // ── HEADER BACKGROUND ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: r.isSmall ? 200 : 230,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0A1628), Color(0xFF1E3A8A)],
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
            ),
          ),

          // ── ANIMATED GRID ON HEADER ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: r.isSmall ? 200 : 230,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
              child: CustomPaint(painter: _GridPainter()),
            ),
          ),

          // ── SCROLLABLE CONTENT ──
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // Back button + title row
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, r.sp(8), 16, r.sp(16)),
                        child: Row(
                          children: [
                            // Back button
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.20),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),

                            const SizedBox(width: 14),

                            // Title
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Detail Skrining',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: r.fs(18),
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  Text(
                                    DateFormat(
                                      'dd MMM yyyy • HH:mm',
                                    ).format(widget.history.createdAt),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: r.fs(11),
                                      color: Colors.white60,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Date chip
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF3B82F6,
                                ).withOpacity(0.25),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(
                                    0xFF3B82F6,
                                  ).withOpacity(0.35),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.history_rounded,
                                    size: 12,
                                    color: Color(0xFF93C5FD),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Riwayat',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: r.fs(10),
                                      color: const Color(0xFF93C5FD),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Result hero card
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _ResultCard(history: widget.history, r: r),
                      ),
                    ),

                    SliverToBoxAdapter(child: SizedBox(height: r.sp(20))),

                    // Domain section
                    SliverToBoxAdapter(
                      child: _SectionLabel(
                        label: 'Nilai Certainty Factor',
                        r: r,
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: r.sp(12))),

                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, r.sp(12)),
                          child: _DomainCard(
                            domain: widget.history.domains[index],
                            index: index,
                            r: r,
                          ),
                        ),
                        childCount: widget.history.domains.length,
                      ),
                    ),

                    SliverToBoxAdapter(child: SizedBox(height: r.sp(8))),

                    // Answer section
                    SliverToBoxAdapter(
                      child: _SectionLabel(label: 'Detail Jawaban', r: r),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: r.sp(12))),

                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, r.sp(10)),
                          child: _AnswerCard(
                            answer: widget.history.answers[index],
                            index: index,
                            r: r,
                          ),
                        ),
                        childCount: widget.history.answers.length,
                      ),
                    ),

                    SliverToBoxAdapter(child: SizedBox(height: r.sp(36))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SECTION LABEL
// ─────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  final _R r;
  const _SectionLabel({required this.label, required this.r});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(15),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// RESULT CARD
// ─────────────────────────────────────────────
class _ResultCard extends StatelessWidget {
  final DiagnosisHistoryEntity history;
  final _R r;
  const _ResultCard({required this.history, required this.r});

  // Determine color by result severity keyword
  List<Color> _resultGradient(String result) {
    final lower = result.toLowerCase();
    if (lower.contains('tinggi') || lower.contains('berisiko')) {
      return [const Color(0xFFEF4444), const Color(0xFFB91C1C)];
    }
    if (lower.contains('sedang') || lower.contains('waspada')) {
      return [const Color(0xFFF59E0B), const Color(0xFFD97706)];
    }
    if (lower.contains('rendah') ||
        lower.contains('normal') ||
        lower.contains('aman')) {
      return [const Color(0xFF059669), const Color(0xFF047857)];
    }
    return [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)];
  }

  IconData _resultIcon(String result) {
    final lower = result.toLowerCase();
    if (lower.contains('tinggi') || lower.contains('berisiko')) {
      return Icons.warning_amber_rounded;
    }
    if (lower.contains('sedang') || lower.contains('waspada')) {
      return Icons.info_outline_rounded;
    }
    if (lower.contains('rendah') ||
        lower.contains('normal') ||
        lower.contains('aman')) {
      return Icons.check_circle_outline_rounded;
    }
    return Icons.monitor_heart_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _resultGradient(history.result);
    final icon = _resultIcon(history.result);
    final date = DateFormat('dd MMM yyyy • HH:mm').format(history.createdAt);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.40),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(r.sp(22)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: label + icon
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Hasil Skrining',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(10.5),
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(icon, color: Colors.white, size: 22),
                    ),
                  ],
                ),

                SizedBox(height: r.sp(16)),

                // Result text
                Text(
                  history.result,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(r.isSmall ? 20 : 24),
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.2,
                    letterSpacing: -0.4,
                  ),
                ),

                SizedBox(height: r.sp(16)),

                // Divider
                Container(height: 1, color: Colors.white.withOpacity(0.20)),

                SizedBox(height: r.sp(14)),

                // Date + meta row
                Row(
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      color: Colors.white70,
                      size: 15,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      date,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(12),
                        color: Colors.white70,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${history.domains.length} Domain',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(10.5),
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DOMAIN CARD
// ─────────────────────────────────────────────
class _DomainCard extends StatefulWidget {
  final DiagnosisDomainEntity domain;
  final int index;
  final _R r;

  const _DomainCard({
    required this.domain,
    required this.index,
    required this.r,
  });

  @override
  State<_DomainCard> createState() => _DomainCardState();
}

class _DomainCardState extends State<_DomainCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _barAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _barAnim = Tween<double>(
      begin: 0,
      end: widget.domain.cfValue.clamp(0.0, 1.0),
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    // Staggered delay per card
    Future.delayed(Duration(milliseconds: 150 + widget.index * 80), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Color _barColor(double value) {
    if (value >= 0.7) return const Color(0xFFEF4444);
    if (value >= 0.4) return const Color(0xFFF59E0B);
    return const Color(0xFF059669);
  }

  Color _bgColor(double value) {
    if (value >= 0.7) return const Color(0xFFFEF2F2);
    if (value >= 0.4) return const Color(0xFFFFFBEB);
    return const Color(0xFFF0FDF4);
  }

  Color _badgeColor(double value) {
    if (value >= 0.7) return const Color(0xFFEF4444);
    if (value >= 0.4) return const Color(0xFFF59E0B);
    return const Color(0xFF059669);
  }

  String _levelLabel(double value) {
    if (value >= 0.7) return 'Tinggi';
    if (value >= 0.4) return 'Sedang';
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
          Row(
            children: [
              // Domain code badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: _bgColor(value),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _badgeColor(value).withOpacity(0.25),
                    width: 1,
                  ),
                ),
                child: Text(
                  widget.domain.domainCode,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(12),
                    fontWeight: FontWeight.w700,
                    color: _badgeColor(value),
                  ),
                ),
              ),

              const Spacer(),

              // CF value pill
              AnimatedBuilder(
                animation: _barAnim,
                builder: (_, __) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        barColor.withOpacity(0.15),
                        barColor.withOpacity(0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: barColor.withOpacity(0.25),
                      width: 1,
                    ),
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
                          color: barColor,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: barColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _levelLabel(value),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(9),
                            fontWeight: FontWeight.w600,
                            color: barColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: r.sp(14)),

          // Animated progress bar
          AnimatedBuilder(
            animation: _barAnim,
            builder: (_, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      children: [
                        // Background track
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        // Animated fill
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
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ANSWER CARD
// ─────────────────────────────────────────────
class _AnswerCard extends StatelessWidget {
  final DiagnosisAnswerEntity answer;
  final int index;
  final _R r;

  const _AnswerCard({
    required this.answer,
    required this.index,
    required this.r,
  });

  // Color per answer key letter/value
  List<Color> _keyGradient(String key) {
    final Map<String, List<Color>> map = {
      'A': [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)],
      'B': [const Color(0xFF8B5CF6), const Color(0xFF6D28D9)],
      'C': [const Color(0xFF059669), const Color(0xFF047857)],
      'D': [const Color(0xFFF59E0B), const Color(0xFFD97706)],
      'E': [const Color(0xFFEC4899), const Color(0xFFBE185D)],
    };
    return map[key.toUpperCase()] ??
        [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)];
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _keyGradient(answer.answerKey);
    final cfFormatted = answer.cfItem.toStringAsFixed(2);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFE8F0FE), width: 1),
      ),
      padding: EdgeInsets.all(r.sp(14)),
      child: Row(
        children: [
          // Answer key badge
          Container(
            width: r.isSmall ? 40 : 46,
            height: r.isSmall ? 40 : 46,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradient,
              ),
              borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  color: gradient[0].withOpacity(0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                answer.answerKey,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(15),
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(width: r.sp(14)),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  answer.questionCode,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(13.5),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: r.sp(4)),
                Row(
                  children: [
                    Text(
                      'CF Item:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11.5),
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      cfFormatted,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11.5),
                        fontWeight: FontWeight.w700,
                        color: gradient[0],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Index number
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(10),
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// GRID PAINTER (background decoration)
// ─────────────────────────────────────────────
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E3A5F).withOpacity(0.30)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const grid = 38.0;
    for (double x = 0; x < size.width + grid; x += grid) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height + grid; y += grid) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Top-right orb glow
    final orbPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              const Color(0xFF3B82F6).withOpacity(0.25),
              const Color(0xFF3B82F6).withOpacity(0.0),
            ],
          ).createShader(
            Rect.fromCircle(center: Offset(size.width + 20, -20), radius: 140),
          );
    canvas.drawCircle(Offset(size.width + 20, -20), 140, orbPaint);
  }

  @override
  bool shouldRepaint(_GridPainter old) => false;
}
