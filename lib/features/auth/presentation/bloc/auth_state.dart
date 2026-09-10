import 'package:equatable/equatable.dart';

import '../../domain/entities/app_user.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  const AuthState({this.user, this.status = AuthStatus.initial, this.message});

  final AppUser? user;
  final AuthStatus status;
  final String? message;

  AuthState copyWith({
    AppUser? user,
    AuthStatus? status,
    String? message,
    bool clearUser = false,
  }) => AuthState(
    user: clearUser ? null : user ?? this.user,
    status: status ?? this.status,
    message: message,
  );

  @override
  List<Object?> get props => [user, status, message];
}
