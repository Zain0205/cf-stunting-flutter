import 'package:dartz/dartz.dart';
import 'package:mobile_flutter/core/error/failure.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/domain_entity.dart';

abstract class QuestionRepository {
  Future<Either<Failure, List<DomainEntity>>> getQuestions();
}
