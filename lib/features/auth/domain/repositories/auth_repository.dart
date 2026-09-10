import '../entities/app_user.dart';

abstract interface class AuthRepository {
  Future<AppUser> signIn({required String email, required String password});
  Future<AppUser> signUp({
    required String email,
    required String password,
    String? displayName,
  });
  Future<void> signOut();
  Stream<AppUser?> authStateChanges();
}
