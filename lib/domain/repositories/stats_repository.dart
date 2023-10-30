import 'package:csgo_copilot/domain/models/player_stats.dart';

abstract class StatsRepository {
  Future<PlayerStats> getUserStats(String steamId);
}
