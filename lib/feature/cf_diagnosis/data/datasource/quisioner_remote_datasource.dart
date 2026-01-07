import 'package:mobile_flutter/core/network/dio_client.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/data/model/diagnosis_history_model.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/data/model/diagnosis_request_model.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/data/model/diagnosis_response_model.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/data/model/domain_model.dart';

abstract class QuestionRemoteDatasource {
  Future<List<DomainModel>> getQuestions();
  Future<DiagnosisResponseModel> submitDiagnosis(DiagnosisRequestModel request);
  Future<List<DiagnosisHistoryModel>> getHistory();
}

class QuestionRemoteDatasourceImpl implements QuestionRemoteDatasource {
  final DioClient dioClient;

  QuestionRemoteDatasourceImpl(this.dioClient);

  @override
  Future<List<DomainModel>> getQuestions() async {
    final response = await dioClient.get('/api/questions');

    final domains = response.data['data']['domains'] as List;

    return domains.map((e) => DomainModel.fromJson(e)).toList();
  }

  @override
  Future<DiagnosisResponseModel> submitDiagnosis(
    DiagnosisRequestModel request,
  ) async {
    final response = await dioClient.post(
      '/api/diagnosis',
      data: request.toJson(),
    );

    return DiagnosisResponseModel.fromJson(response.data);
  }

  @override
  Future<List<DiagnosisHistoryModel>> getHistory() async {
    final response = await dioClient.get('/api/diagnosis');

    return (response.data['data'] as List)
        .map((e) => DiagnosisHistoryModel.fromJson(e))
        .toList();
  }
}
