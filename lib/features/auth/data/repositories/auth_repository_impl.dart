import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final AuthRemoteDataSource _dataSource;

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _dataSource.signIn(
      email: email,
      password: password,
    );
    return _mapUser(credential.user!);
  }

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final credential = await _dataSource.signUp(
      email: email,
      password: password,
    );
    await _dataSource.updateDisplayName(displayName);
    return _mapUser(credential.user!);
  }

  @override
  Future<void> signOut() => _dataSource.signOut();

  @override
  Stream<AppUser?> authStateChanges() => _dataSource.authStateChanges().map(
    (user) => user == null ? null : _mapUser(user),
  );

  AppUser _mapUser(User user) => AppUser(
    id: user.uid,
    email: user.email ?? '',
    displayName: user.displayName,
  );
}
