import 'package:bloc/bloc.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repository) : super(const AuthState()) {
    on<AuthStarted>(_onStarted);
    on<AuthSignInRequested>(_onSignIn);
    on<AuthSignUpRequested>(_onSignUp);
    on<AuthSignOutRequested>((event, emit) async {
      await _repository.signOut();
      emit(const AuthState(status: AuthStatus.unauthenticated));
    });
  }

  final AuthRepository _repository;

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    await emit.forEach<AppUser?>(
      _repository.authStateChanges(),
      onData: (user) => user == null
          ? const AuthState(status: AuthStatus.unauthenticated)
          : AuthState(user: user, status: AuthStatus.authenticated),
    );
  }

  Future<void> _onSignIn(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authenticate(
      emit,
      () => _repository.signIn(email: event.email, password: event.password),
    );
  }

  Future<void> _onSignUp(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authenticate(
      emit,
      () => _repository.signUp(
        email: event.email,
        password: event.password,
        displayName: event.displayName,
      ),
    );
  }

  Future<void> _authenticate(
    Emitter<AuthState> emit,
    Future<AppUser> Function() operation,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, message: null));
    try {
      final user = await operation();
      emit(AuthState(user: user, status: AuthStatus.authenticated));
    } on Failure catch (error) {
      emit(AuthState(status: AuthStatus.failure, message: error.message));
    } catch (_) {
      emit(
        const AuthState(
          status: AuthStatus.failure,
          message: 'Something went wrong.',
        ),
      );
    }
  }
}
