import 'package:mobile_flutter/core/error/failure.dart';
import 'package:mobile_flutter/feature/auth/domain/entity/register_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, RegisterResponseEntity>> register({
    required String name,
    required String phone,
    required String password,
    required String category,
  });
}
