import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_history_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_answer_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_domain_entity.dart';

// ─────────────────────────────────────────────
// RESPONSIVE HELPER
// ─────────────────────────────────────────────
class _R {
  final double w;
  final double h;
  _R(BuildContext context)
    : w = MediaQuery.of(context).size.width,
      h = MediaQuery.of(context).size.height;
  double fs(double size) => (size * w / 390).clamp(size * 0.78, size * 1.18);
  double sp(double size) => (size * h / 844).clamp(size * 0.58, size * 1.22);
  bool get isSmall => h < 680;
}

// ─────────────────────────────────────────────
// RISK LEVEL MODEL
// ─────────────────────────────────────────────
enum _RiskLevel { veryLow, low, medium, high, veryHigh }

class _RiskInfo {
  final _RiskLevel level;
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

  const _RiskInfo({
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

// ─────────────────────────────────────────────
// RISK CONTENT DATABASE
// ─────────────────────────────────────────────
const _riskDatabase = {
  _RiskLevel.veryLow: _RiskInfo(
    level: _RiskLevel.veryLow,
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

  _RiskLevel.low: _RiskInfo(
    level: _RiskLevel.low,
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

  _RiskLevel.medium: _RiskInfo(
    level: _RiskLevel.medium,
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

  _RiskLevel.high: _RiskInfo(
    level: _RiskLevel.high,
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

  _RiskLevel.veryHigh: _RiskInfo(
    level: _RiskLevel.veryHigh,
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

// ─────────────────────────────────────────────
// RISK LEVEL RESOLVER
// ─────────────────────────────────────────────
_RiskLevel _resolveRisk(String result) {
  final lower = result.toLowerCase();
  if (lower.contains('sangat tinggi')) return _RiskLevel.veryHigh;
  if (lower.contains('tinggi')) return _RiskLevel.high;
  if (lower.contains('sedang')) return _RiskLevel.medium;
  if (lower.contains('ringan')) return _RiskLevel.low;
  return _RiskLevel.veryLow;
}

// ─────────────────────────────────────────────
// HISTORY DETAIL SCREEN
// ─────────────────────────────────────────────
class HistoryDetailScreen extends StatefulWidget {
  final DiagnosisHistoryEntity history;
  const HistoryDetailScreen({super.key, required this.history});

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.75, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
        );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = _R(context);
    final risk = _resolveRisk(widget.history.result);
    final riskInfo = _riskDatabase[risk]!;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      // ── BODY: CustomScrollView with pinned SliverAppBar ──
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── FIXED HEADER (pinned: true) ──
              SliverAppBar(
                expandedHeight: r.isSmall ? 130 : 150,
                collapsedHeight: kToolbarHeight + 12,
                pinned: true, // ← TETAP di atas saat scroll
                floating: false,
                snap: false,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                  background: _HeaderBackground(history: widget.history, r: r),
                ),
              ),

              // ── CONTENT ──
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16, r.sp(16), 16, r.sp(40)),
                sliver: _ContentSliver(
                  history: widget.history,
                  riskInfo: riskInfo,
                  r: r,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HEADER BACKGROUND (inside SliverAppBar)
// ─────────────────────────────────────────────
class _HeaderBackground extends StatelessWidget {
  final DiagnosisHistoryEntity history;
  final _R r;
  const _HeaderBackground({required this.history, required this.r});

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A1628), Color(0xFF1E3A8A)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Stack(
        children: [
          // Grid decoration
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(28),
              ),
              child: CustomPaint(painter: _GridPainter()),
            ),
          ),

          // Top-right orb
          Positioned(
            top: -30,
            right: -20,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF3B82F6).withOpacity(0.22),
                    const Color(0xFF3B82F6).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // Content row
          Positioned(
            left: 16,
            right: 16,
            top: topPad + r.sp(10),
            bottom: r.sp(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back button
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.20),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // Title + date
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Skrining',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(18),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        DateFormat(
                          'dd MMM yyyy • HH:mm',
                        ).format(history.createdAt),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(11),
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),

                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF3B82F6).withOpacity(0.35),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.history_rounded,
                        size: 12,
                        color: Color(0xFF93C5FD),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Riwayat',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(10),
                          color: const Color(0xFF93C5FD),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CONTENT SLIVER (all scrollable content)
// ─────────────────────────────────────────────
class _ContentSliver extends StatelessWidget {
  final DiagnosisHistoryEntity history;
  final _RiskInfo riskInfo;
  final _R r;

  const _ContentSliver({
    required this.history,
    required this.riskInfo,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      // Result card
      _ResultCard(history: history, riskInfo: riskInfo, r: r),
      SizedBox(height: r.sp(20)),

      // Narrative section
      _SectionLabel(label: 'Rekomendasi & Tindakan', r: r),
      SizedBox(height: r.sp(12)),
      _RiskNarrativeCard(riskInfo: riskInfo, r: r),
      SizedBox(height: r.sp(20)),

      // Domain section label
      _SectionLabel(label: 'Nilai Certainty Factor', r: r),
      SizedBox(height: r.sp(12)),

      // Domain cards
      ...history.domains.asMap().entries.map(
        (e) => Padding(
          padding: EdgeInsets.only(bottom: r.sp(12)),
          child: _DomainCard(domain: e.value, index: e.key, r: r),
        ),
      ),

      SizedBox(height: r.sp(8)),

      // Answer section label
      _SectionLabel(label: 'Detail Jawaban', r: r),
      SizedBox(height: r.sp(12)),

      // Answer cards
      ...history.answers.asMap().entries.map(
        (e) => Padding(
          padding: EdgeInsets.only(bottom: r.sp(10)),
          child: _AnswerCard(answer: e.value, index: e.key, r: r),
        ),
      ),
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => widgets[index],
        childCount: widgets.length,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// RESULT CARD
// ─────────────────────────────────────────────
class _ResultCard extends StatelessWidget {
  final DiagnosisHistoryEntity history;
  final _RiskInfo riskInfo;
  final _R r;
  const _ResultCard({
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
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
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
                ),
                SizedBox(height: r.sp(14)),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.30),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    riskInfo.label,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.fs(11),
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
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
                Row(
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      color: Colors.white70,
                      size: 15,
                    ),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${history.domains.length} Domain',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(10.5),
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// RISK NARRATIVE CARD
// ─────────────────────────────────────────────
class _RiskNarrativeCard extends StatelessWidget {
  final _RiskInfo riskInfo;
  final _R r;
  const _RiskNarrativeCard({required this.riskInfo, required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Headline card
        Container(
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
        ),

        SizedBox(height: r.sp(12)),

        // Warning block
        if (riskInfo.warning.isNotEmpty) ...[
          _ActionBlock(
            title: 'Perhatian Penting',
            icon: Icons.notifications_active_rounded,
            gradient: [const Color(0xFFDC2626), const Color(0xFF991B1B)],
            bgColor: const Color(0xFFFEF2F2),
            borderColor: const Color(0xFFFECACA),
            items: riskInfo.warning,
            r: r,
            isBullet: false,
          ),
          SizedBox(height: r.sp(12)),
        ],

        // Maintain block
        if (riskInfo.maintain.isNotEmpty) ...[
          _ActionBlock(
            title:
                riskInfo.level == _RiskLevel.veryLow ||
                    riskInfo.level == _RiskLevel.low
                ? 'Yang Perlu Dipertahankan'
                : 'Yang Masih Perlu Dijaga',
            icon: Icons.shield_rounded,
            gradient: [const Color(0xFF059669), const Color(0xFF047857)],
            bgColor: const Color(0xFFF0FDF4),
            borderColor: const Color(0xFFBBF7D0),
            items: riskInfo.maintain,
            r: r,
          ),
          SizedBox(height: r.sp(12)),
        ],

        // Improve block
        if (riskInfo.improve.isNotEmpty)
          _ActionBlock(
            title:
                riskInfo.level == _RiskLevel.veryLow ||
                    riskInfo.level == _RiskLevel.low
                ? 'Yang Bisa Ditingkatkan'
                : 'Tindakan yang Harus Dilakukan',
            icon: riskInfo.level.index >= 2
                ? Icons.medical_services_rounded
                : Icons.trending_up_rounded,
            gradient: riskInfo.level.index >= 3
                ? [const Color(0xFFEF4444), const Color(0xFFB91C1C)]
                : [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)],
            bgColor: riskInfo.level.index >= 3
                ? const Color(0xFFFEF2F2)
                : const Color(0xFFEFF6FF),
            borderColor: riskInfo.level.index >= 3
                ? const Color(0xFFFECACA)
                : const Color(0xFFBFDBFE),
            items: riskInfo.improve,
            r: r,
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// ACTION BLOCK
// ─────────────────────────────────────────────
class _ActionBlock extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final Color bgColor;
  final Color borderColor;
  final List<String> items;
  final _R r;
  final bool isBullet;

  const _ActionBlock({
    required this.title,
    required this.icon,
    required this.gradient,
    required this.bgColor,
    required this.borderColor,
    required this.items,
    required this.r,
    this.isBullet = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(16)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.07),
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
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                      color: gradient[0].withOpacity(0.30),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(13),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: gradient[0].withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${items.length}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(10),
                    fontWeight: FontWeight.w700,
                    color: gradient[0],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(12)),
          Container(height: 1, color: gradient[0].withOpacity(0.10)),
          SizedBox(height: r.sp(10)),
          ...items.asMap().entries.map((entry) {
            final i = entry.key;
            final text = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                bottom: i < items.length - 1 ? r.sp(10) : 0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    margin: const EdgeInsets.only(top: 1),
                    decoration: BoxDecoration(
                      color: gradient[0].withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: isBullet
                          ? Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: gradient[0],
                                shape: BoxShape.circle,
                              ),
                            )
                          : Icon(
                              Icons.priority_high_rounded,
                              size: 12,
                              color: gradient[0],
                            ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(12.5),
                        color: const Color(0xFF374151),
                        height: 1.55,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SECTION LABEL
// ─────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  final _R r;
  const _SectionLabel({required this.label, required this.r});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: const Color(0xFF3B82F6),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(15),
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// DOMAIN CARD
// ─────────────────────────────────────────────
class _DomainCard extends StatefulWidget {
  final DiagnosisDomainEntity domain;
  final int index;
  final _R r;
  const _DomainCard({
    required this.domain,
    required this.index,
    required this.r,
  });

  @override
  State<_DomainCard> createState() => _DomainCardState();
}

class _DomainCardState extends State<_DomainCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _barAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _barAnim = Tween<double>(
      begin: 0,
      end: widget.domain.cfValue.clamp(0.0, 1.0),
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    Future.delayed(Duration(milliseconds: 150 + widget.index * 80), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Color _barColor(double v) {
    if (v >= 0.7) return const Color(0xFFEF4444);
    if (v >= 0.4) return const Color(0xFFF59E0B);
    return const Color(0xFF059669);
  }

  Color _bgColor(double v) {
    if (v >= 0.7) return const Color(0xFFFEF2F2);
    if (v >= 0.4) return const Color(0xFFFFFBEB);
    return const Color(0xFFF0FDF4);
  }

  String _levelLabel(double v) {
    if (v >= 0.7) return 'Tinggi';
    if (v >= 0.4) return 'Sedang';
    return 'Rendah';
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    final value = widget.domain.cfValue.clamp(0.0, 1.0);
    final barColor = _barColor(value);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFE8F0FE), width: 1),
      ),
      padding: EdgeInsets.all(r.sp(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: _bgColor(value),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _barColor(value).withOpacity(0.25),
                    width: 1,
                  ),
                ),
                child: Text(
                  widget.domain.domainCode,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(12),
                    fontWeight: FontWeight.w700,
                    color: _barColor(value),
                  ),
                ),
              ),
              const Spacer(),
              AnimatedBuilder(
                animation: _barAnim,
                builder: (_, __) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        barColor.withOpacity(0.15),
                        barColor.withOpacity(0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: barColor.withOpacity(0.25),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        value.toStringAsFixed(2),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(13),
                          fontWeight: FontWeight.w800,
                          color: barColor,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: barColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _levelLabel(value),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(9),
                            fontWeight: FontWeight.w600,
                            color: barColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(14)),
          AnimatedBuilder(
            animation: _barAnim,
            builder: (_, __) => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: _barAnim.value,
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [barColor.withOpacity(0.7), barColor],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: barColor.withOpacity(0.35),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: r.sp(6)),
                Text(
                  '${(_barAnim.value * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(10),
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ANSWER CARD
// ─────────────────────────────────────────────
class _AnswerCard extends StatelessWidget {
  final DiagnosisAnswerEntity answer;
  final int index;
  final _R r;
  const _AnswerCard({
    required this.answer,
    required this.index,
    required this.r,
  });

  List<Color> _keyGradient(String key) {
    const map = {
      'A': [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
      'B': [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
      'C': [Color(0xFF059669), Color(0xFF047857)],
      'D': [Color(0xFFF59E0B), Color(0xFFD97706)],
      'E': [Color(0xFFEC4899), Color(0xFFBE185D)],
    };
    return map[key.toUpperCase()] ??
        const [Color(0xFF3B82F6), Color(0xFF1D4ED8)];
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _keyGradient(answer.answerKey);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFE8F0FE), width: 1),
      ),
      padding: EdgeInsets.all(r.sp(14)),
      child: Row(
        children: [
          Container(
            width: r.isSmall ? 40 : 46,
            height: r.isSmall ? 40 : 46,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradient,
              ),
              borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  color: gradient[0].withOpacity(0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                answer.answerKey,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(15),
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: r.sp(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  answer.questionCode,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(13.5),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: r.sp(4)),
                Row(
                  children: [
                    Text(
                      'CF Item:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11.5),
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      answer.cfItem.toStringAsFixed(2),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11.5),
                        fontWeight: FontWeight.w700,
                        color: gradient[0],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(10),
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// GRID PAINTER
// ─────────────────────────────────────────────
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = const Color(0xFF1E3A5F).withOpacity(0.30)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;
    const g = 38.0;
    for (double x = 0; x < size.width + g; x += g)
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    for (double y = 0; y < size.height + g; y += g)
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    final orb = Paint()
      ..shader =
          RadialGradient(
            colors: [
              const Color(0xFF3B82F6).withOpacity(0.25),
              const Color(0xFF3B82F6).withOpacity(0.0),
            ],
          ).createShader(
            Rect.fromCircle(center: Offset(size.width + 20, -20), radius: 140),
          );
    canvas.drawCircle(Offset(size.width + 20, -20), 140, orb);
  }

  @override
  bool shouldRepaint(_GridPainter _) => false;
}
