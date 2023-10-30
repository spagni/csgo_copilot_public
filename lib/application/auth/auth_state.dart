part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authorized extends AuthState {
  final Player player;

  Authorized({
    this.player,
  });
}

class Unauthorized extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final message;

  AuthError({this.message});
}
