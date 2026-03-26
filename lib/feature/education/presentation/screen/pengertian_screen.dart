import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/core/widget/section_header.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/definition_card.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/myth_card.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/pengertian_header.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/stats_grid.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/tab_content.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/tab_selector.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/timeline_section.dart';

class PengertianScreen extends StatefulWidget {
  const PengertianScreen({super.key});

  @override
  State<PengertianScreen> createState() => _PengertianScreenState();
}

class _PengertianScreenState extends State<PengertianScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  int _activeTab = 0;
  final _expandedMyths = <int>{};

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _fadeAnim = CurvedAnimation(
      parent: _fadeCtrl,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, -0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  void _toggleMyth(int index) => setState(() {
    if (_expandedMyths.contains(index)) {
      _expandedMyths.remove(index);
    } else {
      _expandedMyths.add(index);
    }
  });

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper(context);
    // Compute how tall the header is so the scroll content starts below it
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
                  // Space below the pinned header
                  SliverToBoxAdapter(child: SizedBox(height: headerHeight + 8)),

                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16, r.sp(8), 16, r.sp(40)),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        DefinitionCard(r: r),
                        SizedBox(height: r.sp(20)),

                        SectionHeader(title: 'Fakta & Statistik', r: r),
                        SizedBox(height: r.sp(12)),
                        StatsGrid(r: r),
                        SizedBox(height: r.sp(20)),

                        SectionHeader(
                          title: 'Panduan Berdasarkan Kondisi',
                          r: r,
                        ),
                        SizedBox(height: r.sp(12)),
                        TabSelector(
                          activeIndex: _activeTab,
                          onTap: (i) => setState(() => _activeTab = i),
                          r: r,
                        ),
                        SizedBox(height: r.sp(14)),
                        TabContent(activeIndex: _activeTab, r: r),
                        SizedBox(height: r.sp(20)),

                        SectionHeader(
                          title: '1000 Hari Pertama Kehidupan',
                          r: r,
                        ),
                        SizedBox(height: r.sp(12)),
                        TimelineSection(r: r),
                        SizedBox(height: r.sp(20)),

                        SectionHeader(title: 'Mitos vs Fakta', r: r),
                        SizedBox(height: r.sp(12)),
                        ...PengertianData.myths.asMap().entries.map(
                          (entry) => Padding(
                            padding: EdgeInsets.only(bottom: r.sp(10)),
                            child: MythCard(
                              item: entry.value,
                              isExpanded: _expandedMyths.contains(entry.key),
                              r: r,
                              onTap: () => _toggleMyth(entry.key),
                            ),
                          ),
                        ),
                        SizedBox(height: r.sp(20)),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── PERSISTENT HEADER (always on top) ──────────────────────────
          Positioned(top: 0, left: 0, right: 0, child: PengertianHeader(r: r)),
        ],
      ),
    );
  }
}
