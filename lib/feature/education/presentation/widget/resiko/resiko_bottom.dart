import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Green gradient CTA card at the bottom of the resiko screen.
class ResikoBottom extends StatelessWidget {
  final ResponsiveHelper r;

  const ResikoBottom({super.key, required this.r});

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
            right: -10,
            top: -10,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.07),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('🛡️', style: TextStyle(fontSize: 28)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Semua Risiko Bisa Dicegah',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(16),
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
                'Dengan pengetahuan yang tepat dan tindakan sejak dini — mulai dari pra-kehamilan hingga masa balita — risiko stunting dapat dicegah hingga 80%.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  color: Colors.white.withOpacity(0.88),
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
