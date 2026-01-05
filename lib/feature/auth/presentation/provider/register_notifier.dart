import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mobile_flutter/feature/auth/domain/entity/register_response_entity.dart';
import 'package:mobile_flutter/feature/auth/domain/usecase/register_usecase.dart';

class RegisterNotifier
    extends StateNotifier<AsyncValue<RegisterResponseEntity?>> {
  final Ref ref;
  final RegisterUsecase registerUseCase;

  RegisterNotifier(this.ref, this.registerUseCase)
    : super(AsyncValue.data(null));

  Future<void> register(
    String name,
    String phone,
    String category,
    String password,
  ) async {
    state = const AsyncValue.loading();

    await Future.delayed(const Duration(seconds: 2));

    final result = await registerUseCase(name, phone, category, password);

    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (registerResponse) {
        return AsyncValue.data(registerResponse);
      },
    );
  }
}
