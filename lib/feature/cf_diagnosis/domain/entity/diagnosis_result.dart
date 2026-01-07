class DiagnosisResultEntity {
  final int id;
  final String category;
  final String result;
  final DateTime createdAt;

  const DiagnosisResultEntity({
    required this.id,
    required this.category,
    required this.result,
    required this.createdAt,
  });
}
