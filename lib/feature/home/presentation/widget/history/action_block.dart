import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

class ActionBlock extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final Color bgColor;
  final Color borderColor;
  final List<String> items;
  final ResponsiveHelper r;

  /// When false, shows an exclamation icon instead of a bullet dot.
  final bool isBullet;

  const ActionBlock({
    super.key,
    required this.title,
    required this.icon,
    required this.gradient,
    required this.bgColor,
    required this.borderColor,
    required this.items,
    required this.r,
    this.isBullet = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(16)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BlockHeader(
            title: title,
            icon: icon,
            gradient: gradient,
            count: items.length,
            r: r,
          ),
          SizedBox(height: r.sp(12)),
          Container(height: 1, color: gradient[0].withOpacity(0.10)),
          SizedBox(height: r.sp(10)),
          ...items.asMap().entries.map((entry) {
            final isLast = entry.key == items.length - 1;
            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : r.sp(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ItemMarker(gradient: gradient, isBullet: isBullet),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(12.5),
                        color: const Color(0xFF374151),
                        height: 1.55,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _BlockHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final int count;
  final ResponsiveHelper r;

  const _BlockHeader({
    required this.title,
    required this.icon,
    required this.gradient,
    required this.count,
    required this.r,
  });

  @override
  Widget build(BuildContext context) => Row(
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
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(13),
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: gradient[0].withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '$count',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(10),
            fontWeight: FontWeight.w700,
            color: gradient[0],
          ),
        ),
      ),
    ],
  );
}

class _ItemMarker extends StatelessWidget {
  final List<Color> gradient;
  final bool isBullet;

  const _ItemMarker({required this.gradient, required this.isBullet});

  @override
  Widget build(BuildContext context) => Container(
    width: 22,
    height: 22,
    margin: const EdgeInsets.only(top: 1),
    decoration: BoxDecoration(
      color: gradient[0].withOpacity(0.12),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Center(
      child: isBullet
          ? Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: gradient[0],
                shape: BoxShape.circle,
              ),
            )
          : Icon(Icons.priority_high_rounded, size: 12, color: gradient[0]),
    ),
  );
}
