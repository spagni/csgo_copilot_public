import 'achievements.dart';
import 'code_value_stats.dart';

class PlayerStatsEntity {
  String steamID;
  String gameName;
  List<CodeValueStatsEntity> stats;
  List<AchievementsEntity> achievements;

  PlayerStatsEntity(
      {this.steamID, this.gameName, this.stats, this.achievements});

  PlayerStatsEntity.fromJson(Map<String, dynamic> json) {
    steamID = json['steamID'];
    gameName = json['gameName'];
    if (json['stats'] != null) {
      stats = <CodeValueStatsEntity>[];
      json['stats'].forEach((v) {
        stats.add(CodeValueStatsEntity.fromJson(v));
      });
    }
    if (json['achievements'] != null) {
      achievements = <AchievementsEntity>[];
      json['achievements'].forEach((v) {
        achievements.add(AchievementsEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['steamID'] = this.steamID;
    data['gameName'] = this.gameName;
    if (this.stats != null) {
      data['stats'] = this.stats.map((v) => v.toJson()).toList();
    }
    if (this.achievements != null) {
      data['achievements'] = this.achievements.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
