import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_answer_entity.dart';

/// Single answer row showing answer key badge, question code, and CF item value.
class AnswerCard extends StatelessWidget {
  final DiagnosisAnswerEntity answer;
  final int index;
  final ResponsiveHelper r;

  const AnswerCard({
    super.key,
    required this.answer,
    required this.index,
    required this.r,
  });

  static List<Color> _keyGradient(String key) {
    const map = {
      'A': [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
      'B': [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
      'C': [Color(0xFF059669), Color(0xFF047857)],
      'D': [Color(0xFFF59E0B), Color(0xFFD97706)],
      'E': [Color(0xFFEC4899), Color(0xFFBE185D)],
    };
    return map[key.toUpperCase()] ??
        const [Color(0xFF3B82F6), Color(0xFF1D4ED8)];
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _keyGradient(answer.answerKey);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFE8F0FE), width: 1),
      ),
      padding: EdgeInsets.all(r.sp(14)),
      child: Row(
        children: [
          _AnswerKeyBadge(
            answerKey: answer.answerKey,
            gradient: gradient,
            r: r,
          ),
          SizedBox(width: r.sp(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  answer.questionCode,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.fs(13.5),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: r.sp(4)),
                Row(
                  children: [
                    Text(
                      'CF Item:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11.5),
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      answer.cfItem.toStringAsFixed(2),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.fs(11.5),
                        fontWeight: FontWeight.w700,
                        color: gradient[0],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _IndexBadge(index: index, r: r),
        ],
      ),
    );
  }
}

class _AnswerKeyBadge extends StatelessWidget {
  final String answerKey;
  final List<Color> gradient;
  final ResponsiveHelper r;
  const _AnswerKeyBadge({
    required this.answerKey,
    required this.gradient,
    required this.r,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: r.isSmall ? 40 : 46,
    height: r.isSmall ? 40 : 46,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradient,
      ),
      borderRadius: BorderRadius.circular(13),
      boxShadow: [
        BoxShadow(
          color: gradient[0].withOpacity(0.35),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Center(
      child: Text(
        answerKey,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(15),
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    ),
  );
}

class _IndexBadge extends StatelessWidget {
  final int index;
  final ResponsiveHelper r;
  const _IndexBadge({required this.index, required this.r});

  @override
  Widget build(BuildContext context) => Container(
    width: 26,
    height: 26,
    decoration: BoxDecoration(
      color: const Color(0xFFF1F5F9),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        '${index + 1}',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(10),
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade400,
        ),
      ),
    ),
  );
}
