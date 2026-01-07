import 'package:dartz/dartz.dart';
import 'package:mobile_flutter/core/error/failure.dart';
import 'package:mobile_flutter/feature/auth/domain/repository/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository repository;

  LogoutUsecase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}
