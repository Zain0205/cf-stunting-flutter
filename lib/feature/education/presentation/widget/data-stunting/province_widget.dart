import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/data-stunting/trend_chart.dart';

class ProvinceFilter extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  final ResponsiveHelper r;

  const ProvinceFilter({
    super.key,
    required this.selected,
    required this.onSelect,
    required this.r,
  });

  static const _filters = [
    ('Semua', Color(0xFF475569), Icons.apps_rounded),
    ('Kritis ≥28%', Color(0xFFDC2626), Icons.priority_high_rounded),
    ('Sedang 18–28%', Color(0xFFF59E0B), Icons.remove_rounded),
    ('Rendah <18%', Color(0xFF059669), Icons.check_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: _filters.asMap().entries.map((e) {
          final i = e.key;
          final f = e.value;
          final isSel = selected == i;
          return Padding(
            padding: EdgeInsets.only(right: i < _filters.length - 1 ? 8 : 0),
            child: GestureDetector(
              onTap: () => onSelect(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: r.sp(12),
                  vertical: r.sp(8),
                ),
                decoration: BoxDecoration(
                  color: isSel ? f.$2 : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSel ? f.$2 : Colors.grey.shade200,
                    width: 1,
                  ),
                  boxShadow: isSel
                      ? [
                          BoxShadow(
                            color: f.$2.withOpacity(0.30),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(f.$3, size: 13, color: isSel ? Colors.white : f.$2),
                    const SizedBox(width: 5),
                    Text(
                      f.$1,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11.5),
                        fontWeight: FontWeight.w600,
                        color: isSel ? Colors.white : f.$2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Scrollable list of province rows inside a white card.
class ProvinceList extends StatelessWidget {
  final List<ProvinceData> provinces;
  final ResponsiveHelper r;

  const ProvinceList({super.key, required this.provinces, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8F0FE), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.07),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: provinces.asMap().entries.map((e) {
          final i = e.key;
          final p = e.value;
          final color = StuntingData.levelColor(p.percent);
          final isLast = i == provinces.length - 1;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: r.sp(16),
                  vertical: r.sp(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(11),
                            fontWeight: FontWeight.w700,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: r.fs(13),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            p.island,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: r.fs(10),
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${p.percent}%',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(14),
                            fontWeight: FontWeight.w800,
                            color: color,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            StuntingData.levelLabel(p.percent),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: r.fs(9.5),
                              fontWeight: FontWeight.w600,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(horizontal: r.sp(16)),
                  color: Colors.grey.shade50,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
