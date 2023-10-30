import 'package:csgo_copilot/domain/models/player.dart';

abstract class PlayerRepository {
  Future<Player> getPlayerData(String steamId);
}
