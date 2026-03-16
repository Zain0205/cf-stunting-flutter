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
class _FactItem {
  final String emoji;
  final String title;
  final String value;
  final Color color;
  const _FactItem(this.emoji, this.title, this.value, this.color);
}

class _MythItem {
  final String myth;
  final String fact;
  final bool isExpanded;
  const _MythItem(this.myth, this.fact, {this.isExpanded = false});
}

class _TimelineItem {
  final String period;
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradient;
  const _TimelineItem(
    this.period,
    this.title,
    this.description,
    this.icon,
    this.gradient,
  );
}

class _PreventionItem {
  final IconData icon;
  final String title;
  final String description;
  final List<Color> gradient;
  const _PreventionItem(this.icon, this.title, this.description, this.gradient);
}

// ─────────────────────────────────────────────
// PENGERTIAN SCREEN
// ─────────────────────────────────────────────
class PengertianScreen extends StatefulWidget {
  const PengertianScreen({super.key});

  @override
  State<PengertianScreen> createState() => _PengertianScreenState();
}

class _PengertianScreenState extends State<PengertianScreen>
    with TickerProviderStateMixin {
  late final AnimationController _headerCtrl;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;

  // Tab: 0 = Umum, 1 = Ibu Hamil, 2 = Bayi Baru Lahir
  int _activeTab = 0;

  final _myths = [
    _MythItem(
      'Anak pendek itu keturunan, tidak bisa dicegah.',
      'Stunting bukan semata soal genetik. Lebih dari 70% kasus stunting disebabkan oleh kurangnya asupan gizi, infeksi berulang, dan lingkungan tidak sehat — semua bisa dicegah.',
    ),
    _MythItem(
      'Anak gemuk pasti tidak stunting.',
      'Stunting diukur dari tinggi badan terhadap usia, bukan berat badan. Anak bisa terlihat gemuk sekaligus mengalami stunting (kondisi ini disebut "stunted overweight").',
    ),
    _MythItem(
      'Stunting hanya masalah fisik.',
      'Stunting juga berdampak pada perkembangan otak, kemampuan belajar, kecerdasan, dan produktivitas di masa dewasa. Dampaknya bersifat jangka panjang.',
    ),
    _MythItem(
      'Stunting bisa disembuhkan setelah anak besar.',
      'Kerusakan akibat stunting yang terjadi pada 1000 HPK (Hari Pertama Kehidupan) bersifat permanen dan sangat sulit dipulihkan setelah usia 2 tahun.',
    ),
  ];

  final _expandedMyths = <int>{};

  @override
  void initState() {
    super.initState();
    _headerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _headerFade = CurvedAnimation(
      parent: _headerCtrl,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _headerCtrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _headerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = _R(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: FadeTransition(
        opacity: _headerFade,
        child: SlideTransition(
          position: _headerSlide,
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

              // ── CONTENT ──
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16, r.sp(16), 16, r.sp(40)),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Definition card
                    _DefinitionCard(r: r),
                    SizedBox(height: r.sp(20)),

                    // Stats row
                    _SectionLabel(label: 'Fakta & Statistik', r: r),
                    SizedBox(height: r.sp(12)),
                    _StatsRow(r: r),
                    SizedBox(height: r.sp(20)),

                    // Tab selector
                    _SectionLabel(label: 'Panduan Berdasarkan Kondisi', r: r),
                    SizedBox(height: r.sp(12)),
                    _TabSelector(
                      active: _activeTab,
                      onTap: (i) => setState(() => _activeTab = i),
                      r: r,
                    ),
                    SizedBox(height: r.sp(14)),
                    _TabContent(tab: _activeTab, r: r),
                    SizedBox(height: r.sp(20)),

                    // Timeline 1000 HPK
                    _SectionLabel(label: '1000 Hari Pertama Kehidupan', r: r),
                    SizedBox(height: r.sp(12)),
                    _TimelineSection(r: r),
                    SizedBox(height: r.sp(20)),

                    // Myth buster
                    _SectionLabel(label: 'Mitos vs Fakta', r: r),
                    SizedBox(height: r.sp(12)),
                    ...List.generate(
                      _myths.length,
                      (i) => Padding(
                        padding: EdgeInsets.only(bottom: r.sp(10)),
                        child: _MythCard(
                          item: _myths[i],
                          index: i,
                          isExpanded: _expandedMyths.contains(i),
                          r: r,
                          onTap: () => setState(() {
                            if (_expandedMyths.contains(i)) {
                              _expandedMyths.remove(i);
                            } else {
                              _expandedMyths.add(i);
                            }
                          }),
                        ),
                      ),
                    ),
                    SizedBox(height: r.sp(20)),

                    // Prevention
                    _SectionLabel(label: 'Pencegahan Stunting', r: r),
                    SizedBox(height: r.sp(12)),
                    _PreventionSection(r: r),
                    SizedBox(height: r.sp(20)),

                    // CTA
                    _CtaCard(r: r),
                  ]),
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
// HEADER BACKGROUND
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
          // Orb
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
          Positioned(
            top: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF06B6D4).withOpacity(0.15),
                    const Color(0xFF06B6D4).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // Content
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
                        'Apa Itu Stunting?',
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
                        'Edukasi Kesehatan Ibu & Anak',
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
                        Icons.school_rounded,
                        size: 12,
                        color: Color(0xFF6EE7B7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Edukasi',
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
// DEFINITION CARD
// ─────────────────────────────────────────────
class _DefinitionCard extends StatelessWidget {
  final _R r;
  const _DefinitionCard({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A1628), Color(0xFF1E3A8A)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D4ED8).withOpacity(0.35),
            blurRadius: 24,
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
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            left: -10,
            bottom: -10,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(r.sp(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.20),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.menu_book_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Definisi WHO',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: r.fs(11),
                              color: Colors.white60,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Stunting',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: r.fs(20),
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: r.sp(16)),
                Container(height: 1, color: Colors.white.withOpacity(0.15)),
                SizedBox(height: r.sp(14)),
                Text(
                  'Stunting adalah kondisi gagal tumbuh pada anak balita akibat kekurangan gizi kronis dan infeksi berulang, terutama pada 1000 Hari Pertama Kehidupan (HPK). Ditandai dengan tinggi badan anak yang lebih pendek dari standar usianya (z-score < -2 SD).',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(13),
                    color: Colors.white.withOpacity(0.85),
                    height: 1.65,
                  ),
                ),
                SizedBox(height: r.sp(14)),
                // Key indicator
                Container(
                  padding: EdgeInsets.all(r.sp(12)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.12),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.straighten_rounded,
                        color: Color(0xFF60A5FA),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Indikator: Tinggi/Panjang Badan menurut Umur (TB/U atau PB/U) < -2 Standar Deviasi',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(11.5),
                            color: const Color(0xFF93C5FD),
                            height: 1.5,
                          ),
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
// STATS ROW
// ─────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  final _R r;
  const _StatsRow({required this.r});

  @override
  Widget build(BuildContext context) {
    final stats = [
      _FactItem('📊', 'Prevalensi Indonesia', '21,6%', const Color(0xFF3B82F6)),
      _FactItem(
        '🌍',
        'Anak Stunting Dunia',
        '149 Juta',
        const Color(0xFFEF4444),
      ),
      _FactItem('⏰', 'Masa Kritis', '1000 HPK', const Color(0xFF059669)),
      _FactItem('💰', 'Kerugian Ekonomi', '2-3% GDP', const Color(0xFFF59E0B)),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.55,
      ),
      itemCount: stats.length,
      itemBuilder: (_, i) => _StatCard(item: stats[i], r: r),
    );
  }
}

class _StatCard extends StatelessWidget {
  final _FactItem item;
  final _R r;
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

// ─────────────────────────────────────────────
// TAB SELECTOR
// ─────────────────────────────────────────────
class _TabSelector extends StatelessWidget {
  final int active;
  final ValueChanged<int> onTap;
  final _R r;
  const _TabSelector({
    required this.active,
    required this.onTap,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [('🔍', 'Umum'), ('🤰', 'Ibu Hamil'), ('👶', 'Bayi Baru')];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (i) => Expanded(
            child: GestureDetector(
              onTap: () => onTap(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(vertical: r.sp(10)),
                decoration: BoxDecoration(
                  gradient: active == i
                      ? const LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: active == i
                      ? [
                          BoxShadow(
                            color: const Color(0xFF3B82F6).withOpacity(0.30),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Column(
                  children: [
                    Text(tabs[i].$1, style: TextStyle(fontSize: r.fs(18))),
                    const SizedBox(height: 3),
                    Text(
                      tabs[i].$2,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(10.5),
                        fontWeight: active == i
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: active == i
                            ? Colors.white
                            : Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TAB CONTENT
// ─────────────────────────────────────────────
class _TabContent extends StatelessWidget {
  final int tab;
  final _R r;
  const _TabContent({required this.tab, required this.r});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.05, 0),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        ),
      ),
      child: KeyedSubtree(
        key: ValueKey(tab),
        child: tab == 0
            ? _TabUmum(r: r)
            : tab == 1
            ? _TabIbuHamil(r: r)
            : _TabBayiBaru(r: r),
      ),
    );
  }
}

// ── TAB UMUM ──
class _TabUmum extends StatelessWidget {
  final _R r;
  const _TabUmum({required this.r});

  @override
  Widget build(BuildContext context) {
    final causes = [
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoCard(
          title: 'Penyebab Utama Stunting',
          icon: Icons.search_rounded,
          gradient: [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)],
          r: r,
          child: Column(
            children: causes.asMap().entries.map((e) {
              final i = e.key;
              final c = e.value;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: i < causes.length - 1 ? r.sp(12) : 0,
                ),
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
        _DampakCard(r: r),
      ],
    );
  }
}

class _DampakCard extends StatelessWidget {
  final _R r;
  const _DampakCard({required this.r});

  @override
  Widget build(BuildContext context) {
    final dampak = [
      ('🧠', 'Gangguan perkembangan otak & kecerdasan'),
      ('📉', 'Prestasi belajar menurun'),
      ('💪', 'Daya tahan tubuh rendah'),
      ('❤️', 'Risiko penyakit tidak menular di usia dewasa'),
      ('💼', 'Produktivitas & pendapatan lebih rendah'),
    ];

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

// ── TAB IBU HAMIL ──
class _TabIbuHamil extends StatelessWidget {
  final _R r;
  const _TabIbuHamil({required this.r});

  @override
  Widget build(BuildContext context) {
    final trimesters = [
      (
        'Trimester 1 (0–12 Minggu)',
        const Color(0xFF059669),
        [
          'Konsumsi asam folat 400 mcg/hari untuk mencegah cacat tabung saraf.',
          'Hindari rokok, alkohol, dan obat-obatan tanpa resep dokter.',
          'Atasi mual dengan makan kecil tapi sering, 5–6 kali per hari.',
          'Mulai suplemen zat besi dan kalsium sesuai anjuran bidan/dokter.',
        ],
      ),
      (
        'Trimester 2 (13–27 Minggu)',
        const Color(0xFF3B82F6),
        [
          'Tingkatkan asupan protein: 70–100 gram per hari (telur, ikan, tahu, tempe).',
          'Konsumsi kalsium 1200 mg/hari untuk pembentukan tulang janin.',
          'Lakukan pemeriksaan USG untuk memantau pertumbuhan janin.',
          'Aktif bergerak ringan: jalan kaki 30 menit per hari jika kondisi memungkinkan.',
        ],
      ),
      (
        'Trimester 3 (28–40 Minggu)',
        const Color(0xFF8B5CF6),
        [
          'Perbanyak zat besi: 27 mg/hari untuk mencegah anemia pada ibu dan janin.',
          'Konsumsi DHA (omega-3) untuk perkembangan otak janin: ikan salmon, sarden.',
          'Istirahat cukup, hindari stres berlebihan yang bisa mengganggu pertumbuhan janin.',
          'Persiapkan ASI: pijat payudara dan kenali tanda-tanda persalinan.',
        ],
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Alert card
        Container(
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
        ),
        SizedBox(height: r.sp(12)),

        // Trimester guide
        ...trimesters.map(
          (t) => Padding(
            padding: EdgeInsets.only(bottom: r.sp(12)),
            child: _TrimesterCard(title: t.$1, color: t.$2, tips: t.$3, r: r),
          ),
        ),

        // Nutrisi key
        _NutrisiKeyCard(r: r),
      ],
    );
  }
}

class _TrimesterCard extends StatefulWidget {
  final String title;
  final Color color;
  final List<String> tips;
  final _R r;
  const _TrimesterCard({
    required this.title,
    required this.color,
    required this.tips,
    required this.r,
  });

  @override
  State<_TrimesterCard> createState() => _TrimesterCardState();
}

class _TrimesterCardState extends State<_TrimesterCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: widget.color.withOpacity(0.22), width: 1),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(r.sp(14)),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: widget.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(13),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${widget.tips.length} tips',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(9.5),
                        color: widget.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 220),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: widget.color,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            if (_expanded) ...[
              Container(height: 1, color: widget.color.withOpacity(0.12)),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  r.sp(14),
                  r.sp(12),
                  r.sp(14),
                  r.sp(14),
                ),
                child: Column(
                  children: widget.tips.asMap().entries.map((e) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: e.key < widget.tips.length - 1 ? r.sp(10) : 0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(top: 2),
                            decoration: BoxDecoration(
                              color: widget.color.withOpacity(0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${e.key + 1}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: r.fs(9),
                                  fontWeight: FontWeight.w700,
                                  color: widget.color,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              e.value,
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
                  }).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NutrisiKeyCard extends StatelessWidget {
  final _R r;
  const _NutrisiKeyCard({required this.r});

  @override
  Widget build(BuildContext context) {
    final nutrients = [
      ('🥚', 'Protein', 'Telur, ikan, ayam', const Color(0xFF3B82F6)),
      ('🥦', 'Asam Folat', 'Sayuran hijau', const Color(0xFF059669)),
      ('🥛', 'Kalsium', 'Susu, keju, tahu', const Color(0xFF8B5CF6)),
      ('🐟', 'DHA', 'Ikan berlemak', const Color(0xFFF59E0B)),
    ];

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

// ── TAB BAYI BARU LAHIR ──
class _TabBayiBaru extends StatelessWidget {
  final _R r;
  const _TabBayiBaru({required this.r});

  @override
  Widget build(BuildContext context) {
    final milestones = [
      (
        '0–6 Bulan',
        Icons.baby_changing_station_rounded,
        const Color(0xFFEC4899),
        [
          'ASI eksklusif: berikan ASI saja tanpa tambahan air, susu formula, atau makanan lain.',
          'Susui on-demand: setiap 2–3 jam atau minimal 8–12 kali per hari.',
          'IMD (Inisiasi Menyusu Dini): dalam 1 jam pertama setelah lahir untuk kolostrum.',
          'Hindari penggunaan dot dan empeng untuk menjaga produksi ASI.',
          'Pantau kenaikan berat badan setiap bulan di Posyandu.',
        ],
      ),
      (
        '6–12 Bulan',
        Icons.restaurant_rounded,
        const Color(0xFF3B82F6),
        [
          'MPASI (Makanan Pendamping ASI) dimulai tepat usia 6 bulan.',
          'Mulai dengan tekstur lembut: bubur saring, pure sayur, pure buah.',
          'Perkenalkan satu bahan makanan baru setiap 3–5 hari untuk deteksi alergi.',
          'Tetap berikan ASI bersama MPASI hingga usia minimal 2 tahun.',
          'Pastikan MPASI kaya protein hewani: hati ayam, telur, ikan sejak awal.',
        ],
      ),
      (
        '12–24 Bulan',
        Icons.child_care_rounded,
        const Color(0xFF059669),
        [
          'Variasikan menu: minimal 5 dari 8 kelompok makanan setiap harinya.',
          'Porsi makan meningkat: 3 kali makan utama + 2 kali selingan bergizi.',
          'Stimulasi aktif: ajak makan bersama keluarga untuk belajar makan mandiri.',
          'Pantau pertumbuhan: lakukan penimbangan dan pengukuran tinggi badan rutin.',
          'Imunisasi lengkap: pastikan jadwal imunisasi dasar terpenuhi.',
        ],
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(r.sp(14)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF3B82F6).withOpacity(0.10),
                const Color(0xFF3B82F6).withOpacity(0.04),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF3B82F6).withOpacity(0.22),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const Text('👶', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Dua tahun pertama kehidupan adalah jendela emas perkembangan anak. Nutrisi yang tepat di periode ini bersifat irreversible — tidak bisa diulang.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(12.5),
                    color: const Color(0xFF1E40AF),
                    height: 1.55,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: r.sp(12)),
        ...milestones.map(
          (m) => Padding(
            padding: EdgeInsets.only(bottom: r.sp(12)),
            child: _TrimesterCard(title: m.$1, color: m.$3, tips: m.$4, r: r),
          ),
        ),
        _TandaStuntingCard(r: r),
      ],
    );
  }
}

class _TandaStuntingCard extends StatelessWidget {
  final _R r;
  const _TandaStuntingCard({required this.r});

  @override
  Widget build(BuildContext context) {
    final signs = [
      ('📏', 'Tinggi badan di bawah garis merah pada KMS (Kartu Menuju Sehat)'),
      ('⚖️', 'Berat badan tidak naik 2 bulan berturut-turut'),
      ('😴', 'Anak tampak lesu, kurang aktif, dan mudah sakit'),
      ('🍽️', 'Nafsu makan buruk atau kesulitan makan dalam waktu lama'),
      ('💬', 'Keterlambatan bicara dan perkembangan motorik'),
    ];

    return Container(
      padding: EdgeInsets.all(r.sp(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFDE68A), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF59E0B).withOpacity(0.10),
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
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                  ),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.visibility_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Tanda-Tanda Perlu Diwaspadai',
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
          ...signs.map(
            (s) => Padding(
              padding: EdgeInsets.only(bottom: r.sp(8)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.$1, style: TextStyle(fontSize: r.fs(16))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      s.$2,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(12.5),
                        color: const Color(0xFF78350F),
                        height: 1.5,
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

// ─────────────────────────────────────────────
// TIMELINE 1000 HPK
// ─────────────────────────────────────────────
class _TimelineSection extends StatelessWidget {
  final _R r;
  const _TimelineSection({required this.r});

  @override
  Widget build(BuildContext context) {
    final items = [
      _TimelineItem(
        'Konsepsi',
        'Persiapan Pra-kehamilan',
        'Konsumsi asam folat, perbaiki status gizi, hindari rokok & alkohol sebelum hamil.',
        Icons.favorite_rounded,
        [const Color(0xFFEC4899), const Color(0xFFBE185D)],
      ),
      _TimelineItem(
        '0–9 Bulan',
        'Masa Kehamilan',
        'Nutrisi optimal ibu hamil, ANC rutin, suplemen zat besi & kalsium, hindari stres.',
        Icons.pregnant_woman_rounded,
        [const Color(0xFF8B5CF6), const Color(0xFF6D28D9)],
      ),
      _TimelineItem(
        'Lahir',
        'Saat Kelahiran',
        'IMD dalam 1 jam pertama, kolostrum ASI pertama untuk kekebalan tubuh bayi.',
        Icons.baby_changing_station_rounded,
        [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)],
      ),
      _TimelineItem(
        '0–6 Bulan',
        'ASI Eksklusif',
        'Hanya ASI, tanpa tambahan apapun. ASI = perlindungan, nutrisi, dan kasih sayang.',
        Icons.water_drop_rounded,
        [const Color(0xFF06B6D4), const Color(0xFF0891B2)],
      ),
      _TimelineItem(
        '6–24 Bulan',
        'ASI + MPASI',
        'MPASI bergizi dimulai tepat usia 6 bulan. Variasi makanan + ASI hingga 2 tahun.',
        Icons.restaurant_rounded,
        [const Color(0xFF059669), const Color(0xFF047857)],
      ),
    ];

    return Column(
      children: items.asMap().entries.map((e) {
        final i = e.key;
        final item = e.value;
        final isLast = i == items.length - 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline line
            Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: item.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: item.gradient[0].withOpacity(0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(item.icon, color: Colors.white, size: 18),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: r.sp(50),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          item.gradient[0].withOpacity(0.4),
                          items[i + 1].gradient[0].withOpacity(0.4),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : r.sp(8), top: 4),
                child: Container(
                  padding: EdgeInsets.all(r.sp(14)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: item.gradient[0].withOpacity(0.18),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: item.gradient[0].withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: item.gradient[0].withOpacity(0.10),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              item.period,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: r.fs(9.5),
                                fontWeight: FontWeight.w700,
                                color: item.gradient[0],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: r.sp(6)),
                      Text(
                        item.title,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(13.5),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      SizedBox(height: r.sp(4)),
                      Text(
                        item.description,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(12),
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────
// MYTH CARD
// ─────────────────────────────────────────────
class _MythCard extends StatelessWidget {
  final _MythItem item;
  final int index;
  final bool isExpanded;
  final _R r;
  final VoidCallback onTap;
  const _MythCard({
    required this.item,
    required this.index,
    required this.isExpanded,
    required this.r,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isExpanded
                ? const Color(0xFF3B82F6).withOpacity(0.30)
                : const Color(0xFFE8F0FE),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isExpanded
                  ? const Color(0xFF3B82F6).withOpacity(0.10)
                  : Colors.black.withOpacity(0.04),
              blurRadius: isExpanded ? 16 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(r.sp(14)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Center(
                      child: Text('🚫', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mitos',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(9.5),
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFEF4444),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.myth,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(13),
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 220),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: isExpanded
                          ? const Color(0xFF3B82F6)
                          : Colors.grey.shade400,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            if (isExpanded) ...[
              Container(height: 1, color: const Color(0xFFE8F0FE)),
              Padding(
                padding: EdgeInsets.all(r.sp(14)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: const Center(
                        child: Text('✅', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fakta',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: r.fs(9.5),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF059669),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.fact,
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
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PREVENTION SECTION
// ─────────────────────────────────────────────
class _PreventionSection extends StatelessWidget {
  final _R r;
  const _PreventionSection({required this.r});

  @override
  Widget build(BuildContext context) {
    final items = [
      _PreventionItem(
        Icons.water_drop_rounded,
        'ASI Eksklusif',
        'Berikan ASI eksklusif 0–6 bulan tanpa tambahan apapun.',
        [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)],
      ),
      _PreventionItem(
        Icons.restaurant_rounded,
        'MPASI Berkualitas',
        'MPASI bergizi, bervariasi, dan tepat waktu mulai usia 6 bulan.',
        [const Color(0xFF059669), const Color(0xFF047857)],
      ),
      _PreventionItem(
        Icons.vaccines_rounded,
        'Imunisasi Lengkap',
        'Pastikan jadwal imunisasi dasar dan lanjutan terpenuhi.',
        [const Color(0xFF8B5CF6), const Color(0xFF6D28D9)],
      ),
      _PreventionItem(
        Icons.wash_rounded,
        'Sanitasi & PHBS',
        'Cuci tangan pakai sabun, air bersih, jamban sehat.',
        [const Color(0xFF06B6D4), const Color(0xFF0891B2)],
      ),
      _PreventionItem(
        Icons.monitor_heart_rounded,
        'Pemantauan Rutin',
        'Timbang & ukur anak di Posyandu minimal 1x per bulan.',
        [const Color(0xFFF59E0B), const Color(0xFFD97706)],
      ),
      _PreventionItem(
        Icons.medical_services_rounded,
        'Konsultasi Rutin',
        'Periksa ke bidan/dokter secara berkala untuk deteksi dini.',
        [const Color(0xFFEC4899), const Color(0xFFBE185D)],
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.15,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];
        return Container(
          padding: EdgeInsets.all(r.sp(14)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: item.gradient[0].withOpacity(0.18),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: item.gradient[0].withOpacity(0.09),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: item.gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: item.gradient[0].withOpacity(0.30),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(item.icon, color: Colors.white, size: 20),
              ),
              SizedBox(height: r.sp(10)),
              Text(
                item.title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: r.sp(4)),
              Text(
                item.description,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(11),
                  color: Colors.grey.shade500,
                  height: 1.45,
                ),
              ),
            ],
          ),
        );
      },
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
      padding: EdgeInsets.all(r.sp(20)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF059669), Color(0xFF047857)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF059669).withOpacity(0.35),
            blurRadius: 24,
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
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('🎯', style: TextStyle(fontSize: 28)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Cegah Stunting Mulai Hari Ini!',
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
              SizedBox(height: r.sp(12)),
              Text(
                'Stunting bukan takdir — stunting bisa dicegah. Dengan pengetahuan yang tepat dan tindakan sejak dini, setiap anak berhak tumbuh sehat dan optimal.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  color: Colors.white.withOpacity(0.88),
                  height: 1.6,
                ),
              ),
              SizedBox(height: r.sp(16)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: r.sp(16),
                  vertical: r.sp(12),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.monitor_heart_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Mulai Skrining Sekarang',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(13),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
// INFO CARD (reusable)
// ─────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final Widget child;
  final _R r;
  const _InfoCard({
    required this.title,
    required this.icon,
    required this.gradient,
    required this.child,
    required this.r,
  });

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
            color: gradient[0].withOpacity(0.07),
            blurRadius: 14,
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
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(13.5),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(14)),
          Container(height: 1, color: Colors.grey.shade100),
          SizedBox(height: r.sp(14)),
          child,
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
              const Color(0xFF3B82F6).withOpacity(0.20),
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
