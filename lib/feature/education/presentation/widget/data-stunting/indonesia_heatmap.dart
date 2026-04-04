import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/data-stunting/trend_chart.dart';

class IndonesiaHeatmap extends StatefulWidget {
  final ResponsiveHelper r;

  const IndonesiaHeatmap({super.key, required this.r});

  @override
  State<IndonesiaHeatmap> createState() => _IndonesiaHeatmapState();
}

class _IndonesiaHeatmapState extends State<IndonesiaHeatmap> {
  ProvinceData? _selectedProvince;

  /// Approximate center coordinates per province ISO code.
  static const Map<String, LatLng> _coords = {
    'ID-AC': LatLng(4.6951, 96.7494), // Aceh
    'ID-SU': LatLng(2.1154, 99.5451), // Sumatera Utara
    'ID-SS': LatLng(-3.3194, 103.9144), // Sumatera Selatan
    'ID-KR': LatLng(3.9457, 108.1429), // Kepulauan Riau
    'ID-JK': LatLng(-6.2088, 106.8456), // DKI Jakarta
    'ID-JB': LatLng(-7.0909, 107.6689), // Jawa Barat
    'ID-JT': LatLng(-7.1500, 110.1403), // Jawa Tengah
    'ID-YO': LatLng(-7.8754, 110.4262), // DI Yogyakarta
    'ID-JI': LatLng(-7.5361, 112.2384), // Jawa Timur
    'ID-BT': LatLng(-6.4058, 106.0640), // Banten
    'ID-BA': LatLng(-8.3405, 115.0920), // Bali
    'ID-NT': LatLng(-8.6574, 122.0000), // NTT
    'ID-KB': LatLng(0.0000, 111.5000), // Kalimantan Barat
    'ID-KT': LatLng(-1.6815, 113.3824), // Kalimantan Tengah
    'ID-KS': LatLng(-3.0926, 115.2838), // Kalimantan Selatan
    'ID-SA': LatLng(0.6246, 123.9750), // Sulawesi Utara
    'ID-ST': LatLng(-1.4300, 121.4456), // Sulawesi Tengah
    'ID-SG': LatLng(-4.1455, 122.1745), // Sulawesi Tenggara
    'ID-GO': LatLng(0.5435, 123.0568), // Gorontalo
    'ID-SR': LatLng(-2.8441, 119.2321), // Sulawesi Barat
    'ID-MA': LatLng(-3.2385, 130.1453), // Maluku
    'ID-MU': LatLng(1.5709, 127.8088), // Maluku Utara
    'ID-PA': LatLng(-4.2699, 138.0804), // Papua
    'ID-PD': LatLng(-1.3361, 132.1747), // Papua Barat Daya
  };

  Color _markerColor(double pct) {
    if (pct >= 30) return const Color(0xFFB91C1C);
    if (pct >= 25) return const Color(0xFFDC2626);
    if (pct >= 18) return const Color(0xFFF59E0B);
    return const Color(0xFF059669);
  }

  double _markerRadius(double pct) {
    if (pct >= 30) return 22;
    if (pct >= 25) return 19;
    if (pct >= 18) return 16;
    return 14;
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    final mapHeight = r.isSmall ? 220.0 : 260.0;

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
          _MapHeader(r: r),
          SizedBox(height: r.sp(10)),
          _HeatLegend(r: r),
          SizedBox(height: r.sp(12)),

          // ── Real interactive map ────────────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              height: mapHeight,
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(-2.5, 118.0),
                  initialZoom: 4.0,
                  minZoom: 3.5,
                  maxZoom: 7.0,
                  interactionOptions: InteractionOptions(
                    flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                  ),
                ),
                children: [
                  // OSM tile layer
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.mobile_flutter',
                    tileBuilder: (context, tileWidget, tile) {
                      // Dark-tint the tiles for better contrast with colored markers
                      return ColorFiltered(
                        colorFilter: const ColorFilter.matrix([
                          0.6,
                          0,
                          0,
                          0,
                          20,
                          0,
                          0.6,
                          0,
                          0,
                          20,
                          0,
                          0,
                          0.65,
                          0,
                          30,
                          0,
                          0,
                          0,
                          1,
                          0,
                        ]),
                        child: tileWidget,
                      );
                    },
                  ),

                  // Province heat markers
                  MarkerLayer(
                    markers: StuntingData.provinces
                        .where((p) => _coords.containsKey(p.isoCode))
                        .map((p) {
                          final coord = _coords[p.isoCode]!;
                          final color = _markerColor(p.percent);
                          final radius = _markerRadius(p.percent);
                          final isSelected =
                              _selectedProvince?.isoCode == p.isoCode;

                          return Marker(
                            point: coord,
                            width: (radius * 2) + 8,
                            height: (radius * 2) + 8,
                            child: GestureDetector(
                              onTap: () => setState(
                                () => _selectedProvince = isSelected ? null : p,
                              ),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(
                                    isSelected ? 0.95 : 0.80,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white54,
                                    width: isSelected ? 2.5 : 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: color.withOpacity(
                                        isSelected ? 0.6 : 0.4,
                                      ),
                                      blurRadius: isSelected ? 12 : 6,
                                      spreadRadius: isSelected ? 2 : 0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    '${p.percent.toStringAsFixed(0)}%',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: radius * 0.55,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                        .toList(),
                  ),

                  // Selected province tooltip
                  if (_selectedProvince != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _coords[_selectedProvince!.isoCode]!,
                          width: 160,
                          height: 52,
                          alignment: const Alignment(0, -2.8),
                          child: _ProvinceTooltip(
                            province: _selectedProvince!,
                            r: r,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),

          SizedBox(height: r.sp(12)),
          _BestWorstRow(r: r),
          SizedBox(height: r.sp(10)),
          _MapHint(r: r),
        ],
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _MapHeader extends StatelessWidget {
  final ResponsiveHelper r;
  const _MapHeader({required this.r});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Text('🗺️', style: TextStyle(fontSize: 16)),
      const SizedBox(width: 8),
      Text(
        'Peta Interaktif Stunting (SSGI 2024)',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(12),
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0F172A),
        ),
      ),
    ],
  );
}

class _HeatLegend extends StatelessWidget {
  final ResponsiveHelper r;
  const _HeatLegend({required this.r});

  @override
  Widget build(BuildContext context) => Column(
    children: [
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
                    Color(0xFFDC2626),
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
            '18–25% Sedang',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(9),
              color: const Color(0xFFF59E0B),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '>25% Tinggi',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(9),
              color: const Color(0xFFB91C1C),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ],
  );
}

class _ProvinceTooltip extends StatelessWidget {
  final ProvinceData province;
  final ResponsiveHelper r;
  const _ProvinceTooltip({required this.province, required this.r});

  @override
  Widget build(BuildContext context) {
    final color = StuntingData.levelColor(province.percent);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.40), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            province.name,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(10),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${province.percent}% — ${StuntingData.levelLabel(province.percent)}',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(9.5),
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _BestWorstRow extends StatelessWidget {
  final ResponsiveHelper r;
  const _BestWorstRow({required this.r});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: _HighlightCard(
          emoji: '🏆',
          label: 'Terbaik',
          value: 'Bali 8.6%',
          bg: const Color(0xFFF0FDF4),
          border: const Color(0xFFBBF7D0),
          textColor: const Color(0xFF047857),
          r: r,
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: _HighlightCard(
          emoji: '⚠️',
          label: 'Tertinggi',
          value: 'NTT 37%',
          bg: const Color(0xFFFEF2F2),
          border: const Color(0xFFFECACA),
          textColor: const Color(0xFFB91C1C),
          r: r,
        ),
      ),
    ],
  );
}

class _HighlightCard extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;
  final Color bg;
  final Color border;
  final Color textColor;
  final ResponsiveHelper r;
  const _HighlightCard({
    required this.emoji,
    required this.label,
    required this.value,
    required this.bg,
    required this.border,
    required this.textColor,
    required this.r,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(r.sp(10)),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: border, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$emoji $label',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(9.5),
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(12),
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ),
      ],
    ),
  );
}

class _MapHint extends StatelessWidget {
  final ResponsiveHelper r;
  const _MapHint({required this.r});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.touch_app_rounded, size: 13, color: Colors.grey.shade400),
      const SizedBox(width: 5),
      Text(
        'Tap marker untuk detail provinsi • Pinch untuk zoom',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(10),
          color: Colors.grey.shade400,
        ),
      ),
    ],
  );
}
