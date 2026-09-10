import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthStarted extends AuthEvent {}

final class AuthSignInRequested extends AuthEvent {
  const AuthSignInRequested(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

final class AuthSignUpRequested extends AuthEvent {
  const AuthSignUpRequested(this.email, this.password, this.displayName);

  final String email;
  final String password;
  final String displayName;

  @override
  List<Object> get props => [email, password, displayName];
}

final class AuthSignOutRequested extends AuthEvent {}
