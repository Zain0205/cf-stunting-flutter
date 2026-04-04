import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/core/widget/section_header.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/data-stunting/data_header.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/data-stunting/data_stat_widget.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/data-stunting/hero_stats_card.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/data-stunting/indonesia_heatmap.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/data-stunting/province_widget.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/data-stunting/target_card.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/data-stunting/trend_chart.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  int _filterLevel = 0;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _fadeAnim = CurvedAnimation(
      parent: _animCtrl,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, -0.05),
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
                  SliverToBoxAdapter(child: SizedBox(height: headerHeight + 8)),

                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16, r.sp(16), 16, r.sp(40)),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Hero stats + 3-card row
                        HeroStatsCard(r: r),
                        SizedBox(height: r.sp(12)),
                        SummaryStatRow(r: r),
                        SizedBox(height: r.sp(20)),

                        // Trend chart
                        // ✅ Reuse SectionHeader from shared
                        SectionHeader(
                          title: 'Tren Nasional 2013–2024 (SSGI)',
                          r: r,
                        ),
                        SizedBox(height: r.sp(12)),
                        TrendChart(r: r),
                        SizedBox(height: r.sp(20)),

                        // Target progress
                        SectionHeader(title: 'Progress Menuju Target', r: r),
                        SizedBox(height: r.sp(12)),
                        TargetCard(r: r),
                        SizedBox(height: r.sp(20)),

                        // Burden 6
                        SectionHeader(title: '6 Provinsi Beban Terbesar', r: r),
                        SizedBox(height: r.sp(4)),
                        BurdenNote(r: r),
                        SizedBox(height: r.sp(10)),
                        Burden6Card(r: r),
                        SizedBox(height: r.sp(20)),

                        // Real interactive heatmap
                        SectionHeader(title: 'Peta Interaktif Stunting', r: r),
                        SizedBox(height: r.sp(12)),
                        IndonesiaHeatmap(r: r),
                        SizedBox(height: r.sp(20)),

                        // Province list with filter
                        SectionHeader(
                          title: 'Data Per Provinsi (SSGI 2024)',
                          r: r,
                        ),
                        SizedBox(height: r.sp(12)),
                        ProvinceFilter(
                          selected: _filterLevel,
                          onSelect: (i) => setState(() => _filterLevel = i),
                          r: r,
                        ),
                        SizedBox(height: r.sp(12)),
                        ProvinceList(
                          provinces: StuntingData.filteredProvinces(
                            _filterLevel,
                          ),
                          r: r,
                        ),
                        SizedBox(height: r.sp(20)),

                        // Global comparison
                        SectionHeader(title: 'Perbandingan Global', r: r),
                        SizedBox(height: r.sp(12)),
                        GlobalComparison(r: r),
                        SizedBox(height: r.sp(20)),

                        // Social gap
                        SectionHeader(title: 'Faktor Kesenjangan Sosial', r: r),
                        SizedBox(height: r.sp(12)),
                        SocialGapCard(r: r),
                        SizedBox(height: r.sp(20)),

                        // Sources
                        SourcesCard(r: r),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── PERSISTENT HEADER ──────────────────────────────────────────
          Positioned(top: 0, left: 0, right: 0, child: DataHeader(r: r)),
        ],
      ),
    );
  }
}
