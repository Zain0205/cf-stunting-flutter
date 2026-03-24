import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/core/resource/responsive_helper.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/question_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/provider/quisioner_provider.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/widget/answer_dropdown.dart';

/// Single question card with:
/// - Left accent bar (colored when answered)
/// - Question number badge
/// - Question text
/// - Check mark when answered
/// - [AnswerDropdown] to select an option
class QuestionItem extends ConsumerWidget {
  final QuestionEntity question;
  final int questionNumber;
  final List<Color> palette;
  final ResponsiveHelper r;

  const QuestionItem({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.palette,
    required this.r,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(answerStateProvider);
    final selectedAnswerKey = answers[question.code]?.answerKey;
    final selectedLabel = question.options
        .where((e) => e.answerKey == selectedAnswerKey)
        .map((e) => e.label.trim())
        .firstOrNull;
    final isAnswered = selectedLabel != null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isAnswered
              ? palette[0].withOpacity(0.25)
              : const Color(0xFFE8F0FE),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isAnswered
                ? palette[0].withOpacity(0.09)
                : const Color(0xFF3B82F6).withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _AccentBar(palette: palette, isAnswered: isAnswered),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(r.sp(14)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _QuestionHeader(
                      question: question,
                      questionNumber: questionNumber,
                      palette: palette,
                      isAnswered: isAnswered,
                      r: r,
                    ),
                    SizedBox(height: r.sp(12)),
                    AnswerDropdown(
                      question: question,
                      selectedLabel: selectedLabel,
                      palette: palette,
                      r: r,
                      onChanged: (label) {
                        final opt = question.options.firstWhere(
                          (e) => e.label == label,
                        );
                        ref
                            .read(answerStateProvider.notifier)
                            .setAnswer(
                              questionCode: question.code,
                              answerKey: opt.answerKey,
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _AccentBar extends StatelessWidget {
  final List<Color> palette;
  final bool isAnswered;

  const _AccentBar({required this.palette, required this.isAnswered});

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    width: 4,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: isAnswered
            ? palette
            : [Colors.grey.shade200, Colors.grey.shade200],
      ),
      borderRadius: const BorderRadius.horizontal(left: Radius.circular(18)),
    ),
  );
}

class _QuestionHeader extends StatelessWidget {
  final QuestionEntity question;
  final int questionNumber;
  final List<Color> palette;
  final bool isAnswered;
  final ResponsiveHelper r;

  const _QuestionHeader({
    required this.question,
    required this.questionNumber,
    required this.palette,
    required this.isAnswered,
    required this.r,
  });

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _NumberBadge(
        number: questionNumber,
        palette: palette,
        isAnswered: isAnswered,
        r: r,
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          question.text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: r.fs(13),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
            height: 1.5,
          ),
        ),
      ),
      if (isAnswered) ...[
        const SizedBox(width: 8),
        _CheckBadge(palette: palette),
      ],
    ],
  );
}

class _NumberBadge extends StatelessWidget {
  final int number;
  final List<Color> palette;
  final bool isAnswered;
  final ResponsiveHelper r;

  const _NumberBadge({
    required this.number,
    required this.palette,
    required this.isAnswered,
    required this.r,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: 24,
    height: 24,
    margin: const EdgeInsets.only(top: 1),
    decoration: BoxDecoration(
      color: isAnswered ? palette[0].withOpacity(0.12) : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(7),
    ),
    child: Center(
      child: Text(
        '$number',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: r.fs(10),
          fontWeight: FontWeight.w700,
          color: isAnswered ? palette[0] : Colors.grey.shade400,
        ),
      ),
    ),
  );
}

class _CheckBadge extends StatelessWidget {
  final List<Color> palette;
  const _CheckBadge({required this.palette});

  @override
  Widget build(BuildContext context) => Container(
    width: 22,
    height: 22,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: palette,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.check_rounded, color: Colors.white, size: 13),
  );
}
