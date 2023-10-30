import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:csgo_copilot/domain/models/player_stats.dart';
import 'package:csgo_copilot/domain/repositories/stats_repository.dart';
import 'package:csgo_copilot/utils/exceptions/private_profile.dart';
import 'package:csgo_copilot/utils/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final StatsRepository _statsRepository;

  StatsBloc(this._statsRepository) : super(StatsInitial());

  @override
  Stream<StatsState> mapEventToState(
    StatsEvent event,
  ) async* {
    if (event is GetPlayerStats) {
      yield* _mapStatsDataSuccess(event);
    }
  }

  Stream<StatsState> _mapStatsDataSuccess(StatsEvent event) async* {
    try {
      String steamId =
          Preferences.getStringValueByType(PreferenceTypes.USER_STEAM_ID);

      PlayerStats _response = await _statsRepository.getUserStats(steamId);

      if (_response == null) {
        yield StatsError(message: 'Something happened. Please try again!');
        return;
      }

      yield StatsDataSuccess(data: _response);
    } on PrivateProfile {
      yield StatsError(
        message:
            '''Your profile seems to be private. To view your stats you must set your game data to public by going to your
Steam Profile --> Edit Profile --> Privacy Settings --> Set: "My profile: Public" and "Game details: public"''',
      );
    } catch (e) {
      print(e);
      yield StatsError(message: 'Something happened. Please try again!');
    }
  }
}
