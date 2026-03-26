import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/stats_grid.dart';

/// Vertical timeline of the 1000 Hari Pertama Kehidupan milestones.
class TimelineSection extends StatelessWidget {
  final ResponsiveHelper r;

  const TimelineSection({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    final items = PengertianData.timeline;

    return Column(
      children: items.asMap().entries.map((entry) {
        final i = entry.key;
        final item = entry.value;
        final isLast = i == items.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TimelineConnector(
              item: item,
              nextItem: isLast ? null : items[i + 1],
              isLast: isLast,
              r: r,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : r.sp(8), top: 4),
                child: _TimelineCard(item: item, r: r),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _TimelineConnector extends StatelessWidget {
  final TimelineItem item;
  final TimelineItem? nextItem;
  final bool isLast;
  final ResponsiveHelper r;

  const _TimelineConnector({
    required this.item,
    required this.nextItem,
    required this.isLast,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: item.gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: item.gradient[0].withOpacity(0.35),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(item.icon, color: Colors.white, size: 18),
        ),
        if (!isLast)
          Container(
            width: 2,
            height: r.sp(50),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  item.gradient[0].withOpacity(0.4),
                  nextItem!.gradient[0].withOpacity(0.4),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _TimelineCard extends StatelessWidget {
  final TimelineItem item;
  final ResponsiveHelper r;

  const _TimelineCard({required this.item, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: item.gradient[0].withOpacity(0.18), width: 1),
        boxShadow: [
          BoxShadow(
            color: item.gradient[0].withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PeriodChip(period: item.period, color: item.gradient[0], r: r),
          SizedBox(height: r.sp(6)),
          Text(
            item.title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(13.5),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: r.sp(4)),
          Text(
            item.description,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(12),
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _PeriodChip extends StatelessWidget {
  final String period;
  final Color color;
  final ResponsiveHelper r;

  const _PeriodChip({
    required this.period,
    required this.color,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        period,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(9.5),
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
