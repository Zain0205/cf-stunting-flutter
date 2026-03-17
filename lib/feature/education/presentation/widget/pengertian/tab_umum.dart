import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/info_card.dart';

/// Tab content for "Umum" — causes and long-term impacts of stunting.
class TabUmum extends StatelessWidget {
  final ResponsiveHelper r;

  const TabUmum({super.key, required this.r});

  static const _causes = [
    (
      '🥗',
      'Kurang Gizi Kronis',
      'Asupan protein, zat besi, zinc, dan vitamin A tidak terpenuhi dalam jangka panjang.',
    ),
    (
      '🦠',
      'Infeksi Berulang',
      'Diare, ISPA, dan infeksi parasit menyebabkan tubuh anak tidak menyerap nutrisi dengan baik.',
    ),
    (
      '💧',
      'Sanitasi Buruk',
      'Air minum tidak bersih, lingkungan kotor, dan kebiasaan cuci tangan yang buruk.',
    ),
    (
      '📚',
      'Kurang Pengetahuan',
      'Orang tua tidak mengetahui cara pemberian makan yang tepat sesuai usia anak.',
    ),
  ];

  static const _dampak = [
    ('🧠', 'Gangguan perkembangan otak & kecerdasan'),
    ('📉', 'Prestasi belajar menurun'),
    ('💪', 'Daya tahan tubuh rendah'),
    ('❤️', 'Risiko penyakit tidak menular di usia dewasa'),
    ('💼', 'Produktivitas & pendapatan lebih rendah'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoCard(
          title: 'Penyebab Utama Stunting',
          icon: Icons.search_rounded,
          gradient: const [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
          r: r,
          child: Column(
            children: _causes.asMap().entries.map((e) {
              final isLast = e.key == _causes.length - 1;
              final c = e.value;
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : r.sp(12)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(c.$1, style: TextStyle(fontSize: r.fs(18))),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.$2,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: r.fs(13),
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            c.$3,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: r.fs(11.5),
                              color: Colors.grey.shade600,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: r.sp(12)),
        _DampakCard(dampak: _dampak, r: r),
      ],
    );
  }
}

class _DampakCard extends StatelessWidget {
  final List<(String, String)> dampak;
  final ResponsiveHelper r;

  const _DampakCard({required this.dampak, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFECACA), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEF4444), Color(0xFFB91C1C)],
                  ),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.warning_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Dampak Jangka Panjang',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(13),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(12)),
          ...dampak.map(
            (d) => Padding(
              padding: EdgeInsets.only(bottom: r.sp(8)),
              child: Row(
                children: [
                  Text(d.$1, style: TextStyle(fontSize: r.fs(16))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      d.$2,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(12.5),
                        color: const Color(0xFF7F1D1D),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
