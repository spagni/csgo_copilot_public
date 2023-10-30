import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:csgo_copilot/domain/models/player.dart';
import 'package:csgo_copilot/domain/repositories/auth_repository.dart';
import 'package:csgo_copilot/domain/repositories/player_repository.dart';
import 'package:csgo_copilot/utils/analytics_helper.dart';
import 'package:csgo_copilot/utils/di.dart';
import 'package:csgo_copilot/utils/exceptions/player_not_found.dart';
import 'package:csgo_copilot/utils/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final PlayerRepository _playerRepository;

  AuthBloc(this._authRepository, this._playerRepository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthStatusRequested) {
      yield* _mapAuthStatusRequestedState(event);
    }
    if (event is LogInWithSteamId) {
      yield* _mapLogInWithSteamId(event);
    }
    if (event is SignOut) {
      yield* _mapSignOut();
    }
  }

  Stream<AuthState> _mapAuthStatusRequestedState(
      AuthStatusRequested event) async* {
    try {
      bool _isLoggedIn = await _authRepository.isUserLoggedIn();
      if (_isLoggedIn) {
        yield Authorized();
      } else
        yield Unauthorized();
    } catch (e) {
      yield AuthError(message: e.toString());
    }
  }

  Stream<AuthState> _mapLogInWithSteamId(LogInWithSteamId event) async* {
    String steamId = event.steamId;
    if (steamId == null || steamId.isEmpty) {
      yield AuthError(message: 'Please enter a Steam Id');
      return;
    }

    yield AuthLoading();

    yield* _getPlayerWithSteamId(steamId);
  }

  Stream<AuthState> _getPlayerWithSteamId(String steamId) async* {
    try {
      Player _response = await _playerRepository.getPlayerData(steamId);

      if (_response == null) {
        yield AuthError(message: 'Error buscando player');
        return;
      }
      Preferences.setStringValueByType(
          PreferenceTypes.USER_STEAM_ID, _response.steamId);

      Injector.getIt<AnalyticsHelper>().logEvent(
        event: 'log_in_steam_id',
        params: {'steamId': steamId},
      );

      yield Authorized(player: _response);
    } on PlayerNotFound {
      yield AuthError(
        message: 'Player not found. Please try with a valid Steam ID',
      );
    } catch (e) {
      print(e);
      yield AuthError(message: 'Something wrong happened. $e');
    }
  }

  Stream<AuthState> _mapSignOut() async* {
    await Preferences.clearValues();
    yield Unauthorized();
  }
}
