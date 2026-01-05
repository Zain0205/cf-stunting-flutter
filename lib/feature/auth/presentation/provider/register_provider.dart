// Register UseCase Provider
import 'package:flutter_riverpod/legacy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_flutter/feature/auth/domain/entity/register_response_entity.dart';
import 'package:mobile_flutter/feature/auth/domain/usecase/register_usecase.dart';
import 'package:mobile_flutter/feature/auth/presentation/provider/auth_shared_provider.dart';
import 'package:mobile_flutter/feature/auth/presentation/provider/register_notifier.dart';

final registerUseCaseProvider = Provider<RegisterUsecase>((ref) {
  return RegisterUsecase(ref.watch(authRepositoryProvider));
});

// Register State Provider
final registerStateProvider =
    StateNotifierProvider<
      RegisterNotifier,
      AsyncValue<RegisterResponseEntity?>
    >((ref) {
      return RegisterNotifier(ref, ref.watch(registerUseCaseProvider));
    });
