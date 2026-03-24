import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/domain_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/widget/question_item.dart';

/// Renders a domain header chip + all its question items.
class DomainSection extends StatelessWidget {
  final DomainEntity domain;
  final int domainIndex;
  final ResponsiveHelper r;

  const DomainSection({
    super.key,
    required this.domain,
    required this.domainIndex,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final palette = DomainPalette.at(domainIndex);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DomainHeader(
          domain: domain,
          domainIndex: domainIndex,
          palette: palette,
          r: r,
        ),
        SizedBox(height: r.sp(10)),
        ...domain.questions.asMap().entries.map(
          (entry) => Padding(
            padding: EdgeInsets.only(bottom: r.sp(10)),
            child: QuestionItem(
              question: entry.value,
              questionNumber: entry.key + 1,
              palette: palette,
              r: r,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Private domain header ─────────────────────────────────────────────────────

class _DomainHeader extends StatelessWidget {
  final DomainEntity domain;
  final int domainIndex;
  final List<Color> palette;
  final ResponsiveHelper r;

  const _DomainHeader({
    required this.domain,
    required this.domainIndex,
    required this.palette,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: r.sp(16), vertical: r.sp(13)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [palette[0].withOpacity(0.12), palette[0].withOpacity(0.04)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette[0].withOpacity(0.20), width: 1),
      ),
      child: Row(
        children: [
          _NumberBadge(number: domainIndex + 1, palette: palette, r: r),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              domain.name,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.fs(13.5),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
                height: 1.3,
              ),
            ),
          ),
          _QuestionCountChip(
            count: domain.questions.length,
            palette: palette,
            r: r,
          ),
        ],
      ),
    );
  }
}

class _NumberBadge extends StatelessWidget {
  final int number;
  final List<Color> palette;
  final ResponsiveHelper r;

  const _NumberBadge({
    required this.number,
    required this.palette,
    required this.r,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: 34,
    height: 34,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: palette,
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: palette[0].withOpacity(0.35),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Center(
      child: Text(
        '$number',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(14),
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    ),
  );
}

class _QuestionCountChip extends StatelessWidget {
  final int count;
  final List<Color> palette;
  final ResponsiveHelper r;

  const _QuestionCountChip({
    required this.count,
    required this.palette,
    required this.r,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: palette[0].withOpacity(0.12),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      '$count soal',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: r.fs(10),
        fontWeight: FontWeight.w600,
        color: palette[0],
      ),
    ),
  );
}

abstract class DomainPalette {
  static const _palette = [
    [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    [Color(0xFF059669), Color(0xFF047857)],
    [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    [Color(0xFFF59E0B), Color(0xFFD97706)],
    [Color(0xFFEC4899), Color(0xFFBE185D)],
    [Color(0xFF06B6D4), Color(0xFF0891B2)],
  ];

  static List<Color> at(int index) => _palette[index % _palette.length];
}
