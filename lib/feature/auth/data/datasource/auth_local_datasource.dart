import 'dart:convert';
import 'package:mobile_flutter/core/data/local/storage_service.dart';
import 'package:mobile_flutter/feature/auth/domain/entity/user_entity.dart';

class AuthLocalDataSource {
  final StorageService storageService;

  AuthLocalDataSource(this.storageService);

  Future<void> clearToken() async {
    await storageService.remove('token');
  }

  Future<void> saveToken(String token) async {
    await storageService.set('token', token);
  }

  Future<void> saveUser(UserEntity user) async {
    final userJson = {
      'id': user.id,
      'name': user.name,
      'phone': user.phone,
      'category': user.category,
    };
    await storageService.set('user', jsonEncode(userJson));
  }

  Future<UserEntity?> getUser() async {
    final encoded = await storageService.get('user');
    if (encoded == null) return null;
    final userJson = jsonDecode(encoded) as Map<String, dynamic>;
    return UserEntity(
      id: userJson['id'] as int,
      name: userJson['name'] as String,
      phone: userJson['phone'] as String,
      category: userJson['category'] as String,
    );
  }

  Future<void> clearUser() async {
    await storageService.remove('user');
  }
}
