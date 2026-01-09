// Shared providers untuk auth (dipakai oleh login, register, logout, dll)
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_flutter/core/data/local/shared_prefs_storage_service_provider.dart';
import 'package:mobile_flutter/core/network/dio_client_provider.dart';
import 'package:mobile_flutter/feature/auth/data/datasource/auth_local_datasource.dart';
import 'package:mobile_flutter/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:mobile_flutter/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:mobile_flutter/feature/auth/domain/usecase/logout_usecase.dart';

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSource(ref.watch(storageServiceSyncProvider));
});

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(ref.watch(dioClientProvider));
});

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
});

final logoutUsaseProvider = Provider<LogoutUsecase>((ref) {
  return LogoutUsecase(ref.watch(authRepositoryProvider));
});
