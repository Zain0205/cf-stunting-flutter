class DiagnosisDomainModel {
  final String domainCode;
  final double cfValue;

  DiagnosisDomainModel({required this.domainCode, required this.cfValue});

  factory DiagnosisDomainModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisDomainModel(
      domainCode: json['DomainCode'],
      cfValue: (json['CFValue'] as num).toDouble(),
    );
  }
}
