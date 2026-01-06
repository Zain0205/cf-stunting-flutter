import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/option_entity.dart';

class QuestionEntity {
  final int id;
  final String code;
  final String text;
  final String domainCode;
  final String domainName;
  final double cfPakar;
  final bool isReverse;
  final List<OptionEntity> options;

  const QuestionEntity({
    required this.id,
    required this.code,
    required this.text,
    required this.domainCode,
    required this.domainName,
    required this.cfPakar,
    required this.isReverse,
    required this.options,
  });
}
