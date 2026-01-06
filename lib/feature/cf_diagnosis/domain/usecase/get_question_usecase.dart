import 'package:dartz/dartz.dart';
import 'package:mobile_flutter/core/error/failure.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/domain_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/repository/question_repository.dart';

class GetQuestionsUsecase {
  final QuestionRepository repository;

  GetQuestionsUsecase(this.repository);

  Future<Either<Failure, List<DomainEntity>>> call() {
    return repository.getQuestions();
  }
}
