part of 'stats_bloc.dart';

@immutable
abstract class StatsState {}

class StatsInitial extends StatsState {}

class StatsDataSuccess extends StatsState {
  final PlayerStats data;

  StatsDataSuccess({
    @required this.data,
  });
}

class StatsDataLoading extends StatsState {}

class StatsError extends StatsState {
  final message;

  StatsError({this.message});

}
