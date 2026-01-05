import 'package:mobile_flutter/feature/auth/domain/entity/user_entity.dart';

class UserModel {
  final int id;
  final String name;
  final String phone;
  final String category;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.category,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      category: json['category'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(id: id, name: name, phone: phone, category: category);
  }
}
