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
