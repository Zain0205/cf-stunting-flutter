// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Splash)
const splashProvider = SplashProvider._();

final class SplashProvider
    extends $AsyncNotifierProvider<Splash, SplashNavigationResult?> {
  const SplashProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'splashProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$splashHash();

  @$internal
  @override
  Splash create() => Splash();
}

String _$splashHash() => r'87e61b547fc949511d312acf3ef5e66e706b3aa0';

abstract class _$Splash extends $AsyncNotifier<SplashNavigationResult?> {
  FutureOr<SplashNavigationResult?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<SplashNavigationResult?>,
              SplashNavigationResult?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<SplashNavigationResult?>,
                SplashNavigationResult?
              >,
              AsyncValue<SplashNavigationResult?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
