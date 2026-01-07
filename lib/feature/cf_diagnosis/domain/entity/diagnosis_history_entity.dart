import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_answer_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_domain_entity.dart';

class DiagnosisHistoryEntity {
  final int id;
  final String category;
  final String result;
  final DateTime createdAt;
  final List<DiagnosisAnswerEntity> answers;
  final List<DiagnosisDomainEntity> domains;

  DiagnosisHistoryEntity({
    required this.id,
    required this.category,
    required this.result,
    required this.createdAt,
    required this.answers,
    required this.domains,
  });
}
