import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_history_entity.dart';

/// Gradient card showing the main diagnosis result with risk level,
/// date, and domain count.
class ResultCard extends StatelessWidget {
  final DiagnosisHistoryEntity history;
  final RiskInfo riskInfo;
  final ResponsiveHelper r;

  const ResultCard({
    super.key,
    required this.history,
    required this.riskInfo,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM yyyy • HH:mm').format(history.createdAt);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: riskInfo.gradient,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: riskInfo.gradient[0].withOpacity(0.40),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(r.sp(22)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TopRow(riskInfo: riskInfo, r: r),
                SizedBox(height: r.sp(14)),
                _RiskLevelChip(label: riskInfo.label, r: r),
                SizedBox(height: r.sp(8)),
                Text(
                  history.result,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(r.isSmall ? 18 : 22),
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.2,
                    letterSpacing: -0.4,
                  ),
                ),
                SizedBox(height: r.sp(16)),
                Container(height: 1, color: Colors.white.withOpacity(0.20)),
                SizedBox(height: r.sp(12)),
                _BottomRow(
                  date: date,
                  domainCount: history.domains.length,
                  r: r,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopRow extends StatelessWidget {
  final RiskInfo riskInfo;
  final ResponsiveHelper r;
  const _TopRow({required this.riskInfo, required this.r});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.20),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Hasil Skrining',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(10.5),
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const Spacer(),
      Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(riskInfo.icon, color: Colors.white, size: 22),
      ),
    ],
  );
}

class _RiskLevelChip extends StatelessWidget {
  final String label;
  final ResponsiveHelper r;
  const _RiskLevelChip({required this.label, required this.r});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withOpacity(0.30), width: 1),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: r.fs(11),
        color: Colors.white,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      ),
    ),
  );
}

class _BottomRow extends StatelessWidget {
  final String date;
  final int domainCount;
  final ResponsiveHelper r;
  const _BottomRow({
    required this.date,
    required this.domainCount,
    required this.r,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Icon(Icons.schedule_rounded, color: Colors.white70, size: 15),
      const SizedBox(width: 6),
      Text(
        date,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(12),
          color: Colors.white70,
        ),
      ),
      const Spacer(),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '$domainCount Domain',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(10.5),
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

enum RiskLevel { veryLow, low, medium, high, veryHigh }

class RiskInfo {
  final RiskLevel level;
  final String label;
  final List<Color> gradient;
  final Color bgTint;
  final Color borderColor;
  final IconData icon;
  final String headline;
  final String summary;
  final List<String> maintain;
  final List<String> improve;
  final List<String> warning;

  const RiskInfo({
    required this.level,
    required this.label,
    required this.gradient,
    required this.bgTint,
    required this.borderColor,
    required this.icon,
    required this.headline,
    required this.summary,
    required this.maintain,
    required this.improve,
    required this.warning,
  });
}

abstract class RiskDatabase {
  static const Map<RiskLevel, RiskInfo> data = {
    RiskLevel.veryLow: RiskInfo(
      level: RiskLevel.veryLow,
      label: 'Risiko Rendah',
      gradient: [Color(0xFF059669), Color(0xFF047857)],
      bgTint: Color(0xFFF0FDF4),
      borderColor: Color(0xFFBBF7D0),
      icon: Icons.check_circle_rounded,
      headline: '🎉 Kondisi Anda Sangat Baik!',
      summary:
          'Berdasarkan hasil skrining, kondisi kesehatan anak Anda berada pada level risiko rendah. Pertumbuhan dan perkembangan berjalan dengan baik. Tetaplah konsisten menjalankan pola hidup sehat yang sudah diterapkan.',
      maintain: [
        'Lanjutkan pemberian ASI eksklusif hingga 6 bulan dan MPASI bergizi setelah itu.',
        'Pertahankan jadwal imunisasi lengkap sesuai rekomendasi Kemenkes.',
        'Rutin menimbang berat badan dan mengukur tinggi badan anak di Posyandu setiap bulan.',
        'Jaga kebersihan lingkungan dan sanitasi rumah agar anak terhindar dari infeksi.',
        'Berikan stimulasi tumbuh kembang sesuai usia seperti bermain, bernyanyi, dan membaca.',
      ],
      improve: [
        'Lakukan skrining ulang dalam 7 hari untuk memastikan kondisi tetap terjaga.',
        'Konsultasikan perkembangan anak ke bidan atau dokter anak secara berkala.',
        'Perbanyak konsumsi sayur, buah, dan protein hewani dalam menu harian.',
      ],
      warning: [],
    ),

    RiskLevel.low: RiskInfo(
      level: RiskLevel.low,
      label: 'Risiko Ringan',
      gradient: [Color(0xFF10B981), Color(0xFF059669)],
      bgTint: Color(0xFFF0FDF4),
      borderColor: Color(0xFFA7F3D0),
      icon: Icons.thumb_up_rounded,
      headline: '✅ Kondisi Cukup Baik, Tetap Waspada',
      summary:
          'Hasil skrining menunjukkan risiko ringan. Kondisi secara umum baik, namun terdapat beberapa aspek yang perlu mendapat perhatian lebih agar risiko tidak berkembang menjadi lebih besar.',
      maintain: [
        'Pertahankan pola makan bergizi seimbang dengan 4 kelompok pangan: karbohidrat, protein, lemak, dan vitamin.',
        'Lanjutkan kunjungan rutin ke Posyandu minimal 1 kali per bulan.',
        'Pastikan anak mendapatkan tidur yang cukup dan berkualitas setiap malam.',
        'Jaga kebersihan diri dan lingkungan sekitar secara konsisten.',
      ],
      improve: [
        'Tingkatkan asupan protein hewani seperti telur, ikan, ayam, dan daging.',
        'Pastikan anak mendapat cukup cairan dan tidak mengalami dehidrasi.',
        'Perhatikan tumbuh kembang anak lebih cermat, terutama berat dan tinggi badan.',
        'Lakukan skrining ulang setelah 7 hari untuk memantau perubahan kondisi.',
        'Konsultasikan hasil skrining ini kepada petugas kesehatan terdekat.',
      ],
      warning: [],
    ),

    RiskLevel.medium: RiskInfo(
      level: RiskLevel.medium,
      label: 'Risiko Sedang',
      gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
      bgTint: Color(0xFFFFFBEB),
      borderColor: Color(0xFFFDE68A),
      icon: Icons.warning_amber_rounded,
      headline: '⚠️ Perlu Perhatian Lebih Serius',
      summary:
          'Hasil skrining menunjukkan risiko sedang. Kondisi ini mengindikasikan adanya beberapa faktor risiko yang perlu segera ditangani. Penanganan dini sangat penting untuk mencegah kondisi memburuk.',
      maintain: [
        'Tetap lanjutkan rutinitas Posyandu dan pantau grafik pertumbuhan anak.',
        'Pertahankan kebersihan makanan dan minuman yang dikonsumsi sehari-hari.',
        'Jaga jadwal tidur dan aktivitas anak agar tetap teratur.',
      ],
      improve: [
        'Segera konsultasikan kondisi anak kepada bidan, dokter, atau ahli gizi terdekat.',
        'Perbaiki asupan gizi dengan menambahkan makanan kaya zat besi, zinc, dan vitamin A.',
        'Pastikan anak mendapat imunisasi yang belum lengkap sesegera mungkin.',
        'Periksa sanitasi air minum dan toilet di rumah — pastikan bersih dan higienis.',
        'Berikan suplemen gizi sesuai rekomendasi tenaga kesehatan jika diperlukan.',
        'Hindari makanan rendah gizi seperti junk food, minuman manis berlebih, dan camilan tidak bergizi.',
      ],
      warning: [
        'Jangan menunggu kondisi memburuk untuk mencari bantuan medis.',
        'Lakukan skrining ulang dalam 7 hari untuk memantau perkembangan kondisi.',
      ],
    ),

    RiskLevel.high: RiskInfo(
      level: RiskLevel.high,
      label: 'Risiko Tinggi',
      gradient: [Color(0xFFEF4444), Color(0xFFB91C1C)],
      bgTint: Color(0xFFFEF2F2),
      borderColor: Color(0xFFFECACA),
      icon: Icons.error_rounded,
      headline: '🚨 Tindakan Segera Diperlukan',
      summary:
          'Hasil skrining menunjukkan risiko tinggi terhadap stunting. Kondisi ini memerlukan tindakan yang cepat dan tepat. Penanganan segera oleh tenaga kesehatan sangat direkomendasikan untuk mencegah dampak jangka panjang pada tumbuh kembang anak.',
      maintain: [
        'Tetap berikan makan secara teratur meski dalam porsi kecil namun sering (minimal 5–6 kali per hari).',
        'Jaga kebersihan diri anak dengan mencuci tangan sebelum dan sesudah makan.',
      ],
      improve: [
        'Segera bawa anak ke Puskesmas, Klinik, atau Rumah Sakit untuk evaluasi medis lengkap.',
        'Minta rujukan ke ahli gizi klinis untuk program pemulihan gizi intensif.',
        'Ikuti program Pemberian Makanan Tambahan (PMT) dari Pemerintah jika tersedia.',
        'Pastikan anak mendapatkan suplemen zat besi, vitamin D, dan zinc sesuai resep dokter.',
        'Perbaiki kondisi sanitasi rumah: air bersih, jamban sehat, tempat sampah tertutup.',
        'Hindari paparan asap rokok dan polusi udara di sekitar anak.',
        'Catat perkembangan berat badan, tinggi badan, dan kondisi kesehatan anak setiap minggu.',
      ],
      warning: [
        'Jangan abaikan hasil ini — penanganan tertunda dapat berdampak permanen pada kecerdasan dan pertumbuhan anak.',
        'Hubungi kader Posyandu atau bidan desa segera untuk pendampingan intensif.',
        'Laporkan kondisi ini ke program Intervensi Stunting di wilayah Anda.',
      ],
    ),

    RiskLevel.veryHigh: RiskInfo(
      level: RiskLevel.veryHigh,
      label: 'Risiko Sangat Tinggi',
      gradient: [Color(0xFFDC2626), Color(0xFF7F1D1D)],
      bgTint: Color(0xFFFFF1F2),
      borderColor: Color(0xFFFFCDD2),
      icon: Icons.crisis_alert_rounded,
      headline: '🆘 Darurat — Segera Hubungi Tenaga Medis',
      summary:
          'Hasil skrining menunjukkan risiko sangat tinggi. Ini merupakan kondisi darurat gizi yang membutuhkan penanganan medis segera. Keterlambatan penanganan dapat menyebabkan dampak permanen dan tidak dapat dipulihkan pada tumbuh kembang anak.',
      maintain: [
        'Tetap berikan asupan makanan dan minuman meski hanya sedikit untuk mencegah dehidrasi.',
        'Pastikan anak mendapat istirahat cukup dan tidak stres.',
      ],
      improve: [
        'SEGERA bawa anak ke Rumah Sakit atau Puskesmas dengan fasilitas rawat inap.',
        'Minta penanganan gizi buruk atau gizi kurang berat sesuai protokol Kemenkes.',
        'Ikuti seluruh anjuran dokter, ahli gizi, dan tenaga kesehatan tanpa penundaan.',
        'Daftarkan anak ke program Therapeutic Feeding Center (TFC) jika tersedia.',
        'Dokumentasikan kondisi anak (foto, catatan berat/tinggi badan) untuk pemantauan medis.',
        'Minta dukungan keluarga dan komunitas dalam proses pemulihan.',
        'Pastikan seluruh anggota keluarga menerapkan pola hidup bersih dan sehat.',
      ],
      warning: [
        'INI ADALAH KONDISI DARURAT. Jangan tunda penanganan medis lebih dari 24 jam.',
        'Hubungi 119 (hotline kesehatan) atau datangi fasilitas kesehatan terdekat sekarang.',
        'Tanpa penanganan segera, kondisi ini dapat menyebabkan kerusakan kognitif permanen.',
        'Laporkan ke Dinas Kesehatan setempat untuk mendapat intervensi program stunting.',
      ],
    ),
  };

  /// Resolve risk level from a free-form result string.
  static RiskLevel resolve(String result) {
    final lower = result.toLowerCase();
    if (lower.contains('sangat tinggi')) return RiskLevel.veryHigh;
    if (lower.contains('tinggi')) return RiskLevel.high;
    if (lower.contains('sedang')) return RiskLevel.medium;
    if (lower.contains('ringan')) return RiskLevel.low;
    return RiskLevel.veryLow;
  }
}
