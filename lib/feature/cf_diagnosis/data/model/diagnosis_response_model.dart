class DiagnosisResponseModel {
  final int id;
  final String category;
  final String result;
  final DateTime createdAt;

  DiagnosisResponseModel({
    required this.id,
    required this.category,
    required this.result,
    required this.createdAt,
  });

  factory DiagnosisResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return DiagnosisResponseModel(
      id: data['ID'],
      category: data['Category'],
      result: data['Result'],
      createdAt: DateTime.parse(data['CreatedAt']),
    );
  }
}
