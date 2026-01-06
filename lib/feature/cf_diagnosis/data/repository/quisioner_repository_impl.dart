import 'package:dartz/dartz.dart';
import 'package:mobile_flutter/core/error/failure.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/data/datasource/quisioner_remote_datasource.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/domain_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/repository/question_repository.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionRemoteDatasource remoteDatasource;

  QuestionRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<DomainEntity>>> getQuestions() async {
    final result = await remoteDatasource.getQuestions();
    return Right(result.map((e) => e.toEntity()).toList());
  }
}
