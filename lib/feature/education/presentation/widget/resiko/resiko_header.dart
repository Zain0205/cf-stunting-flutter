import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/education/presentation/widget/pengertian/grid_painter.dart';

class ResikoHeader extends StatelessWidget {
  final ResponsiveHelper r;

  const ResikoHeader({super.key, required this.r});

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
            Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
                child: CustomPaint(painter: const GridPainter()),
              ),
            ),
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
                color: const Color(0xFF8B5CF6),
                opacity: 0.15,
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
                  _BackButton(onTap: () => Navigator.of(context).pop()),
                  const SizedBox(width: 14),
                  Expanded(child: _TitleColumn(r: r)),
                  _RiskCountChip(r: r),
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
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [color.withOpacity(opacity), Colors.transparent],
      ),
    ),
  );
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
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

class _TitleColumn extends StatelessWidget {
  final ResponsiveHelper r;

  const _TitleColumn({required this.r});

  @override
  Widget build(BuildContext context) => Column(
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
  );
}

class _RiskCountChip extends StatelessWidget {
  final ResponsiveHelper r;

  const _RiskCountChip({required this.r});

  @override
  Widget build(BuildContext context) => Container(
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
          '${ResikoData.totalCount} Risiko',
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

enum RiskGroup { prahamil, ibuHamil, bayiBaru, balita, dewasa, komunitas }

class RiskItem {
  final String emoji;
  final String title;
  final String shortDesc;
  final String detail;
  final String mechanism;
  final RiskGroup group;
  final List<Color> gradient;
  final bool isCritical;

  const RiskItem({
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

abstract class ResikoData {
  static const List<RiskItem> risks = [
    // ── PRA-KEHAMILAN ──
    RiskItem(
      emoji: '🩸',
      title: 'Anemia pada Calon Ibu',
      shortDesc: 'Hemoglobin rendah sebelum hamil',
      detail:
          'Wanita usia subur dengan anemia defisiensi besi memiliki risiko 2× lebih tinggi melahirkan anak stunting. Cadangan zat besi yang rendah sebelum kehamilan tidak cukup untuk memenuhi kebutuhan janin selama 9 bulan.',
      mechanism:
          'Zat besi diperlukan untuk sintesis hemoglobin janin dan mielinisasi saraf otak. Defisiensi di awal kehamilan berdampak permanen pada perkembangan kognitif.',
      group: RiskGroup.prahamil,
      gradient: [Color(0xFFEF4444), Color(0xFFB91C1C)],
      isCritical: true,
    ),
    RiskItem(
      emoji: '⚖️',
      title: 'Status Gizi Buruk Sebelum Hamil',
      shortDesc: 'IMT <18.5 atau lingkar lengan <23.5 cm',
      detail:
          'Wanita dengan Kurang Energi Kronis (KEK) sebelum hamil — ditandai lingkar lengan atas <23.5 cm — memiliki risiko sangat tinggi melahirkan bayi dengan berat lahir rendah (BBLR), yang merupakan pintu gerbang stunting.',
      mechanism:
          'Cadangan energi dan protein yang tidak memadai sejak awal mengakibatkan transfer nutrisi ke janin terganggu. Pertumbuhan plasenta pun tidak optimal.',
      group: RiskGroup.prahamil,
      gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
      isCritical: true,
    ),
    RiskItem(
      emoji: '🚬',
      title: 'Paparan Rokok & Alkohol',
      shortDesc: 'Zat toksik menghambat pertumbuhan janin',
      detail:
          'Merokok aktif maupun pasif, serta konsumsi alkohol sebelum dan selama kehamilan, secara langsung mengganggu pertumbuhan janin. Bahkan 1 batang rokok per hari meningkatkan risiko BBLR hingga 40%.',
      mechanism:
          'Karbon monoksida mengurangi oksigenasi darah janin. Nikotin menyebabkan vasokonstriksi pembuluh plasenta. Alkohol mengganggu metabolisme asam folat yang krusial untuk perkembangan saraf.',
      group: RiskGroup.prahamil,
      gradient: [Color(0xFF6B7280), Color(0xFF374151)],
    ),

    // ── IBU HAMIL ──
    RiskItem(
      emoji: '🤰',
      title: 'Kekurangan Gizi saat Hamil',
      shortDesc: 'Protein, zat besi, zinc, folat tidak cukup',
      detail:
          'Ibu hamil yang tidak mendapat asupan gizi adekuat — terutama protein, zat besi, zinc, asam folat, dan kalsium — berisiko tinggi melahirkan bayi stunting. 70% kasus stunting berawal dari masa kehamilan.',
      mechanism:
          'Janin bersaing dengan tubuh ibu untuk nutrisi terbatas. Prioritas diberikan ke organ vital janin, tetapi pertumbuhan panjang tulang dan otak tetap terganggu jika defisiensi berlangsung kronis.',
      group: RiskGroup.ibuHamil,
      gradient: [Color(0xFFEC4899), Color(0xFFBE185D)],
      isCritical: true,
    ),
    RiskItem(
      emoji: '🏥',
      title: 'Tidak Periksa Kehamilan (ANC)',
      shortDesc: 'Tidak rutin ke bidan atau dokter',
      detail:
          'Ibu yang tidak melakukan Antenatal Care (ANC) minimal 6 kali selama kehamilan kehilangan kesempatan deteksi dini komplikasi, pemantauan pertumbuhan janin, dan suplementasi gizi tepat waktu.',
      mechanism:
          'Tanpa ANC, kondisi seperti preeklampsia, IUGR (Intrauterine Growth Restriction), dan anemia berat tidak terdeteksi hingga terlambat, meningkatkan risiko BBLR dan prematuritas.',
      group: RiskGroup.ibuHamil,
      gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    ),
    RiskItem(
      emoji: '😰',
      title: 'Stres Kronis & Depresi Kehamilan',
      shortDesc: 'Kortisol tinggi menghambat pertumbuhan janin',
      detail:
          'Ibu hamil yang mengalami stres psikologis berat atau depresi memiliki kadar kortisol tinggi yang secara langsung menghambat pertumbuhan dan perkembangan janin, serta meningkatkan risiko kelahiran prematur.',
      mechanism:
          'Kortisol berlebih mengganggu sekresi Growth Hormone dan IGF-1. Aktivasi sistem stres juga menyebabkan vasokonstriksi yang mengurangi aliran darah ke plasenta.',
      group: RiskGroup.ibuHamil,
      gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    ),
    RiskItem(
      emoji: '🦠',
      title: 'Infeksi Selama Kehamilan',
      shortDesc: 'TORCH, malaria, dan infeksi saluran kemih',
      detail:
          'Infeksi TORCH (Toksoplasmosis, Rubella, CMV, Herpes), malaria, dan infeksi saluran kemih selama kehamilan dapat menyebabkan IUGR, prematuritas, dan gangguan perkembangan otak janin yang berujung pada stunting.',
      mechanism:
          'Patogen dapat menembus plasenta dan secara langsung menginfeksi janin. Respons inflamasi sistemik ibu juga mengalihkan nutrisi dari pertumbuhan janin ke sistem imun.',
      group: RiskGroup.ibuHamil,
      gradient: [Color(0xFF059669), Color(0xFF047857)],
    ),

    // ── BAYI BARU LAHIR ──
    RiskItem(
      emoji: '⚡',
      title: 'Berat Lahir Rendah (BBLR)',
      shortDesc: 'Berat <2.500 gram saat lahir',
      detail:
          'Bayi dengan berat lahir rendah (<2.500 gram) memiliki risiko stunting 3–5 kali lebih tinggi. BBLR menunjukkan pertumbuhan janin yang sudah terhambat sejak dalam kandungan (stunted in utero).',
      mechanism:
          'Bayi BBLR memiliki cadangan otot, lemak, dan mineral yang sangat terbatas. Kapasitas saluran cerna kecil membatasi kemampuan menyerap nutrisi, memperparah defisit pertumbuhan pasca lahir.',
      group: RiskGroup.bayiBaru,
      gradient: [Color(0xFFEF4444), Color(0xFFB91C1C)],
      isCritical: true,
    ),
    RiskItem(
      emoji: '🍼',
      title: 'Tidak Mendapat ASI Eksklusif',
      shortDesc: 'Pemberian sufor atau makanan terlalu dini',
      detail:
          'Bayi yang tidak mendapat ASI eksklusif 0–6 bulan berisiko 2× lebih tinggi mengalami stunting. ASI mengandung faktor pertumbuhan, antibodi, dan nutrisi bioavailabilitas tinggi yang tidak tergantikan formula.',
      mechanism:
          'Susu formula tidak mengandung growth factors seperti EGF, IGF-1, dan lactoferrin yang krusial untuk pematangan usus. Pemberian makanan padat terlalu dini merusak mukosa usus yang belum matang.',
      group: RiskGroup.bayiBaru,
      gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
      isCritical: true,
    ),
    RiskItem(
      emoji: '🌡️',
      title: 'Infeksi Berulang pada Bayi',
      shortDesc: 'Diare, ISPA, dan infeksi neonatal',
      detail:
          'Bayi yang mengalami infeksi berulang — terutama diare dan infeksi saluran napas — menghabiskan energi untuk melawan penyakit dan kehilangan nutrisi, menciptakan lingkaran setan defisit pertumbuhan.',
      mechanism:
          'Setiap episode diare akut menyebabkan hilangnya zinc, elektrolit, dan kerusakan vili usus. Proses perbaikan usus membutuhkan protein yang seharusnya digunakan untuk pertumbuhan tulang.',
      group: RiskGroup.bayiBaru,
      gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
    ),
    RiskItem(
      emoji: '💉',
      title: 'Imunisasi Tidak Lengkap',
      shortDesc: 'Rentan infeksi yang menyebabkan stunting',
      detail:
          'Bayi yang tidak mendapat imunisasi lengkap lebih rentan terhadap campak, difteri, dan infeksi lain yang secara langsung mengganggu penyerapan nutrisi dan pertumbuhan, serta meningkatkan risiko stunting.',
      mechanism:
          'Campak khususnya menyebabkan kerusakan serius pada mukosa usus dan paru, diikuti periode malabsorpsi panjang. Satu episode campak bisa menghilangkan pertumbuhan selama 3–6 bulan.',
      group: RiskGroup.bayiBaru,
      gradient: [Color(0xFF06B6D4), Color(0xFF0891B2)],
    ),

    // ── BALITA ──
    RiskItem(
      emoji: '🥗',
      title: 'MPASI Tidak Adekuat',
      shortDesc: 'Kualitas dan keragaman makanan buruk',
      detail:
          'Pemberian MPASI yang kurang beragam, tidak kaya protein hewani, atau dimulai terlambat/terlalu dini merupakan faktor risiko utama stunting pada usia 6–24 bulan — masa paling kritis pertumbuhan.',
      mechanism:
          'Protein hewani (telur, ikan, daging) mengandung semua asam amino esensial dan zinc bioavailabilitas tinggi yang diperlukan untuk sintesis protein tulang dan otot. Protein nabati saja tidak cukup.',
      group: RiskGroup.balita,
      gradient: [Color(0xFF059669), Color(0xFF047857)],
      isCritical: true,
    ),
    RiskItem(
      emoji: '💧',
      title: 'Air Minum & Sanitasi Buruk',
      shortDesc: 'E.coli dan parasit usus merusak gizi',
      detail:
          'Air minum terkontaminasi dan sanitasi buruk menyebabkan environmental enteric dysfunction (EED) — peradangan kronis usus yang mengganggu penyerapan nutrisi meski asupan makanan cukup.',
      mechanism:
          'Paparan berulang bakteri fecal-oral (E.coli, Giardia, Cryptosporidium) menyebabkan atrofi vili usus permanen. Bahkan tanpa gejala diare, absorpsi nutrisi terganggu secara kronis.',
      group: RiskGroup.balita,
      gradient: [Color(0xFF06B6D4), Color(0xFF0891B2)],
      isCritical: true,
    ),
    RiskItem(
      emoji: '🧒',
      title: 'Kurang Stimulasi & Interaksi',
      shortDesc: 'Stimulasi kurang menghambat perkembangan otak',
      detail:
          'Anak yang kurang mendapat stimulasi kognitif, sosial, dan emosional dari pengasuh berisiko mengalami kegagalan tumbuh kembang yang saling memperburuk dengan defisiensi gizi.',
      mechanism:
          'Stimulasi memicu pelepasan GH dan IGF-1. Anak yang tidak distimulasi cenderung lebih pasif, makan lebih sedikit, dan memiliki metabolisme pertumbuhan yang lebih rendah.',
      group: RiskGroup.balita,
      gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    ),

    // ── USIA DEWASA ──
    RiskItem(
      emoji: '🧠',
      title: 'Penurunan Kecerdasan Permanen',
      shortDesc: 'IQ lebih rendah 10–15 poin rata-rata',
      detail:
          'Stunting pada 1000 HPK menyebabkan kerusakan struktural otak yang permanen. Anak stunting rata-rata memiliki IQ 5–10 poin lebih rendah, tingkat kelulusan sekolah lebih rendah, dan penghasilan dewasa 20% lebih sedikit.',
      mechanism:
          'Volume hipokampus dan korteks prefrontal lebih kecil secara permanen. Konektivitas neural antara area kognitif terganggu akibat defisiensi mielinisasi pada masa kritis 0–2 tahun.',
      group: RiskGroup.dewasa,
      gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
      isCritical: true,
    ),
    RiskItem(
      emoji: '❤️',
      title: 'Penyakit Tidak Menular di Usia Dewasa',
      shortDesc: 'Diabetes, hipertensi, dan penyakit jantung',
      detail:
          'Anak stunting yang kemudian mengalami kenaikan berat badan cepat (catch-up growth) di usia remaja/dewasa memiliki risiko 2–3× lebih tinggi terkena diabetes tipe 2, hipertensi, dan penyakit jantung koroner.',
      mechanism:
          'Fenomena "thrifty phenotype hypothesis" — organ metabolik (pankreas, ginjal) yang berkembang dalam kondisi defisit kalori menjadi tidak adaptif ketika mendapat surplus nutrisi di kemudian hari.',
      group: RiskGroup.dewasa,
      gradient: [Color(0xFFEF4444), Color(0xFFB91C1C)],
      isCritical: true,
    ),
    RiskItem(
      emoji: '💼',
      title: 'Produktivitas Ekonomi Rendah',
      shortDesc: 'Pendapatan seumur hidup berkurang 20–30%',
      detail:
          'Individu yang mengalami stunting memiliki kapasitas kerja fisik lebih rendah, tingkat pendidikan lebih rendah, dan pendapatan seumur hidup rata-rata 20–30% lebih sedikit dibanding individu yang tumbuh normal.',
      mechanism:
          'Kombinasi kapasitas kognitif terbatas, kesehatan lebih buruk, dan tinggi badan lebih pendek menciptakan kerugian ekonomi kumulatif jangka panjang.',
      group: RiskGroup.dewasa,
      gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
    ),
    RiskItem(
      emoji: '👩',
      title: 'Siklus Stunting Antargenerasi',
      shortDesc: 'Ibu stunting → anak stunting',
      detail:
          'Perempuan yang tumbuh stunting memiliki panggul lebih sempit (meningkatkan risiko komplikasi persalinan), berat badan sebelum hamil lebih rendah, dan status gizi lebih buruk — mewariskan risiko stunting ke generasi berikutnya.',
      mechanism:
          'Siklus intergenerasi: ibu pendek → cadangan gizi terbatas → janin kecil → BBLR → stunting → anak perempuan tumbuh pendek → siklus berlanjut. Satu generasi stunting bisa berlanjut 3–4 generasi tanpa intervensi.',
      group: RiskGroup.dewasa,
      gradient: [Color(0xFFEC4899), Color(0xFFBE185D)],
      isCritical: true,
    ),

    // ── KOMUNITAS & SOSIAL ──
    RiskItem(
      emoji: '🏘️',
      title: 'Kemiskinan & Ketahanan Pangan',
      shortDesc: 'Akses pangan bergizi terbatas',
      detail:
          'Keluarga miskin memiliki akses terbatas terhadap pangan bergizi terutama protein hewani. Anak dari kuintil termiskin 2.5× lebih berisiko stunting dibanding anak dari keluarga terkaya.',
      mechanism:
          'Kemiskinan memaksa substitusi protein hewani dengan protein nabati murah yang memiliki bioavailabilitas zinc dan zat besi lebih rendah. Dietary diversity score rendah berkorelasi kuat dengan stunting.',
      group: RiskGroup.komunitas,
      gradient: [Color(0xFF6B7280), Color(0xFF374151)],
      isCritical: true,
    ),
    RiskItem(
      emoji: '📚',
      title: 'Pendidikan Pengasuh Rendah',
      shortDesc: 'Kurang pengetahuan gizi dan pengasuhan',
      detail:
          'Tingkat pendidikan ibu adalah prediktor terkuat kedua stunting setelah kemiskinan. Ibu dengan pendidikan rendah cenderung memiliki pengetahuan gizi lebih buruk, praktik pemberian makan tidak tepat, dan utilisasi layanan kesehatan lebih rendah.',
      mechanism:
          'Pendidikan ibu memengaruhi pengambilan keputusan pemberian makan, kemampuan membaca label nutrisi, kepatuhan imunisasi, dan responsivitas terhadap tanda-tanda penyakit pada anak.',
      group: RiskGroup.komunitas,
      gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    ),
    RiskItem(
      emoji: '🌿',
      title: 'Lingkungan & Polusi',
      shortDesc: 'Polusi udara dan tanah terkontaminasi',
      detail:
          'Paparan timbal (Pb), pestisida, dan polusi udara partikulat halus (PM2.5) selama kehamilan dan masa bayi mengganggu perkembangan otak dan pertumbuhan fisik, berkontribusi pada stunting.',
      mechanism:
          'Timbal bersaing dengan kalsium dalam mineralisasi tulang dan perkembangan otak. PM2.5 menyebabkan stres oksidatif yang mengganggu sintesis protein dan pertumbuhan sel pada janin.',
      group: RiskGroup.komunitas,
      gradient: [Color(0xFF059669), Color(0xFF047857)],
    ),
  ];

  static List<RiskItem> filtered(RiskGroup? group) =>
      group == null ? risks : risks.where((r) => r.group == group).toList();

  static int countByGroup(RiskGroup group) =>
      risks.where((r) => r.group == group).length;

  static int get totalCount => risks.length;
}
