import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/ciri/ciri_header.dart';

class SummaryStrip extends StatelessWidget {
  final ResponsiveHelper r;

  const SummaryStrip({super.key, required this.r});

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
      child: Row(
        children: SignCategory.values.map((cat) {
          final color = CategoryMeta.colors[cat]!;
          final icon = CategoryMeta.icons[cat]!;
          final label = CategoryMeta.labels[cat]!;
          final count = CiriData.countByCategory(cat);

          return Expanded(
            child: Column(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.10),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                SizedBox(height: r.sp(6)),
                Text(
                  '$count',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(16),
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(9.5),
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

abstract class CategoryMeta {
  static const Map<SignCategory, String> labels = {
    SignCategory.fisik: 'Fisik',
    SignCategory.kognitif: 'Kognitif',
    SignCategory.imun: 'Imunitas',
    SignCategory.perilaku: 'Perilaku',
  };

  static const Map<SignCategory, IconData> icons = {
    SignCategory.fisik: Icons.accessibility_new_rounded,
    SignCategory.kognitif: Icons.psychology_rounded,
    SignCategory.imun: Icons.shield_rounded,
    SignCategory.perilaku: Icons.emoji_emotions_rounded,
  };

  static const Map<SignCategory, Color> colors = {
    SignCategory.fisik: Color(0xFF3B82F6),
    SignCategory.kognitif: Color(0xFF8B5CF6),
    SignCategory.imun: Color(0xFFEF4444),
    SignCategory.perilaku: Color(0xFFEC4899),
  };
}
