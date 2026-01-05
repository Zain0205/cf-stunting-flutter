import 'package:mobile_flutter/feature/auth/domain/entity/register_response_entity.dart';

class RegisterResponseModel {
  final bool success;
  final String? message;

  RegisterResponseModel({required this.success, this.message});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? json['data'],
    );
  }

  RegisterResponseEntity toEntity() {
    return RegisterResponseEntity(success: success, message: message);
  }
}
