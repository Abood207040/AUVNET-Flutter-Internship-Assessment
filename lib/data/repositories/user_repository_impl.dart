import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/user_entity.dart';
import '../../domain/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl(this._firebaseAuth);

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return UserEntity(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
    );
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
} 