// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quisioner_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(QuestionNotifier)
const questionProvider = QuestionNotifierProvider._();

final class QuestionNotifierProvider
    extends $AsyncNotifierProvider<QuestionNotifier, QuestionState> {
  const QuestionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'questionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$questionNotifierHash();

  @$internal
  @override
  QuestionNotifier create() => QuestionNotifier();
}

String _$questionNotifierHash() => r'3286bd0930b848b86317b3f4a751572763757967';

abstract class _$QuestionNotifier extends $AsyncNotifier<QuestionState> {
  FutureOr<QuestionState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<QuestionState>, QuestionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<QuestionState>, QuestionState>,
              AsyncValue<QuestionState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(AnswerState)
const answerStateProvider = AnswerStateProvider._();

final class AnswerStateProvider
    extends $NotifierProvider<AnswerState, Map<String, AnswerEntity>> {
  const AnswerStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'answerStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$answerStateHash();

  @$internal
  @override
  AnswerState create() => AnswerState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, AnswerEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, AnswerEntity>>(value),
    );
  }
}

String _$answerStateHash() => r'306dd36bb5c771e33b717d390d5d825d11868c1e';

abstract class _$AnswerState extends $Notifier<Map<String, AnswerEntity>> {
  Map<String, AnswerEntity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<Map<String, AnswerEntity>, Map<String, AnswerEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, AnswerEntity>, Map<String, AnswerEntity>>,
              Map<String, AnswerEntity>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DiagnosisNotifier)
const diagnosisProvider = DiagnosisNotifierProvider._();

final class DiagnosisNotifierProvider
    extends
        $NotifierProvider<
          DiagnosisNotifier,
          AsyncValue<DiagnosisResultEntity?>
        > {
  const DiagnosisNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'diagnosisProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$diagnosisNotifierHash();

  @$internal
  @override
  DiagnosisNotifier create() => DiagnosisNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<DiagnosisResultEntity?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<DiagnosisResultEntity?>>(
        value,
      ),
    );
  }
}

String _$diagnosisNotifierHash() => r'3b2544ff938eeb43759ddcb5a0cf6a591f251240';

abstract class _$DiagnosisNotifier
    extends $Notifier<AsyncValue<DiagnosisResultEntity?>> {
  AsyncValue<DiagnosisResultEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<DiagnosisResultEntity?>,
              AsyncValue<DiagnosisResultEntity?>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<DiagnosisResultEntity?>,
                AsyncValue<DiagnosisResultEntity?>
              >,
              AsyncValue<DiagnosisResultEntity?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DiagnosisHistoryNotifier)
const diagnosisHistoryProvider = DiagnosisHistoryNotifierProvider._();

final class DiagnosisHistoryNotifierProvider
    extends
        $AsyncNotifierProvider<
          DiagnosisHistoryNotifier,
          List<DiagnosisHistoryEntity>
        > {
  const DiagnosisHistoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'diagnosisHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$diagnosisHistoryNotifierHash();

  @$internal
  @override
  DiagnosisHistoryNotifier create() => DiagnosisHistoryNotifier();
}

String _$diagnosisHistoryNotifierHash() =>
    r'40c7b0f0fe8eaf82811fff0c727bfde55ec8bf9a';

abstract class _$DiagnosisHistoryNotifier
    extends $AsyncNotifier<List<DiagnosisHistoryEntity>> {
  FutureOr<List<DiagnosisHistoryEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<DiagnosisHistoryEntity>>,
              List<DiagnosisHistoryEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DiagnosisHistoryEntity>>,
                List<DiagnosisHistoryEntity>
              >,
              AsyncValue<List<DiagnosisHistoryEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
