import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/expandable_card.dart';

/// Tab content for "Ibu Hamil" — trimester guides and key nutrients.
class TabIbuHamil extends StatelessWidget {
  final ResponsiveHelper r;

  const TabIbuHamil({super.key, required this.r});

  static const _trimesters = [
    (
      'Trimester 1 (0–12 Minggu)',
      Color(0xFF059669),
      [
        'Konsumsi asam folat 400 mcg/hari untuk mencegah cacat tabung saraf.',
        'Hindari rokok, alkohol, dan obat-obatan tanpa resep dokter.',
        'Atasi mual dengan makan kecil tapi sering, 5–6 kali per hari.',
        'Mulai suplemen zat besi dan kalsium sesuai anjuran bidan/dokter.',
      ],
    ),
    (
      'Trimester 2 (13–27 Minggu)',
      Color(0xFF3B82F6),
      [
        'Tingkatkan asupan protein: 70–100 gram per hari (telur, ikan, tahu, tempe).',
        'Konsumsi kalsium 1200 mg/hari untuk pembentukan tulang janin.',
        'Lakukan pemeriksaan USG untuk memantau pertumbuhan janin.',
        'Aktif bergerak ringan: jalan kaki 30 menit per hari jika kondisi memungkinkan.',
      ],
    ),
    (
      'Trimester 3 (28–40 Minggu)',
      Color(0xFF8B5CF6),
      [
        'Perbanyak zat besi: 27 mg/hari untuk mencegah anemia pada ibu dan janin.',
        'Konsumsi DHA (omega-3) untuk perkembangan otak janin: ikan salmon, sarden.',
        'Istirahat cukup, hindari stres berlebihan yang bisa mengganggu pertumbuhan janin.',
        'Persiapkan ASI: pijat payudara dan kenali tanda-tanda persalinan.',
      ],
    ),
  ];

  static const _nutrients = [
    ('🥚', 'Protein', 'Telur, ikan, ayam', Color(0xFF3B82F6)),
    ('🥦', 'Asam Folat', 'Sayuran hijau', Color(0xFF059669)),
    ('🥛', 'Kalsium', 'Susu, keju, tahu', Color(0xFF8B5CF6)),
    ('🐟', 'DHA', 'Ikan berlemak', Color(0xFFF59E0B)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AlertBanner(r: r),
        SizedBox(height: r.sp(12)),
        ..._trimesters.map(
          (t) => Padding(
            padding: EdgeInsets.only(bottom: r.sp(12)),
            child: ExpandableCard(title: t.$1, color: t.$2, tips: t.$3, r: r),
          ),
        ),
        _NutrisiGrid(nutrients: _nutrients, r: r),
      ],
    );
  }
}

class _AlertBanner extends StatelessWidget {
  final ResponsiveHelper r;

  const _AlertBanner({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(14)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFEC4899).withOpacity(0.12),
            const Color(0xFFEC4899).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEC4899).withOpacity(0.25),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Text('🤰', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Gizi ibu hamil adalah fondasi terpenting bagi tumbuh kembang janin. Kekurangan gizi sejak dalam kandungan meningkatkan risiko stunting hingga 3× lipat.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(12.5),
                color: const Color(0xFF831843),
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NutrisiGrid extends StatelessWidget {
  final List<(String, String, String, Color)> nutrients;
  final ResponsiveHelper r;

  const _NutrisiGrid({required this.nutrients, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8F0FE), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🍽️', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                'Nutrisi Kunci Ibu Hamil',
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
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2.4,
            children: nutrients
                .map(
                  (n) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: n.$4.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: n.$4.withOpacity(0.20),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(n.$1, style: TextStyle(fontSize: r.fs(16))),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                n.$2,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: r.fs(10.5),
                                  fontWeight: FontWeight.w700,
                                  color: n.$4,
                                ),
                              ),
                              Text(
                                n.$3,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: r.fs(9.5),
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
