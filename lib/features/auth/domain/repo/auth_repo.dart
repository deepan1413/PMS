
import 'package:pms/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginInWithEmailAndPassword(String email, String password);

  Future<AppUser?> signUpWithEmailAndPassword(
    String name,
    String email,
    String password,
  );

  Future<void> signOut();

  Future<AppUser?> getCurrentUser();

  Future<void> forgotPassword(String email);
}
