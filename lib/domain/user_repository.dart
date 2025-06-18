import 'user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> getCurrentUser();
  Future<void> signOut();
} 