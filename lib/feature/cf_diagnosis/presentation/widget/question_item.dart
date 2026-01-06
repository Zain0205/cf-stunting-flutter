import 'package:flutter/material.dart';
import '../../domain/entity/question_entity.dart';
import '../../../../core/widget/custom_select_field.dart';

class QuestionItem extends StatefulWidget {
  final QuestionEntity question;

  const QuestionItem({super.key, required this.question});

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final optionsLabel = widget.question.options.map((e) => e.label).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question.text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        CustomSelectField(
          label: "Jawaban",
          hint: "Pilih jawaban",
          options: optionsLabel,
          value: selectedValue,
          isRequired: true,
          onChanged: (val) {
            setState(() {
              selectedValue = val;
            });
          },
        ),
      ],
    );
  }
}
