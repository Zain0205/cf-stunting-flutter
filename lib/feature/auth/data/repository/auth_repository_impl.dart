import 'package:dartz/dartz.dart';
import 'package:mobile_flutter/core/error/failure.dart';
import 'package:mobile_flutter/core/exception/app_exception.dart';
import 'package:mobile_flutter/feature/auth/data/datasource/auth_local_datasource.dart';
import 'package:mobile_flutter/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:mobile_flutter/feature/auth/domain/entity/login_response_entity.dart';
import 'package:mobile_flutter/feature/auth/domain/entity/register_response_entity.dart';
import 'package:mobile_flutter/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, RegisterResponseEntity>> register({
    required String name,
    required String phone,
    required String password,
    required String category,
  }) async {
    try {
      final loginResponse = await remoteDataSource.register(
        name,
        phone,
        category,
        password,
      );
      return Right(loginResponse.toEntity());
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, statusCode: e.statusCode));
    } on TimeoutException catch (e) {
      return Left(NetworkFailure(e.message, statusCode: e.statusCode));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on UnknownException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, LoginResponseEntity>> login(
    String name,
    String password,
  ) async {
    try {
      final loginResponse = await remoteDataSource.login(name, password);
      return Right(loginResponse.toEntity());
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, statusCode: e.statusCode));
    } on TimeoutException catch (e) {
      return Left(NetworkFailure(e.message, statusCode: e.statusCode));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on UnknownException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearToken();
      await localDataSource.clearUser();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to logout'));
    }
  }

  @override
  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await localDataSource.saveToken(token);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure("Failed to save token"));
    }
  }
}
