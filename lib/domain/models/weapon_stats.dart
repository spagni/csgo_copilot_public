import 'package:meta/meta.dart';
import 'package:csgo_copilot/domain/models/weapon.dart';
import 'package:csgo_copilot/utils/extensions/double.dart';

class WeaponStats {
  final Weapon weapon;
  final int totalKills;
  final int totalShotsHit;
  final int totalShotsFired;

  double get accuracy =>
      (totalShotsHit / totalShotsFired * 100).roundDecimalPlaces(1);

  WeaponStats({
    @required this.weapon,
    @required this.totalKills,
    @required this.totalShotsHit,
    @required this.totalShotsFired,
  });

  @override
  String toString() {
    return '${weapon.name}: KILLS: $totalKills - ACCURACY: $accuracy';
  }
}
