import 'package:dartz/dartz.dart';
import 'package:mobile_flutter/core/error/failure.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_history_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/repository/question_repository.dart';

class GetDiagnosisHistoryUsecase {
  final QuestionRepository repository;

  GetDiagnosisHistoryUsecase(this.repository);

  Future<Either<Failure, List<DiagnosisHistoryEntity>>> call() {
    return repository.getHistory();
  }
}
