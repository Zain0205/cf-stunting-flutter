import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

/// Generic white card with a gradient icon header and divider.
/// Used as a container for tab content sections.
class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final Widget child;
  final ResponsiveHelper r;

  const InfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.gradient,
    required this.child,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8F0FE), width: 1),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.07),
            blurRadius: 14,
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
                  gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                      color: gradient[0].withOpacity(0.30),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(13.5),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          SizedBox(height: r.sp(14)),
          Container(height: 1, color: Colors.grey.shade100),
          SizedBox(height: r.sp(14)),
          child,
        ],
      ),
    );
  }
}
