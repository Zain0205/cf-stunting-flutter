import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/question_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/provider/quisioner_provider.dart';
import '../../../../core/widget/custom_select_field.dart';

class QuestionItem extends ConsumerWidget {
  final QuestionEntity question;

  const QuestionItem({super.key, required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(answerStateProvider);

    // answer_key yang tersimpan (contoh: "0")
    final selectedAnswerKey = answers[question.code]?.answerKey;

    // mapping label list
    final optionsLabel = question.options.map((e) => e.label).toList();

    // konversi answer_key -> label untuk value dropdown
    final selectedLabel = question.options
        .where((e) => e.answerKey == selectedAnswerKey)
        .map((e) => e.label)
        .firstOrNull;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        CustomSelectField(
          label: "Jawaban",
          hint: "Pilih jawaban",
          options: optionsLabel,
          value: selectedLabel,
          isRequired: true,
          onChanged: (label) {
            // cari option berdasarkan label
            final selectedOption = question.options.firstWhere(
              (e) => e.label == label,
            );

            ref
                .read(answerStateProvider.notifier)
                .setAnswer(
                  questionCode: question.code,
                  answerKey: selectedOption.answerKey, // ✅ BENAR
                );
          },
        ),
      ],
    );
  }
}
