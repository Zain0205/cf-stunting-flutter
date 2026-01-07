import 'package:flutter_riverpod/legacy.dart';
import 'package:mobile_flutter/feature/auth/domain/entity/user_entity.dart';

final authUserProvider = StateProvider<UserEntity?>((ref) => null);
