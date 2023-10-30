import 'package:csgo_copilot/data/core/api_client.dart';
import 'package:csgo_copilot/data/core/api_constants.dart';
import 'package:csgo_copilot/data/entities/player_data.dart';
import 'package:csgo_copilot/utils/exceptions/player_not_found.dart';

abstract class PlayerDataSource {
  Future<PlayerData> getPlayerData(String steamId);
}

class PlayerDataSourceImpl extends PlayerDataSource {
  final ApiClient _client;

  PlayerDataSourceImpl(this._client);

  @override
  Future<PlayerData> getPlayerData(String steamId) async {
    final response = await _client.get(
      ApiConstants.GET_PLAYER_DATA_URL,
      params: {
        "key": ApiConstants.API_KEY,
        "steamids": steamId,
      },
    );

    if ((response['response']['players'] as List).isEmpty) {
      throw PlayerNotFound();
    }

    final _playerData = PlayerData.fromJson(response['response']['players'][0]);

    return _playerData;
  }
}
