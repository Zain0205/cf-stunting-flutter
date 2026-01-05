import 'package:dio/dio.dart';
import 'package:mobile_flutter/core/data/local/storage_service.dart';
import 'package:mobile_flutter/core/exception/app_exception.dart';

class DioClient {
  final Dio _dio;
  final StorageService storageService;

  DioClient({required this.storageService, String? baseUrl}) : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl ?? 'http://localhost:8080',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Content-Type': 'application/json'},
    );

    _dio.interceptors.addAll([
      LogInterceptor(responseBody: true, requestBody: true),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storageService.get("token");
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          // Example: Add auth token if available
          // options.headers['Authorization'] = 'Bearer your_token';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          return handler.next(error);
        },
      ),
    ]);
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String endpoint, {dynamic data}) async {
    try {
      return await _dio.delete(endpoint, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  AppException _handleError(DioException error) {
    return AppException.fromDioException(error);
  }

  Dio get dio => _dio;

  String get baseUrl => _dio.options.baseUrl;
}
