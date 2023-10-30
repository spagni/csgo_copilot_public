class AchievementsEntity {
  String name;
  int achieved;

  AchievementsEntity({this.name, this.achieved});

  AchievementsEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    achieved = json['achieved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['achieved'] = this.achieved;
    return data;
  }
}
