import 'dart:io';

import 'package:csgo_copilot/data/core/api_client.dart';
import 'package:csgo_copilot/data/core/api_constants.dart';
import 'package:csgo_copilot/data/entities/player_stats.dart';
import 'package:csgo_copilot/utils/exceptions/api_client_exception.dart';
import 'package:csgo_copilot/utils/exceptions/private_profile.dart';

abstract class StatsDataSource {
  Future<PlayerStatsEntity> getUserStats(String steamId);
}

class StatsDataSourceImpl extends StatsDataSource {
  final ApiClient _client;

  StatsDataSourceImpl(this._client);

  @override
  Future<PlayerStatsEntity> getUserStats(String steamId) async {
    try {
      final response = await _client.get(ApiConstants.GET_STATS_URL, params: {
        "key": ApiConstants.API_KEY,
        "steamid": steamId,
        "appid": ApiConstants.APP_ID
      });

      final stats = PlayerStatsEntity.fromJson(response['playerstats']);

      return stats;
    } on ApiClientException catch (e) {
      if (e.statusCode == HttpStatus.internalServerError) {
        throw PrivateProfile();
      }
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
