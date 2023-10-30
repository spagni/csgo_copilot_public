import 'package:csgo_copilot/data/datasources/player_data_source.dart';
import 'package:csgo_copilot/domain/models/player.dart';
import 'package:csgo_copilot/domain/repositories/player_repository.dart';

class PlayerRepositoryImpl extends PlayerRepository {
  final PlayerDataSource _playerDataSource;

  PlayerRepositoryImpl(this._playerDataSource);

  @override
  Future<Player> getPlayerData(String steamId) async {
    try {
      final _data = await _playerDataSource.getPlayerData(steamId);

      return Player.fromEntity(_data);
    } catch (e) {
      throw e;
    }
  }
}
