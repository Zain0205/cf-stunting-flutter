import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

class PencegahanCard extends StatelessWidget {
  final ResponsiveHelper r;

  const PencegahanCard({super.key, required this.r});

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
            right: -10,
            top: -10,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('🚀', style: TextStyle(fontSize: 26)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Mulai Sekarang, Bukan Nanti!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(15),
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: r.sp(10)),
              Text(
                'Setiap hari yang terlewat dalam 1000 HPK tidak bisa diulang. Tapi setiap langkah kecil yang Anda ambil hari ini memberi dampak besar bagi masa depan si kecil.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  color: Colors.white.withOpacity(0.85),
                  height: 1.6,
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
