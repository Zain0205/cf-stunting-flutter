import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/history/action_block.dart';
import 'package:mobile_flutter/feature/home/presentation/widget/history/result_card.dart';

/// Full recommendation card: headline summary + warning/maintain/improve blocks.
class RiskNarrativeCard extends StatelessWidget {
  final RiskInfo riskInfo;
  final ResponsiveHelper r;

  const RiskNarrativeCard({super.key, required this.riskInfo, required this.r});

  bool get _isPositive =>
      riskInfo.level == RiskLevel.veryLow || riskInfo.level == RiskLevel.low;

  bool get _isCritical => riskInfo.level.index >= 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _HeadlineCard(riskInfo: riskInfo, r: r),
        if (riskInfo.warning.isNotEmpty) ...[
          SizedBox(height: r.sp(12)),
          ActionBlock(
            title: 'Perhatian Penting',
            icon: Icons.notifications_active_rounded,
            gradient: const [Color(0xFFDC2626), Color(0xFF991B1B)],
            bgColor: const Color(0xFFFEF2F2),
            borderColor: const Color(0xFFFECACA),
            items: riskInfo.warning,
            r: r,
            isBullet: false,
          ),
        ],
        if (riskInfo.maintain.isNotEmpty) ...[
          SizedBox(height: r.sp(12)),
          ActionBlock(
            title: _isPositive
                ? 'Yang Perlu Dipertahankan'
                : 'Yang Masih Perlu Dijaga',
            icon: Icons.shield_rounded,
            gradient: const [Color(0xFF059669), Color(0xFF047857)],
            bgColor: const Color(0xFFF0FDF4),
            borderColor: const Color(0xFFBBF7D0),
            items: riskInfo.maintain,
            r: r,
          ),
        ],
        if (riskInfo.improve.isNotEmpty) ...[
          SizedBox(height: r.sp(12)),
          ActionBlock(
            title: _isPositive
                ? 'Yang Bisa Ditingkatkan'
                : 'Tindakan yang Harus Dilakukan',
            icon: _isCritical
                ? Icons.medical_services_rounded
                : Icons.trending_up_rounded,
            gradient: _isCritical
                ? const [Color(0xFFEF4444), Color(0xFFB91C1C)]
                : const [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
            bgColor: _isCritical
                ? const Color(0xFFFEF2F2)
                : const Color(0xFFEFF6FF),
            borderColor: _isCritical
                ? const Color(0xFFFECACA)
                : const Color(0xFFBFDBFE),
            items: riskInfo.improve,
            r: r,
          ),
        ],
      ],
    );
  }
}

class _HeadlineCard extends StatelessWidget {
  final RiskInfo riskInfo;
  final ResponsiveHelper r;
  const _HeadlineCard({required this.riskInfo, required this.r});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(r.sp(18)),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          riskInfo.gradient[0].withOpacity(0.12),
          riskInfo.gradient[0].withOpacity(0.05),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: riskInfo.gradient[0].withOpacity(0.22),
        width: 1.2,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: riskInfo.gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: riskInfo.gradient[0].withOpacity(0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(riskInfo.icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                riskInfo.headline,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(14),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: r.sp(12)),
        Text(
          riskInfo.summary,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(13),
            color: Colors.grey.shade700,
            height: 1.65,
          ),
        ),
      ],
    ),
  );
}
