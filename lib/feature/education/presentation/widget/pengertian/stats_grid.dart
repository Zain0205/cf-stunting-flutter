import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// 2-column grid of key statistics about stunting.
class StatsGrid extends StatelessWidget {
  final ResponsiveHelper r;

  const StatsGrid({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.55,
      ),
      itemCount: PengertianData.stats.length,
      itemBuilder: (_, i) => _StatCard(item: PengertianData.stats[i], r: r),
    );
  }
}

class _StatCard extends StatelessWidget {
  final FactItem item;
  final ResponsiveHelper r;

  const _StatCard({required this.item, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: item.color.withOpacity(0.18), width: 1),
        boxShadow: [
          BoxShadow(
            color: item.color.withOpacity(0.09),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(item.emoji, style: TextStyle(fontSize: r.fs(20))),
              const Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: item.color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.value,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(16),
                  fontWeight: FontWeight.w800,
                  color: item.color,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                item.title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(10),
                  color: Colors.grey.shade500,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

abstract class PengertianData {
  static const List<MythItem> myths = [
    MythItem(
      'Anak pendek itu keturunan, tidak bisa dicegah.',
      'Stunting bukan semata soal genetik. Lebih dari 70% kasus stunting disebabkan oleh kurangnya asupan gizi, infeksi berulang, dan lingkungan tidak sehat — semua bisa dicegah.',
    ),
    MythItem(
      'Anak gemuk pasti tidak stunting.',
      'Stunting diukur dari tinggi badan terhadap usia, bukan berat badan. Anak bisa terlihat gemuk sekaligus mengalami stunting (kondisi ini disebut "stunted overweight").',
    ),
    MythItem(
      'Stunting hanya masalah fisik.',
      'Stunting juga berdampak pada perkembangan otak, kemampuan belajar, kecerdasan, dan produktivitas di masa dewasa. Dampaknya bersifat jangka panjang.',
    ),
    MythItem(
      'Stunting bisa disembuhkan setelah anak besar.',
      'Kerusakan akibat stunting yang terjadi pada 1000 HPK (Hari Pertama Kehidupan) bersifat permanen dan sangat sulit dipulihkan setelah usia 2 tahun.',
    ),
  ];

  static const List<FactItem> stats = [
    FactItem('📊', 'Prevalensi Indonesia', '21,6%', Color(0xFF3B82F6)),
    FactItem('🌍', 'Anak Stunting Dunia', '149 Juta', Color(0xFFEF4444)),
    FactItem('⏰', 'Masa Kritis', '1000 HPK', Color(0xFF059669)),
    FactItem('💰', 'Kerugian Ekonomi', '2-3% GDP', Color(0xFFF59E0B)),
  ];

  static const List<TimelineItem> timeline = [
    TimelineItem(
      'Konsepsi',
      'Persiapan Pra-kehamilan',
      'Konsumsi asam folat, perbaiki status gizi, hindari rokok & alkohol sebelum hamil.',
      Icons.favorite_rounded,
      [Color(0xFFEC4899), Color(0xFFBE185D)],
    ),
    TimelineItem(
      '0–9 Bulan',
      'Masa Kehamilan',
      'Nutrisi optimal ibu hamil, ANC rutin, suplemen zat besi & kalsium, hindari stres.',
      Icons.pregnant_woman_rounded,
      [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    ),
    TimelineItem(
      'Lahir',
      'Saat Kelahiran',
      'IMD dalam 1 jam pertama, kolostrum ASI pertama untuk kekebalan tubuh bayi.',
      Icons.baby_changing_station_rounded,
      [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    ),
    TimelineItem(
      '0–6 Bulan',
      'ASI Eksklusif',
      'Hanya ASI, tanpa tambahan apapun. ASI = perlindungan, nutrisi, dan kasih sayang.',
      Icons.water_drop_rounded,
      [Color(0xFF06B6D4), Color(0xFF0891B2)],
    ),
    TimelineItem(
      '6–24 Bulan',
      'ASI + MPASI',
      'MPASI bergizi dimulai tepat usia 6 bulan. Variasi makanan + ASI hingga 2 tahun.',
      Icons.restaurant_rounded,
      [Color(0xFF059669), Color(0xFF047857)],
    ),
  ];

  static const List<PreventionItem> prevention = [
    PreventionItem(
      Icons.water_drop_rounded,
      'ASI Eksklusif',
      'Berikan ASI eksklusif 0–6 bulan tanpa tambahan apapun.',
      [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    ),
    PreventionItem(
      Icons.restaurant_rounded,
      'MPASI Berkualitas',
      'MPASI bergizi, bervariasi, dan tepat waktu mulai usia 6 bulan.',
      [Color(0xFF059669), Color(0xFF047857)],
    ),
    PreventionItem(
      Icons.vaccines_rounded,
      'Imunisasi Lengkap',
      'Pastikan jadwal imunisasi dasar dan lanjutan terpenuhi.',
      [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    ),
    PreventionItem(
      Icons.wash_rounded,
      'Sanitasi & PHBS',
      'Cuci tangan pakai sabun, air bersih, jamban sehat.',
      [Color(0xFF06B6D4), Color(0xFF0891B2)],
    ),
    PreventionItem(
      Icons.monitor_heart_rounded,
      'Pemantauan Rutin',
      'Timbang & ukur anak di Posyandu minimal 1x per bulan.',
      [Color(0xFFF59E0B), Color(0xFFD97706)],
    ),
    PreventionItem(
      Icons.medical_services_rounded,
      'Konsultasi Rutin',
      'Periksa ke bidan/dokter secara berkala untuk deteksi dini.',
      [Color(0xFFEC4899), Color(0xFFBE185D)],
    ),
  ];
}

class FactItem {
  final String emoji;
  final String title;
  final String value;
  final Color color;

  const FactItem(this.emoji, this.title, this.value, this.color);
}

class MythItem {
  final String myth;
  final String fact;

  const MythItem(this.myth, this.fact);
}

class TimelineItem {
  final String period;
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradient;

  const TimelineItem(
    this.period,
    this.title,
    this.description,
    this.icon,
    this.gradient,
  );
}

class PreventionItem {
  final IconData icon;
  final String title;
  final String description;
  final List<Color> gradient;

  const PreventionItem(this.icon, this.title, this.description, this.gradient);
}
