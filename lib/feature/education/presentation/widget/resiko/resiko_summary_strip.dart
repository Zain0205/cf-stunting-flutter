import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/resiko/resiko_header.dart';

class ResikoSummaryStrip extends StatelessWidget {
  final ResponsiveHelper r;

  const ResikoSummaryStrip({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8F0FE), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.07),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        spacing: r.sp(8),
        runSpacing: r.sp(8),
        children: RiskGroup.values.map((g) {
          final color = GroupMeta.color(g);
          final count = ResikoData.countByGroup(g);

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: r.sp(10),
              vertical: r.sp(6),
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withOpacity(0.18), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(GroupMeta.emoji(g), style: TextStyle(fontSize: r.fs(14))),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      GroupMeta.label(g),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(10),
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                    Text(
                      '$count risiko',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(9),
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

abstract class GroupMeta {
  static const Map<RiskGroup, (String, String, Color)> data = {
    RiskGroup.prahamil: ('🌸', 'Pra-Kehamilan', Color(0xFFEC4899)),
    RiskGroup.ibuHamil: ('🤰', 'Ibu Hamil', Color(0xFF8B5CF6)),
    RiskGroup.bayiBaru: ('👶', 'Bayi 0–12 Bln', Color(0xFF3B82F6)),
    RiskGroup.balita: ('🧒', 'Balita 1–5 Thn', Color(0xFF059669)),
    RiskGroup.dewasa: ('👤', 'Dampak Dewasa', Color(0xFFEF4444)),
    RiskGroup.komunitas: ('🏘️', 'Komunitas', Color(0xFF6B7280)),
  };

  static String emoji(RiskGroup g) => data[g]!.$1;
  static String label(RiskGroup g) => data[g]!.$2;
  static Color color(RiskGroup g) => data[g]!.$3;
}
