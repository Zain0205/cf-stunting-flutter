import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';

class HeroStatsCard extends StatelessWidget {
  final ResponsiveHelper r;

  const HeroStatsCard({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(r.sp(20)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A1628), Color(0xFF1E3A8A)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D4ED8).withOpacity(0.35),
            blurRadius: 24,
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
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SsgiBadge(r: r),
              SizedBox(height: r.sp(12)),
              _BigNumber(r: r),
              SizedBox(height: r.sp(8)),
              _DeltaBadges(r: r),
              SizedBox(height: r.sp(14)),
              Container(height: 1, color: Colors.white.withOpacity(0.12)),
              SizedBox(height: r.sp(14)),
              _MiniStatsRow(r: r),
            ],
          ),
        ],
      ),
    );
  }
}

class _SsgiBadge extends StatelessWidget {
  final ResponsiveHelper r;
  const _SsgiBadge({required this.r});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: const Color(0xFF059669).withOpacity(0.25),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: const Color(0xFF059669).withOpacity(0.40),
        width: 1,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.new_releases_rounded,
          size: 11,
          color: Color(0xFF6EE7B7),
        ),
        const SizedBox(width: 5),
        Text(
          'SSGI 2024 • Diumumkan 26 Mei 2025',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(10),
            color: const Color(0xFF6EE7B7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

class _BigNumber extends StatelessWidget {
  final ResponsiveHelper r;
  const _BigNumber({required this.r});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        '19.8',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(54),
          fontWeight: FontWeight.w800,
          color: Colors.white,
          height: 1.0,
          letterSpacing: -2,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 2),
        child: Text(
          '%',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(24),
            fontWeight: FontWeight.w700,
            color: Colors.white70,
          ),
        ),
      ),
    ],
  );
}

class _DeltaBadges extends StatelessWidget {
  final ResponsiveHelper r;
  const _DeltaBadges({required this.r});

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 6,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xFF059669).withOpacity(0.20),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.arrow_downward_rounded,
              color: Color(0xFF34D399),
              size: 13,
            ),
            const SizedBox(width: 3),
            Text(
              'Turun 1.7% dari 2023 (21.5%)',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(11.5),
                color: const Color(0xFF6EE7B7),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6).withOpacity(0.20),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Lampaui target 20.1%',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(11),
            color: const Color(0xFF93C5FD),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

class _MiniStatsRow extends StatelessWidget {
  final ResponsiveHelper r;
  const _MiniStatsRow({required this.r});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      _MiniStat('4.48 Juta', 'Balita stunting', r),
      Container(width: 1, height: 32, color: Colors.white.withOpacity(0.12)),
      _MiniStat('357 Ribu', 'Berhasil dicegah', r),
      Container(width: 1, height: 32, color: Colors.white.withOpacity(0.12)),
      _MiniStat('38', 'Provinsi', r),
    ],
  );
}

class _MiniStat extends StatelessWidget {
  final String value;
  final String label;
  final ResponsiveHelper r;
  const _MiniStat(this.value, this.label, this.r);

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(13),
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(9.5),
            color: Colors.white54,
          ),
        ),
      ],
    ),
  );
}

/// Row of 3 summary stat cards below the hero card.
class SummaryStatRow extends StatelessWidget {
  final ResponsiveHelper r;

  const SummaryStatRow({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.trending_down_rounded,
            label: 'Penurunan\n2013→2024',
            value: '−17.4%',
            color: const Color(0xFF059669),
            r: r,
          ),
        ),
        SizedBox(width: r.sp(10)),
        Expanded(
          child: _StatCard(
            icon: Icons.flag_rounded,
            label: 'Target\nRPJMN 2029',
            value: '14.2%',
            color: const Color(0xFFF59E0B),
            r: r,
          ),
        ),
        SizedBox(width: r.sp(10)),
        Expanded(
          child: _StatCard(
            icon: Icons.diversity_3_rounded,
            label: 'Miskin vs\nKaya',
            value: '2.5×',
            color: const Color(0xFFEF4444),
            r: r,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final ResponsiveHelper r;
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.r,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(r.sp(13)),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withOpacity(0.18), width: 1),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.09),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.10),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        SizedBox(height: r.sp(8)),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(17),
            fontWeight: FontWeight.w800,
            color: color,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(9.5),
            color: Colors.grey.shade500,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}
