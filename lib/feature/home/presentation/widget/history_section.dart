import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/core/widget/section_header.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/empty/w_home_empty.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/history_card.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/history_card_wrapper.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/skrining_button.dart';

/// Displays the list of past screening history, an empty state,
/// and a button to start a new screening.
class HistorySection extends StatelessWidget {
  final List histories;
  final ResponsiveHelper r;
  final VoidCallback onSkrining;

  const HistorySection({
    super.key,
    required this.histories,
    required this.r,
    required this.onSkrining,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, r.sp(6), 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Riwayat Skrining',
            r: r,
            trailing: SkriningButton(r: r, onTap: onSkrining),
          ),
          SizedBox(height: r.sp(14)),
          if (histories.isEmpty)
            const WHomeEmpty()
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: histories.length,
              separatorBuilder: (_, __) => SizedBox(height: r.sp(12)),
              itemBuilder: (_, index) => HistoryCardWrapper(
                child: HistoryCard(history: histories[index]),
              ),
            ),
        ],
      ),
    );
  }
}
