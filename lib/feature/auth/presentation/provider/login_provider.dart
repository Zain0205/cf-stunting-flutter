// Login UseCase Provider
import 'package:flutter_riverpod/legacy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_flutter/feature/auth/domain/entity/login_response_entity.dart';
import 'package:mobile_flutter/feature/auth/domain/usecase/login_usecase.dart';
import 'package:mobile_flutter/feature/auth/presentation/provider/auth_shared_provider.dart';
import 'package:mobile_flutter/feature/auth/presentation/provider/login_notifier.dart';

final loginUseCaseProvider = Provider<LoginUsecase>((ref) {
  return LoginUsecase(ref.watch(authRepositoryProvider));
});

// Login State Provider
final loginStateProvider =
    StateNotifierProvider<LoginNotifier, AsyncValue<LoginResponseEntity?>>((
      ref,
    ) {
      return LoginNotifier(ref, ref.watch(loginUseCaseProvider));
    });
