part of 'player_bloc.dart';

@immutable
abstract class PlayerState {}

class PlayerInitial extends PlayerState {}

class PlayerDataLoading extends PlayerState {}

class PlayerDataSuccesss extends PlayerState {
  final Player player;

  PlayerDataSuccesss({this.player});
}

class PlayerError extends PlayerState {
  final message;

  PlayerError({this.message});
}
