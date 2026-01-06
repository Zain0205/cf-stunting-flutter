import '../../domain/entity/option_entity.dart';

class OptionModel {
  final String answerKey;
  final double cfEvidence;
  final String label;

  OptionModel({
    required this.answerKey,
    required this.cfEvidence,
    required this.label,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      answerKey: json['answer_key'],
      cfEvidence: (json['cf_evidence'] as num).toDouble(),
      label: json['label'],
    );
  }

  OptionEntity toEntity() =>
      OptionEntity(answerKey: answerKey, cfEvidence: cfEvidence, label: label);
}
