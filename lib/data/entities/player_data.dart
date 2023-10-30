class PlayerData {
  String steamid;
  int communityvisibilitystate;
  int profilestate;
  String personaname;
  String profileurl;
  String avatar;
  String avatarmedium;
  String avatarfull;
  String avatarhash;
  int lastlogoff;
  int personastate;
  String realname;
  String primaryclanid;
  int timecreated;
  int personastateflags;
  String loccountrycode;

  PlayerData(
      {this.steamid,
      this.communityvisibilitystate,
      this.profilestate,
      this.personaname,
      this.profileurl,
      this.avatar,
      this.avatarmedium,
      this.avatarfull,
      this.avatarhash,
      this.lastlogoff,
      this.personastate,
      this.realname,
      this.primaryclanid,
      this.timecreated,
      this.personastateflags,
      this.loccountrycode});

  PlayerData.fromJson(Map<String, dynamic> json) {
    steamid = json['steamid'];
    communityvisibilitystate = json['communityvisibilitystate'];
    profilestate = json['profilestate'];
    personaname = json['personaname'];
    profileurl = json['profileurl'];
    avatar = json['avatar'];
    avatarmedium = json['avatarmedium'];
    avatarfull = json['avatarfull'];
    avatarhash = json['avatarhash'];
    lastlogoff = json['lastlogoff'];
    personastate = json['personastate'];
    realname = json['realname'];
    primaryclanid = json['primaryclanid'];
    timecreated = json['timecreated'];
    personastateflags = json['personastateflags'];
    loccountrycode = json['loccountrycode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['steamid'] = this.steamid;
    data['communityvisibilitystate'] = this.communityvisibilitystate;
    data['profilestate'] = this.profilestate;
    data['personaname'] = this.personaname;
    data['profileurl'] = this.profileurl;
    data['avatar'] = this.avatar;
    data['avatarmedium'] = this.avatarmedium;
    data['avatarfull'] = this.avatarfull;
    data['avatarhash'] = this.avatarhash;
    data['lastlogoff'] = this.lastlogoff;
    data['personastate'] = this.personastate;
    data['realname'] = this.realname;
    data['primaryclanid'] = this.primaryclanid;
    data['timecreated'] = this.timecreated;
    data['personastateflags'] = this.personastateflags;
    data['loccountrycode'] = this.loccountrycode;
    return data;
  }
}
