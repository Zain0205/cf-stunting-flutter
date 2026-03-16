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
enum _RiskGroup { prahamil, ibuHamil, bayiBaru, balita, dewasa, komunitas }

class _RiskItem {
  final String emoji;
  final String title;
  final String shortDesc;
  final String detail;
  final String mechanism;
  final _RiskGroup group;
  final List<Color> gradient;
  final bool isCritical;
  const _RiskItem({
    required this.emoji,
    required this.title,
    required this.shortDesc,
    required this.detail,
    required this.mechanism,
    required this.group,
    required this.gradient,
    this.isCritical = false,
  });
}

// ─────────────────────────────────────────────
// DATA
// ─────────────────────────────────────────────
const _risks = [
  // ── PRA-KEHAMILAN ──
  _RiskItem(
    emoji: '🩸',
    title: 'Anemia pada Calon Ibu',
    shortDesc: 'Hemoglobin rendah sebelum hamil',
    detail:
        'Wanita usia subur dengan anemia defisiensi besi memiliki risiko 2× lebih tinggi melahirkan anak stunting. Cadangan zat besi yang rendah sebelum kehamilan tidak cukup untuk memenuhi kebutuhan janin selama 9 bulan.',
    mechanism:
        'Zat besi diperlukan untuk sintesis hemoglobin janin dan mielinisasi saraf otak. Defisiensi di awal kehamilan berdampak permanen pada perkembangan kognitif.',
    group: _RiskGroup.prahamil,
    gradient: [Color(0xFFEF4444), Color(0xFFB91C1C)],
    isCritical: true,
  ),
  _RiskItem(
    emoji: '⚖️',
    title: 'Status Gizi Buruk Sebelum Hamil',
    shortDesc: 'IMT <18.5 atau lingkar lengan <23.5 cm',
    detail:
        'Wanita dengan Kurang Energi Kronis (KEK) sebelum hamil — ditandai lingkar lengan atas <23.5 cm — memiliki risiko sangat tinggi melahirkan bayi dengan berat lahir rendah (BBLR), yang merupakan pintu gerbang stunting.',
    mechanism:
        'Cadangan energi dan protein yang tidak memadai sejak awal mengakibatkan transfer nutrisi ke janin terganggu. Pertumbuhan plasenta pun tidak optimal.',
    group: _RiskGroup.prahamil,
    gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
    isCritical: true,
  ),
  _RiskItem(
    emoji: '🚬',
    title: 'Paparan Rokok & Alkohol',
    shortDesc: 'Zat toksik menghambat pertumbuhan janin',
    detail:
        'Merokok aktif maupun pasif, serta konsumsi alkohol sebelum dan selama kehamilan, secara langsung mengganggu pertumbuhan janin. Bahkan 1 batang rokok per hari meningkatkan risiko BBLR hingga 40%.',
    mechanism:
        'Karbon monoksida mengurangi oksigenasi darah janin. Nikotin menyebabkan vasokonstriksi pembuluh plasenta. Alkohol mengganggu metabolisme asam folat yang krusial untuk perkembangan saraf.',
    group: _RiskGroup.prahamil,
    gradient: [Color(0xFF6B7280), Color(0xFF374151)],
  ),

  // ── IBU HAMIL ──
  _RiskItem(
    emoji: '🤰',
    title: 'Kekurangan Gizi saat Hamil',
    shortDesc: 'Protein, zat besi, zinc, folat tidak cukup',
    detail:
        'Ibu hamil yang tidak mendapat asupan gizi adekuat — terutama protein, zat besi, zinc, asam folat, dan kalsium — berisiko tinggi melahirkan bayi stunting. 70% kasus stunting berawal dari masa kehamilan.',
    mechanism:
        'Janin bersaing dengan tubuh ibu untuk nutrisi terbatas. Prioritas diberikan ke organ vital janin, tetapi pertumbuhan panjang tulang dan otak tetap terganggu jika defisiensi berlangsung kronis.',
    group: _RiskGroup.ibuHamil,
    gradient: [Color(0xFFEC4899), Color(0xFFBE185D)],
    isCritical: true,
  ),
  _RiskItem(
    emoji: '🏥',
    title: 'Tidak Periksa Kehamilan (ANC)',
    shortDesc: 'Tidak rutin ke bidan atau dokter',
    detail:
        'Ibu yang tidak melakukan Antenatal Care (ANC) minimal 6 kali selama kehamilan kehilangan kesempatan deteksi dini komplikasi, pemantauan pertumbuhan janin, dan suplementasi gizi tepat waktu.',
    mechanism:
        'Tanpa ANC, kondisi seperti preeklampsia, IUGR (Intrauterine Growth Restriction), dan anemia berat tidak terdeteksi hingga terlambat, meningkatkan risiko BBLR dan prematuritas.',
    group: _RiskGroup.ibuHamil,
    gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
  ),
  _RiskItem(
    emoji: '😰',
    title: 'Stres Kronis & Depresi Kehamilan',
    shortDesc: 'Kortisol tinggi menghambat pertumbuhan janin',
    detail:
        'Ibu hamil yang mengalami stres psikologis berat atau depresi memiliki kadar kortisol tinggi yang secara langsung menghambat pertumbuhan dan perkembangan janin, serta meningkatkan risiko kelahiran prematur.',
    mechanism:
        'Kortisol berlebih mengganggu sekresi Growth Hormone dan IGF-1. Aktivasi sistem stres juga menyebabkan vasokonstriksi yang mengurangi aliran darah ke plasenta.',
    group: _RiskGroup.ibuHamil,
    gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
  ),
  _RiskItem(
    emoji: '🦠',
    title: 'Infeksi Selama Kehamilan',
    shortDesc: 'TORCH, malaria, dan infeksi saluran kemih',
    detail:
        'Infeksi TORCH (Toksoplasmosis, Rubella, CMV, Herpes), malaria, dan infeksi saluran kemih selama kehamilan dapat menyebabkan IUGR, prematuritas, dan gangguan perkembangan otak janin yang berujung pada stunting.',
    mechanism:
        'Patogen dapat menembus plasenta dan secara langsung menginfeksi janin. Respons inflamasi sistemik ibu juga mengalihkan nutrisi dari pertumbuhan janin ke sistem imun.',
    group: _RiskGroup.ibuHamil,
    gradient: [Color(0xFF059669), Color(0xFF047857)],
  ),

  // ── BAYI BARU LAHIR ──
  _RiskItem(
    emoji: '⚡',
    title: 'Berat Lahir Rendah (BBLR)',
    shortDesc: 'Berat <2.500 gram saat lahir',
    detail:
        'Bayi dengan berat lahir rendah (<2.500 gram) memiliki risiko stunting 3–5 kali lebih tinggi. BBLR menunjukkan pertumbuhan janin yang sudah terhambat sejak dalam kandungan (stunted in utero).',
    mechanism:
        'Bayi BBLR memiliki cadangan otot, lemak, dan mineral yang sangat terbatas. Kapasitas saluran cerna kecil membatasi kemampuan menyerap nutrisi, memperparah defisit pertumbuhan pasca lahir.',
    group: _RiskGroup.bayiBaru,
    gradient: [Color(0xFFEF4444), Color(0xFFB91C1C)],
    isCritical: true,
  ),
  _RiskItem(
    emoji: '🍼',
    title: 'Tidak Mendapat ASI Eksklusif',
    shortDesc: 'Pemberian sufor atau makanan terlalu dini',
    detail:
        'Bayi yang tidak mendapat ASI eksklusif 0–6 bulan berisiko 2× lebih tinggi mengalami stunting. ASI mengandung faktor pertumbuhan, antibodi, dan nutrisi bioavailabilitas tinggi yang tidak tergantikan formula.',
    mechanism:
        'Susu formula tidak mengandung growth factors seperti EGF, IGF-1, dan lactoferrin yang krusial untuk pematangan usus. Pemberian makanan padat terlalu dini merusak mukosa usus yang belum matang.',
    group: _RiskGroup.bayiBaru,
    gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    isCritical: true,
  ),
  _RiskItem(
    emoji: '🌡️',
    title: 'Infeksi Berulang pada Bayi',
    shortDesc: 'Diare, ISPA, dan infeksi neonatal',
    detail:
        'Bayi yang mengalami infeksi berulang — terutama diare dan infeksi saluran napas — menghabiskan energi untuk melawan penyakit dan kehilangan nutrisi, menciptakan lingkaran setan defisit pertumbuhan.',
    mechanism:
        'Setiap episode diare akut menyebabkan hilangnya zinc, elektrolit, dan kerusakan vili usus. Proses perbaikan usus membutuhkan protein yang seharusnya digunakan untuk pertumbuhan tulang.',
    group: _RiskGroup.bayiBaru,
    gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
  ),
  _RiskItem(
    emoji: '💉',
    title: 'Imunisasi Tidak Lengkap',
    shortDesc: 'Rentan infeksi yang menyebabkan stunting',
    detail:
        'Bayi yang tidak mendapat imunisasi lengkap lebih rentan terhadap campak, difteri, dan infeksi lain yang secara langsung mengganggu penyerapan nutrisi dan pertumbuhan, serta meningkatkan risiko stunting.',
    mechanism:
        'Campak khususnya menyebabkan kerusakan serius pada mukosa usus dan paru, diikuti periode malabsorpsi panjang. Satu episode campak bisa menghilangkan pertumbuhan selama 3–6 bulan.',
    group: _RiskGroup.bayiBaru,
    gradient: [Color(0xFF06B6D4), Color(0xFF0891B2)],
  ),

  // ── BALITA ──
  _RiskItem(
    emoji: '🥗',
    title: 'MPASI Tidak Adekuat',
    shortDesc: 'Kualitas dan keragaman makanan buruk',
    detail:
        'Pemberian MPASI yang kurang beragam, tidak kaya protein hewani, atau dimulai terlambat/terlalu dini merupakan faktor risiko utama stunting pada usia 6–24 bulan — masa paling kritis pertumbuhan.',
    mechanism:
        'Protein hewani (telur, ikan, daging) mengandung semua asam amino esensial dan zinc bioavailabilitas tinggi yang diperlukan untuk sintesis protein tulang dan otot. Protein nabati saja tidak cukup.',
    group: _RiskGroup.balita,
    gradient: [Color(0xFF059669), Color(0xFF047857)],
    isCritical: true,
  ),
  _RiskItem(
    emoji: '💧',
    title: 'Air Minum & Sanitasi Buruk',
    shortDesc: 'E.coli dan parasit usus merusak gizi',
    detail:
        'Air minum terkontaminasi dan sanitasi buruk menyebabkan environmental enteric dysfunction (EED) — peradangan kronis usus yang mengganggu penyerapan nutrisi meski asupan makanan cukup.',
    mechanism:
        'Paparan berulang bakteri fecal-oral (E.coli, Giardia, Cryptosporidium) menyebabkan atrofi vili usus permanen. Bahkan tanpa gejala diare, absorpsi nutrisi terganggu secara kronis.',
    group: _RiskGroup.balita,
    gradient: [Color(0xFF06B6D4), Color(0xFF0891B2)],
    isCritical: true,
  ),
  _RiskItem(
    emoji: '🧒',
    title: 'Kurang Stimulasi & Interaksi',
    shortDesc: 'Stimulasi kurang menghambat perkembangan otak',
    detail:
        'Anak yang kurang mendapat stimulasi kognitif, sosial, dan emosional dari pengasuh berisiko mengalami kegagalan tumbuh kembang yang saling memperburuk dengan defisiensi gizi.',
    mechanism:
        'Stimulasi memicu pelepasan GH dan IGF-1. Anak yang tidak distimulasi cenderung lebih pasif, makan lebih sedikit, dan memiliki metabolisme pertumbuhan yang lebih rendah.',
    group: _RiskGroup.balita,
    gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
  ),

  // ── USIA DEWASA ──
  _RiskItem(
    emoji: '🧠',
    title: 'Penurunan Kecerdasan Permanen',
    shortDesc: 'IQ lebih rendah 10–15 poin rata-rata',
    detail:
        'Stunting pada 1000 HPK menyebabkan kerusakan struktural otak yang permanen. Anak stunting rata-rata memiliki IQ 5–10 poin lebih rendah, tingkat kelulusan sekolah lebih rendah, dan penghasilan dewasa 20% lebih sedikit.',
    mechanism:
        'Volume hipokampus dan korteks prefrontal lebih kecil secara permanen. Konektivitas neural antara area kognitif terganggu akibat defisiensi mielinisasi pada masa kritis 0–2 tahun.',
    group: _RiskGroup.dewasa,
    gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    isCritical: true,
  ),
  _RiskItem(
    emoji: '❤️',
    title: 'Penyakit Tidak Menular di Usia Dewasa',
    shortDesc: 'Diabetes, hipertensi, dan penyakit jantung',
    detail:
        'Anak stunting yang kemudian mengalami kenaikan berat badan cepat (catch-up growth) di usia remaja/dewasa memiliki risiko 2–3× lebih tinggi terkena diabetes tipe 2, hipertensi, dan penyakit jantung koroner.',
    mechanism:
        'Fenomena "thrifty phenotype hypothesis" — organ metabolik (pankreas, ginjal) yang berkembang dalam kondisi defisit kalori menjadi tidak adaptif ketika mendapat surplus nutrisi di kemudian hari.',
    group: _RiskGroup.dewasa,
    gradient: [Color(0xFFEF4444), Color(0xFFB91C1C)],
    isCritical: true,
  ),
  _RiskItem(
    emoji: '💼',
    title: 'Produktivitas Ekonomi Rendah',
    shortDesc: 'Pendapatan seumur hidup berkurang 20–30%',
    detail:
        'Individu yang mengalami stunting memiliki kapasitas kerja fisik lebih rendah, tingkat pendidikan lebih rendah, dan pendapatan seumur hidup rata-rata 20–30% lebih sedikit dibanding individu yang tumbuh normal.',
    mechanism:
        'Kombinasi kapasitas kognitif terbatas, kesehatan lebih buruk, dan tinggi badan lebih pendek (dikaitkan dengan diskriminasi di pasar kerja) menciptakan kerugian ekonomi kumulatif jangka panjang.',
    group: _RiskGroup.dewasa,
    gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
  ),
  _RiskItem(
    emoji: '👩',
    title: 'Siklus Stunting Antargenerasi',
    shortDesc: 'Ibu stunting → anak stunting',
    detail:
        'Perempuan yang tumbuh stunting memiliki panggul lebih sempit (meningkatkan risiko komplikasi persalinan), berat badan sebelum hamil lebih rendah, dan status gizi lebih buruk — mewariskan risiko stunting ke generasi berikutnya.',
    mechanism:
        'Siklus intergenerasi: ibu pendek → cadangan gizi terbatas → janin kecil → BBLR → stunting → anak perempuan tumbuh pendek → siklus berlanjut. Satu generasi stunting bisa berlanjut 3–4 generasi tanpa intervensi.',
    group: _RiskGroup.dewasa,
    gradient: [Color(0xFFEC4899), Color(0xFFBE185D)],
    isCritical: true,
  ),

  // ── KOMUNITAS & SOSIAL ──
  _RiskItem(
    emoji: '🏘️',
    title: 'Kemiskinan & Ketahanan Pangan',
    shortDesc: 'Akses pangan bergizi terbatas',
    detail:
        'Keluarga miskin memiliki akses terbatas terhadap pangan bergizi terutama protein hewani. Anak dari kuintil termiskin 2.5× lebih berisiko stunting dibanding anak dari keluarga terkaya.',
    mechanism:
        'Kemiskinan memaksa substitusi protein hewani dengan protein nabati murah yang memiliki bioavailabilitas zinc dan zat besi lebih rendah. Dietary diversity score rendah berkorelasi kuat dengan stunting.',
    group: _RiskGroup.komunitas,
    gradient: [Color(0xFF6B7280), Color(0xFF374151)],
    isCritical: true,
  ),
  _RiskItem(
    emoji: '📚',
    title: 'Pendidikan Pengasuh Rendah',
    shortDesc: 'Kurang pengetahuan gizi dan pengasuhan',
    detail:
        'Tingkat pendidikan ibu adalah prediktor terkuat kedua stunting setelah kemiskinan. Ibu dengan pendidikan rendah cenderung memiliki pengetahuan gizi lebih buruk, praktik pemberian makan tidak tepat, dan utilisasi layanan kesehatan lebih rendah.',
    mechanism:
        'Pendidikan ibu memengaruhi pengambilan keputusan pemberian makan, kemampuan membaca label nutrisi, kepatuhan imunisasi, dan responsivitas terhadap tanda-tanda penyakit pada anak.',
    group: _RiskGroup.komunitas,
    gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
  ),
  _RiskItem(
    emoji: '🌿',
    title: 'Lingkungan & Polusi',
    shortDesc: 'Polusi udara dan tanah terkontaminasi',
    detail:
        'Paparan timbal (Pb), pestisida, dan polusi udara partikulat halus (PM2.5) selama kehamilan dan masa bayi mengganggu perkembangan otak dan pertumbuhan fisik, berkontribusi pada stunting.',
    mechanism:
        'Timbal bersaing dengan kalsium dalam mineralisasi tulang dan perkembangan otak. PM2.5 menyebabkan stres oksidatif yang mengganggu sintesis protein dan pertumbuhan sel pada janin.',
    group: _RiskGroup.komunitas,
    gradient: [Color(0xFF059669), Color(0xFF047857)],
  ),
];

const _groupMeta = {
  _RiskGroup.prahamil: ('🌸', 'Pra-Kehamilan', Color(0xFFEC4899)),
  _RiskGroup.ibuHamil: ('🤰', 'Ibu Hamil', Color(0xFF8B5CF6)),
  _RiskGroup.bayiBaru: ('👶', 'Bayi 0–12 Bln', Color(0xFF3B82F6)),
  _RiskGroup.balita: ('🧒', 'Balita 1–5 Thn', Color(0xFF059669)),
  _RiskGroup.dewasa: ('👤', 'Dampak Dewasa', Color(0xFFEF4444)),
  _RiskGroup.komunitas: ('🏘️', 'Komunitas', Color(0xFF6B7280)),
};

// ─────────────────────────────────────────────
// RESIKO SCREEN
// ─────────────────────────────────────────────
class ResikoScreen extends StatefulWidget {
  const ResikoScreen({super.key});

  @override
  State<ResikoScreen> createState() => _ResikoScreenState();
}

class _ResikoScreenState extends State<ResikoScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  _RiskGroup? _selectedGroup;
  int? _expandedIndex;

  List<_RiskItem> get _filtered => _selectedGroup == null
      ? _risks
      : _risks.where((r) => r.group == _selectedGroup).toList();

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
    final criticalCount = filtered.where((r) => r.isCritical).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── PINNED HEADER ──
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

              // ── SUMMARY STRIP ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, r.sp(16), 16, 0),
                  child: _SummaryStrip(r: r),
                ),
              ),

              // ── LIFECYCLE BANNER ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, r.sp(14), 16, 0),
                  child: _LifecycleBanner(r: r),
                ),
              ),

              // ── FILTER BAR ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, r.sp(14), 16, 0),
                  child: _FilterBar(
                    selected: _selectedGroup,
                    onSelect: (g) => setState(() {
                      _selectedGroup = _selectedGroup == g ? null : g;
                      _expandedIndex = null;
                    }),
                    r: r,
                  ),
                ),
              ),

              // ── COUNT INFO ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, r.sp(12), 16, 0),
                  child: Row(
                    children: [
                      Text(
                        '${filtered.length} faktor risiko',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(12),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569),
                        ),
                      ),
                      if (criticalCount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444).withOpacity(0.10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.priority_high_rounded,
                                size: 11,
                                color: Color(0xFFEF4444),
                              ),
                              Text(
                                ' $criticalCount kritis',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: r.fs(10),
                                  color: const Color(0xFFEF4444),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const Spacer(),
                      Text(
                        'Tap untuk detail',
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

              // ── RISK LIST ──
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16, r.sp(10), 16, 0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final risk = filtered[index];
                    final isExp = _expandedIndex == index;
                    return Padding(
                      padding: EdgeInsets.only(bottom: r.sp(10)),
                      child: _RiskCard(
                        risk: risk,
                        index: index,
                        isExpanded: isExp,
                        r: r,
                        onTap: () => setState(() {
                          _expandedIndex = isExp ? null : index;
                        }),
                      ),
                    );
                  }, childCount: filtered.length),
                ),
              ),

              // ── BOTTOM CTA ──
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16, r.sp(6), 16, 0),
                sliver: SliverToBoxAdapter(child: _BottomCta(r: r)),
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
                    const Color(0xFFEF4444).withOpacity(0.18),
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
                    const Color(0xFF8B5CF6).withOpacity(0.15),
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
                        'Faktor Risiko Stunting',
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
                        'Kenali & cegah sejak dini',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(11),
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
                    color: const Color(0xFFEF4444).withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFEF4444).withOpacity(0.40),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        size: 12,
                        color: Color(0xFFFCA5A5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${_risks.length} Risiko',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(10),
                          color: const Color(0xFFFCA5A5),
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
// SUMMARY STRIP
// ─────────────────────────────────────────────
class _SummaryStrip extends StatelessWidget {
  final _R r;
  const _SummaryStrip({required this.r});

  @override
  Widget build(BuildContext context) {
    final groups = [
      _RiskGroup.prahamil,
      _RiskGroup.ibuHamil,
      _RiskGroup.bayiBaru,
      _RiskGroup.balita,
      _RiskGroup.dewasa,
      _RiskGroup.komunitas,
    ];

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
        children: groups.map((g) {
          final meta = _groupMeta[g]!;
          final count = _risks.where((risk) => risk.group == g).length;
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: r.sp(10),
              vertical: r.sp(6),
            ),
            decoration: BoxDecoration(
              color: meta.$3.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: meta.$3.withOpacity(0.18), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(meta.$1, style: TextStyle(fontSize: r.fs(14))),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      meta.$2,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(10),
                        fontWeight: FontWeight.w600,
                        color: meta.$3,
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

// ─────────────────────────────────────────────
// LIFECYCLE BANNER
// ─────────────────────────────────────────────
class _LifecycleBanner extends StatelessWidget {
  final _R r;
  const _LifecycleBanner({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(16)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A1628), Color(0xFF1E3A8A)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D4ED8).withOpacity(0.30),
            blurRadius: 18,
            offset: const Offset(0, 8),
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444).withOpacity(0.22),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFEF4444).withOpacity(0.35),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.timeline_rounded,
                          size: 12,
                          color: Color(0xFFFCA5A5),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Siklus Risiko Sepanjang Hidup',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(10),
                            color: const Color(0xFFFCA5A5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: r.sp(10)),
              Text(
                'Stunting bukan hanya masalah anak kecil — risikonya berawal jauh sebelum kelahiran dan dampaknya berlanjut hingga dewasa.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  color: Colors.white.withOpacity(0.85),
                  height: 1.55,
                ),
              ),
              SizedBox(height: r.sp(14)),
              // Timeline dots
              Row(
                children: [
                  _TimelineDot('Pra-\nHamil', const Color(0xFFEC4899), r),
                  _TimelineConnector(),
                  _TimelineDot('Hamil', const Color(0xFF8B5CF6), r),
                  _TimelineConnector(),
                  _TimelineDot('Bayi', const Color(0xFF3B82F6), r),
                  _TimelineConnector(),
                  _TimelineDot('Balita', const Color(0xFF059669), r),
                  _TimelineConnector(),
                  _TimelineDot('Dewasa', const Color(0xFFEF4444), r),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimelineDot extends StatelessWidget {
  final String label;
  final Color color;
  final _R r;
  const _TimelineDot(this.label, this.color, this.r);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.22),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.45), width: 1.5),
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(8.5),
            color: Colors.white60,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

class _TimelineConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      height: 1.5,
      margin: const EdgeInsets.only(bottom: 20),
      color: Colors.white.withOpacity(0.15),
    ),
  );
}

// ─────────────────────────────────────────────
// FILTER BAR
// ─────────────────────────────────────────────
class _FilterBar extends StatelessWidget {
  final _RiskGroup? selected;
  final ValueChanged<_RiskGroup> onSelect;
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
          // All chip
          GestureDetector(
            onTap: () {
              if (selected != null) onSelect(selected!);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
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
                  width: 1,
                ),
                boxShadow: selected == null
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.20),
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
          const SizedBox(width: 8),

          ..._RiskGroup.values.map((g) {
            final meta = _groupMeta[g]!;
            final isSel = selected == g;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => onSelect(g),
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
// RISK CARD
// ─────────────────────────────────────────────
class _RiskCard extends StatelessWidget {
  final _RiskItem risk;
  final int index;
  final bool isExpanded;
  final _R r;
  final VoidCallback onTap;

  const _RiskCard({
    required this.risk,
    required this.index,
    required this.isExpanded,
    required this.r,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final meta = _groupMeta[risk.group]!;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isExpanded
                ? risk.gradient[0].withOpacity(0.35)
                : const Color(0xFFE8F0FE),
            width: isExpanded ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isExpanded
                  ? risk.gradient[0].withOpacity(0.14)
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
              // Left accent bar
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isExpanded
                        ? risk.gradient
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
                      // Header row
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
                                  risk.gradient[0].withOpacity(0.12),
                                  risk.gradient[0].withOpacity(0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: risk.gradient[0].withOpacity(0.20),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                risk.emoji,
                                style: TextStyle(fontSize: r.fs(22)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Chips row
                                Wrap(
                                  spacing: 5,
                                  children: [
                                    _Chip(label: meta.$2, color: meta.$3, r: r),
                                    if (risk.isCritical)
                                      _Chip(
                                        label: '⚠ Kritis',
                                        color: const Color(0xFFEF4444),
                                        r: r,
                                      ),
                                  ],
                                ),
                                SizedBox(height: r.sp(4)),
                                Text(
                                  risk.title,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: r.fs(14),
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                SizedBox(height: r.sp(2)),
                                Text(
                                  risk.shortDesc,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: r.fs(11.5),
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: AnimatedRotation(
                              turns: isExpanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 220),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: isExpanded
                                      ? risk.gradient[0].withOpacity(0.10)
                                      : Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 18,
                                  color: isExpanded
                                      ? risk.gradient[0]
                                      : Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Expanded content
                      if (isExpanded) ...[
                        SizedBox(height: r.sp(14)),
                        Container(
                          height: 1,
                          color: risk.gradient[0].withOpacity(0.10),
                        ),
                        SizedBox(height: r.sp(12)),

                        _DetailBox(
                          icon: Icons.info_outline_rounded,
                          label: 'Dampak & Penjelasan',
                          color: risk.gradient[0],
                          text: risk.detail,
                          r: r,
                        ),
                        SizedBox(height: r.sp(10)),
                        _DetailBox(
                          icon: Icons.biotech_rounded,
                          label: 'Mekanisme Ilmiah',
                          color: const Color(0xFF8B5CF6),
                          text: risk.mechanism,
                          r: r,
                        ),
                        SizedBox(height: r.sp(10)),

                        // Close hint
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: r.sp(10),
                              vertical: r.sp(6),
                            ),
                            decoration: BoxDecoration(
                              color: risk.gradient[0].withOpacity(0.06),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.touch_app_rounded,
                                  size: 13,
                                  color: risk.gradient[0].withOpacity(0.7),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Tap untuk menutup',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: r.fs(10.5),
                                    color: risk.gradient[0].withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  final _R r;
  const _Chip({required this.label, required this.color, required this.r});

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

class _DetailBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final String text;
  final _R r;
  const _DetailBox({
    required this.icon,
    required this.label,
    required this.color,
    required this.text,
    required this.r,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(r.sp(12)),
    decoration: BoxDecoration(
      color: color.withOpacity(0.05),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.15), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(11),
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: r.sp(7)),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(12.5),
            color: const Color(0xFF374151),
            height: 1.6,
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────
// BOTTOM CTA
// ─────────────────────────────────────────────
class _BottomCta extends StatelessWidget {
  final _R r;
  const _BottomCta({required this.r});

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
            right: -10,
            top: -10,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.07),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('🛡️', style: TextStyle(fontSize: 28)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Semua Risiko Bisa Dicegah',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(16),
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
                'Dengan pengetahuan yang tepat dan tindakan sejak dini — mulai dari pra-kehamilan hingga masa balita — risiko stunting dapat dicegah hingga 80%.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  color: Colors.white.withOpacity(0.88),
                  height: 1.6,
                ),
              ),
              SizedBox(height: r.sp(14)),
              Row(
                children: [
                  Expanded(
                    child: _CtaChip(
                      icon: Icons.monitor_heart_rounded,
                      label: 'Lakukan Skrining',
                      r: r,
                    ),
                  ),
                  SizedBox(width: r.sp(10)),
                  Expanded(
                    child: _CtaChip(
                      icon: Icons.local_hospital_rounded,
                      label: 'Konsultasi Nakes',
                      r: r,
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

class _CtaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final _R r;
  const _CtaChip({required this.icon, required this.label, required this.r});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(vertical: r.sp(10), horizontal: r.sp(12)),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.18),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 7),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(12),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
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
              const Color(0xFFEF4444).withOpacity(0.15),
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
