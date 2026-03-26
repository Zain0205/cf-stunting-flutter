import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/grid_painter.dart';

class CiriHeader extends StatelessWidget {
  final ResponsiveHelper r;

  const CiriHeader({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final headerHeight = topPad + (r.isSmall ? 80.0 : 96.0);

    return SizedBox(
      height: headerHeight,
      child: Container(
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
            // Shared grid texture
            Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
                child: CustomPaint(painter: const GridPainter()),
              ),
            ),

            // Red orb (matches the warning theme of this screen)
            Positioned(
              top: -30,
              right: -20,
              child: _Orb(
                size: 140,
                color: const Color(0xFFEF4444),
                opacity: 0.18,
              ),
            ),
            Positioned(
              top: -10,
              left: -30,
              child: _Orb(
                size: 90,
                color: const Color(0xFF3B82F6),
                opacity: 0.15,
              ),
            ),

            // Content row
            Positioned(
              left: 16,
              right: 16,
              top: topPad + r.sp(10),
              bottom: r.sp(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _BackButton(onTap: () => Navigator.of(context).pop()),
                  const SizedBox(width: 14),
                  Expanded(child: _TitleColumn(r: r)),
                  _SignCountChip(r: r),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _Orb extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;

  const _Orb({required this.size, required this.color, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withOpacity(opacity), color.withOpacity(0.0)],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.14),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.20), width: 1),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}

class _TitleColumn extends StatelessWidget {
  final ResponsiveHelper r;

  const _TitleColumn({required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class _SignCountChip extends StatelessWidget {
  final ResponsiveHelper r;

  const _SignCountChip({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            '${CiriData.signs.length} Ciri',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(10),
              color: const Color(0xFFFCA5A5),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

abstract class CiriData {
  static const List<SignItem> signs = [
    // ── FISIK ──
    SignItem(
      emoji: '📏',
      title: 'Tinggi Badan Pendek',
      shortDesc: 'TB/U di bawah -2 SD standar WHO',
      detail:
          'Tinggi atau panjang badan anak secara signifikan lebih pendek dibandingkan anak seusia dari populasi yang sehat. Diukur menggunakan z-score TB/U (Tinggi Badan menurut Umur) < -2 SD berdasarkan standar pertumbuhan WHO.',
      whyItHappens:
          'Kekurangan protein, zinc, dan kalsium jangka panjang menghambat sintesis tulang dan hormon pertumbuhan (IGF-1). Infeksi berulang memperparah kondisi karena energi dipakai untuk melawan penyakit.',
      category: SignCategory.fisik,
      gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
      isUrgent: true,
    ),
    SignItem(
      emoji: '⚖️',
      title: 'Berat Badan Tidak Naik',
      shortDesc: 'Tidak naik selama 2 bulan berturut-turut',
      detail:
          'Berat badan anak stagnan atau tidak mengalami kenaikan minimal selama 2 bulan berturut-turut saat ditimbang di Posyandu. Ini disebut sebagai "Balita Tidak Naik (T)" pada grafik KMS.',
      whyItHappens:
          'Asupan kalori tidak mencukupi kebutuhan basal ditambah kebutuhan tumbuh. Bisa disebabkan oleh pola makan tidak teratur, MPASI tidak adekuat, atau absorpsi nutrisi terganggu akibat infeksi usus.',
      category: SignCategory.fisik,
      gradient: [Color(0xFFEF4444), Color(0xFFB91C1C)],
      isUrgent: true,
    ),
    SignItem(
      emoji: '🦷',
      title: 'Terlambat Tumbuh Gigi',
      shortDesc: 'Gigi belum tumbuh di atas usia 12 bulan',
      detail:
          'Gigi pertama anak normalnya mulai tumbuh antara usia 6–10 bulan. Pada anak stunting, erupsi gigi dapat tertunda hingga melewati usia 12–14 bulan. Struktur gigi yang terbentuk juga cenderung lebih rapuh.',
      whyItHappens:
          'Kekurangan kalsium, fosfor, dan vitamin D menghambat mineralisasi email gigi dan tulang alveolar. Nutrisi yang tidak adekuat selama masa pembentukan gigi dalam kandungan turut berkontribusi.',
      category: SignCategory.fisik,
      gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    ),
    SignItem(
      emoji: '💪',
      title: 'Massa Otot Rendah',
      shortDesc: 'Tubuh tampak kurus, otot tidak berkembang',
      detail:
          'Anak stunting sering menunjukkan tanda-tanda hipotrofi otot: lengan dan kaki terlihat kurus, tonus otot rendah, serta kemampuan motorik kasar yang terbatas.',
      whyItHappens:
          'Defisiensi protein — terutama asam amino esensial — menghambat sintesis protein otot (muscle protein synthesis). Hormon pertumbuhan dan IGF-1 yang rendah juga menurunkan anabolisme otot.',
      category: SignCategory.fisik,
      gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
    ),
    SignItem(
      emoji: '🤲',
      title: 'Kulit & Rambut Kusam',
      shortDesc: 'Rambut tipis, mudah rontok, kulit kering',
      detail:
          'Rambut anak terlihat tipis, jarang, berwarna kemerahan/kekuningan (flag sign), dan mudah dicabut tanpa rasa sakit. Kulit tampak kering, bersisik, dan mudah mengalami luka yang lambat sembuh.',
      whyItHappens:
          'Defisiensi protein berat (kwashiorkor) menyebabkan perubahan warna dan tekstur rambut. Kekurangan zinc, biotin, dan vitamin A memengaruhi pertumbuhan sel epidermis dan folikel rambut.',
      category: SignCategory.fisik,
      gradient: [Color(0xFF06B6D4), Color(0xFF0891B2)],
    ),
    SignItem(
      emoji: '🫃',
      title: 'Perut Membuncit',
      shortDesc: 'Perut besar tidak proporsional',
      detail:
          'Perut anak tampak membuncit keluar secara tidak proporsional dibanding tubuhnya. Ini bukan tanda anak gemuk atau sehat, melainkan tanda malnutrisi protein yang mengganggu keseimbangan tekanan osmotik.',
      whyItHappens:
          'Kekurangan albumin darah akibat defisiensi protein menyebabkan tekanan onkotik plasma turun, sehingga cairan bocor ke rongga perut (asites). Pembesaran hati berlemak (hepatomegali) juga dapat berkontribusi.',
      category: SignCategory.fisik,
      gradient: [Color(0xFFEC4899), Color(0xFFBE185D)],
    ),

    // ── KOGNITIF ──
    SignItem(
      emoji: '💬',
      title: 'Terlambat Bicara',
      shortDesc: 'Perkembangan bahasa di bawah anak seusia',
      detail:
          'Anak stunting cenderung mencapai milestone bicara lebih lambat: belum mengucapkan kata bermakna di usia 12 bulan, kalimat 2 kata di usia 24 bulan, atau kalimat lengkap di usia 36 bulan.',
      whyItHappens:
          'Kekurangan gizi pada 1000 HPK mengganggu mielinisasi serabut saraf dan pembentukan sinapsis di area Broca dan Wernicke yang mengatur bahasa.',
      category: SignCategory.kognitif,
      gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    ),
    SignItem(
      emoji: '🧩',
      title: 'Kemampuan Kognitif Lambat',
      shortDesc: 'Sulit berkonsentrasi dan memecahkan masalah',
      detail:
          'Anak mengalami keterlambatan dalam memori kerja, kemampuan pemecahan masalah, dan konsentrasi. Prestasi akademik di sekolah dasar cenderung di bawah rata-rata teman seusianya.',
      whyItHappens:
          'Volume hipokampus (pusat memori) dan korteks prefrontal (pengambilan keputusan) lebih kecil pada anak stunting. DHA dan zat besi yang rendah pada masa kritis perkembangan otak berdampak permanen pada konektivitas neural.',
      category: SignCategory.kognitif,
      gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    ),
    SignItem(
      emoji: '🚶',
      title: 'Motorik Lambat',
      shortDesc: 'Terlambat duduk, berdiri, berjalan',
      detail:
          'Milestone motorik kasar seperti duduk (~6 bulan), berdiri (~12 bulan), dan berjalan (~12–15 bulan) dapat tertunda secara signifikan. Motorik halus seperti memegang pensil juga terlambat berkembang.',
      whyItHappens:
          'Defisiensi zat besi menurunkan mielinisasi traktus kortikospinalis yang mengontrol gerakan volunter. Massa otot rendah dan kelemahan umum juga membuat anak enggan mencoba gerakan baru.',
      category: SignCategory.kognitif,
      gradient: [Color(0xFF059669), Color(0xFF047857)],
    ),

    // ── IMUN ──
    SignItem(
      emoji: '🤒',
      title: 'Mudah Sakit',
      shortDesc: 'Infeksi berulang dan pemulihan lambat',
      detail:
          'Anak stunting lebih rentan terkena infeksi saluran napas atas (pilek, batuk), diare, dan pneumonia. Frekuensi sakit lebih tinggi dan durasi penyakit lebih panjang dibanding anak bergizi baik.',
      whyItHappens:
          'Defisiensi vitamin A, C, zinc, dan protein melemahkan imunitas seluler (sel T dan B) dan imunitas bawaan (neutrofil, makrofag). Integritas mukosa saluran napas dan pencernaan juga menurun.',
      category: SignCategory.imun,
      gradient: [Color(0xFFEF4444), Color(0xFFB91C1C)],
      isUrgent: true,
    ),
    SignItem(
      emoji: '🩹',
      title: 'Luka Lambat Sembuh',
      shortDesc: 'Penyembuhan luka lebih lama dari normal',
      detail:
          'Luka kecil, lecet, atau bekas suntikan imunisasi sembuh jauh lebih lambat dibanding anak seusia. Bekas luka juga lebih rentan terinfeksi sekunder.',
      whyItHappens:
          'Sintesis kolagen membutuhkan vitamin C, zinc, dan protein yang cukup. Defisiensi nutrisi ini secara langsung memperlambat proliferasi fibroblas dan angiogenesis.',
      category: SignCategory.imun,
      gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
    ),

    // ── PERILAKU ──
    SignItem(
      emoji: '😴',
      title: 'Lesu & Kurang Aktif',
      shortDesc: 'Tampak lemas, tidak bersemangat bermain',
      detail:
          'Anak tampak tidak berenergi, mudah lelah, dan kurang bersemangat untuk bermain dan berinteraksi. Berbeda dengan anak normal seusia yang aktif dan penuh rasa ingin tahu.',
      whyItHappens:
          'Anemia defisiensi besi menurunkan kapasitas pengangkutan oksigen ke otak dan otot, menghasilkan kelelahan kronis. Disfungsi mitokondria akibat malnutrisi juga mengurangi produksi ATP.',
      category: SignCategory.perilaku,
      gradient: [Color(0xFF06B6D4), Color(0xFF0891B2)],
    ),
    SignItem(
      emoji: '😢',
      title: 'Mudah Rewel & Menangis',
      shortDesc: 'Temperamen mudah marah, sulit ditenangkan',
      detail:
          'Anak lebih sering menangis, rewel, dan mengalami kesulitan dalam regulasi emosi dibanding anak sehat. Responsivitas terhadap stimulus juga bisa meningkat secara negatif.',
      whyItHappens:
          'Ketidakseimbangan neurotransmiter (serotonin, dopamin) akibat defisiensi triptofan dan tirosin. Ketidaknyamanan fisik akibat lapar dan kembung kronis juga meningkatkan iritabilitas.',
      category: SignCategory.perilaku,
      gradient: [Color(0xFFEC4899), Color(0xFFBE185D)],
    ),
    SignItem(
      emoji: '🍽️',
      title: 'Nafsu Makan Buruk',
      shortDesc: 'Susah makan, pilih-pilih makanan',
      detail:
          'Anak menolak makan, hanya mau makanan tertentu, atau makan dalam jumlah sangat sedikit. Proses makan bisa berlangsung sangat lama (>30 menit) dengan hasil yang tidak adekuat.',
      whyItHappens:
          'Defisiensi zinc secara langsung memengaruhi persepsi rasa (hipogeusia) dan nafsu makan melalui jalur neuropeptida Y. Distended abdomen akibat dismotilitas GI juga menciptakan rasa kenyang palsu.',
      category: SignCategory.perilaku,
      gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    ),
  ];

  static List<SignItem> filtered(SignCategory? category) => category == null
      ? signs
      : signs.where((s) => s.category == category).toList();

  static int countByCategory(SignCategory category) =>
      signs.where((s) => s.category == category).length;

  static int get urgentCount => signs.where((s) => s.isUrgent).length;
}

enum SignCategory { fisik, kognitif, imun, perilaku }

class SignItem {
  final String emoji;
  final String title;
  final String shortDesc;
  final String detail;
  final String whyItHappens;
  final SignCategory category;
  final List<Color> gradient;
  final bool isUrgent;

  const SignItem({
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
