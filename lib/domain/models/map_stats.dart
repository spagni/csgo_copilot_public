import 'package:meta/meta.dart';
import 'package:csgo_copilot/domain/models/map.dart';
import 'package:csgo_copilot/utils/extensions/double.dart';

class MapStats {
  final Map map;
  final int totalRoundsWon;
  final int totalRoundsPlayed;

  double get winRate => this.totalRoundsWon / this.totalRoundsPlayed;
  double get winRatePerc => (winRate * 100).roundDecimalPlaces(1);
  int get totalRoundsLosed => totalRoundsPlayed - totalRoundsWon;

  MapStats({
    @required this.map,
    @required this.totalRoundsWon,
    @required this.totalRoundsPlayed,
  });

  @override
  String toString() {
    return '${map.name}: WON: $totalRoundsWon - WINRATE: $winRatePerc%';
  }
}
