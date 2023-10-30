import 'dart:math';

import 'package:csgo_copilot/data/entities/code_value_stats.dart';
import 'package:csgo_copilot/data/entities/player_stats.dart';
import 'package:csgo_copilot/domain/models/enums_helper.dart';
import 'package:csgo_copilot/domain/models/map_stats.dart';
import 'package:csgo_copilot/domain/models/weapon.dart';
import 'package:csgo_copilot/domain/models/weapon_stats.dart';
import 'package:csgo_copilot/domain/models/map.dart';
import 'package:csgo_copilot/utils/extensions/double.dart';

class PlayerStats {
  final int totalKills;
  final int totalDeaths;
  final Duration totalTimePlayed;
  final int totalWins;
  final int totalMVPs;
  final int totalKillsKnife;
  final int totalKillsHeadshot;
  final int totalShotsHit;
  final int totalShotsFired;
  final int totalRoundsPlayed;
  final int totalDamageDone;
  final List<WeaponStats> weapons;
  final List<MapStats> maps;

  double get totalKDRatio =>
      (this.totalKills / this.totalDeaths).roundDecimalPlaces(2);
  double get winRate => this.totalWins / this.totalRoundsPlayed;
  double get winRatePerc => (winRate * 100).roundDecimalPlaces(1);
  double get headshotPerc =>
      (totalKillsHeadshot / totalKills * 100).roundDecimalPlaces(1);
  double get accuracy =>
      (totalShotsHit / totalShotsFired * 100).roundDecimalPlaces(1);
  int get averageADR => (totalDamageDone / totalRoundsPlayed).round();
  int get kdDiff => (this.totalKills - this.totalDeaths);
  WeaponStats get mostKillsWeapon {
    return this.weapons.firstWhere(
          (element) =>
              element.totalKills ==
              (this.weapons.map((e) => e.totalKills).reduce(
                    (max),
                  )),
        );
  }

  WeaponStats get mostAccWeapon {
    return this.weapons.firstWhere(
          (element) =>
              element.accuracy ==
              (this.weapons.map((e) => e.accuracy).reduce(
                    (max),
                  )),
        );
  }

  List<WeaponStats> getSortedWeapons({
    WeaponSortBy orderBy = WeaponSortBy.KILLS,
    SortType sortType = SortType.DESC,
  }) {
    switch (orderBy) {
      case WeaponSortBy.KILLS:
        return this.weapons
          ..sort(
            (a, b) {
              if (sortType == SortType.DESC)
                return a.totalKills < b.totalKills ? 1 : 0;
              else
                return a.totalKills > b.totalKills ? 1 : 0;
            },
          );
      case WeaponSortBy.ACCURACY:
        return this.weapons
          ..sort(
            (a, b) {
              if (sortType == SortType.DESC)
                return a.accuracy < b.accuracy ? 1 : 0;
              else
                return a.accuracy > b.accuracy ? 1 : 0;
            },
          );
      default:
        return this.weapons
          ..sort(
            (a, b) {
              if (sortType == SortType.DESC)
                return a.totalKills < b.totalKills ? 1 : 0;
              else
                return a.totalKills > b.totalKills ? 1 : 0;
            },
          );
    }
  }

  List<MapStats> getSortedMaps({
    SortType sortType = SortType.DESC,
  }) {
    return this.maps
      ..sort(
        (a, b) {
          if (sortType == SortType.DESC)
            return a.totalRoundsWon < b.totalRoundsWon ? 1 : 0;
          else
            return a.totalRoundsWon > b.totalRoundsWon ? 1 : 0;
        },
      );
  }

  MapStats get bestMap {
    return this.maps.firstWhere(
          (element) =>
              element.totalRoundsWon ==
              (this.maps.map((e) => e.totalRoundsWon).reduce(
                    (max),
                  )),
        );
  }

  PlayerStats({
    this.totalKills,
    this.totalDeaths,
    this.totalTimePlayed,
    this.totalWins,
    this.totalMVPs,
    this.totalKillsKnife,
    this.totalKillsHeadshot,
    this.totalShotsHit,
    this.totalShotsFired,
    this.totalRoundsPlayed,
    this.totalDamageDone,
    this.weapons,
    this.maps,
  });

  PlayerStats.fromEntity(PlayerStatsEntity entity)
      : this.totalDeaths = entity.stats
            .firstWhere((element) => element.name == 'total_deaths')
            .value,
        this.totalKills = entity.stats
            .firstWhere((element) => element.name == 'total_kills')
            .value,
        this.totalTimePlayed = Duration(
          seconds: entity.stats
              .firstWhere((element) => element.name == 'total_time_played')
              .value,
        ),
        this.totalWins = entity.stats
            .firstWhere((element) => element.name == 'total_wins')
            .value,
        this.totalMVPs = entity.stats
            .firstWhere((element) => element.name == 'total_mvps')
            .value,
        this.totalKillsKnife = entity.stats
            .firstWhere((element) => element.name == 'total_kills_knife')
            .value,
        this.totalKillsHeadshot = entity.stats
            .firstWhere((element) => element.name == 'total_kills_headshot')
            .value,
        this.totalShotsHit = entity.stats
            .firstWhere((element) => element.name == 'total_shots_hit')
            .value,
        this.totalShotsFired = entity.stats
            .firstWhere((element) => element.name == 'total_shots_fired')
            .value,
        this.totalRoundsPlayed = entity.stats
            .firstWhere((element) => element.name == 'total_rounds_played')
            .value,
        this.totalDamageDone = entity.stats
            .firstWhere((element) => element.name == 'total_damage_done')
            .value,
        this.weapons = _mapWeapons(entity),
        this.maps = _mapMaps(entity);

  static List<WeaponStats> _mapWeapons(PlayerStatsEntity entity) {
    List<WeaponStats> _list = [];
    entity.stats.forEach(
      (e) {
        // Es la forma que encontre de recorrer solo las weapons
        if (e.name.contains('total_hits_') && !e.name.contains('elite')) {
          String name = e.name.substring('total_hits_'.length);

          _list.add(
            WeaponStats(
              weapon: Weapon(
                name: name.toUpperCase(),
                assetPath: 'assets/svgs/weapon_$name.svg',
              ),
              totalKills: entity.stats
                  .firstWhere(
                    (element) => element.name == 'total_kills_$name',
                    orElse: () => CodeValueStatsEntity(
                      name: 'total_kills_$name',
                      value: 0,
                    ),
                  )
                  .value,
              totalShotsHit: e.value,
              totalShotsFired: entity.stats
                  .firstWhere(
                    (element) => element.name == 'total_shots_$name',
                    orElse: () => CodeValueStatsEntity(
                      name: 'total_shots_$name',
                      value: 0,
                    ),
                  )
                  .value,
            ),
          );
        }
      },
    );

    return _list;
  }

  static List<MapStats> _mapMaps(PlayerStatsEntity entity) {
    List<MapStats> _list = [];
    entity.stats.forEach(
      (e) {
        // Es la forma que encontre de recorrer solo las weapons
        if (e.name.contains('total_rounds_map_de_')) {
          String name = e.name.substring('total_rounds_map_de_'.length);

          _list.add(
            MapStats(
              map: Map(
                name: name.toUpperCase(),
                assetPath: 'assets/images/maps/$name.jpg',
              ),
              totalRoundsWon: entity.stats
                  .firstWhere(
                    (element) => element.name == 'total_wins_map_de_$name',
                    orElse: () => CodeValueStatsEntity(
                      name: 'total_wins_map_de_$name',
                      value: 0,
                    ),
                  )
                  .value,
              totalRoundsPlayed: e.value,
            ),
          );
        }
      },
    );

    return _list;
  }
}
