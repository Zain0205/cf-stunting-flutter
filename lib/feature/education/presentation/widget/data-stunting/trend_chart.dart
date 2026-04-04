import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Animated line chart showing national stunting trend 2013–2024.
class TrendChart extends StatefulWidget {
  final ResponsiveHelper r;

  const TrendChart({super.key, required this.r});

  @override
  State<TrendChart> createState() => _TrendChartState();
}

class _TrendChartState extends State<TrendChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;
  int? _selectedIndex;

  final List<YearData> _actual = StuntingData.actualYearly;

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
          _ChartHeader(r: r),
          if (_selectedIndex != null) ...[
            SizedBox(height: r.sp(10)),
            _SelectedDetail(data: _actual[_selectedIndex!], r: r),
          ],
          SizedBox(height: r.sp(16)),
          SizedBox(
            height: r.isSmall ? 160 : 190,
            child: AnimatedBuilder(
              animation: _anim,
              builder: (context, _) => CustomPaint(
                painter: LineChartPainter(
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
                    setState(
                      () => _selectedIndex = _selectedIndex == closest
                          ? null
                          : closest,
                    );
                  },
                ),
              ),
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

class _ChartHeader extends StatelessWidget {
  final ResponsiveHelper r;
  const _ChartHeader({required this.r});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
  );
}

class _SelectedDetail extends StatelessWidget {
  final YearData data;
  final ResponsiveHelper r;
  const _SelectedDetail({required this.data, required this.r});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(r.sp(12)),
    decoration: BoxDecoration(
      color: const Color(0xFF0A1628),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Text(
          '${data.year}',
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
            '${data.percent}% — ${data.note}',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(11.5),
              color: Colors.white70,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Custom painter for the animated trend line chart.
class LineChartPainter extends CustomPainter {
  final List<YearData> data;
  final double progress;
  final double maxVal;
  final int? selectedIndex;

  const LineChartPainter({
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
    const ts = TextStyle(
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
    final fillPath = Path();
    fillPath.moveTo(points.first.dx, h);
    for (final pt in points) fillPath.lineTo(pt.dx, pt.dy);
    fillPath.lineTo(points.last.dx, h);
    fillPath.close();
    canvas.drawPath(
      fillPath,
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

    // Smooth line
    final linePath = Path();
    linePath.moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      final p0 = points[i - 1];
      final p1 = points[i];
      linePath.cubicTo(
        (p0.dx + p1.dx) / 2,
        p0.dy,
        (p0.dx + p1.dx) / 2,
        p1.dy,
        p1.dx,
        p1.dy,
      );
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
  bool shouldRepaint(LineChartPainter old) =>
      old.progress != progress || old.selectedIndex != selectedIndex;
}

class YearData {
  final int year;
  final double percent;
  final String note;
  final bool isTarget;

  const YearData(this.year, this.percent, this.note, {this.isTarget = false});
}

class ProvinceData {
  final String name;
  final double percent;
  final String island;

  /// ISO 3166-2:ID province code (e.g. 'ID-JB' for Jawa Barat).
  /// Used to identify the province on the map.
  final String isoCode;

  const ProvinceData(this.name, this.percent, this.island, this.isoCode);
}

abstract class StuntingData {
  static const List<YearData> yearly = [
    YearData(2013, 37.2, 'Baseline — Riskesdas 2013'),
    YearData(2016, 27.5, 'Perbaikan program gizi nasional'),
    YearData(2017, 29.6, 'Revisi metodologi pengukuran'),
    YearData(2018, 30.8, 'SSGBI pertama dilakukan'),
    YearData(2019, 27.7, 'Program 1000 HPK masif'),
    YearData(2021, 24.4, 'Dampak pandemi COVID-19'),
    YearData(2022, 21.6, 'Percepatan penurunan signifikan'),
    YearData(2023, 21.5, 'Stagnasi — perlu percepatan'),
    YearData(2024, 19.8, 'SSGI 2024: Melampaui target Bappenas'),
    YearData(2025, 18.8, 'Target RPJMN 2025', isTarget: true),
    YearData(2029, 14.2, 'Target RPJMN 2029', isTarget: true),
  ];

  static List<YearData> get actualYearly =>
      yearly.where((d) => !d.isTarget).toList();

  /// SSGI 2024 province data with ISO 3166-2 codes
  static const List<ProvinceData> provinces = [
    // Sangat Tinggi (≥30%)
    ProvinceData('Nusa Tenggara Timur', 37.0, 'Nusa Tenggara', 'ID-NT'),
    ProvinceData('Sulawesi Barat', 35.4, 'Sulawesi', 'ID-SR'),
    ProvinceData('Papua Barat Daya', 30.5, 'Papua', 'ID-PD'),
    // Tinggi (25–30%)
    ProvinceData('Papua', 28.9, 'Papua', 'ID-PA'),
    ProvinceData('Maluku Utara', 27.8, 'Maluku', 'ID-MU'),
    ProvinceData('Kalimantan Barat', 27.2, 'Kalimantan', 'ID-KB'),
    ProvinceData('Sulawesi Tengah', 26.8, 'Sulawesi', 'ID-ST'),
    ProvinceData('Aceh', 26.1, 'Sumatera', 'ID-AC'),
    ProvinceData('Maluku', 25.9, 'Maluku', 'ID-MA'),
    ProvinceData('Gorontalo', 25.5, 'Sulawesi', 'ID-GO'),
    // Sedang (18–25%)
    ProvinceData('Sumatera Utara', 23.2, 'Sumatera', 'ID-SU'),
    ProvinceData('Kalimantan Selatan', 22.7, 'Kalimantan', 'ID-KS'),
    ProvinceData('Sulawesi Tenggara', 22.5, 'Sulawesi', 'ID-SG'),
    ProvinceData('Kalimantan Tengah', 22.1, 'Kalimantan', 'ID-KT'),
    ProvinceData('Sumatera Selatan', 21.9, 'Sumatera', 'ID-SS'),
    ProvinceData('Jawa Tengah', 20.9, 'Jawa-Bali', 'ID-JT'),
    ProvinceData('Jawa Barat', 20.2, 'Jawa-Bali', 'ID-JB'),
    ProvinceData('Banten', 19.8, 'Jawa-Bali', 'ID-BT'),
    ProvinceData('Sulawesi Utara', 19.2, 'Sulawesi', 'ID-SA'),
    // Rendah (<18%)
    ProvinceData('Jawa Timur', 14.7, 'Jawa-Bali', 'ID-JI'),
    ProvinceData('DI Yogyakarta', 14.9, 'Jawa-Bali', 'ID-YO'),
    ProvinceData('DKI Jakarta', 15.6, 'Jawa-Bali', 'ID-JK'),
    ProvinceData('Kepulauan Riau', 15.0, 'Sumatera', 'ID-KR'),
    ProvinceData('Bali', 8.6, 'Jawa-Bali', 'ID-BA'),
  ];

  static const List<(String, String, int)> burden6 = [
    ('🏙️', 'Jawa Barat', 638000),
    ('🏔️', 'Jawa Tengah', 485893),
    ('🌾', 'Jawa Timur', 430780),
    ('🌴', 'Sumatera Utara', 316456),
    ('🌺', 'NTT', 214143),
    ('🌊', 'Banten', 209600),
  ];

  static const List<String> sources = [
    'SSGI 2024 — Kemenkes RI, diumumkan 26 Mei 2025 (Data terbaru)',
    'BKPK Kemenkes RI — badankebijakan.kemkes.go.id',
    'Tim Percepatan Penurunan Stunting — stunting.go.id',
    'Riskesdas 2013, 2016, 2017, 2018 (Data historis)',
    'RPJMN 2025–2029 — Bappenas & Setwapres',
    'Global Nutrition Report 2023 — WHO/UNICEF (Data komparatif)',
  ];

  // ── Province level helpers ──────────────────────────────────────────────────

  static Color levelColor(double val) {
    if (val >= 30) return const Color(0xFFB91C1C);
    if (val >= 25) return const Color(0xFFDC2626);
    if (val >= 18) return const Color(0xFFF59E0B);
    return const Color(0xFF059669);
  }

  static String levelLabel(double val) {
    if (val >= 30) return 'Sangat Tinggi';
    if (val >= 25) return 'Tinggi';
    if (val >= 18) return 'Sedang';
    return 'Rendah';
  }

  static List<ProvinceData> filteredProvinces(int filterLevel) {
    switch (filterLevel) {
      case 1:
        return provinces.where((p) => p.percent >= 28).toList();
      case 2:
        return provinces
            .where((p) => p.percent >= 18 && p.percent < 28)
            .toList();
      case 3:
        return provinces.where((p) => p.percent < 18).toList();
      default:
        return provinces;
    }
  }
}
