import '../../domain/entity/question_entity.dart';
import 'option_model.dart';

class QuestionModel {
  final int id;
  final String code;
  final String text;
  final String domainCode;
  final String domainName;
  final double cfPakar;
  final bool isReverse;
  final List<OptionModel> options;

  QuestionModel({
    required this.id,
    required this.code,
    required this.text,
    required this.domainCode,
    required this.domainName,
    required this.cfPakar,
    required this.isReverse,
    required this.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      code: json['code'],
      text: json['text'],
      domainCode: json['domain_code'],
      domainName: json['domain_name'],
      cfPakar: (json['cf_pakar'] as num).toDouble(),
      isReverse: json['is_reverse'],
      options: (json['options'] as List)
          .map((e) => OptionModel.fromJson(e))
          .toList(),
    );
  }

  QuestionEntity toEntity() => QuestionEntity(
    id: id,
    code: code,
    text: text,
    domainCode: domainCode,
    domainName: domainName,
    cfPakar: cfPakar,
    isReverse: isReverse,
    options: options.map((e) => e.toEntity()).toList(),
  );
}
