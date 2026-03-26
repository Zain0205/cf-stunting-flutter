import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/resiko/count_info_row.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/resiko/lifecycle_banner.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/resiko/resiko_bottom.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/resiko/resiko_filter_bar.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/resiko/resiko_header.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/resiko/resiko_summary_strip.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/resiko/risk_card.dart';

class ResikoScreen extends StatefulWidget {
  const ResikoScreen({super.key});

  @override
  State<ResikoScreen> createState() => _ResikoScreenState();
}

class _ResikoScreenState extends State<ResikoScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  RiskGroup? _selectedGroup;
  int? _expandedIndex;

  List<RiskItem> get _filtered => ResikoData.filtered(_selectedGroup);

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

  void _onGroupSelect(RiskGroup? group) {
    setState(() {
      _selectedGroup = group;
      _expandedIndex = null;
    });
  }

  void _onCardTap(int index) {
    setState(() => _expandedIndex = _expandedIndex == index ? null : index);
  }

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper(context);
    final topPad = MediaQuery.of(context).padding.top;
    final headerHeight = topPad + (r.isSmall ? 80.0 : 96.0);
    final filtered = _filtered;
    final criticalCount = filtered.where((item) => item.isCritical).length;

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

                  // Summary strip
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, r.sp(16), 16, 0),
                      child: ResikoSummaryStrip(r: r),
                    ),
                  ),

                  // Lifecycle banner
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, r.sp(14), 16, 0),
                      child: LifecycleBanner(r: r),
                    ),
                  ),

                  // Filter bar
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, r.sp(14), 16, 0),
                      child: ResikoFilterBar(
                        selected: _selectedGroup,
                        onSelect: _onGroupSelect,
                        r: r,
                      ),
                    ),
                  ),

                  // Count info
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, r.sp(12), 16, 0),
                      child: CountInfoRow(
                        total: filtered.length,
                        criticalCount: criticalCount,
                        r: r,
                      ),
                    ),
                  ),

                  // Risk cards
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16, r.sp(10), 16, 0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: r.sp(10)),
                          child: RiskCard(
                            risk: filtered[index],
                            isExpanded: _expandedIndex == index,
                            r: r,
                            onTap: () => _onCardTap(index),
                          ),
                        ),
                        childCount: filtered.length,
                      ),
                    ),
                  ),

                  // Bottom CTA
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16, r.sp(6), 16, 0),
                    sliver: SliverToBoxAdapter(child: ResikoBottom(r: r)),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: r.sp(36))),
                ],
              ),
            ),
          ),

          // ── PERSISTENT HEADER ──────────────────────────────────────────
          Positioned(top: 0, left: 0, right: 0, child: ResikoHeader(r: r)),
        ],
      ),
    );
  }
}
