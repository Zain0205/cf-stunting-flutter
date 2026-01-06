import 'package:flutter/material.dart';
import '../../domain/entity/domain_entity.dart';
import 'question_item.dart';

class DomainSection extends StatelessWidget {
  final DomainEntity domain;

  const DomainSection({super.key, required this.domain});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          domain.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        ...domain.questions.map(
          (q) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: QuestionItem(question: q),
          ),
        ),
      ],
    );
  }
}
