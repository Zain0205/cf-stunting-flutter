import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/expandable_card.dart';

/// Tab content for "Bayi Baru Lahir" — 0–24 month milestones and warning signs.
class TabBayiBaru extends StatelessWidget {
  final ResponsiveHelper r;

  const TabBayiBaru({super.key, required this.r});

  static const _milestones = [
    (
      '0–6 Bulan',
      Color(0xFFEC4899),
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
      Color(0xFF3B82F6),
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
      Color(0xFF059669),
      [
        'Variasikan menu: minimal 5 dari 8 kelompok makanan setiap harinya.',
        'Porsi makan meningkat: 3 kali makan utama + 2 kali selingan bergizi.',
        'Stimulasi aktif: ajak makan bersama keluarga untuk belajar makan mandiri.',
        'Pantau pertumbuhan: lakukan penimbangan dan pengukuran tinggi badan rutin.',
        'Imunisasi lengkap: pastikan jadwal imunisasi dasar terpenuhi.',
      ],
    ),
  ];

  static const _warningSigns = [
    ('📏', 'Tinggi badan di bawah garis merah pada KMS (Kartu Menuju Sehat)'),
    ('⚖️', 'Berat badan tidak naik 2 bulan berturut-turut'),
    ('😴', 'Anak tampak lesu, kurang aktif, dan mudah sakit'),
    ('🍽️', 'Nafsu makan buruk atau kesulitan makan dalam waktu lama'),
    ('💬', 'Keterlambatan bicara dan perkembangan motorik'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoBanner(r: r),
        SizedBox(height: r.sp(12)),
        ..._milestones.map(
          (m) => Padding(
            padding: EdgeInsets.only(bottom: r.sp(12)),
            child: ExpandableCard(title: m.$1, color: m.$2, tips: m.$3, r: r),
          ),
        ),
        _WarningSignsCard(signs: _warningSigns, r: r),
      ],
    );
  }
}

class _InfoBanner extends StatelessWidget {
  final ResponsiveHelper r;

  const _InfoBanner({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _WarningSignsCard extends StatelessWidget {
  final List<(String, String)> signs;
  final ResponsiveHelper r;

  const _WarningSignsCard({required this.signs, required this.r});

  @override
  Widget build(BuildContext context) {
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
