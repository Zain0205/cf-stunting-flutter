import 'package:dartz/dartz.dart';
import 'package:mobile_flutter/core/error/failure.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/data/datasource/quisioner_remote_datasource.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/data/model/diagnosis_request_model.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/answer_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_answer_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_domain_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_history_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_result.dart';
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

  @override
  Future<Either<Failure, DiagnosisResultEntity>> submitDiagnosis({
    required String category,
    required List<AnswerEntity> answers,
  }) async {
    try {
      final request = DiagnosisRequestModel(
        category: category,
        answers: answers
            .map(
              (e) => {
                "question_code": e.questionCode,
                "answer_key": e.answerKey,
              },
            )
            .toList(),
      );

      final response = await remoteDatasource.submitDiagnosis(request);

      return Right(
        DiagnosisResultEntity(
          id: response.id,
          category: response.category,
          result: response.result,
          createdAt: response.createdAt,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DiagnosisHistoryEntity>>> getHistory() async {
    try {
      final result = await remoteDatasource.getHistory();

      return Right(
        result
            .map(
              (e) => DiagnosisHistoryEntity(
                id: e.id,
                category: e.category,
                result: e.result,
                createdAt: e.createdAt,
                answers: e.answers
                    .map(
                      (a) => DiagnosisAnswerEntity(
                        questionCode: a.questionCode,
                        answerKey: a.answerKey,
                        cfItem: a.cfItem,
                      ),
                    )
                    .toList(),
                domains: e.domains
                    .map(
                      (d) => DiagnosisDomainEntity(
                        domainCode: d.domainCode,
                        cfValue: d.cfValue,
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
      );
    } catch (e) {
      return Left(ServerFailure("Server Error"));
    }
  }
}
