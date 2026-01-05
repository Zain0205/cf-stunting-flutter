import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mobile_flutter/feature/auth/domain/entity/login_response_entity.dart';
import 'package:mobile_flutter/feature/auth/domain/usecase/login_usecase.dart';
import 'package:mobile_flutter/feature/auth/presentation/provider/auth_shared_provider.dart';

class LoginNotifier extends StateNotifier<AsyncValue<LoginResponseEntity?>> {
  final Ref ref;
  final LoginUsecase loginUseCase;

  LoginNotifier(this.ref, this.loginUseCase)
    : super(const AsyncValue.data(null));

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();

    await Future.delayed(const Duration(seconds: 2));

    final result = await loginUseCase(username, password);

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (loginResponse) {
        // ref.read(authUserProvider.notifier).state = loginResponse.user;

        final authRepository = ref.read(authRepositoryProvider);
        authRepository.saveUser(loginResponse.user);

        return AsyncValue.data(loginResponse);
      },
    );
  }
}
