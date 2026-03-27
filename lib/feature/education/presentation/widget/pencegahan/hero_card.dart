import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

class HeroCard extends StatelessWidget {
  final ResponsiveHelper r;

  const HeroCard({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(18)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF059669), Color(0xFF047857)],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF059669).withOpacity(0.35),
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
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.07),
              ),
            ),
          ),
          Positioned(
            left: -10,
            bottom: -15,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '🛡️  Stunting Bisa Dicegah hingga 80%',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(11),
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: r.sp(12)),
              Text(
                'Dengan tindakan tepat sejak sebelum kehamilan hingga anak usia 2 tahun, risiko stunting bisa dicegah secara signifikan.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(13),
                  color: Colors.white.withOpacity(0.88),
                  height: 1.6,
                ),
              ),
              SizedBox(height: r.sp(14)),
              Container(height: 1, color: Colors.white.withOpacity(0.15)),
            ],
          ),
        ],
      ),
    );
  }
}
