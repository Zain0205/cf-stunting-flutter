import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:mobile_flutter/core/error/failure.dart';
import 'package:mobile_flutter/feature/auth/domain/entity/login_response_entity.dart';
import 'package:mobile_flutter/feature/auth/domain/repository/auth_repository.dart';

final logger = Logger();

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, LoginResponseEntity>> call(
    String name,
    String password,
  ) async {
    final result = await repository.login(name, password);

    return result.fold((failure) => Left(failure), (loginResponse) async {
      // Save token
      final saveTokenResult = await repository.saveToken(loginResponse.token);
      logger.i("TEST ${loginResponse.token}");
      saveTokenResult.fold(
        (failure) => logger.i("Error saving token: ${failure.message}"),
        (_) => logger.i("Token saved successfully"),
      );

      // Save students

      return Right(loginResponse);
    });
  }
}
