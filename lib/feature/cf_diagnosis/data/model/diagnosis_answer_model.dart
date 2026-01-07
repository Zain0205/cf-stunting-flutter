class DiagnosisAnswerModel {
  final String questionCode;
  final String answerKey;
  final double cfItem;

  DiagnosisAnswerModel({
    required this.questionCode,
    required this.answerKey,
    required this.cfItem,
  });

  factory DiagnosisAnswerModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisAnswerModel(
      questionCode: json['QuestionCode'],
      answerKey: json['AnswerKey'],
      cfItem: (json['CFItem'] as num).toDouble(),
    );
  }
}
