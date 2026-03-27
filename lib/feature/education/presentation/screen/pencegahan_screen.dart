import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/core/widget/section_header.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pencegahan/hero_card.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pencegahan/nutrient_grid.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pencegahan/pencegahan_card.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pencegahan/pencegahan_filter_bar.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pencegahan/pencegahan_header.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pencegahan/step_card.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pencegahan/step_count_row.dart';

class PencegahanScreen extends StatefulWidget {
  const PencegahanScreen({super.key});

  @override
  State<PencegahanScreen> createState() => _PencegahanScreenState();
}

class _PencegahanScreenState extends State<PencegahanScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  PreventionPhase? _selectedPhase;
  int? _expandedIndex;

  /// Flattened action check state: key = cardIndex * 100 + actionIndex
  final Map<int, bool> _checkedActions = {};

  List<PreventionStep> get _filtered => PencegahanData.filtered(_selectedPhase);

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

  void _onPhaseSelect(PreventionPhase? phase) {
    setState(() {
      _selectedPhase = phase;
      _expandedIndex = null;
    });
  }

  void _onCardTap(int index) {
    setState(() => _expandedIndex = _expandedIndex == index ? null : index);
  }

  void _onCheckAction(int key, bool value) {
    setState(() => _checkedActions[key] = value);
  }

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper(context);
    final topPad = MediaQuery.of(context).padding.top;
    final headerHeight = topPad + (r.isSmall ? 80.0 : 96.0);
    final filtered = _filtered;
    final priorityCount = filtered.where((s) => s.isPriority).length;

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

                  // Hero card
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, r.sp(16), 16, 0),
                      child: HeroCard(r: r),
                    ),
                  ),

                  // Nutrient grid
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, r.sp(18), 16, 0),
                      // ✅ Reuse shared SectionHeader
                      child: SectionHeader(
                        title: 'Nutrisi Kunci Pencegahan',
                        r: r,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, r.sp(12), 16, 0),
                      child: NutrientGrid(r: r),
                    ),
                  ),

                  // Filter header
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, r.sp(18), 16, 0),
                      child: SectionHeader(title: 'Langkah Pencegahan', r: r),
                    ),
                  ),

                  // Filter bar
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, r.sp(12), 16, 0),
                      child: PencegahanFilterBar(
                        selected: _selectedPhase,
                        onSelect: _onPhaseSelect,
                        r: r,
                      ),
                    ),
                  ),

                  // Count row
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, r.sp(12), 16, 0),
                      child: StepCountRow(
                        total: filtered.length,
                        priorityCount: priorityCount,
                        r: r,
                      ),
                    ),
                  ),

                  // Step cards
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16, r.sp(10), 16, 0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: r.sp(10)),
                          child: StepCard(
                            step: filtered[index],
                            index: index,
                            isExpanded: _expandedIndex == index,
                            checkedActions: _checkedActions,
                            r: r,
                            onTap: () => _onCardTap(index),
                            onCheckAction: _onCheckAction,
                          ),
                        ),
                        childCount: filtered.length,
                      ),
                    ),
                  ),

                  // CTA card
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, r.sp(18), 16, 0),
                      child: PencegahanCard(r: r),
                    ),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: r.sp(36))),
                ],
              ),
            ),
          ),

          // ── PERSISTENT HEADER ──────────────────────────────────────────
          Positioned(top: 0, left: 0, right: 0, child: PencegahanHeader(r: r)),
        ],
      ),
    );
  }
}
