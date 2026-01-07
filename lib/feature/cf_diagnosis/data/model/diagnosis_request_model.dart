class DiagnosisRequestModel {
  final String category;
  final List<Map<String, String>> answers;

  DiagnosisRequestModel({required this.category, required this.answers});

  Map<String, dynamic> toJson() {
    return {"category": category, "answers": answers};
  }
}
