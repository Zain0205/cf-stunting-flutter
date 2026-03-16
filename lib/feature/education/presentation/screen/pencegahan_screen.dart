import 'package:flutter/material.dart';

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
// MODELS
// ─────────────────────────────────────────────
enum _Phase { prahamil, hamil, bayi, balita, keluarga }

class _Step {
  final String emoji;
  final String title;
  final String subtitle;
  final List<String> actions;
  final String whyImportant;
  final _Phase phase;
  final List<Color> gradient;
  final bool isPriority;
  const _Step({
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

class _NutrientItem {
  final String emoji;
  final String name;
  final String dose;
  final String sources;
  final Color color;
  const _NutrientItem(
    this.emoji,
    this.name,
    this.dose,
    this.sources,
    this.color,
  );
}

class _ChecklistItem {
  final String label;
  final bool checked;
  const _ChecklistItem(this.label, {this.checked = false});
}

// ─────────────────────────────────────────────
// DATA
// ─────────────────────────────────────────────
const _steps = [
  // ── PRA-KEHAMILAN ──
  _Step(
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
    phase: _Phase.prahamil,
    gradient: [Color(0xFFEC4899), Color(0xFFBE185D)],
    isPriority: true,
  ),
  _Step(
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
    phase: _Phase.prahamil,
    gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    isPriority: true,
  ),
  _Step(
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
    phase: _Phase.prahamil,
    gradient: [Color(0xFF6B7280), Color(0xFF374151)],
  ),

  // ── KEHAMILAN ──
  _Step(
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
    phase: _Phase.hamil,
    gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    isPriority: true,
  ),
  _Step(
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
    phase: _Phase.hamil,
    gradient: [Color(0xFF059669), Color(0xFF047857)],
    isPriority: true,
  ),
  _Step(
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
    phase: _Phase.hamil,
    gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
  ),

  // ── BAYI ──
  _Step(
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
    phase: _Phase.bayi,
    gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    isPriority: true,
  ),
  _Step(
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
    phase: _Phase.bayi,
    gradient: [Color(0xFF06B6D4), Color(0xFF0891B2)],
    isPriority: true,
  ),
  _Step(
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
    phase: _Phase.bayi,
    gradient: [Color(0xFF059669), Color(0xFF047857)],
    isPriority: true,
  ),

  // ── BALITA ──
  _Step(
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
      'Minyak/lemak sehat: minyak kelapa, alpukat.',
      'Pantau skor keragaman pangan — target minimal 5 kelompok/hari.',
    ],
    whyImportant:
        'Dietary Diversity Score (DDS) rendah adalah prediktor independen stunting. Setiap penambahan kelompok pangan menurunkan risiko stunting 15–20%.',
    phase: _Phase.balita,
    gradient: [Color(0xFF059669), Color(0xFF047857)],
    isPriority: true,
  ),
  _Step(
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
    phase: _Phase.balita,
    gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    isPriority: true,
  ),
  _Step(
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
    phase: _Phase.balita,
    gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
  ),

  // ── KELUARGA & LINGKUNGAN ──
  _Step(
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
    phase: _Phase.keluarga,
    gradient: [Color(0xFF06B6D4), Color(0xFF0891B2)],
    isPriority: true,
  ),
  _Step(
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
    phase: _Phase.keluarga,
    gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
  ),
  _Step(
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
    phase: _Phase.keluarga,
    gradient: [Color(0xFFEF4444), Color(0xFFB91C1C)],
  ),
];

const _phaseMeta = {
  _Phase.prahamil: ('🌸', 'Pra-Kehamilan', Color(0xFFEC4899)),
  _Phase.hamil: ('🤰', 'Saat Hamil', Color(0xFF8B5CF6)),
  _Phase.bayi: ('👶', 'Bayi 0–12 Bln', Color(0xFF3B82F6)),
  _Phase.balita: ('🧒', 'Balita 1–5 Thn', Color(0xFF059669)),
  _Phase.keluarga: ('🏠', 'Keluarga & Lingkungan', Color(0xFF06B6D4)),
};

const _keyNutrients = [
  _NutrientItem(
    '🩸',
    'Zat Besi',
    '27 mg/hari (hamil)',
    'Hati, daging merah, kacang merah',
    Color(0xFFEF4444),
  ),
  _NutrientItem(
    '🧬',
    'Asam Folat',
    '400–800 mcg/hari',
    'Bayam, brokoli, kacang hijau',
    Color(0xFF059669),
  ),
  _NutrientItem(
    '🦴',
    'Kalsium',
    '1.200 mg/hari (hamil)',
    'Susu, keju, tahu, ikan teri',
    Color(0xFF3B82F6),
  ),
  _NutrientItem(
    '🐟',
    'DHA/Omega-3',
    '200–300 mg/hari',
    'Ikan salmon, sarden, tuna',
    Color(0xFF06B6D4),
  ),
  _NutrientItem(
    '⚡',
    'Zinc',
    '11 mg/hari (hamil)',
    'Tiram, daging sapi, biji labu',
    Color(0xFFF59E0B),
  ),
  _NutrientItem(
    '☀️',
    'Vitamin D',
    '600 IU/hari',
    'Sinar matahari pagi, ikan, telur',
    Color(0xFFEC4899),
  ),
];

// ─────────────────────────────────────────────
// PENCEGAHAN SCREEN
// ─────────────────────────────────────────────
class PencegahanScreen extends StatefulWidget {
  const PencegahanScreen({super.key});

  @override
  State<PencegahanScreen> createState() => _PencegahanScreenState();
}

class _PencegahanScreenState extends State<PencegahanScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  _Phase? _selectedPhase;
  int? _expandedIndex;

  // Checklist state
  final Map<int, bool> _checked = {};

  List<_Step> get _filtered => _selectedPhase == null
      ? _steps
      : _steps.where((s) => s.phase == _selectedPhase).toList();

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _fadeAnim = CurvedAnimation(
      parent: _animCtrl,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, -0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = _R(context);
    final filtered = _filtered;
    final priorityCount = filtered.where((s) => s.isPriority).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── HEADER ──
              SliverAppBar(
                expandedHeight: r.isSmall ? 140 : 165,
                collapsedHeight: kToolbarHeight + 12,
                pinned: true,
                floating: false,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                  background: _HeaderBg(r: r),
                ),
              ),

              // ── HERO STATS ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, r.sp(16), 16, 0),
                  child: _HeroCard(r: r),
                ),
              ),

              // ── KEY NUTRIENTS ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, r.sp(18), 16, 0),
                  child: _SectionLabel(label: 'Nutrisi Kunci Pencegahan', r: r),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, r.sp(12), 16, 0),
                  child: _NutrientGrid(r: r),
                ),
              ),

              // ── FILTER ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, r.sp(18), 16, 0),
                  child: _SectionLabel(label: 'Langkah Pencegahan', r: r),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, r.sp(12), 16, 0),
                  child: _FilterBar(
                    selected: _selectedPhase,
                    onSelect: (p) => setState(() {
                      _selectedPhase = _selectedPhase == p ? null : p;
                      _expandedIndex = null;
                    }),
                    r: r,
                  ),
                ),
              ),

              // ── COUNT ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, r.sp(12), 16, 0),
                  child: Row(
                    children: [
                      Text(
                        '${filtered.length} langkah',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(12),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569),
                        ),
                      ),
                      if (priorityCount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF059669).withOpacity(0.10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 11,
                                color: Color(0xFF059669),
                              ),
                              Text(
                                ' $priorityCount prioritas',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: r.fs(10),
                                  color: const Color(0xFF059669),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const Spacer(),
                      Text(
                        'Tap untuk detail & checklist',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(10),
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── STEPS LIST ──
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16, r.sp(10), 16, 0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final step = filtered[index];
                    final isExp = _expandedIndex == index;
                    return Padding(
                      padding: EdgeInsets.only(bottom: r.sp(10)),
                      child: _StepCard(
                        step: step,
                        index: index,
                        isExpanded: isExp,
                        checkedActions: _checked,
                        r: r,
                        onTap: () => setState(
                          () => _expandedIndex = isExp ? null : index,
                        ),
                        onCheckAction: (actionKey, val) =>
                            setState(() => _checked[actionKey] = val ?? false),
                      ),
                    );
                  }, childCount: filtered.length),
                ),
              ),

              // ── DAILY CHECKLIST ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, r.sp(6), 16, 0),
                  child: _SectionLabel(label: 'Checklist Harian', r: r),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, r.sp(12), 16, 0),
                  child: _DailyChecklist(r: r),
                ),
              ),

              // ── CTA ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, r.sp(18), 16, 0),
                  child: _CtaCard(r: r),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: r.sp(36))),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HEADER BG
// ─────────────────────────────────────────────
class _HeaderBg extends StatelessWidget {
  final _R r;
  const _HeaderBg({required this.r});

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
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(28),
              ),
              child: CustomPaint(painter: _GridPainter()),
            ),
          ),
          Positioned(
            top: -30,
            right: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF059669).withOpacity(0.20),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -10,
            left: -30,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF3B82F6).withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
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
                Expanded(
                  child: Column(
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
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
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
                      const Icon(
                        Icons.shield_rounded,
                        size: 12,
                        color: Color(0xFF6EE7B7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${_steps.length} Langkah',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(10),
                          color: const Color(0xFF6EE7B7),
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
// HERO CARD
// ─────────────────────────────────────────────
class _HeroCard extends StatelessWidget {
  final _R r;
  const _HeroCard({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(18)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF059669), Color(0xFF047857)],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF059669).withOpacity(0.35),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -15,
            top: -15,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.07),
              ),
            ),
          ),
          Positioned(
            left: -10,
            bottom: -15,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  '🛡️  Stunting Bisa Dicegah hingga 80%',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(11),
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: r.sp(12)),
              Text(
                'Dengan tindakan tepat sejak sebelum kehamilan hingga anak usia 2 tahun, risiko stunting bisa dicegah secara signifikan.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(13),
                  color: Colors.white.withOpacity(0.88),
                  height: 1.6,
                ),
              ),
              SizedBox(height: r.sp(14)),
              Container(height: 1, color: Colors.white.withOpacity(0.15)),
              SizedBox(height: r.sp(14)),
              Row(
                children: [
                  _HeroStat('${_steps.length}', 'Langkah', r),
                  _HeroStatDiv(),
                  _HeroStat(
                    '${_steps.where((s) => s.isPriority).length}',
                    'Prioritas',
                    r,
                  ),
                  _HeroStatDiv(),
                  _HeroStat('5', 'Fase Hidup', r),
                  _HeroStatDiv(),
                  _HeroStat('1000', 'HPK Kritis', r),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String value;
  final String label;
  final _R r;
  const _HeroStat(this.value, this.label, this.r);

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(15),
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(9.5),
            color: Colors.white60,
          ),
        ),
      ],
    ),
  );
}

class _HeroStatDiv extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 32, color: Colors.white.withOpacity(0.15));
}

// ─────────────────────────────────────────────
// NUTRIENT GRID
// ─────────────────────────────────────────────
class _NutrientGrid extends StatelessWidget {
  final _R r;
  const _NutrientGrid({required this.r});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.6,
      ),
      itemCount: _keyNutrients.length,
      itemBuilder: (_, i) {
        final n = _keyNutrients[i];
        return Container(
          padding: EdgeInsets.all(r.sp(12)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: n.color.withOpacity(0.18), width: 1),
            boxShadow: [
              BoxShadow(
                color: n.color.withOpacity(0.08),
                blurRadius: 10,
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
                  Text(n.emoji, style: TextStyle(fontSize: r.fs(20))),
                  const Spacer(),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: n.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    n.name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.fs(12),
                      fontWeight: FontWeight.w700,
                      color: n.color,
                    ),
                  ),
                  Text(
                    n.dose,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.fs(9.5),
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Text(
                    n.sources,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.fs(9),
                      color: Colors.grey.shade400,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// FILTER BAR
// ─────────────────────────────────────────────
class _FilterBar extends StatelessWidget {
  final _Phase? selected;
  final ValueChanged<_Phase> onSelect;
  final _R r;
  const _FilterBar({
    required this.selected,
    required this.onSelect,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          // All
          GestureDetector(
            onTap: () {
              if (selected != null) onSelect(selected!);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: EdgeInsets.symmetric(
                horizontal: r.sp(12),
                vertical: r.sp(8),
              ),
              decoration: BoxDecoration(
                color: selected == null
                    ? const Color(0xFF0A1628)
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected == null
                      ? const Color(0xFF0A1628)
                      : Colors.grey.shade200,
                ),
                boxShadow: selected == null
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.18),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.apps_rounded,
                    size: 13,
                    color: selected == null
                        ? Colors.white
                        : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Semua',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.fs(11.5),
                      fontWeight: FontWeight.w600,
                      color: selected == null
                          ? Colors.white
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          ..._Phase.values.map((p) {
            final meta = _phaseMeta[p]!;
            final isSel = selected == p;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => onSelect(p),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: r.sp(12),
                    vertical: r.sp(8),
                  ),
                  decoration: BoxDecoration(
                    color: isSel ? meta.$3 : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSel ? meta.$3 : Colors.grey.shade200,
                      width: 1,
                    ),
                    boxShadow: isSel
                        ? [
                            BoxShadow(
                              color: meta.$3.withOpacity(0.30),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(meta.$1, style: TextStyle(fontSize: r.fs(13))),
                      const SizedBox(width: 5),
                      Text(
                        meta.$2,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(11),
                          fontWeight: FontWeight.w600,
                          color: isSel ? Colors.white : meta.$3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// STEP CARD (with interactive checklist inside)
// ─────────────────────────────────────────────
class _StepCard extends StatelessWidget {
  final _Step step;
  final int index;
  final bool isExpanded;
  final Map<int, bool> checkedActions;
  final _R r;
  final VoidCallback onTap;
  final Function(int, bool?) onCheckAction;

  const _StepCard({
    required this.step,
    required this.index,
    required this.isExpanded,
    required this.checkedActions,
    required this.r,
    required this.onTap,
    required this.onCheckAction,
  });

  @override
  Widget build(BuildContext context) {
    final meta = _phaseMeta[step.phase]!;
    final totalActions = step.actions.length;
    final doneCount = step.actions
        .asMap()
        .entries
        .where((e) => checkedActions[index * 100 + e.key] == true)
        .length;
    final allDone = doneCount == totalActions;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: allDone
                ? const Color(0xFF059669).withOpacity(0.40)
                : isExpanded
                ? step.gradient[0].withOpacity(0.35)
                : const Color(0xFFE8F0FE),
            width: (isExpanded || allDone) ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: allDone
                  ? const Color(0xFF059669).withOpacity(0.12)
                  : isExpanded
                  ? step.gradient[0].withOpacity(0.14)
                  : Colors.black.withOpacity(0.04),
              blurRadius: isExpanded ? 20 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left accent
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: allDone
                        ? [const Color(0xFF059669), const Color(0xFF047857)]
                        : isExpanded
                        ? step.gradient
                        : [Colors.grey.shade200, Colors.grey.shade200],
                  ),
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(r.sp(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Emoji badge
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  step.gradient[0].withOpacity(0.12),
                                  step.gradient[0].withOpacity(0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: step.gradient[0].withOpacity(0.20),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                step.emoji,
                                style: TextStyle(fontSize: r.fs(22)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: 5,
                                  children: [
                                    _SmallChip(
                                      label: meta.$2,
                                      color: meta.$3,
                                      r: r,
                                    ),
                                    if (step.isPriority)
                                      _SmallChip(
                                        label: '⭐ Prioritas',
                                        color: const Color(0xFF059669),
                                        r: r,
                                      ),
                                    if (allDone)
                                      _SmallChip(
                                        label: '✅ Selesai',
                                        color: const Color(0xFF059669),
                                        r: r,
                                      ),
                                  ],
                                ),
                                SizedBox(height: r.sp(4)),
                                Text(
                                  step.title,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: r.fs(13.5),
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                SizedBox(height: r.sp(2)),
                                Text(
                                  step.subtitle,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: r.fs(11.5),
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AnimatedRotation(
                                turns: isExpanded ? 0.5 : 0,
                                duration: const Duration(milliseconds: 220),
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: isExpanded
                                        ? step.gradient[0].withOpacity(0.10)
                                        : Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 18,
                                    color: isExpanded
                                        ? step.gradient[0]
                                        : Colors.grey.shade400,
                                  ),
                                ),
                              ),
                              SizedBox(height: r.sp(4)),
                              Text(
                                '$doneCount/$totalActions',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: r.fs(10),
                                  fontWeight: FontWeight.w700,
                                  color: allDone
                                      ? const Color(0xFF059669)
                                      : Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Mini progress bar always visible
                      SizedBox(height: r.sp(10)),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Stack(
                          children: [
                            Container(height: 4, color: Colors.grey.shade100),
                            FractionallySizedBox(
                              widthFactor: totalActions > 0
                                  ? doneCount / totalActions
                                  : 0,
                              child: Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  color: allDone
                                      ? const Color(0xFF059669)
                                      : step.gradient[0],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Expanded content
                      if (isExpanded) ...[
                        SizedBox(height: r.sp(14)),
                        Container(
                          height: 1,
                          color: step.gradient[0].withOpacity(0.10),
                        ),
                        SizedBox(height: r.sp(12)),

                        // Why important
                        Container(
                          padding: EdgeInsets.all(r.sp(12)),
                          decoration: BoxDecoration(
                            color: step.gradient[0].withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: step.gradient[0].withOpacity(0.15),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.lightbulb_outline_rounded,
                                    size: 13,
                                    color: step.gradient[0],
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Mengapa Penting?',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: r.fs(11),
                                      fontWeight: FontWeight.w700,
                                      color: step.gradient[0],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: r.sp(6)),
                              Text(
                                step.whyImportant,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: r.fs(12.5),
                                  color: const Color(0xFF374151),
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: r.sp(12)),

                        // Interactive checklist actions
                        Row(
                          children: [
                            Icon(
                              Icons.checklist_rounded,
                              size: 13,
                              color: step.gradient[0],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Checklist Tindakan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: r.fs(11),
                                fontWeight: FontWeight.w700,
                                color: step.gradient[0],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '$doneCount/${step.actions.length} selesai',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: r.fs(10),
                                color: allDone
                                    ? const Color(0xFF059669)
                                    : Colors.grey.shade400,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: r.sp(8)),

                        ...step.actions.asMap().entries.map((e) {
                          final actionKey = index * 100 + e.key;
                          final isDone = checkedActions[actionKey] == true;
                          return GestureDetector(
                            onTap: () => onCheckAction(actionKey, !isDone),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: r.sp(8)),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(
                                  horizontal: r.sp(12),
                                  vertical: r.sp(10),
                                ),
                                decoration: BoxDecoration(
                                  color: isDone
                                      ? const Color(
                                          0xFF059669,
                                        ).withOpacity(0.06)
                                      : Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isDone
                                        ? const Color(
                                            0xFF059669,
                                          ).withOpacity(0.25)
                                        : Colors.grey.shade200,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: isDone
                                            ? const Color(0xFF059669)
                                            : Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isDone
                                              ? const Color(0xFF059669)
                                              : Colors.grey.shade300,
                                          width: 1.5,
                                        ),
                                        boxShadow: isDone
                                            ? [
                                                BoxShadow(
                                                  color: const Color(
                                                    0xFF059669,
                                                  ).withOpacity(0.30),
                                                  blurRadius: 6,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: isDone
                                          ? const Icon(
                                              Icons.check_rounded,
                                              color: Colors.white,
                                              size: 13,
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        e.value,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: r.fs(12.5),
                                          color: isDone
                                              ? const Color(0xFF059669)
                                              : const Color(0xFF374151),
                                          height: 1.5,
                                          decoration: isDone
                                              ? TextDecoration.lineThrough
                                              : null,
                                          decorationColor: const Color(
                                            0xFF059669,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmallChip extends StatelessWidget {
  final String label;
  final Color color;
  final _R r;
  const _SmallChip({required this.label, required this.color, required this.r});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.10),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: r.fs(9.5),
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}

// ─────────────────────────────────────────────
// DAILY CHECKLIST
// ─────────────────────────────────────────────
class _DailyChecklist extends StatefulWidget {
  final _R r;
  const _DailyChecklist({required this.r});

  @override
  State<_DailyChecklist> createState() => _DailyChecklistState();
}

class _DailyChecklistState extends State<_DailyChecklist> {
  final _items = [
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

  final Map<int, bool> _checked = {};

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    final doneCount = _checked.values.where((v) => v).length;
    final total = _items.length;
    final progress = total > 0 ? doneCount / total : 0.0;

    return Container(
      padding: EdgeInsets.all(r.sp(16)),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$doneCount dari $total selesai',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(13),
                        fontWeight: FontWeight.w700,
                        color: doneCount == total
                            ? const Color(0xFF059669)
                            : const Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      doneCount == total
                          ? '🎉 Luar biasa! Semua terpenuhi!'
                          : 'Centang yang sudah dilakukan hari ini',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11),
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              // Circle progress
              SizedBox(
                width: 48,
                height: 48,
                child: Stack(
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 4,
                      backgroundColor: Colors.grey.shade100,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        doneCount == total
                            ? const Color(0xFF059669)
                            : const Color(0xFF3B82F6),
                      ),
                    ),
                    Center(
                      child: Text(
                        '${(progress * 100).toInt()}%',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(9),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF3B82F6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: r.sp(14)),

          // Items
          ...List.generate(_items.length, (i) {
            final isDone = _checked[i] == true;
            return GestureDetector(
              onTap: () =>
                  setState(() => _checked[i] = !(_checked[i] ?? false)),
              child: Padding(
                padding: EdgeInsets.only(bottom: r.sp(8)),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: EdgeInsets.symmetric(
                    horizontal: r.sp(12),
                    vertical: r.sp(10),
                  ),
                  decoration: BoxDecoration(
                    color: isDone
                        ? const Color(0xFF059669).withOpacity(0.06)
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDone
                          ? const Color(0xFF059669).withOpacity(0.25)
                          : Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: isDone
                              ? const Color(0xFF059669)
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDone
                                ? const Color(0xFF059669)
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                          boxShadow: isDone
                              ? [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF059669,
                                    ).withOpacity(0.30),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: isDone
                            ? const Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 13,
                              )
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _items[i],
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(12.5),
                            color: isDone
                                ? const Color(0xFF059669)
                                : const Color(0xFF374151),
                            decoration: isDone
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: const Color(0xFF059669),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          if (doneCount > 0) ...[
            SizedBox(height: r.sp(8)),
            GestureDetector(
              onTap: () => setState(() => _checked.clear()),
              child: Center(
                child: Text(
                  'Reset checklist',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(11.5),
                    color: Colors.grey.shade400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CTA CARD
// ─────────────────────────────────────────────
class _CtaCard extends StatelessWidget {
  final _R r;
  const _CtaCard({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(18)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A1628), Color(0xFF1E3A8A)],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D4ED8).withOpacity(0.35),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -10,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('🚀', style: TextStyle(fontSize: 26)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Mulai Sekarang, Bukan Nanti!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(15),
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: r.sp(10)),
              Text(
                'Setiap hari yang terlewat dalam 1000 HPK tidak bisa diulang. Tapi setiap langkah kecil yang Anda ambil hari ini memberi dampak besar bagi masa depan si kecil.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  color: Colors.white.withOpacity(0.85),
                  height: 1.6,
                ),
              ),
              SizedBox(height: r.sp(14)),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: r.sp(11),
                        horizontal: r.sp(10),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF059669).withOpacity(0.22),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF059669).withOpacity(0.40),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.monitor_heart_rounded,
                            color: Color(0xFF6EE7B7),
                            size: 16,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            'Mulai Skrining',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: r.fs(12),
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF6EE7B7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: r.sp(10)),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: r.sp(11),
                        horizontal: r.sp(10),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.22),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.local_hospital_rounded,
                            color: Colors.white70,
                            size: 16,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            'Ke Posyandu',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: r.fs(12),
                              fontWeight: FontWeight.w700,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
  Widget build(BuildContext context) => Row(
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

// ─────────────────────────────────────────────
// GRID PAINTER
// ─────────────────────────────────────────────
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = const Color(0xFF1E3A5F).withOpacity(0.28)
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
              const Color(0xFF059669).withOpacity(0.18),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(center: Offset(size.width + 20, -20), radius: 140),
          );
    canvas.drawCircle(Offset(size.width + 20, -20), 140, orb);
  }

  @override
  bool shouldRepaint(_GridPainter _) => false;
}
