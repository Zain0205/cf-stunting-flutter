import 'package:dio/dio.dart';

/// Base class for all application exceptions
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic details;

  AppException(this.message, {this.statusCode, this.details});

  @override
  String toString() {
    return 'AppException: $message (Status: $statusCode, Details: $details)';
  }

  /// Extract error message from response data
  static String _extractErrorMessage(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      // Cek apakah ada field 'message' di response
      if (responseData.containsKey('message')) {
        return responseData['message']?.toString() ?? 'Request failed';
      }
      // Cek field lain yang mungkin ada
      if (responseData.containsKey('error')) {
        return responseData['error']?.toString() ?? 'Request failed';
      }
    }
    return 'Request failed';
  }

  /// Converts DioException to AppException
  static AppException fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return TimeoutException(
          "Request timed out",
          statusCode: e.response?.statusCode,
        );
      case DioExceptionType.badResponse:
        // Extract message dari response body kalau ada
        final errorMessage = _extractErrorMessage(e.response?.data);
        return ServerException(
          errorMessage,
          statusCode: e.response?.statusCode,
          details: e.response?.data,
        );
      case DioExceptionType.cancel:
        return RequestCancelledException("Request was cancelled");
      case DioExceptionType.connectionError:
        return NetworkException("No internet connection");
      case DioExceptionType.unknown:
      default:
        return UnknownException("Unknown error occurred", details: e.message);
    }
  }
}

/// Exception for network-related issues
class NetworkException extends AppException {
  NetworkException(super.message, {super.statusCode, super.details});
}

/// Exception for server errors (e.g., 500 Internal Server Error)
class ServerException extends AppException {
  ServerException(super.message, {super.statusCode, super.details});
}

/// Exception for timeout errors
class TimeoutException extends AppException {
  TimeoutException(super.message, {super.statusCode, super.details});
}

/// Exception when a request is cancelled
class RequestCancelledException extends AppException {
  RequestCancelledException(super.message, {super.details});
}

/// Exception for unknown or unexpected errors
class UnknownException extends AppException {
  UnknownException(super.message, {super.details});
}
