import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/core/network/dio_client_provider.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/data/datasource/quisioner_remote_datasource.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/data/repository/quisioner_repository_impl.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/domain_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/usecase/get_question_usecase.dart';
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
