import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/app_colors.dart';

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
class _YearData {
  final int year;
  final double percent;
  final String note;
  final bool isTarget;
  const _YearData(this.year, this.percent, this.note, {this.isTarget = false});
}

class _ProvinceData {
  final String name;
  final double percent;
  final String island;
  const _ProvinceData(this.name, this.percent, this.island);
}

// ─────────────────────────────────────────────
// SSGI 2024 DATA (Sumber: Kemenkes RI, Mei 2025)
// ─────────────────────────────────────────────
const _yearlyData = [
  _YearData(2013, 37.2, 'Baseline — Riskesdas 2013'),
  _YearData(2016, 27.5, 'Perbaikan program gizi nasional'),
  _YearData(2017, 29.6, 'Revisi metodologi pengukuran'),
  _YearData(2018, 30.8, 'SSGBI pertama dilakukan'),
  _YearData(2019, 27.7, 'Program 1000 HPK masif'),
  _YearData(2021, 24.4, 'Dampak pandemi COVID-19'),
  _YearData(2022, 21.6, 'Percepatan penurunan signifikan'),
  _YearData(2023, 21.5, 'Stagnasi — perlu percepatan'),
  _YearData(2024, 19.8, 'SSGI 2024: Melampaui target Bappenas'),
  _YearData(2025, 18.8, 'Target RPJMN 2025', isTarget: true),
  _YearData(2029, 14.2, 'Target RPJMN 2029', isTarget: true),
];

// Data provinsi SSGI 2024 (sumber: BKPK Kemenkes, Mei 2025)
const _provinceData = [
  // Sangat Tinggi (≥30%)
  _ProvinceData('Nusa Tenggara Timur', 37.0, 'Nusa Tenggara'),
  _ProvinceData('Sulawesi Barat', 35.4, 'Sulawesi'),
  _ProvinceData('Papua Barat Daya', 30.5, 'Papua'),
  // Tinggi (25–30%)
  _ProvinceData('Papua', 28.9, 'Papua'),
  _ProvinceData('Maluku Utara', 27.8, 'Maluku'),
  _ProvinceData('Kalimantan Barat', 27.2, 'Kalimantan'),
  _ProvinceData('Sulawesi Tengah', 26.8, 'Sulawesi'),
  _ProvinceData('Aceh', 26.1, 'Sumatera'),
  _ProvinceData('Maluku', 25.9, 'Maluku'),
  _ProvinceData('Gorontalo', 25.5, 'Sulawesi'),
  // Sedang (18–25%)
  _ProvinceData('Sumatera Utara', 23.2, 'Sumatera'),
  _ProvinceData('Kalimantan Selatan', 22.7, 'Kalimantan'),
  _ProvinceData('Sulawesi Tenggara', 22.5, 'Sulawesi'),
  _ProvinceData('Kalimantan Tengah', 22.1, 'Kalimantan'),
  _ProvinceData('Sumatera Selatan', 21.9, 'Sumatera'),
  _ProvinceData('Jawa Tengah', 20.9, 'Jawa-Bali'),
  _ProvinceData('Jawa Barat', 20.2, 'Jawa-Bali'),
  _ProvinceData('Banten', 19.8, 'Jawa-Bali'),
  _ProvinceData('Sulawesi Utara', 19.2, 'Sulawesi'),
  // Rendah (<18%)
  _ProvinceData('Jawa Timur', 14.7, 'Jawa-Bali'),
  _ProvinceData('DI Yogyakarta', 14.9, 'Jawa-Bali'),
  _ProvinceData('DKI Jakarta', 15.6, 'Jawa-Bali'),
  _ProvinceData('Kepulauan Riau', 15.0, 'Sumatera'),
  _ProvinceData('Bali', 8.6, 'Jawa-Bali'),
];

// 6 Provinsi beban terbesar (absolut)
const _burden6 = [
  ('🏙️', 'Jawa Barat', 638000),
  ('🏔️', 'Jawa Tengah', 485893),
  ('🌾', 'Jawa Timur', 430780),
  ('🌴', 'Sumatera Utara', 316456),
  ('🌺', 'NTT', 214143),
  ('🌊', 'Banten', 209600),
];

// ─────────────────────────────────────────────
// DATA SCREEN
// ─────────────────────────────────────────────
class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;
  int _filterLevel = 0;

  List<_ProvinceData> get _filteredProvinces {
    switch (_filterLevel) {
      case 1:
        return _provinceData.where((p) => p.percent >= 28).toList();
      case 2:
        return _provinceData
            .where((p) => p.percent >= 18 && p.percent < 28)
            .toList();
      case 3:
        return _provinceData.where((p) => p.percent < 18).toList();
      default:
        return _provinceData;
    }
  }

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
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: r.isSmall ? 140 : 165,
                collapsedHeight: kToolbarHeight + 12,
                pinned: true,
                floating: false,
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.primary,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                  background: _HeaderBg(r: r),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16, r.sp(16), 16, r.sp(40)),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _HeroStats(r: r),
                    SizedBox(height: r.sp(20)),

                    _SectionLabel(
                      label: 'Tren Nasional 2013–2024 (SSGI)',
                      r: r,
                    ),
                    SizedBox(height: r.sp(12)),
                    _TrendChart(r: r),
                    SizedBox(height: r.sp(20)),

                    _SectionLabel(label: 'Progress Menuju Target', r: r),
                    SizedBox(height: r.sp(12)),
                    _TargetCard(r: r),
                    SizedBox(height: r.sp(20)),

                    _SectionLabel(label: '6 Provinsi Beban Terbesar', r: r),
                    SizedBox(height: r.sp(4)),
                    _BurdenNote(r: r),
                    SizedBox(height: r.sp(10)),
                    _Burden6Card(r: r),
                    SizedBox(height: r.sp(20)),

                    _SectionLabel(label: 'Peta Sebaran Stunting', r: r),
                    SizedBox(height: r.sp(12)),
                    _IndonesiaHeatmap(r: r),
                    SizedBox(height: r.sp(20)),

                    _SectionLabel(label: 'Data Per Provinsi (SSGI 2024)', r: r),
                    SizedBox(height: r.sp(12)),
                    _ProvinceFilter(
                      selected: _filterLevel,
                      onSelect: (i) => setState(() => _filterLevel = i),
                      r: r,
                    ),
                    SizedBox(height: r.sp(12)),
                    _ProvinceList(provinces: _filteredProvinces, r: r),
                    SizedBox(height: r.sp(20)),

                    _SectionLabel(label: 'Perbandingan Global', r: r),
                    SizedBox(height: r.sp(12)),
                    _GlobalComparison(r: r),
                    SizedBox(height: r.sp(20)),

                    _SectionLabel(label: 'Faktor Kesenjangan Sosial', r: r),
                    SizedBox(height: r.sp(12)),
                    _SocialGapCard(r: r),
                    SizedBox(height: r.sp(20)),

                    _SourcesCard(r: r),
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
                    const Color(0xFF3B82F6).withOpacity(0.22),
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
                        'Data Stunting Indonesia',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(17),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Sumber: SSGI 2024 — Kemenkes RI',
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
                        Icons.update_rounded,
                        size: 12,
                        color: Color(0xFF6EE7B7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '2024',
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
// HERO STATS
// ─────────────────────────────────────────────
class _HeroStats extends StatelessWidget {
  final _R r;
  const _HeroStats({required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(r.sp(20)),
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
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // New badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
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
                          Icons.new_releases_rounded,
                          size: 11,
                          color: Color(0xFF6EE7B7),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'SSGI 2024 • Diumumkan 26 Mei 2025',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(10),
                            color: const Color(0xFF6EE7B7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: r.sp(12)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '19.8',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(54),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.0,
                          letterSpacing: -2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8, left: 2),
                        child: Text(
                          '%',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(24),
                            fontWeight: FontWeight.w700,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Prevalensi Stunting Nasional 2024',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.fs(12),
                      color: Colors.white60,
                    ),
                  ),
                  SizedBox(height: r.sp(8)),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF059669).withOpacity(0.20),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.arrow_downward_rounded,
                              color: Color(0xFF34D399),
                              size: 13,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              'Turun 1.7% dari 2023 (21.5%)',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: r.fs(11.5),
                                color: const Color(0xFF6EE7B7),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6).withOpacity(0.20),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Lampaui target 20.1%',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(11),
                            color: const Color(0xFF93C5FD),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: r.sp(14)),
                  Container(height: 1, color: Colors.white.withOpacity(0.12)),
                  SizedBox(height: r.sp(14)),
                  Row(
                    children: [
                      _MiniStat('4.48 Juta', 'Balita stunting', r),
                      _MiniStatDiv(),
                      _MiniStat('357 Ribu', 'Berhasil dicegah', r),
                      _MiniStatDiv(),
                      _MiniStat('38', 'Provinsi', r),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: r.sp(12)),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.trending_down_rounded,
                label: 'Penurunan\n2013→2024',
                value: '−17.4%',
                color: const Color(0xFF059669),
                r: r,
              ),
            ),
            SizedBox(width: r.sp(10)),
            Expanded(
              child: _StatCard(
                icon: Icons.flag_rounded,
                label: 'Target\nRPJMN 2029',
                value: '14.2%',
                color: const Color(0xFFF59E0B),
                r: r,
              ),
            ),
            SizedBox(width: r.sp(10)),
            Expanded(
              child: _StatCard(
                icon: Icons.diversity_3_rounded,
                label: 'Miskin vs\nKaya',
                value: '2.5×',
                color: const Color(0xFFEF4444),
                r: r,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String value;
  final String label;
  final _R r;
  const _MiniStat(this.value, this.label, this.r);

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(13),
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(9.5),
            color: Colors.white54,
          ),
        ),
      ],
    ),
  );
}

class _MiniStatDiv extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 32, color: Colors.white.withOpacity(0.12));
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final _R r;
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(13)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.18), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.09),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withOpacity(0.10),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          SizedBox(height: r.sp(8)),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(17),
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(9.5),
              color: Colors.grey.shade500,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TREND CHART
// ─────────────────────────────────────────────
class _TrendChart extends StatefulWidget {
  final _R r;
  const _TrendChart({required this.r});

  @override
  State<_TrendChart> createState() => _TrendChartState();
}

class _TrendChartState extends State<_TrendChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;
  int? _selectedIndex;

  // Only non-target points for animation
  final _actual = _yearlyData.where((d) => !d.isTarget).toList();

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    final maxVal = _actual.map((d) => d.percent).reduce(math.max);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8F0FE), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
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
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF059669).withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.trending_down_rounded,
                      size: 12,
                      color: Color(0xFF059669),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Turun 17.4% sejak 2013',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(10.5),
                        color: const Color(0xFF059669),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Tap titik untuk detail',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(10),
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),

          if (_selectedIndex != null) ...[
            SizedBox(height: r.sp(10)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(r.sp(12)),
              decoration: BoxDecoration(
                color: const Color(0xFF0A1628),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(
                    '${_actual[_selectedIndex!].year}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.fs(14),
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF60A5FA),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${_actual[_selectedIndex!].percent}% — ${_actual[_selectedIndex!].note}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11.5),
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          SizedBox(height: r.sp(16)),

          SizedBox(
            height: r.isSmall ? 160 : 190,
            child: AnimatedBuilder(
              animation: _anim,
              builder: (context, _) {
                return CustomPaint(
                  painter: _LineChartPainter(
                    data: _actual,
                    progress: _anim.value,
                    maxVal: maxVal,
                    selectedIndex: _selectedIndex,
                  ),
                  child: GestureDetector(
                    onTapDown: (details) {
                      final w = context.size!.width;
                      final spacing = w / (_actual.length - 1);
                      final tappedX = details.localPosition.dx;
                      int closest = 0;
                      double minDist = double.infinity;
                      for (int i = 0; i < _actual.length; i++) {
                        final dist = (i * spacing - tappedX).abs();
                        if (dist < minDist) {
                          minDist = dist;
                          closest = i;
                        }
                      }
                      setState(() {
                        _selectedIndex = _selectedIndex == closest
                            ? null
                            : closest;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          SizedBox(height: r.sp(8)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _actual
                .map(
                  (d) => Text(
                    "'${d.year.toString().substring(2)}",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.fs(9.5),
                      color: d.year == 2024
                          ? const Color(0xFF3B82F6)
                          : Colors.grey.shade400,
                      fontWeight: d.year == 2024
                          ? FontWeight.w700
                          : FontWeight.w400,
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

class _LineChartPainter extends CustomPainter {
  final List<_YearData> data;
  final double progress;
  final double maxVal;
  final int? selectedIndex;

  _LineChartPainter({
    required this.data,
    required this.progress,
    required this.maxVal,
    required this.selectedIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final spacing = w / (data.length - 1);

    double yFor(double val) =>
        h - (h * 0.1) - ((val / (maxVal + 5)) * (h * 0.85));

    // Grid
    final gridPaint = Paint()
      ..color = Colors.grey.shade100
      ..strokeWidth = 1;
    for (int i = 0; i <= 4; i++) {
      final y = h * 0.1 + (h * 0.8 * i / 4);
      canvas.drawLine(Offset(0, y), Offset(w, y), gridPaint);
    }

    // Y labels
    final ts = const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 9,
      color: Color(0xFF94A3B8),
    );
    for (int i = 0; i <= 4; i++) {
      final val = (maxVal + 5) - ((maxVal + 5) * i / 4);
      final y = h * 0.1 + (h * 0.8 * i / 4);
      final tp = TextPainter(
        text: TextSpan(text: '${val.toStringAsFixed(0)}%', style: ts),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(0, y - 6));
    }

    // Animated points
    final totalPts = (data.length - 1) * progress;
    final fullPts = totalPts.floor();
    final partial = totalPts - fullPts;

    final points = <Offset>[];
    for (int i = 0; i <= fullPts && i < data.length; i++) {
      points.add(Offset(i * spacing, yFor(data[i].percent)));
    }
    if (fullPts < data.length - 1) {
      final x1 = fullPts * spacing;
      final x2 = (fullPts + 1) * spacing;
      final y1 = yFor(data[fullPts].percent);
      final y2 = yFor(data[fullPts + 1].percent);
      points.add(Offset(x1 + (x2 - x1) * partial, y1 + (y2 - y1) * partial));
    }

    if (points.length < 2) return;

    // Fill
    final path = Path();
    path.moveTo(points.first.dx, h);
    for (final pt in points) path.lineTo(pt.dx, pt.dy);
    path.lineTo(points.last.dx, h);
    path.close();
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF3B82F6).withOpacity(0.22),
            const Color(0xFF3B82F6).withOpacity(0.02),
          ],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    // Line
    final linePath = Path();
    linePath.moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      final p0 = points[i - 1];
      final p1 = points[i];
      final cp1 = Offset((p0.dx + p1.dx) / 2, p0.dy);
      final cp2 = Offset((p0.dx + p1.dx) / 2, p1.dy);
      linePath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p1.dx, p1.dy);
    }
    canvas.drawPath(
      linePath,
      Paint()
        ..color = const Color(0xFF3B82F6)
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );

    // Dots
    for (int i = 0; i < points.length && i < data.length; i++) {
      final pt = points[i];
      final isSelected = selectedIndex == i;
      final isLast = i == data.length - 1;

      if (isSelected || isLast) {
        canvas.drawCircle(
          pt,
          isSelected ? 10 : 7,
          Paint()..color = const Color(0xFF3B82F6).withOpacity(0.20),
        );
        canvas.drawCircle(
          pt,
          isSelected ? 7 : 5,
          Paint()..color = Colors.white,
        );
        canvas.drawCircle(
          pt,
          isSelected ? 5 : 3.5,
          Paint()
            ..color = isLast
                ? const Color(0xFF059669)
                : const Color(0xFF3B82F6),
        );
      } else {
        canvas.drawCircle(pt, 2.5, Paint()..color = Colors.white);
        canvas.drawCircle(
          pt,
          1.8,
          Paint()..color = const Color(0xFF3B82F6).withOpacity(0.7),
        );
      }
    }
  }

  @override
  bool shouldRepaint(_LineChartPainter old) =>
      old.progress != progress || old.selectedIndex != selectedIndex;
}

// ─────────────────────────────────────────────
// TARGET CARD
// ─────────────────────────────────────────────
class _TargetCard extends StatefulWidget {
  final _R r;
  const _TargetCard({required this.r});

  @override
  State<_TargetCard> createState() => _TargetCardState();
}

class _TargetCardState extends State<_TargetCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    // Progress 2013 (37.2) → 2024 (19.8) toward 2029 (14.2)
    // total to reduce: 37.2 - 14.2 = 23.0
    // already reduced: 37.2 - 19.8 = 17.4
    // progress = 17.4 / 23.0 = 75.65%
    const progressPct = 0.7565;
    const gapTo2025 = 19.8 - 18.8; // 1.0%
    const gapTo2029 = 19.8 - 14.2; // 5.6%

    return Container(
      padding: EdgeInsets.all(r.sp(18)),
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
          // Milestones row
          Row(
            children: [
              _TargetMilestone(
                '2024',
                '19.8%',
                const Color(0xFF3B82F6),
                true,
                r,
              ),
              _TargetMilestoneArrow(),
              _TargetMilestone(
                '2025',
                '18.8%',
                const Color(0xFFF59E0B),
                false,
                r,
              ),
              _TargetMilestoneArrow(),
              _TargetMilestone(
                '2029',
                '14.2%',
                const Color(0xFF059669),
                false,
                r,
              ),
              _TargetMilestoneArrow(),
              _TargetMilestone('2045', '5%', const Color(0xFF8B5CF6), false, r),
            ],
          ),
          SizedBox(height: r.sp(18)),

          // Progress bar
          AnimatedBuilder(
            animation: _anim,
            builder: (_, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress menuju target 2029',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(11.5),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        '${(progressPct * _anim.value * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(12),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF3B82F6),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: r.sp(8)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      children: [
                        Container(height: 12, color: Colors.grey.shade100),
                        FractionallySizedBox(
                          widthFactor: progressPct * _anim.value,
                          child: Container(
                            height: 12,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF3B82F6), Color(0xFF059669)],
                              ),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF3B82F6,
                                  ).withOpacity(0.35),
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
                  SizedBox(height: r.sp(5)),
                  Row(
                    children: [
                      Text(
                        'Baseline 2013: 37.2%',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(9.5),
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Target 2029: 14.2%',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(9.5),
                          color: const Color(0xFF059669),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),

          SizedBox(height: r.sp(14)),
          Container(height: 1, color: Colors.grey.shade100),
          SizedBox(height: r.sp(12)),

          Row(
            children: [
              Expanded(
                child: _GapChip(
                  label: 'Gap ke 2025',
                  value: '−${gapTo2025.toStringAsFixed(1)}%',
                  color: const Color(0xFFF59E0B),
                  r: r,
                ),
              ),
              SizedBox(width: r.sp(10)),
              Expanded(
                child: _GapChip(
                  label: 'Gap ke 2029',
                  value: '−${gapTo2029.toStringAsFixed(1)}%',
                  color: const Color(0xFFEF4444),
                  r: r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TargetMilestone extends StatelessWidget {
  final String year;
  final String value;
  final Color color;
  final bool isCurrent;
  final _R r;
  const _TargetMilestone(
    this.year,
    this.value,
    this.color,
    this.isCurrent,
    this.r,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: r.sp(8), horizontal: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(isCurrent ? 0.12 : 0.05),
          borderRadius: BorderRadius.circular(10),
          border: isCurrent
              ? Border.all(color: color.withOpacity(0.35), width: 1.5)
              : null,
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(13),
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            Text(
              year,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(9.5),
                color: Colors.grey.shade500,
              ),
            ),
            if (isCurrent)
              Container(
                margin: const EdgeInsets.only(top: 3),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Kini',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(8),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TargetMilestoneArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Icon(
      Icons.arrow_forward_ios_rounded,
      size: 10,
      color: Colors.grey.shade300,
    ),
  );
}

class _GapChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final _R r;
  const _GapChip({
    required this.label,
    required this.value,
    required this.color,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(12)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.18), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
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
              fontSize: r.fs(10.5),
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BURDEN NOTE
// ─────────────────────────────────────────────
class _BurdenNote extends StatelessWidget {
  final _R r;
  const _BurdenNote({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(12)),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFECACA), width: 1),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: Color(0xFFEF4444),
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '50% balita stunting nasional terkonsentrasi di 6 provinsi berikut ini — menjadi prioritas utama pemerintah.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(11.5),
                color: const Color(0xFFB91C1C),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BURDEN 6 CARD
// ─────────────────────────────────────────────
class _Burden6Card extends StatefulWidget {
  final _R r;
  const _Burden6Card({required this.r});

  @override
  State<_Burden6Card> createState() => _Burden6CardState();
}

class _Burden6CardState extends State<_Burden6Card>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    final maxVal = _burden6.map((b) => b.$3.toDouble()).reduce(math.max);

    return Container(
      padding: EdgeInsets.all(r.sp(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8F0FE), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEF4444).withOpacity(0.07),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: _burden6.asMap().entries.map((e) {
          final i = e.key;
          final item = e.value;
          return Padding(
            padding: EdgeInsets.only(
              bottom: i < _burden6.length - 1 ? r.sp(14) : 0,
            ),
            child: AnimatedBuilder(
              animation: _anim,
              builder: (_, __) => Row(
                children: [
                  Text(item.$1, style: TextStyle(fontSize: r.fs(20))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.$2,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: r.fs(12.5),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              '${((item.$3 * _anim.value) / 1000).toStringAsFixed(0)} ribu',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: r.fs(12),
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFEF4444),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: r.sp(5)),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Stack(
                            children: [
                              Container(height: 8, color: Colors.grey.shade100),
                              FractionallySizedBox(
                                widthFactor: (item.$3 / maxVal) * _anim.value,
                                child: Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(
                                          0xFFEF4444,
                                        ).withOpacity(0.7),
                                        const Color(0xFFEF4444),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFFEF4444,
                                        ).withOpacity(0.25),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
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
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// INDONESIA HEATMAP
// ─────────────────────────────────────────────
class _IndonesiaHeatmap extends StatelessWidget {
  final _R r;
  const _IndonesiaHeatmap({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: EdgeInsets.all(r.sp(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🗺️', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Text(
                'Peta Sebaran Visual (SSGI 2024)',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(10)),
          // Heat legend
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF059669),
                        Color(0xFFF59E0B),
                        Color(0xFFEF4444),
                        Color(0xFFB91C1C),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '<18% Rendah',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(9),
                  color: const Color(0xFF059669),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '18–28% Sedang',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(9),
                  color: const Color(0xFFF59E0B),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '>28% Tinggi',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(9),
                  color: const Color(0xFFB91C1C),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(14)),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              height: r.isSmall ? 175 : 210,
              color: const Color(0xFFBAE6FD),
              child: CustomPaint(painter: _MapPainter2024()),
            ),
          ),
          SizedBox(height: r.sp(10)),
          // Highlight best/worst
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(r.sp(10)),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFBBF7D0),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🏆 Terbaik',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(9.5),
                          color: const Color(0xFF059669),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Bali 8.6%',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(12),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF047857),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(r.sp(10)),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFFECACA),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '⚠️ Tertinggi',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(9.5),
                          color: const Color(0xFFEF4444),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'NTT 37%',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: r.fs(12),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFB91C1C),
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

class _MapPainter2024 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFFBAE6FD),
    );

    final islands = [
      // (l, t, w, h, color, label)
      (0.02, 0.15, 0.20, 0.55, const Color(0xFF10B981), 'Sumatera\n22.6%'),
      (0.23, 0.28, 0.14, 0.40, const Color(0xFF059669), 'Jawa\n18.4%'),
      (0.37, 0.05, 0.18, 0.65, const Color(0xFFF59E0B), 'Kalimantan\n25%'),
      (0.55, 0.10, 0.16, 0.55, const Color(0xFFF59E0B), 'Sulawesi\n24%'),
      (0.35, 0.72, 0.07, 0.22, const Color(0xFF059669), 'Bali\n8.6%'),
      (0.43, 0.72, 0.10, 0.22, const Color(0xFFDC2626), 'NTT\n37%'),
      (0.71, 0.25, 0.10, 0.35, const Color(0xFFF59E0B), 'Maluku\n25%'),
      (0.83, 0.05, 0.16, 0.75, const Color(0xFFDC2626), 'Papua\n28–37%'),
    ];

    for (final isl in islands) {
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(w * isl.$1, h * isl.$2, w * isl.$3, h * isl.$4),
        const Radius.circular(8),
      );
      canvas.drawRRect(
        rect.shift(const Offset(2, 2)),
        Paint()..color = Colors.black.withOpacity(0.10),
      );
      canvas.drawRRect(rect, Paint()..color = isl.$5);
      canvas.drawRRect(
        rect,
        Paint()
          ..color = Colors.white.withOpacity(0.45)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );

      final tp = TextPainter(
        text: TextSpan(
          text: isl.$6,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: math.min(w * isl.$3 * 0.18, 10),
            fontWeight: FontWeight.w700,
            color: Colors.white,
            shadows: const [
              Shadow(
                color: Colors.black26,
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: w * isl.$3);

      tp.paint(
        canvas,
        Offset(
          w * isl.$1 + (w * isl.$3 - tp.width) / 2,
          h * isl.$2 + (h * isl.$4 - tp.height) / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(_MapPainter2024 _) => false;
}

// ─────────────────────────────────────────────
// PROVINCE FILTER
// ─────────────────────────────────────────────
class _ProvinceFilter extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  final _R r;
  const _ProvinceFilter({
    required this.selected,
    required this.onSelect,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      ('Semua', Colors.grey.shade600, Icons.apps_rounded),
      ('Kritis ≥28%', const Color(0xFFDC2626), Icons.priority_high_rounded),
      ('Sedang 18–28%', const Color(0xFFF59E0B), Icons.remove_rounded),
      ('Rendah <18%', const Color(0xFF059669), Icons.check_rounded),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filters.asMap().entries.map((e) {
          final i = e.key;
          final f = e.value;
          final isSel = selected == i;
          return Padding(
            padding: EdgeInsets.only(right: i < filters.length - 1 ? 8 : 0),
            child: GestureDetector(
              onTap: () => onSelect(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: r.sp(12),
                  vertical: r.sp(8),
                ),
                decoration: BoxDecoration(
                  color: isSel ? f.$2 : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSel ? f.$2 : Colors.grey.shade200,
                    width: 1,
                  ),
                  boxShadow: isSel
                      ? [
                          BoxShadow(
                            color: f.$2.withOpacity(0.30),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(f.$3, size: 13, color: isSel ? Colors.white : f.$2),
                    const SizedBox(width: 5),
                    Text(
                      f.$1,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11.5),
                        fontWeight: FontWeight.w600,
                        color: isSel ? Colors.white : f.$2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PROVINCE LIST
// ─────────────────────────────────────────────
class _ProvinceList extends StatelessWidget {
  final List<_ProvinceData> provinces;
  final _R r;
  const _ProvinceList({required this.provinces, required this.r});

  Color _levelColor(double val) {
    if (val >= 28) return const Color(0xFFDC2626);
    if (val >= 18) return const Color(0xFFF59E0B);
    return const Color(0xFF059669);
  }

  String _levelLabel(double val) {
    if (val >= 28) return 'Kritis';
    if (val >= 18) return 'Sedang';
    return 'Rendah';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: provinces.asMap().entries.map((e) {
          final i = e.key;
          final p = e.value;
          final color = _levelColor(p.percent);
          final isLast = i == provinces.length - 1;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: r.sp(16),
                  vertical: r.sp(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(11),
                            fontWeight: FontWeight.w700,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: r.fs(13),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            p.island,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: r.fs(10),
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${p.percent}%',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: r.fs(14),
                            fontWeight: FontWeight.w800,
                            color: color,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _levelLabel(p.percent),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: r.fs(9.5),
                              fontWeight: FontWeight.w600,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(horizontal: r.sp(16)),
                  color: Colors.grey.shade50,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// GLOBAL COMPARISON
// ─────────────────────────────────────────────
class _GlobalComparison extends StatefulWidget {
  final _R r;
  const _GlobalComparison({required this.r});

  @override
  State<_GlobalComparison> createState() => _GlobalComparisonState();
}

class _GlobalComparisonState extends State<_GlobalComparison>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    final countries = [
      ('🇵🇰', 'Pakistan', 37.6, const Color(0xFF991B1B)),
      ('🇮🇳', 'India', 35.5, const Color(0xFFB91C1C)),
      ('🇧🇩', 'Bangladesh', 28.0, const Color(0xFFDC2626)),
      ('🌍', 'Rata² Dunia', 22.3, const Color(0xFF3B82F6)),
      ('🇮🇩', 'Indonesia', 19.8, const Color(0xFF10B981)),
      ('🇹🇭', 'Thailand', 11.4, const Color(0xFF059669)),
      ('🇸🇬', 'Singapura', 4.1, const Color(0xFF047857)),
    ];
    final maxVal = countries.map((c) => c.$3).reduce(math.max);

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
        children: countries.asMap().entries.map((e) {
          final i = e.key;
          final c = e.value;
          final isIndo = c.$2 == 'Indonesia';
          return Padding(
            padding: EdgeInsets.only(
              bottom: i < countries.length - 1 ? r.sp(12) : 0,
            ),
            child: AnimatedBuilder(
              animation: _anim,
              builder: (_, __) => Row(
                children: [
                  Text(c.$1, style: TextStyle(fontSize: r.fs(18))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  c.$2,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: r.fs(12.5),
                                    fontWeight: isIndo
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isIndo
                                        ? c.$4
                                        : const Color(0xFF374151),
                                  ),
                                ),
                                if (isIndo) ...[
                                  const SizedBox(width: 5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: c.$4,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '2024',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: r.fs(8),
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              '${(c.$3 * _anim.value).toStringAsFixed(1)}%',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: r.fs(12),
                                fontWeight: FontWeight.w700,
                                color: c.$4,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: r.sp(4)),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Stack(
                            children: [
                              Container(
                                height: isIndo ? 9 : 7,
                                color: Colors.grey.shade100,
                              ),
                              FractionallySizedBox(
                                widthFactor: (c.$3 / maxVal) * _anim.value,
                                child: Container(
                                  height: isIndo ? 9 : 7,
                                  decoration: BoxDecoration(
                                    color: isIndo
                                        ? c.$4
                                        : c.$4.withOpacity(0.65),
                                    borderRadius: BorderRadius.circular(5),
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
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SOCIAL GAP CARD (data baru dari SSGI 2024)
// ─────────────────────────────────────────────
class _SocialGapCard extends StatelessWidget {
  final _R r;
  const _SocialGapCard({required this.r});

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.bar_chart_rounded,
                  color: Colors.white,
                  size: 17,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Kesenjangan Sosial-Ekonomi (SSGI 2024)',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(13),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(14)),

          // Quintile bars
          ...[
            ('Q1 Termiskin', 29.8, const Color(0xFFDC2626)),
            ('Q2', 24.5, const Color(0xFFEF4444)),
            ('Q3 Menengah', 20.2, const Color(0xFFF59E0B)),
            ('Q4', 16.8, const Color(0xFF10B981)),
            ('Q5 Terkaya', 12.0, const Color(0xFF059669)),
          ].asMap().entries.map((e) {
            final i = e.key;
            final q = e.value;
            return Padding(
              padding: EdgeInsets.only(bottom: i < 4 ? r.sp(10) : 0),
              child: Row(
                children: [
                  SizedBox(
                    width: r.w * 0.28,
                    child: Text(
                      q.$1,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11.5),
                        color: const Color(0xFF374151),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Stack(
                        children: [
                          Container(height: 8, color: Colors.grey.shade100),
                          FractionallySizedBox(
                            widthFactor: q.$2 / 35,
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: q.$3,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${q.$2}%',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.fs(11.5),
                      fontWeight: FontWeight.w700,
                      color: q.$3,
                    ),
                  ),
                ],
              ),
            );
          }),

          SizedBox(height: r.sp(12)),
          Container(
            padding: EdgeInsets.all(r.sp(12)),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFDDD6FE), width: 1),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Color(0xFF7C3AED),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Anak dari keluarga termiskin 2.5× lebih berisiko stunting dibanding keluarga terkaya.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.fs(11.5),
                      color: const Color(0xFF5B21B6),
                      height: 1.45,
                    ),
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
// SOURCES CARD
// ─────────────────────────────────────────────
class _SourcesCard extends StatelessWidget {
  final _R r;
  const _SourcesCard({required this.r});

  @override
  Widget build(BuildContext context) {
    final sources = [
      'SSGI 2024 — Kemenkes RI, diumumkan 26 Mei 2025 (Data terbaru)',
      'BKPK Kemenkes RI — badankebijakan.kemkes.go.id',
      'Tim Percepatan Penurunan Stunting — stunting.go.id',
      'Riskesdas 2013, 2016, 2017, 2018 (Data historis)',
      'RPJMN 2025–2029 — Bappenas & Setwapres',
      'Global Nutrition Report 2023 — WHO/UNICEF (Data komparatif)',
    ];

    return Container(
      padding: EdgeInsets.all(r.sp(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF059669).withOpacity(0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_rounded,
                      size: 12,
                      color: Color(0xFF059669),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Data Terverifikasi',
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
              const SizedBox(width: 8),
              Text(
                'Sumber Data',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF475569),
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(10)),
          ...sources.map(
            (s) => Padding(
              padding: EdgeInsets.only(bottom: r.sp(6)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      s,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11),
                        color: const Color(0xFF64748B),
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
