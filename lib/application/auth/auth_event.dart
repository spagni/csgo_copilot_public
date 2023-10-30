part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthStatusRequested extends AuthEvent {}

class LogInWithSteamId extends AuthEvent {
  final String steamId;

  LogInWithSteamId({
    this.steamId,
  });
}

class SignOut extends AuthEvent {}
