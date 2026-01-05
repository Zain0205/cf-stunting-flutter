import 'package:dartz/dartz.dart';
import 'package:mobile_flutter/core/error/failure.dart';
import 'package:mobile_flutter/feature/auth/domain/entity/register_response_entity.dart';
import 'package:mobile_flutter/feature/auth/domain/repository/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<Either<Failure, RegisterResponseEntity>> call(
    String name,
    String phone,
    String category,
    String password,
  ) async {
    return await repository.register(
      name: name,
      phone: phone,
      password: password,
      category: category,
    );
  }
}
