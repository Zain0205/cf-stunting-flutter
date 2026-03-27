import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/ciri/ciri_header.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/ciri/filter_bar.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/ciri/sign_card.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/ciri/summary_strip.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/ciri/urgent_card.dart';

class CiriScreen extends StatefulWidget {
  const CiriScreen({super.key});

  @override
  State<CiriScreen> createState() => _CiriScreenState();
}

class _CiriScreenState extends State<CiriScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  SignCategory? _selectedCategory;
  int? _expandedIndex;

  List<SignItem> get _filtered => CiriData.filtered(_selectedCategory);

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

  void _onCategorySelect(SignCategory? cat) {
    setState(() {
      _selectedCategory = cat;
      _expandedIndex = null; // collapse any open card on filter change
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
                      child: SummaryStrip(r: r),
                    ),
                  ),

                  // Filter bar
                  SliverToBoxAdapter(
                    child: FilterBar(
                      selected: _selectedCategory,
                      onSelect: _onCategorySelect,
                      r: r,
                    ),
                  ),

                  // Sign cards
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16, r.sp(14), 16, r.sp(16)),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: r.sp(12)),
                          child: SignCard(
                            sign: filtered[index],
                            isExpanded: _expandedIndex == index,
                            r: r,
                            onTap: () => _onCardTap(index),
                          ),
                        ),
                        childCount: filtered.length,
                      ),
                    ),
                  ),

                  // Urgent card
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, r.sp(16)),
                    sliver: SliverToBoxAdapter(child: UrgentCard(r: r)),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: r.sp(30))),
                ],
              ),
            ),
          ),

          // ── PERSISTENT HEADER ──────────────────────────────────────────
          Positioned(top: 0, left: 0, right: 0, child: CiriHeader(r: r)),
        ],
      ),
    );
  }
}
