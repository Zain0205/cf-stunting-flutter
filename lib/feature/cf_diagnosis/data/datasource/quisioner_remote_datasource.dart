import 'package:mobile_flutter/core/network/dio_client.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/data/model/domain_model.dart';

abstract class QuestionRemoteDatasource {
  Future<List<DomainModel>> getQuestions();
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
}
