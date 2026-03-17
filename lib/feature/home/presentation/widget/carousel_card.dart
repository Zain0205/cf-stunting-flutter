import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Single card inside the education carousel.
class CarouselCard extends StatelessWidget {
  final CarouselItem item;
  final ResponsiveHelper r;
  final double height;
  final VoidCallback onTap;

  const CarouselCard({
    super.key,
    required this.item,
    required this.r,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: item.gradient,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: item.gradient[0].withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            _DecorativeCircles(),
            _CardContent(item: item, r: r),
          ],
        ),
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _DecorativeCircles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: -20,
          top: -20,
          child: _Circle(size: 110, opacity: 0.10),
        ),
        Positioned(
          right: 20,
          bottom: -30,
          child: _Circle(size: 80, opacity: 0.07),
        ),
        Positioned(
          left: -15,
          bottom: -10,
          child: _Circle(size: 60, opacity: 0.06),
        ),
      ],
    );
  }
}

class _Circle extends StatelessWidget {
  final double size;
  final double opacity;

  const _Circle({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(opacity),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final CarouselItem item;
  final ResponsiveHelper r;

  const _CardContent({required this.item, required this.r});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(r.sp(r.isSmall ? 16 : 20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _CardText(item: item, r: r),
          ),
          SizedBox(width: r.sp(12)),
          _CardIcon(item: item, r: r),
        ],
      ),
    );
  }
}

class _CardText extends StatelessWidget {
  final CarouselItem item;
  final ResponsiveHelper r;

  const _CardText({required this.item, required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Tag chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.22),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            item.tag,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.fs(9.5),
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        SizedBox(height: r.sp(8)),
        Text(
          item.title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(r.isSmall ? 15 : 17),
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.25,
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: r.sp(6)),
        Text(
          item.subtitle,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(r.isTiny ? 9.5 : 10.5),
            color: Colors.white.withOpacity(0.80),
            height: 1.45,
          ),
          maxLines: r.isTiny ? 2 : 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _CardIcon extends StatelessWidget {
  final CarouselItem item;
  final ResponsiveHelper r;

  const _CardIcon({required this.item, required this.r});

  @override
  Widget build(BuildContext context) {
    final size = r.isSmall ? 62.0 : 70.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(item.icon, size: r.isSmall ? 30 : 34, color: Colors.white),
    );
  }
}

/// Data model for each carousel education card.
class CarouselItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final String tag;

  const CarouselItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.tag,
  });
}

/// Static list of health education carousel items.
const List<CarouselItem> carouselItems = [
  CarouselItem(
    tag: 'Pengertian',
    title: 'Apa Itu\nStunting?',
    subtitle:
        'Stunting adalah kondisi gagal tumbuh pada anak akibat kekurangan gizi kronis dalam waktu lama.',
    icon: Icons.menu_book_rounded,
    gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
  ),
  CarouselItem(
    tag: 'Ciri-ciri',
    title: 'Ciri-Ciri\nStunting',
    subtitle:
        'Kenali tanda-tanda stunting seperti tinggi badan lebih pendek dari anak seusianya.',
    icon: Icons.search_rounded,
    gradient: [Color(0xFF059669), Color(0xFF047857)],
  ),
  CarouselItem(
    tag: 'Data',
    title: 'Data Stunting\nIndonesia',
    subtitle:
        'Ketahui kondisi dan angka prevalensi stunting di Indonesia berdasarkan data kesehatan.',
    icon: Icons.bar_chart_rounded,
    gradient: [Color(0xFFEC4899), Color(0xFFBE185D)],
  ),
  CarouselItem(
    tag: 'Risiko',
    title: 'Risiko\nStunting',
    subtitle:
        'Stunting dapat memengaruhi perkembangan otak, kesehatan, dan masa depan anak.',
    icon: Icons.warning_amber_rounded,
    gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
  ),
  CarouselItem(
    tag: 'Pencegahan',
    title: 'Cegah\nStunting',
    subtitle:
        'Pencegahan dapat dilakukan melalui gizi seimbang, ASI eksklusif, dan pemantauan tumbuh kembang.',
    icon: Icons.health_and_safety_rounded,
    gradient: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
  ),
];
