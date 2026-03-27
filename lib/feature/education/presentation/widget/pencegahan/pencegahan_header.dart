import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/grid_painter.dart';

class PencegahanHeader extends StatelessWidget {
  final ResponsiveHelper r;

  const PencegahanHeader({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final headerHeight = topPad + (r.isSmall ? 80.0 : 96.0);

    return SizedBox(
      height: headerHeight,
      child: Container(
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
            Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
                child: CustomPaint(painter: const GridPainter()),
              ),
            ),
            // Green orb — matches prevention theme
            Positioned(
              top: -30,
              right: -20,
              child: _Orb(
                size: 140,
                color: const Color(0xFF059669),
                opacity: 0.20,
              ),
            ),
            Positioned(
              top: -10,
              left: -30,
              child: _Orb(
                size: 90,
                color: const Color(0xFF3B82F6),
                opacity: 0.15,
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              top: topPad + r.sp(10),
              bottom: r.sp(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _BackButton(onTap: () => Navigator.of(context).pop()),
                  const SizedBox(width: 14),
                  Expanded(child: _TitleColumn(r: r)),
                  _StepCountChip(r: r),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _Orb extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;

  const _Orb({required this.size, required this.color, required this.opacity});

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [color.withOpacity(opacity), Colors.transparent],
      ),
    ),
  );
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.20), width: 1),
      ),
      child: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Colors.white,
        size: 16,
      ),
    ),
  );
}

class _TitleColumn extends StatelessWidget {
  final ResponsiveHelper r;
  const _TitleColumn({required this.r});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Pencegahan Stunting',
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
        'Panduan lengkap dari pra-hamil hingga balita',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(10.5),
          color: Colors.white60,
        ),
      ),
    ],
  );
}

class _StepCountChip extends StatelessWidget {
  final ResponsiveHelper r;
  const _StepCountChip({required this.r});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: const Color(0xFF059669).withOpacity(0.25),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: const Color(0xFF059669).withOpacity(0.40),
        width: 1,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.shield_rounded, size: 12, color: Color(0xFF6EE7B7)),
        const SizedBox(width: 4),
        Text(
          '${PencegahanData.totalCount} Langkah',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(10),
            color: const Color(0xFF6EE7B7),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

enum PreventionPhase { prahamil, hamil, bayi, balita, keluarga }

class PreventionStep {
  final String emoji;
  final String title;
  final String subtitle;
  final List<String> actions;
  final String whyImportant;
  final PreventionPhase phase;
  final List<Color> gradient;
  final bool isPriority;

  const PreventionStep({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.actions,
    required this.whyImportant,
    required this.phase,
    required this.gradient,
    this.isPriority = false,
  });
}

class NutrientItem {
  final String emoji;
  final String name;
  final String dose;
  final String sources;
  final Color color;

  const NutrientItem(
    this.emoji,
    this.name,
    this.dose,
    this.sources,
    this.color,
  );
}

abstract class PencegahanData {
  static const List<PreventionStep> steps = [
    // ── PRA-KEHAMILAN ──
    PreventionStep(
      emoji: '💊',
      title: 'Konsumsi Asam Folat Sebelum Hamil',
      subtitle: '400 mcg/hari minimal 3 bulan sebelum hamil',
      actions: [
        'Mulai suplemen asam folat 400–800 mcg per hari.',
        'Konsumsi sayuran hijau: bayam, brokoli, kacang-kacangan.',
        'Hindari alkohol yang menghambat absorpsi folat.',
        'Periksa kadar asam folat ke dokter jika memungkinkan.',
      ],
      whyImportant:
          'Asam folat mencegah cacat tabung saraf pada janin yang terbentuk pada 28 hari pertama kehamilan — sebelum banyak ibu tahu mereka hamil.',
      phase: PreventionPhase.prahamil,
      gradient: [Color(0xFFEC4899), Color(0xFFBE185D)],
      isPriority: true,
    ),
    PreventionStep(
      emoji: '⚖️',
      title: 'Perbaiki Status Gizi Sebelum Hamil',
      subtitle: 'IMT ideal 18.5–24.9, LILA ≥23.5 cm',
      actions: [
        'Ukur lingkar lengan atas (LILA) — target ≥23.5 cm.',
        'Capai berat badan ideal dengan diet bergizi seimbang.',
        'Atasi anemia dengan suplemen zat besi sebelum hamil.',
        'Konsultasi ke ahli gizi untuk program peningkatan gizi.',
      ],
      whyImportant:
          'Ibu dengan KEK (Kurang Energi Kronis) berisiko 3× lebih tinggi melahirkan bayi BBLR. Perbaikan gizi 3–6 bulan sebelum hamil adalah investasi terbaik.',
      phase: PreventionPhase.prahamil,
      gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
      isPriority: true,
    ),
    PreventionStep(
      emoji: '🚭',
      title: 'Berhenti Merokok & Hindari Alkohol',
      subtitle: 'Zat toksik menghambat pertumbuhan janin',
      actions: [
        'Berhenti merokok aktif dan hindari asap rokok pasif.',
        'Hentikan konsumsi alkohol sepenuhnya.',
        'Jauhkan lingkungan dari paparan pestisida berlebihan.',
        'Minta pasangan/anggota keluarga untuk tidak merokok di dalam rumah.',
      ],
      whyImportant:
          'Satu batang rokok per hari meningkatkan risiko BBLR 40%. Karbon monoksida mengurangi oksigen ke janin secara langsung.',
      phase: PreventionPhase.prahamil,
      gradient: [Color(0xFF6B7280), Color(0xFF374151)],
    ),

    // ── KEHAMILAN ──
    PreventionStep(
      emoji: '🏥',
      title: 'ANC Minimal 6 Kali Selama Hamil',
      subtitle: 'Pemeriksaan rutin ke bidan/dokter',
      actions: [
        'ANC ke-1: sebelum usia kehamilan 12 minggu.',
        'ANC ke-2: usia 12–16 minggu.',
        'ANC ke-3 & 4: usia 20–26 dan 28–32 minggu.',
        'ANC ke-5 & 6: usia 34–36 dan 37–40 minggu.',
        'Laporkan semua keluhan dan pantau pertumbuhan janin via USG.',
      ],
      whyImportant:
          'ANC rutin memungkinkan deteksi dini anemia, preeklampsia, IUGR, dan komplikasi lain sebelum berdampak permanen pada janin.',
      phase: PreventionPhase.hamil,
      gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
      isPriority: true,
    ),
    PreventionStep(
      emoji: '🥩',
      title: 'Gizi Optimal Selama Kehamilan',
      subtitle: 'Tambahan 340–450 kkal dan 25 g protein/hari',
      actions: [
        'Makan 3× utama + 2–3× selingan bergizi per hari.',
        'Protein hewani: telur, ikan, ayam, daging sapi setiap hari.',
        'Suplementasi: tablet Fe 90 butir + vitamin C untuk absorpsi.',
        'Konsumsi kalsium 1.200 mg/hari dari susu, keju, tahu.',
        'DHA 200–300 mg/hari: ikan salmon, sarden, atau suplemen.',
        'Hindari makanan mentah, olahan tinggi garam/gula berlebih.',
      ],
      whyImportant:
          'Janin membangun tulang, otak, dan organ vital menggunakan nutrisi dari ibu. Defisiensi protein pada trimester 2–3 secara langsung menghambat pertumbuhan panjang badan.',
      phase: PreventionPhase.hamil,
      gradient: [Color(0xFF059669), Color(0xFF047857)],
      isPriority: true,
    ),
    PreventionStep(
      emoji: '🧘',
      title: 'Kelola Stres & Kesehatan Mental',
      subtitle: 'Stres kronis meningkatkan kortisol yang hambat janin',
      actions: [
        'Lakukan relaksasi ringan: meditasi, yoga prenatal, atau jalan sore.',
        'Tidur cukup 7–9 jam per malam dan hindari begadang.',
        'Ceritakan kekhawatiran ke pasangan, keluarga, atau bidan.',
        'Jika merasa tertekan berat, minta rujukan konseling.',
        'Bergabung dengan komunitas ibu hamil untuk dukungan sosial.',
      ],
      whyImportant:
          'Kortisol berlebih akibat stres kronis mengurangi aliran darah ke plasenta dan mengganggu pertumbuhan janin secara hormonal.',
      phase: PreventionPhase.hamil,
      gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
    ),

    // ── BAYI ──
    PreventionStep(
      emoji: '🍼',
      title: 'IMD & ASI Eksklusif 6 Bulan',
      subtitle: 'Inisiasi Menyusu Dini dalam 1 jam pertama',
      actions: [
        'Minta IMD segera setelah lahir — bayi disusui dalam 1 jam pertama.',
        'Kolostrum (ASI pertama) jangan dibuang — penuh antibodi dan faktor pertumbuhan.',
        'Susui on-demand: minimal 8–12 kali per 24 jam pada bulan pertama.',
        'Jangan berikan air, madu, atau sufor apapun selama 0–6 bulan.',
        'Jaga produksi ASI: cukup minum, makan bergizi, tidak stres.',
      ],
      whyImportant:
          'ASI mengandung IGF-1, EGF, dan lactoferrin yang tidak ada di formula — faktor pertumbuhan krusial untuk pematangan usus dan otak bayi.',
      phase: PreventionPhase.bayi,
      gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
      isPriority: true,
    ),
    PreventionStep(
      emoji: '💉',
      title: 'Imunisasi Lengkap Sesuai Jadwal',
      subtitle: 'Vaksin mencegah infeksi pemicu stunting',
      actions: [
        'HB0 (Hepatitis B): diberikan dalam 24 jam setelah lahir.',
        'BCG + Polio 1: usia 1 bulan.',
        'DPT-HB-Hib 1 + Polio 2: usia 2 bulan.',
        'DPT-HB-Hib 2 + Polio 3: usia 3 bulan.',
        'DPT-HB-Hib 3 + Polio 4 + IPV: usia 4 bulan.',
        'MR + PCV: usia 9 bulan.',
        'Simpan buku KIA/KMS dan bawa setiap kunjungan Posyandu.',
      ],
      whyImportant:
          'Campak saja bisa merusak mukosa usus selama berbulan-bulan. Satu episode campak setara kehilangan pertumbuhan 3–6 bulan pada anak yang sudah rentan.',
      phase: PreventionPhase.bayi,
      gradient: [Color(0xFF06B6D4), Color(0xFF0891B2)],
      isPriority: true,
    ),
    PreventionStep(
      emoji: '🥄',
      title: 'MPASI Tepat Waktu & Berkualitas',
      subtitle: 'Dimulai tepat usia 6 bulan, tidak lebih awal/lambat',
      actions: [
        'Mulai MPASI tepat di usia 6 bulan — tidak sebelum, tidak sesudah.',
        'Hari pertama: pure sayur/buah 1–2 sdm, tingkatkan bertahap.',
        'Protein hewani WAJIB sejak awal: hati ayam, telur, ikan, daging.',
        'Perkenalkan 1 bahan baru per 3–5 hari untuk deteksi alergi.',
        'Frekuensi: 2–3× makan utama + 1–2× selingan mulai usia 9 bulan.',
        'Lanjutkan ASI bersama MPASI hingga anak usia 2 tahun.',
        'Hindari garam, gula, MSG, dan madu hingga usia 1 tahun.',
      ],
      whyImportant:
          'Protein hewani mengandung semua asam amino esensial dan zinc bioavailabilitas tinggi. Penelitian di Indonesia: anak yang rutin makan ikan/telur 37% lebih rendah risiko stuntingnya.',
      phase: PreventionPhase.bayi,
      gradient: [Color(0xFF059669), Color(0xFF047857)],
      isPriority: true,
    ),

    // ── BALITA ──
    PreventionStep(
      emoji: '🌈',
      title: 'Diversifikasi Pangan Setiap Hari',
      subtitle: 'Minimal 5 dari 8 kelompok pangan per hari',
      actions: [
        'Serealia & umbi: nasi, roti, kentang, ubi.',
        'Kacang-kacangan: tempe, tahu, kacang hijau.',
        'Protein hewani: ikan, telur, ayam, daging.',
        'Sayuran hijau & berwarna: bayam, wortel, brokoli.',
        'Buah-buahan segar: pisang, pepaya, jeruk, mangga.',
        'Susu & produk susu: susu, yogurt, keju (bila tidak alergi).',
        'Pantau skor keragaman pangan — target minimal 5 kelompok/hari.',
      ],
      whyImportant:
          'Dietary Diversity Score (DDS) rendah adalah prediktor independen stunting. Setiap penambahan kelompok pangan menurunkan risiko stunting 15–20%.',
      phase: PreventionPhase.balita,
      gradient: [Color(0xFF059669), Color(0xFF047857)],
      isPriority: true,
    ),
    PreventionStep(
      emoji: '📏',
      title: 'Pantau Tumbuh Kembang Rutin',
      subtitle: 'Penimbangan & pengukuran di Posyandu tiap bulan',
      actions: [
        'Timbang berat badan setiap bulan di Posyandu.',
        'Ukur panjang/tinggi badan dan lingkar kepala setiap 3 bulan.',
        'Plot hasil di KMS — waspadai jika kurva mendekati garis merah.',
        'Jika anak tidak naik berat 2 bulan berturut (2T), segera konsultasi.',
        'Ikuti skrining perkembangan (DDST) sesuai usia.',
        'Manfaatkan Pemberian Makanan Tambahan (PMT) dari Posyandu.',
      ],
      whyImportant:
          'Deteksi dini di Posyandu memungkinkan intervensi sebelum stunting "terkunci." Setiap bulan keterlambatan intervensi mengurangi efektivitas hingga 10–15%.',
      phase: PreventionPhase.balita,
      gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
      isPriority: true,
    ),
    PreventionStep(
      emoji: '🧩',
      title: 'Stimulasi Tumbuh Kembang',
      subtitle: 'Bermain = nutrisi untuk otak',
      actions: [
        'Ajak bicara, bernyanyi, dan bercerita sejak lahir.',
        'Bermain aktif minimal 3 jam per hari (gabungan aktivitas ringan & berat).',
        'Batasi layar/gadget: tidak sama sekali <2 tahun, maksimal 1 jam 2–5 tahun.',
        'Dorong eksplorasi sensorik: sentuh, cium, rasa, dengar.',
        'Makan bersama keluarga untuk stimulasi sosial dan makan mandiri.',
        'Beri respon positif dan konsisten terhadap semua usaha anak.',
      ],
      whyImportant:
          'Stimulasi memicu pelepasan Growth Hormone dan merangsang pembentukan sinapsis otak. Anak yang distimulasi baik memiliki volume otak 10% lebih besar dari yang tidak.',
      phase: PreventionPhase.balita,
      gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
    ),

    // ── KELUARGA & LINGKUNGAN ──
    PreventionStep(
      emoji: '💧',
      title: 'PHBS: Air Bersih & Sanitasi',
      subtitle: 'Cuci tangan = pencegahan infeksi = gizi terjaga',
      actions: [
        'Gunakan air bersih (PDAM/sumur terproteksi) untuk minum dan masak.',
        'Masak air hingga mendidih jika sumber air diragukan.',
        'Cuci tangan 5 momen: sebelum masak, sebelum makan, setelah ke toilet, setelah ganti popok, setelah memegang hewan.',
        'Pastikan keluarga menggunakan jamban sehat, bukan BABS.',
        'Tutup makanan dari lalat dan simpan di tempat higienis.',
        'Buang sampah pada tempatnya, jaga kebersihan dapur.',
      ],
      whyImportant:
          'Environmental Enteric Dysfunction (EED) akibat sanitasi buruk menyebabkan atrofi vili usus kronis — anak makan cukup tapi tidak menyerap nutrisi dengan baik.',
      phase: PreventionPhase.keluarga,
      gradient: [Color(0xFF06B6D4), Color(0xFF0891B2)],
      isPriority: true,
    ),
    PreventionStep(
      emoji: '📚',
      title: 'Tingkatkan Literasi Gizi Keluarga',
      subtitle: 'Pengetahuan ibu = kunci utama pencegahan',
      actions: [
        'Ikuti kelas ibu hamil dan kelas ibu balita di Puskesmas.',
        'Baca materi gizi dari sumber terpercaya (Kemenkes, WHO, UNICEF).',
        'Diskusikan praktik pemberian makan yang tepat bersama pasangan.',
        'Ikuti program edukasi gizi di Posyandu secara aktif.',
        'Ajarkan anggota keluarga lain (nenek, kakek) tentang praktik gizi terkini.',
      ],
      whyImportant:
          'Setiap 1 tahun tambahan pendidikan ibu berkorelasi dengan penurunan 5–10% prevalensi stunting. Pengetahuan gizi ibu adalah prediktor terkuat kedua setelah kemiskinan.',
      phase: PreventionPhase.keluarga,
      gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    ),
    PreventionStep(
      emoji: '🏛️',
      title: 'Manfaatkan Program Pemerintah',
      subtitle: 'Daftarkan diri ke program intervensi stunting',
      actions: [
        'Daftar ke Program Keluarga Harapan (PKH) jika memenuhi syarat.',
        'Minta tablet Fe gratis dan PMT di Puskesmas/Posyandu.',
        'Ikuti program Taburia (tabur bubuk gizi) untuk anak 6–59 bulan.',
        'Daftarkan anak ke PAUD/BKB untuk stimulasi terstruktur.',
        'Laporkan masalah sanitasi lingkungan ke kelurahan/dinas terkait.',
        'Manfaatkan JKN/BPJS Kesehatan untuk pemeriksaan rutin.',
      ],
      whyImportant:
          'Program intervensi pemerintah yang diakses secara optimal terbukti menurunkan prevalensi stunting 30–40% di daerah intervensi. Jangan abaikan hak ini.',
      phase: PreventionPhase.keluarga,
      gradient: [Color(0xFFEF4444), Color(0xFFB91C1C)],
    ),
  ];

  static const List<NutrientItem> nutrients = [
    NutrientItem(
      '🩸',
      'Zat Besi',
      '27 mg/hari (hamil)',
      'Hati, daging merah, kacang merah',
      Color(0xFFEF4444),
    ),
    NutrientItem(
      '🧬',
      'Asam Folat',
      '400–800 mcg/hari',
      'Bayam, brokoli, kacang hijau',
      Color(0xFF059669),
    ),
    NutrientItem(
      '🦴',
      'Kalsium',
      '1.200 mg/hari (hamil)',
      'Susu, keju, tahu, ikan teri',
      Color(0xFF3B82F6),
    ),
    NutrientItem(
      '🐟',
      'DHA/Omega-3',
      '200–300 mg/hari',
      'Ikan salmon, sarden, tuna',
      Color(0xFF06B6D4),
    ),
    NutrientItem(
      '⚡',
      'Zinc',
      '11 mg/hari (hamil)',
      'Tiram, daging sapi, biji labu',
      Color(0xFFF59E0B),
    ),
    NutrientItem(
      '☀️',
      'Vitamin D',
      '600 IU/hari',
      'Sinar matahari pagi, ikan, telur',
      Color(0xFFEC4899),
    ),
  ];

  static const List<String> dailyChecklistItems = [
    '🥚 Makan protein hewani minimal 1 porsi',
    '🥦 Makan sayuran hijau/berwarna',
    '💧 Minum air bersih minimal 8 gelas',
    '🤲 Cuci tangan 5 momen penting',
    '🍼 Berikan ASI / MPASI bergizi (untuk ibu menyusui/balita)',
    '📏 Pantau tanda-tanda tumbuh kembang anak',
    '😴 Tidur cukup 7–9 jam (ibu hamil/menyusui)',
    '💊 Minum suplemen Fe/asam folat jika diresepkan',
    '🎮 Ajak anak bermain dan berinteraksi aktif',
    '🏥 Jadwalkan kunjungan Posyandu bulan ini',
  ];

  static List<PreventionStep> filtered(PreventionPhase? phase) =>
      phase == null ? steps : steps.where((s) => s.phase == phase).toList();

  static int get totalCount => steps.length;
  static int get priorityCount => steps.where((s) => s.isPriority).length;
}
