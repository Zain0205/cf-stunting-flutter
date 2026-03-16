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
// DATA MODELS
// ─────────────────────────────────────────────
enum _Category { fisik, kognitif, imun, perilaku }

class _Sign {
  final String emoji;
  final String title;
  final String shortDesc;
  final String detail;
  final String whyItHappens;
  final _Category category;
  final List<Color> gradient;
  final bool isUrgent;

  const _Sign({
    required this.emoji,
    required this.title,
    required this.shortDesc,
    required this.detail,
    required this.whyItHappens,
    required this.category,
    required this.gradient,
    this.isUrgent = false,
  });
}

// ─────────────────────────────────────────────
// DATA
// ─────────────────────────────────────────────
const _signs = [
  // ── FISIK ──
  _Sign(
    emoji: '📏',
    title: 'Tinggi Badan Pendek',
    shortDesc: 'TB/U di bawah -2 SD standar WHO',
    detail:
        'Tinggi atau panjang badan anak secara signifikan lebih pendek dibandingkan anak seusia dari populasi yang sehat. Diukur menggunakan z-score TB/U (Tinggi Badan menurut Umur) < -2 SD berdasarkan standar pertumbuhan WHO.',
    whyItHappens:
        'Kekurangan protein, zinc, dan kalsium jangka panjang menghambat sintesis tulang dan hormon pertumbuhan (IGF-1). Infeksi berulang memperparah kondisi karena energi dipakai untuk melawan penyakit.',
    category: _Category.fisik,
    gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    isUrgent: true,
  ),
  _Sign(
    emoji: '⚖️',
    title: 'Berat Badan Tidak Naik',
    shortDesc: 'Tidak naik selama 2 bulan berturut-turut',
    detail:
        'Berat badan anak stagnan atau tidak mengalami kenaikan minimal selama 2 bulan berturut-turut saat ditimbang di Posyandu. Ini disebut sebagai "Balita Tidak Naik (T)" pada grafik KMS.',
    whyItHappens:
        'Asupan kalori tidak mencukupi kebutuhan basal ditambah kebutuhan tumbuh. Bisa disebabkan oleh pola makan tidak teratur, MPASI tidak adekuat, atau absorpsi nutrisi terganggu akibat infeksi usus.',
    category: _Category.fisik,
    gradient: [Color(0xFFEF4444), Color(0xFFB91C1C)],
    isUrgent: true,
  ),
  _Sign(
    emoji: '🦷',
    title: 'Terlambat Tumbuh Gigi',
    shortDesc: 'Gigi belum tumbuh di atas usia 12 bulan',
    detail:
        'Gigi pertama anak normalnya mulai tumbuh antara usia 6–10 bulan. Pada anak stunting, erupsi gigi dapat tertunda hingga melewati usia 12–14 bulan. Struktur gigi yang terbentuk juga cenderung lebih rapuh.',
    whyItHappens:
        'Kekurangan kalsium, fosfor, dan vitamin D menghambat mineralisasi email gigi dan tulang alveolar. Nutrisi yang tidak adekuat selama masa pembentukan gigi dalam kandungan turut berkontribusi.',
    category: _Category.fisik,
    gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
  ),
  _Sign(
    emoji: '💪',
    title: 'Massa Otot Rendah',
    shortDesc: 'Tubuh tampak kurus, otot tidak berkembang',
    detail:
        'Anak stunting sering menunjukkan tanda-tanda hipotrofi otot: lengan dan kaki terlihat kurus, tonus otot rendah, serta kemampuan motorik kasar yang terbatas. Ini berbeda dengan anak gemuk yang juga bisa stunting.',
    whyItHappens:
        'Defisiensi protein — terutama asam amino esensial — menghambat sintesis protein otot (muscle protein synthesis). Hormon pertumbuhan dan IGF-1 yang rendah juga menurunkan anabolisme otot.',
    category: _Category.fisik,
    gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
  ),
  _Sign(
    emoji: '🤲',
    title: 'Kulit & Rambut Kusam',
    shortDesc: 'Rambut tipis, mudah rontok, kulit kering',
    detail:
        'Rambut anak terlihat tipis, jarang, berwarna kemerahan/kekuningan (flag sign), dan mudah dicabut tanpa rasa sakit. Kulit tampak kering, bersisik, dan mudah mengalami luka yang lambat sembuh.',
    whyItHappens:
        'Defisiensi protein berat (kwashiorkor) menyebabkan perubahan warna dan tekstur rambut. Kekurangan zinc, biotin, dan vitamin A memengaruhi pertumbuhan sel epidermis dan folikel rambut.',
    category: _Category.fisik,
    gradient: [Color(0xFF06B6D4), Color(0xFF0891B2)],
  ),
  _Sign(
    emoji: '🫃',
    title: 'Perut Membuncit',
    shortDesc: 'Perut besar tidak proporsional',
    detail:
        'Perut anak tampak membuncit keluar secara tidak proporsional dibanding tubuhnya. Ini bukan tanda anak gemuk atau sehat, melainkan tanda malnutrisi protein yang mengganggu keseimbangan tekanan osmotik.',
    whyItHappens:
        'Kekurangan albumin darah akibat defisiensi protein menyebabkan tekanan onkotik plasma turun, sehingga cairan bocor ke rongga perut (asites). Pembesaran hati berlemak (hepatomegali) juga dapat berkontribusi.',
    category: _Category.fisik,
    gradient: [Color(0xFFEC4899), Color(0xFFBE185D)],
  ),

  // ── KOGNITIF ──
  _Sign(
    emoji: '💬',
    title: 'Terlambat Bicara',
    shortDesc: 'Perkembangan bahasa di bawah anak seusia',
    detail:
        'Anak stunting cenderung mencapai milestone bicara lebih lambat: belum mengucapkan kata bermakna di usia 12 bulan, kalimat 2 kata di usia 24 bulan, atau kalimat lengkap di usia 36 bulan.',
    whyItHappens:
        'Kekurangan gizi pada 1000 HPK mengganggu mielinisasi serabut saraf dan pembentukan sinapsis di area Broca dan Wernicke yang mengatur bahasa. Berkurangnya interaksi sosial akibat kelesuan juga memperlambat perkembangan bahasa.',
    category: _Category.kognitif,
    gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
  ),
  _Sign(
    emoji: '🧩',
    title: 'Kemampuan Kognitif Lambat',
    shortDesc: 'Sulit berkonsentrasi dan memecahkan masalah',
    detail:
        'Anak mengalami keterlambatan dalam memori kerja, kemampuan pemecahan masalah, dan konsentrasi. Prestasi akademik di sekolah dasar cenderung di bawah rata-rata teman seusianya.',
    whyItHappens:
        'Volume hipokampus (pusat memori) dan korteks prefrontal (pengambilan keputusan) lebih kecil pada anak stunting. DHA dan zat besi yang rendah pada masa kritis perkembangan otak berdampak permanen pada konektivitas neural.',
    category: _Category.kognitif,
    gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
  ),
  _Sign(
    emoji: '🚶',
    title: 'Motorik Lambat',
    shortDesc: 'Terlambat duduk, berdiri, berjalan',
    detail:
        'Milestone motorik kasar seperti duduk (seharusnya ~6 bulan), berdiri (~12 bulan), dan berjalan (~12–15 bulan) dapat tertunda secara signifikan. Motorik halus seperti memegang pensil juga terlambat berkembang.',
    whyItHappens:
        'Defisiensi zat besi menurunkan mielinisasi traktus kortikospinalis yang mengontrol gerakan volunter. Massa otot rendah dan kelemahan umum juga membuat anak enggan mencoba gerakan baru.',
    category: _Category.kognitif,
    gradient: [Color(0xFF059669), Color(0xFF047857)],
  ),

  // ── IMUN ──
  _Sign(
    emoji: '🤒',
    title: 'Mudah Sakit',
    shortDesc: 'Infeksi berulang dan pemulihan lambat',
    detail:
        'Anak stunting lebih rentan terkena infeksi saluran napas atas (pilek, batuk), diare, dan pneumonia. Frekuensi sakit lebih tinggi dan durasi penyakit lebih panjang dibanding anak bergizi baik.',
    whyItHappens:
        'Defisiensi vitamin A, C, zinc, dan protein melemahkan imunitas seluler (sel T dan B) dan imunitas bawaan (neutrofil, makrofag). Integritas mukosa saluran napas dan pencernaan juga menurun.',
    category: _Category.imun,
    gradient: [Color(0xFFEF4444), Color(0xFFB91C1C)],
    isUrgent: true,
  ),
  _Sign(
    emoji: '🩹',
    title: 'Luka Lambat Sembuh',
    shortDesc: 'Penyembuhan luka lebih lama dari normal',
    detail:
        'Luka kecil, lecet, atau bekas suntikan imunisasi sembuh jauh lebih lambat dibanding anak seusia. Bekas luka juga lebih rentan terinfeksi sekunder.',
    whyItHappens:
        'Sintesis kolagen — komponen utama penyembuhan luka — membutuhkan vitamin C, zinc, dan protein yang cukup. Defisiensi nutrisi ini secara langsung memperlambat proliferasi fibroblas dan angiogenesis.',
    category: _Category.imun,
    gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
  ),

  // ── PERILAKU ──
  _Sign(
    emoji: '😴',
    title: 'Lesu & Kurang Aktif',
    shortDesc: 'Tampak lemas, tidak bersemangat bermain',
    detail:
        'Anak tampak tidak berenergi, mudah lelah, dan kurang bersemangat untuk bermain dan berinteraksi. Berbeda dengan anak normal seusia yang aktif dan penuh rasa ingin tahu.',
    whyItHappens:
        'Anemia defisiensi besi menurunkan kapasitas pengangkutan oksigen ke otak dan otot, menghasilkan kelelahan kronis. Disfungsi mitokondria akibat malnutrisi juga mengurangi produksi ATP (energi sel).',
    category: _Category.perilaku,
    gradient: [Color(0xFF06B6D4), Color(0xFF0891B2)],
  ),
  _Sign(
    emoji: '😢',
    title: 'Mudah Rewel & Menangis',
    shortDesc: 'Temperamen mudah marah, sulit ditenangkan',
    detail:
        'Anak lebih sering menangis, rewel, dan mengalami kesulitan dalam regulasi emosi dibanding anak sehat. Responsivitas terhadap stimulus juga bisa meningkat secara negatif.',
    whyItHappens:
        'Ketidakseimbangan neurotransmiter (serotonin, dopamin) akibat defisiensi triptofan dan tirosin. Ketidaknyamanan fisik akibat lapar dan kembung kronis juga meningkatkan iritabilitas.',
    category: _Category.perilaku,
    gradient: [Color(0xFFEC4899), Color(0xFFBE185D)],
  ),
  _Sign(
    emoji: '🍽️',
    title: 'Nafsu Makan Buruk',
    shortDesc: 'Susah makan, pilih-pilih makanan',
    detail:
        'Anak menolak makan, hanya mau makanan tertentu, atau makan dalam jumlah sangat sedikit. Proses makan bisa berlangsung sangat lama (>30 menit) dengan hasil yang tidak adekuat.',
    whyItHappens:
        'Defisiensi zinc secara langsung memengaruhi persepsi rasa (hipogeusia) dan nafsu makan melalui jalur neuropeptida Y. Distended abdomen akibat dismotilitas GI juga menciptakan rasa kenyang palsu.',
    category: _Category.perilaku,
    gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
  ),
];

const _categoryLabels = {
  _Category.fisik: 'Fisik',
  _Category.kognitif: 'Kognitif',
  _Category.imun: 'Imunitas',
  _Category.perilaku: 'Perilaku',
};

const _categoryIcons = {
  _Category.fisik: Icons.accessibility_new_rounded,
  _Category.kognitif: Icons.psychology_rounded,
  _Category.imun: Icons.shield_rounded,
  _Category.perilaku: Icons.emoji_emotions_rounded,
};

const _categoryColors = {
  _Category.fisik: Color(0xFF3B82F6),
  _Category.kognitif: Color(0xFF8B5CF6),
  _Category.imun: Color(0xFFEF4444),
  _Category.perilaku: Color(0xFFEC4899),
};

// ─────────────────────────────────────────────
// CIRI SCREEN
// ─────────────────────────────────────────────
class CiriScreen extends StatefulWidget {
  const CiriScreen({super.key});

  @override
  State<CiriScreen> createState() => _CiriScreenState();
}

class _CiriScreenState extends State<CiriScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  _Category? _selectedCategory; // null = tampilkan semua
  int? _expandedIndex;

  List<_Sign> get _filtered => _selectedCategory == null
      ? _signs
      : _signs.where((s) => s.category == _selectedCategory).toList();

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
                snap: false,
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

              // ── FILTER TABS ──
              SliverToBoxAdapter(
                child: _FilterBar(
                  selected: _selectedCategory,
                  onSelect: (cat) => setState(() {
                    _selectedCategory = _selectedCategory == cat ? null : cat;
                    _expandedIndex = null;
                  }),
                  r: r,
                ),
              ),

              // ── SIGN LIST ──
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16, r.sp(14), 16, r.sp(16)),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final sign = filtered[index];
                    final isExpanded = _expandedIndex == index;
                    return Padding(
                      padding: EdgeInsets.only(bottom: r.sp(12)),
                      child: _SignCard(
                        sign: sign,
                        index: index,
                        isExpanded: isExpanded,
                        r: r,
                        onTap: () => setState(() {
                          _expandedIndex = isExpanded ? null : index;
                        }),
                      ),
                    );
                  }, childCount: filtered.length),
                ),
              ),

              // ── PENTING CARD ──
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, r.sp(16)),
                sliver: SliverToBoxAdapter(child: _UrgentCard(r: r)),
              ),

              // Bottom padding
              SliverToBoxAdapter(child: SizedBox(height: r.sp(30))),
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
                    const Color(0xFFEF4444).withOpacity(0.0),
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
                    const Color(0xFF3B82F6).withOpacity(0.0),
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
                        'Ciri-Ciri Stunting',
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
                        'Kenali tanda sejak dini',
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
                        '${_signs.length} Ciri',
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
    final cats = [
      (
        _Category.fisik,
        _signs.where((s) => s.category == _Category.fisik).length,
      ),
      (
        _Category.kognitif,
        _signs.where((s) => s.category == _Category.kognitif).length,
      ),
      (
        _Category.imun,
        _signs.where((s) => s.category == _Category.imun).length,
      ),
      (
        _Category.perilaku,
        _signs.where((s) => s.category == _Category.perilaku).length,
      ),
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
      child: Row(
        children: cats.map((c) {
          final color = _categoryColors[c.$1]!;
          final icon = _categoryIcons[c.$1]!;
          final label = _categoryLabels[c.$1]!;
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
                  '${c.$2}',
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

// ─────────────────────────────────────────────
// FILTER BAR
// ─────────────────────────────────────────────
class _FilterBar extends StatelessWidget {
  final _Category? selected;
  final ValueChanged<_Category> onSelect;
  final _R r;

  const _FilterBar({
    required this.selected,
    required this.onSelect,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0F4FF),
      padding: EdgeInsets.fromLTRB(16, r.sp(12), 16, r.sp(4)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _FilterChip(
              label: 'Semua',
              icon: Icons.apps_rounded,
              color: const Color(0xFF475569),
              isSelected: selected == null,
              onTap: () {
                if (selected != null) onSelect(selected!);
              },
              r: r,
            ),
            const SizedBox(width: 8),
            ..._Category.values.map(
              (cat) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _FilterChip(
                  label: _categoryLabels[cat]!,
                  icon: _categoryIcons[cat]!,
                  color: _categoryColors[cat]!,
                  isSelected: selected == cat,
                  onTap: () => onSelect(cat),
                  r: r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final _R r;

  const _FilterChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: r.sp(12), vertical: r.sp(8)),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade200,
            width: isSelected ? 0 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.30),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: isSelected ? Colors.white : color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(11.5),
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SIGN CARD
// ─────────────────────────────────────────────
class _SignCard extends StatelessWidget {
  final _Sign sign;
  final int index;
  final bool isExpanded;
  final _R r;
  final VoidCallback onTap;

  const _SignCard({
    required this.sign,
    required this.index,
    required this.isExpanded,
    required this.r,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final catColor = _categoryColors[sign.category]!;
    final catLabel = _categoryLabels[sign.category]!;
    final catIcon = _categoryIcons[sign.category]!;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isExpanded
                ? sign.gradient[0].withOpacity(0.35)
                : const Color(0xFFE8F0FE),
            width: isExpanded ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isExpanded
                  ? sign.gradient[0].withOpacity(0.15)
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
              // ── LEFT ACCENT ──
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isExpanded
                        ? sign.gradient
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
                      // ── HEADER ROW ──
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
                                  sign.gradient[0].withOpacity(0.12),
                                  sign.gradient[0].withOpacity(0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: sign.gradient[0].withOpacity(0.20),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                sign.emoji,
                                style: TextStyle(fontSize: r.fs(22)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Category chip
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: catColor.withOpacity(0.10),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            catIcon,
                                            size: 10,
                                            color: catColor,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            catLabel,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: r.fs(9),
                                              fontWeight: FontWeight.w600,
                                              color: catColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (sign.isUrgent) ...[
                                      const SizedBox(width: 5),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFFEF4444,
                                          ).withOpacity(0.10),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.priority_high_rounded,
                                              size: 10,
                                              color: Color(0xFFEF4444),
                                            ),
                                            Text(
                                              'Urgent',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: r.fs(9),
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFFEF4444),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: r.sp(4)),
                                Text(
                                  sign.title,
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
                                  sign.shortDesc,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: r.fs(11.5),
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Expand arrow
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
                                      ? sign.gradient[0].withOpacity(0.10)
                                      : Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 18,
                                  color: isExpanded
                                      ? sign.gradient[0]
                                      : Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ── EXPANDED DETAIL ──
                      if (isExpanded) ...[
                        SizedBox(height: r.sp(14)),
                        Container(
                          height: 1,
                          color: sign.gradient[0].withOpacity(0.10),
                        ),
                        SizedBox(height: r.sp(14)),

                        // Detail description
                        _DetailSection(
                          icon: Icons.info_outline_rounded,
                          label: 'Penjelasan',
                          color: sign.gradient[0],
                          text: sign.detail,
                          r: r,
                        ),

                        SizedBox(height: r.sp(12)),

                        // Why it happens
                        _DetailSection(
                          icon: Icons.biotech_rounded,
                          label: 'Mengapa Bisa Terjadi?',
                          color: const Color(0xFF8B5CF6),
                          text: sign.whyItHappens,
                          r: r,
                        ),

                        SizedBox(height: r.sp(12)),

                        // Tap hint
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: r.sp(12),
                            vertical: r.sp(8),
                          ),
                          decoration: BoxDecoration(
                            color: sign.gradient[0].withOpacity(0.06),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.touch_app_rounded,
                                size: 14,
                                color: sign.gradient[0].withOpacity(0.7),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Tap untuk menutup',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: r.fs(10.5),
                                  color: sign.gradient[0].withOpacity(0.7),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
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

// ─────────────────────────────────────────────
// DETAIL SECTION
// ─────────────────────────────────────────────
class _DetailSection extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final String text;
  final _R r;

  const _DetailSection({
    required this.icon,
    required this.label,
    required this.color,
    required this.text,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Icon(icon, size: 14, color: color),
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
          SizedBox(height: r.sp(8)),
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
}

// ─────────────────────────────────────────────
// URGENT CARD
// ─────────────────────────────────────────────
class _UrgentCard extends StatelessWidget {
  final _R r;
  const _UrgentCard({required this.r});

  @override
  Widget build(BuildContext context) {
    final urgentCount = _signs.where((s) => s.isUrgent).length;

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
            right: -15,
            top: -15,
            child: Container(
              width: 90,
              height: 90,
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
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444).withOpacity(0.20),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFEF4444).withOpacity(0.35),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.notification_important_rounded,
                      color: Color(0xFFFCA5A5),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kapan Harus ke Dokter?',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(15),
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          '$urgentCount ciri di atas memerlukan perhatian segera',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(10.5),
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: r.sp(14)),
              Container(height: 1, color: Colors.white.withOpacity(0.10)),
              SizedBox(height: r.sp(14)),
              Text(
                'Segera konsultasikan ke bidan atau dokter anak jika anak menunjukkan 2 atau lebih ciri berikut secara bersamaan:',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  color: Colors.white.withOpacity(0.80),
                  height: 1.55,
                ),
              ),
              SizedBox(height: r.sp(12)),
              ...[
                ('📏', 'Tinggi badan jauh di bawah standar usia'),
                ('⚖️', 'Berat badan tidak naik 2 bulan berturut-turut'),
                ('🤒', 'Sakit lebih dari 2 kali dalam sebulan'),
                ('😴', 'Sangat lesu dan tidak responsif'),
              ].map(
                (item) => Padding(
                  padding: EdgeInsets.only(bottom: r.sp(8)),
                  child: Row(
                    children: [
                      Text(item.$1, style: TextStyle(fontSize: r.fs(16))),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item.$2,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(12.5),
                            color: Colors.white.withOpacity(0.80),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: r.sp(14)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: r.sp(12)),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withOpacity(0.20),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFEF4444).withOpacity(0.35),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.local_hospital_rounded,
                        color: Color(0xFFFCA5A5),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Hubungi Posyandu / Puskesmas Terdekat',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(13),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFCA5A5),
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
              const Color(0xFFEF4444).withOpacity(0.18),
              const Color(0xFFEF4444).withOpacity(0.0),
            ],
          ).createShader(
            Rect.fromCircle(center: Offset(size.width + 20, -20), radius: 140),
          );
    canvas.drawCircle(Offset(size.width + 20, -20), 140, orb);
  }

  @override
  bool shouldRepaint(_GridPainter _) => false;
}
