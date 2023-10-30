class CodeValueStatsEntity {
  String name;
  int value;

  CodeValueStatsEntity({this.name, this.value});

  CodeValueStatsEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}
