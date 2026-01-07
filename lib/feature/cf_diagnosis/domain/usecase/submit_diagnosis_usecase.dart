import 'package:dartz/dartz.dart';
import 'package:mobile_flutter/core/error/failure.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/answer_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_result.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/repository/question_repository.dart';

class SubmitDiagnosisUseCase {
  final QuestionRepository repository;

  SubmitDiagnosisUseCase(this.repository);

  Future<Either<Failure, DiagnosisResultEntity>> call({
    required String category,
    required List<AnswerEntity> answers,
  }) {
    return repository.submitDiagnosis(category: category, answers: answers);
  }
}
