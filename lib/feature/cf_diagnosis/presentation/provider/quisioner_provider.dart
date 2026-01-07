import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/core/network/dio_client_provider.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/data/datasource/quisioner_remote_datasource.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/data/repository/quisioner_repository_impl.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/answer_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_history_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_result.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/domain_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/usecase/get_diagnosis_history_usecase.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/usecase/get_question_usecase.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/usecase/submit_diagnosis_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quisioner_provider.g.dart';

final questionRemoteDatasourceProvider = Provider(
  (ref) => QuestionRemoteDatasourceImpl(ref.read(dioClientProvider)),
);

final questionRepositoryProvider = Provider(
  (ref) => QuestionRepositoryImpl(ref.read(questionRemoteDatasourceProvider)),
);

final getQuestionsUsecaseProvider = Provider(
  (ref) => GetQuestionsUsecase(ref.read(questionRepositoryProvider)),
);

final submitDiagnosisUseCaseProvider = Provider<SubmitDiagnosisUseCase>((ref) {
  return SubmitDiagnosisUseCase(ref.read(questionRepositoryProvider));
});

final getDiagnosisHistoryUsecaseProvider = Provider<GetDiagnosisHistoryUsecase>(
  (ref) {
    return GetDiagnosisHistoryUsecase(ref.read(questionRepositoryProvider));
  },
);

class QuestionState {
  final List<DomainEntity> domains;

  const QuestionState({required this.domains});
}

@riverpod
class QuestionNotifier extends _$QuestionNotifier {
  @override
  Future<QuestionState> build() async {
    final usecase = ref.read(getQuestionsUsecaseProvider);

    final result = await usecase();

    return result.fold(
      (failure) {
        throw failure; // Riverpod akan masuk AsyncError
      },
      (domains) {
        return QuestionState(domains: domains);
      },
    );
  }
}

@riverpod
class AnswerState extends _$AnswerState {
  @override
  Map<String, AnswerEntity> build() => {};

  void setAnswer({required String questionCode, required String answerKey}) {
    state = {
      ...state,
      questionCode: AnswerEntity(
        questionCode: questionCode,
        answerKey: answerKey,
      ),
    };
  }

  List<AnswerEntity> get answers => state.values.toList();
}

@riverpod
class DiagnosisNotifier extends _$DiagnosisNotifier {
  @override
  AsyncValue<DiagnosisResultEntity?> build() {
    return const AsyncData(null);
  }

  Future<void> submit({
    required String category,
    required List<AnswerEntity> answers,
  }) async {
    state = const AsyncLoading();

    final usecase = ref.read(submitDiagnosisUseCaseProvider);

    final result = await usecase(category: category, answers: answers);

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (data) {
        state = AsyncData(data);
      },
    );
  }
}

@riverpod
class DiagnosisHistoryNotifier extends _$DiagnosisHistoryNotifier {
  @override
  Future<List<DiagnosisHistoryEntity>> build() async {
    final usecase = ref.read(getDiagnosisHistoryUsecaseProvider);
    final result = await usecase();

    return result.fold((failure) => throw failure, (history) => history);
  }
}
