import 'package:mobile_flutter/feature/cf_diagnosis/data/model/diagnosis_answer_model.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/data/model/diagnosis_domain_model.dart';

class DiagnosisHistoryModel {
  final int id;
  final String category;
  final String result;
  final DateTime createdAt;
  final List<DiagnosisAnswerModel> answers;
  final List<DiagnosisDomainModel> domains;

  DiagnosisHistoryModel({
    required this.id,
    required this.category,
    required this.result,
    required this.createdAt,
    required this.answers,
    required this.domains,
  });

  factory DiagnosisHistoryModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisHistoryModel(
      id: json['ID'],
      category: json['Category'],
      result: json['Result'],
      createdAt: DateTime.parse(json['CreatedAt']),
      answers: (json['Answers'] as List)
          .map((e) => DiagnosisAnswerModel.fromJson(e))
          .toList(),
      domains: (json['Domains'] as List)
          .map((e) => DiagnosisDomainModel.fromJson(e))
          .toList(),
    );
  }
}
