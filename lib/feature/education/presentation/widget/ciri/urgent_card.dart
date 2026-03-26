import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/ciri/ciri_header.dart';

class UrgentCard extends StatelessWidget {
  final ResponsiveHelper r;

  const UrgentCard({super.key, required this.r});

  static const _warningItems = [
    ('📏', 'Tinggi badan jauh di bawah standar usia'),
    ('⚖️', 'Berat badan tidak naik 2 bulan berturut-turut'),
    ('🤒', 'Sakit lebih dari 2 kali dalam sebulan'),
    ('😴', 'Sangat lesu dan tidak responsif'),
  ];

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
              _CardHeader(urgentCount: CiriData.urgentCount, r: r),
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
              ..._warningItems.map(
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
            ],
          ),
        ],
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _CardHeader extends StatelessWidget {
  final int urgentCount;
  final ResponsiveHelper r;

  const _CardHeader({required this.urgentCount, required this.r});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
