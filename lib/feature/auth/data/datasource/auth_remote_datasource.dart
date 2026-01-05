import 'package:dio/dio.dart';
import 'package:mobile_flutter/core/exception/app_exception.dart';
import 'package:mobile_flutter/core/network/dio_client.dart';
import 'package:mobile_flutter/feature/auth/data/model/login_response_model.dart';
import 'package:mobile_flutter/feature/auth/data/model/register_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterResponseModel> register(
    String name,
    String phone,
    String category,
    String password,
  );
  Future<LoginResponseModel> login(String name, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl(this.dioClient);

  String _extractErrorMessage(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      if (responseData.containsKey('message')) {
        return responseData['message']?.toString() ?? 'Request failed';
      }
      if (responseData.containsKey('error')) {
        return responseData['error']?.toString() ?? 'Request failed';
      }
    }
    return 'Request failed';
  }

  @override
  Future<RegisterResponseModel> register(
    String name,
    String phone,
    String category,
    String password,
  ) async {
    try {
      final response = await dioClient.post(
        '/auth/register',
        data: {
          "name": name,
          "phone": phone,
          "category": category,
          "password": password,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        return RegisterResponseModel.fromJson(data);
      } else {
        // Extract message dari response body kalau ada
        String errorMessage = _extractErrorMessage(response.data);
        if (errorMessage == 'Request failed') {
          errorMessage = "Server error: ${response.statusMessage}";
        }
        throw ServerException(
          errorMessage,
          statusCode: response.statusCode,
          details: response.data,
        );
      }
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknownException(
        "An unexpected error occurred",
        details: e.toString(),
      );
    }
  }

  @override
  Future<LoginResponseModel> login(String name, String password) async {
    try {
      final response = await dioClient.post(
        "/auth/login",
        data: {"phone": name, "password": password},
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'];

        if (data is Map<String, dynamic>) {
          final hasAccessToken = data.containsKey('token');
          final hasErrorMessage =
              data.containsKey('message') && !hasAccessToken;
          if (hasErrorMessage) {
            throw ServerException(
              data['message']?.toString() ?? 'Request failed',
              statusCode: response.statusCode,
              details: data,
            );
          }
          return LoginResponseModel.fromJson(data);
        } else {
          throw ServerException(
            'Invalid response format',
            statusCode: response.statusCode,
            details: data,
          );
        }
      } else {
        // Extract message dari response body kalau ada
        String errorMessage = _extractErrorMessage(response.data);
        if (errorMessage == 'Request failed') {
          errorMessage = "Server error: ${response.statusMessage}";
        }
        throw ServerException(
          errorMessage,
          statusCode: response.statusCode,
          details: response.data,
        );
      }
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    } on AppException {
      // Preserve thrown ServerException/UnknownException without wrapping
      rethrow;
    } catch (e) {
      throw UnknownException(e.toString(), details: e.toString());
    }
  }
}
