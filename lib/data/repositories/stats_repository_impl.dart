import 'package:csgo_copilot/data/datasources/stats_data_source.dart';
import 'package:csgo_copilot/domain/models/player_stats.dart';
import 'package:csgo_copilot/domain/repositories/stats_repository.dart';

class StatsRepositoryImpl extends StatsRepository {
  final StatsDataSource dataSource;

  StatsRepositoryImpl(this.dataSource);

  @override
  Future<PlayerStats> getUserStats(String steamId) async {
    try {
      final stats = await dataSource.getUserStats(steamId);

      return PlayerStats.fromEntity(stats);
    } catch (e) {
      throw e;
    }
  }
}
