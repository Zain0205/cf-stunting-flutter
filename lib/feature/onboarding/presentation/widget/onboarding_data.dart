import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// SLIDE CONTENT MODEL
// ─────────────────────────────────────────────
class OnboardingSlide {
  final String tag;
  final String emoji;
  final String title;
  final String body;
  final Color accent;
  final Color accentLight;
  final List<_Stat> stats;
  final List<_Pill> pills;

  const OnboardingSlide({
    required this.tag,
    required this.emoji,
    required this.title,
    required this.body,
    required this.accent,
    required this.accentLight,
    this.stats = const [],
    this.pills = const [],
  });
}

class _Stat {
  final String value;
  final String label;
  const _Stat(this.value, this.label);
}

class _Pill {
  final String text;
  final IconData icon;
  const _Pill(this.text, this.icon);
}

// ─────────────────────────────────────────────
// SLIDE DATA
// ─────────────────────────────────────────────
const List<OnboardingSlide> onboardingSlides = [
  // ── SLIDE 1: Apa itu Stunting ──
  OnboardingSlide(
    tag: 'Apa Itu Stunting?',
    emoji: '🧒',
    title: 'Lebih dari\nSekadar Pendek',
    body:
        'Stunting adalah kondisi gagal tumbuh pada anak akibat kekurangan gizi kronis sejak dalam kandungan. '
        'Bukan hanya soal tinggi badan — stunting mempengaruhi kecerdasan, imunitas, dan produktivitas anak hingga dewasa.',
    accent: Color(0xFF3B82F6),
    accentLight: Color(0xFFEFF6FF),
    stats: [
      _Stat('1.000', 'Hari Pertama Kehidupan adalah masa paling kritis'),
      _Stat('Permanen', 'Dampaknya tidak bisa dipulihkan setelah usia 2 tahun'),
    ],
    pills: [
      _Pill('Gizi Kronis', Icons.no_food_rounded),
      _Pill('Infeksi Berulang', Icons.coronavirus_rounded),
      _Pill('Sanitasi Buruk', Icons.water_damage_rounded),
    ],
  ),

  // ── SLIDE 2: Data Indonesia ──
  OnboardingSlide(
    tag: 'Data Indonesia',
    emoji: '📊',
    title: 'Masalah Nyata\ndi Sekitar Kita',
    body:
        'Indonesia masih berjuang melawan stunting. Data SSGI 2024 menunjukkan 19,8% balita Indonesia '
        'mengalami stunting — hampir 1 dari 5 anak. Target nasional 2025 adalah menekan angka ini ke 18,8%.',
    accent: Color(0xFF059669),
    accentLight: Color(0xFFF0FDF4),
    stats: [
      _Stat('19,8%', 'Prevalensi stunting nasional 2024 (SSGI)'),
      _Stat('4,48 Juta', 'Balita stunting di seluruh Indonesia'),
    ],
    pills: [
      _Pill('NTT 37%', Icons.location_on_rounded),
      _Pill('Target 2025: 18,8%', Icons.flag_rounded),
      _Pill('Turun dari 21,5%', Icons.trending_down_rounded),
    ],
  ),

  // ── SLIDE 3: Fun Fact ──
  OnboardingSlide(
    tag: 'Tahukah Kamu?',
    emoji: '💡',
    title: 'Fakta yang\nMengejutkan',
    body:
        'Stunting bisa dicegah hingga 80% dengan tindakan yang tepat sejak sebelum kehamilan. '
        'Satu butir telur per hari terbukti menurunkan risiko stunting sebesar 47% pada balita.',
    accent: Color(0xFFF59E0B),
    accentLight: Color(0xFFFFFBEB),
    stats: [
      _Stat('80%', 'Kasus stunting bisa dicegah dengan intervensi dini'),
      _Stat('47%', 'Risiko stunting turun jika anak makan telur tiap hari'),
    ],
    pills: [
      _Pill('ASI Eksklusif', Icons.favorite_rounded),
      _Pill('Rutin ke Posyandu', Icons.local_hospital_rounded),
      _Pill('Cuci Tangan', Icons.wash_rounded),
    ],
  ),
];
