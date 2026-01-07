import 'package:dartz/dartz.dart';
import 'package:mobile_flutter/core/error/failure.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/answer_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_history_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_result.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/domain_entity.dart';

abstract class QuestionRepository {
  Future<Either<Failure, List<DomainEntity>>> getQuestions();

  Future<Either<Failure, DiagnosisResultEntity>> submitDiagnosis({
    required String category,
    required List<AnswerEntity> answers,
  });

  Future<Either<Failure, List<DiagnosisHistoryEntity>>> getHistory();
}
