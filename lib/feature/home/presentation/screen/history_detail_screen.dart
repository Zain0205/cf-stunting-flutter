import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/core/widget/section_header.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_history_entity.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/history/answer_card.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/history/domain_card.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/history/history_detail_header.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/history/result_card.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/history/risk_narative_card.dart';

class HistoryDetailScreen extends StatefulWidget {
  final DiagnosisHistoryEntity history;

  const HistoryDetailScreen({super.key, required this.history});

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();

    _fadeAnim = CurvedAnimation(
      parent: _animCtrl,
      curve: const Interval(0.0, 0.75, curve: Curves.easeOut),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper(context);
    final topPad = MediaQuery.of(context).padding.top;
    final headerHeight = topPad + (r.isSmall ? 80.0 : 96.0);

    final risk = RiskDatabase.resolve(widget.history.result);
    final riskInfo = RiskDatabase.data[risk]!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── SCROLLABLE CONTENT ──────────────────────────────────────────
          FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Space below persistent header
                  SliverToBoxAdapter(child: SizedBox(height: headerHeight + 8)),

                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16, r.sp(16), 16, r.sp(40)),
                    sliver: _ContentSliver(
                      history: widget.history,
                      riskInfo: riskInfo,
                      r: r,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── PERSISTENT HEADER ──────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: HistoryDetailHeader(history: widget.history, r: r),
          ),
        ],
      ),
    );
  }
}

// ── Content sliver ────────────────────────────────────────────────────────────

class _ContentSliver extends StatelessWidget {
  final DiagnosisHistoryEntity history;
  final RiskInfo riskInfo;
  final ResponsiveHelper r;

  const _ContentSliver({
    required this.history,
    required this.riskInfo,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      // Result card
      ResultCard(history: history, riskInfo: riskInfo, r: r),
      SizedBox(height: r.sp(20)),

      // Recommendations
      // ✅ Reuse shared SectionHeader
      SectionHeader(title: 'Rekomendasi & Tindakan', r: r),
      SizedBox(height: r.sp(12)),
      RiskNarrativeCard(riskInfo: riskInfo, r: r),
      SizedBox(height: r.sp(20)),

      // Domain CF values
      SectionHeader(title: 'Nilai Certainty Factor', r: r),
      SizedBox(height: r.sp(12)),
      ...history.domains.asMap().entries.map(
        (e) => Padding(
          padding: EdgeInsets.only(bottom: r.sp(12)),
          child: DomainCard(domain: e.value, index: e.key, r: r),
        ),
      ),

      SizedBox(height: r.sp(8)),

      // Detailed answers
      SectionHeader(title: 'Detail Jawaban', r: r),
      SizedBox(height: r.sp(12)),
      ...history.answers.asMap().entries.map(
        (e) => Padding(
          padding: EdgeInsets.only(bottom: r.sp(10)),
          child: AnswerCard(answer: e.value, index: e.key, r: r),
        ),
      ),
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => items[index],
        childCount: items.length,
      ),
    );
  }
}
