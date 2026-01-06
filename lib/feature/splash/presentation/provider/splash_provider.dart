import 'package:mobile_flutter/core/data/local/shared_prefs_storage_service_provider.dart';
import 'package:mobile_flutter/core/data/local/storage_utils.dart';
import 'package:mobile_flutter/routes/route_path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_provider.g.dart';

class SplashNavigationResult {
  final String route;
  final Object? extra;

  const SplashNavigationResult({required this.route, this.extra});
}

@riverpod
class Splash extends _$Splash {
  @override
  Future<SplashNavigationResult?> build() async {
    await Future.delayed(const Duration(seconds: 3));

    final storageAsync = await ref.read(storageServiceProvider.future);
    final token = await storageAsync.get<String>('token');

    if (token != null && token.isNotEmpty) {
      return const SplashNavigationResult(route: RoutePath.mainNavigation);
    }

    final firstInstall = await storageAsync.get<bool>(StorageKeys.firstInstall);
    return SplashNavigationResult(
      route: firstInstall == false ? RoutePath.login : RoutePath.onboarding,
    );
  }
}

  // Future<void> _loadUserData() async {
  //   final authRepository = ref.read(authRepositoryProvider);
  //   final user = await authRepository.getUser();
  //
  //   if (user != null) {
  //     ref.read(authUserProvider.notifier).state = user;
  //   }
  // }

