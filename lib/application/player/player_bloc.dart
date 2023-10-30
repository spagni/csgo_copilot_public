import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:csgo_copilot/domain/models/player.dart';
import 'package:csgo_copilot/domain/repositories/player_repository.dart';
import 'package:csgo_copilot/utils/exceptions/player_not_found.dart';
import 'package:csgo_copilot/utils/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final PlayerRepository _playerRepository;
  
  PlayerBloc(this._playerRepository) : super(PlayerInitial());

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is GetPlayerData){
      yield* _mapGetPlayerData();
    }
  }

  Stream<PlayerState> _mapGetPlayerData() async* {
    try {
      yield PlayerDataLoading();
      String steamId = Preferences.getStringValueByType(PreferenceTypes.USER_STEAM_ID);
      Player _response = await _playerRepository.getPlayerData(steamId);

      if (_response == null) {
        yield PlayerError(message: 'Something happened. Please try again!');
        return;
      }

      yield PlayerDataSuccesss(player: _response);
    } on PlayerNotFound {
      yield PlayerError(
        message: 'Player not found. Please try with a valid Steam ID',
      );
    } catch (e) {
      print(e);
      yield PlayerError(message: 'Something happened. Please try again!');
    }
  }
}
