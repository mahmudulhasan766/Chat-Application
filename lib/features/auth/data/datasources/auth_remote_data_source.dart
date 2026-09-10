import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserCredential> signIn({
    required String email,
    required String password,
  });
  Future<UserCredential> signUp({
    required String email,
    required String password,
  });
  Future<void> updateDisplayName(String? displayName);
  Future<void> signOut();
  Stream<User?> authStateChanges();
}

class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  FirebaseAuthRemoteDataSource(this._auth);

  final FirebaseAuth _auth;

  @override
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) => _run(
    () => _auth.signInWithEmailAndPassword(email: email, password: password),
  );

  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) => _run(
    () =>
        _auth.createUserWithEmailAndPassword(email: email, password: password),
  );

  @override
  Future<void> updateDisplayName(String? displayName) async {
    if (displayName == null || displayName.trim().isEmpty) return;
    await _auth.currentUser?.updateDisplayName(displayName.trim());
    await _auth.currentUser?.reload();
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<T> _run<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on FirebaseAuthException catch (error) {
      throw Failure(error.message ?? 'Authentication failed.');
    }
  }
}
