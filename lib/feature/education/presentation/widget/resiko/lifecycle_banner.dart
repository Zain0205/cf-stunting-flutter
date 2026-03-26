import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

class LifecycleBanner extends StatelessWidget {
  final ResponsiveHelper r;

  const LifecycleBanner({super.key, required this.r});

  static const _stages = [
    ('Pra-\nHamil', Color(0xFFEC4899)),
    ('Hamil', Color(0xFF8B5CF6)),
    ('Bayi', Color(0xFF3B82F6)),
    ('Balita', Color(0xFF059669)),
    ('Dewasa', Color(0xFFEF4444)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(16)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A1628), Color(0xFF1E3A8A)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D4ED8).withOpacity(0.30),
            blurRadius: 18,
            offset: const Offset(0, 8),
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
              _LifecycleChip(r: r),
              SizedBox(height: r.sp(10)),
              Text(
                'Stunting bukan hanya masalah anak kecil — risikonya berawal jauh sebelum kelahiran dan dampaknya berlanjut hingga dewasa.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.fs(12.5),
                  color: Colors.white.withOpacity(0.85),
                  height: 1.55,
                ),
              ),
              SizedBox(height: r.sp(14)),
              Row(
                children: _stages
                    .expand<Widget>(
                      (stage) => [
                        _TimelineDot(label: stage.$1, color: stage.$2, r: r),
                        if (stage != _stages.last) const _TimelineConnector(),
                      ],
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _LifecycleChip extends StatelessWidget {
  final ResponsiveHelper r;

  const _LifecycleChip({required this.r});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    decoration: BoxDecoration(
      color: const Color(0xFFEF4444).withOpacity(0.22),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: const Color(0xFFEF4444).withOpacity(0.35),
        width: 1,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.timeline_rounded, size: 12, color: Color(0xFFFCA5A5)),
        const SizedBox(width: 4),
        Text(
          'Siklus Risiko Sepanjang Hidup',
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

class _TimelineDot extends StatelessWidget {
  final String label;
  final Color color;
  final ResponsiveHelper r;

  const _TimelineDot({
    required this.label,
    required this.color,
    required this.r,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color.withOpacity(0.22),
          shape: BoxShape.circle,
          border: Border.all(color: color.withOpacity(0.45), width: 1.5),
        ),
        child: Center(
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(8.5),
          color: Colors.white60,
          height: 1.2,
        ),
      ),
    ],
  );
}

class _TimelineConnector extends StatelessWidget {
  const _TimelineConnector();

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      height: 1.5,
      margin: const EdgeInsets.only(bottom: 20),
      color: Colors.white.withOpacity(0.15),
    ),
  );
}
