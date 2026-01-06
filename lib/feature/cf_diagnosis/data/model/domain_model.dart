import '../../domain/entity/domain_entity.dart';
import 'question_model.dart';

class DomainModel {
  final String code;
  final String name;
  final List<QuestionModel> questions;

  DomainModel({
    required this.code,
    required this.name,
    required this.questions,
  });

  factory DomainModel.fromJson(Map<String, dynamic> json) {
    return DomainModel(
      code: json['code'],
      name: json['name'],
      questions: (json['questions'] as List)
          .map((e) => QuestionModel.fromJson(e))
          .toList(),
    );
  }

  DomainEntity toEntity() => DomainEntity(
    code: code,
    name: name,
    questions: questions.map((e) => e.toEntity()).toList(),
  );
}
