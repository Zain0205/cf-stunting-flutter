import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/domain_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/provider/quisioner_provider.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/widget/domain_section.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/widget/quisioner_header.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/widget/quisioner_states.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/widget/submit_button.dart';

class QuisionerScreen extends ConsumerWidget {
  const QuisionerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = ResponsiveHelper(context);
    final state = ref.watch(questionProvider);
    final topPad = MediaQuery.of(context).padding.top;
    final headerHeight = topPad + (r.isSmall ? 80.0 : 96.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── SCROLLABLE CONTENT ────────────────────────────────────────
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Space below persistent header
              SliverToBoxAdapter(child: SizedBox(height: headerHeight + 8)),

              // Questions + submit
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16, r.sp(16), 16, r.sp(40)),
                sliver: state.when(
                  loading: () =>
                      SliverToBoxAdapter(child: QuisionerLoadingShimmer(r: r)),
                  error: (e, _) => SliverToBoxAdapter(
                    child: QuisionerErrorCard(message: e.toString(), r: r),
                  ),
                  data: (data) => _QuestionSliver(domains: data.domains, r: r),
                ),
              ),
            ],
          ),

          // ── PERSISTENT HEADER ─────────────────────────────────────────
          Positioned(top: 0, left: 0, right: 0, child: QuisionerHeader(r: r)),
        ],
      ),
    );
  }
}

// ── Question sliver ───────────────────────────────────────────────────────────

/// Builds the flat list of domain sections + submit button as a [SliverList].
class _QuestionSliver extends StatelessWidget {
  final List<DomainEntity> domains;
  final ResponsiveHelper r;

  const _QuestionSliver({required this.domains, required this.r});

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      for (int i = 0; i < domains.length; i++) ...[
        DomainSection(domain: domains[i], domainIndex: i, r: r),
        SizedBox(height: r.sp(16)),
      ],
      SubmitButton(r: r),
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => items[index],
        childCount: items.length,
      ),
    );
  }
}
