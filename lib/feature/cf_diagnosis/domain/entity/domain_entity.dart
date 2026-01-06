import 'question_entity.dart';

class DomainEntity {
  final String code;
  final String name;
  final List<QuestionEntity> questions;

  const DomainEntity({
    required this.code,
    required this.name,
    required this.questions,
  });
}
