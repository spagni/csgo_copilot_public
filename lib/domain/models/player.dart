import 'package:csgo_copilot/data/entities/player_data.dart';

class Player {
  final String steamId;
  final String personaName;
  final String profileUrl;
  final String avatar;
  final String avatarMedium;
  final String avatarFull;
  final DateTime lastLogOff;
  final String personaState;
  final String realName;
  final String primaryClanId;
  final DateTime timeCreated;
  final int personaStateFlags;
  final String locCountryCode;

  Player({
    this.steamId,
    this.personaName,
    this.profileUrl,
    this.avatar,
    this.avatarMedium,
    this.avatarFull,
    this.lastLogOff,
    this.personaState,
    this.realName,
    this.primaryClanId,
    this.timeCreated,
    this.personaStateFlags,
    this.locCountryCode,
  });

  Player.fromEntity(PlayerData entity)
      : this.steamId = entity.steamid,
        this.personaName = entity.personaname,
        this.profileUrl = entity.profileurl,
        this.avatar = entity.avatar,
        this.avatarMedium = entity.avatarmedium,
        this.avatarFull = entity.avatarfull,
        this.lastLogOff = entity.lastlogoff == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(entity.lastlogoff),
        this.personaState = _getPersonaState(entity.personastate),
        this.realName = entity.realname,
        this.primaryClanId = entity.primaryclanid,
        this.timeCreated =
            DateTime.fromMicrosecondsSinceEpoch(entity.timecreated),
        this.personaStateFlags = entity.personastateflags,
        this.locCountryCode = entity.loccountrycode;

  static String _getPersonaState(int personaState) {
    switch (personaState) {
      case 0:
        return 'Offline';
      case 1:
        return 'Online';
      case 2:
        return 'Busy';
      case 3:
        return 'Away';
      case 4:
        return 'Snooze';
      case 5:
        return 'Looking to trade';
      case 6:
        return 'Looking to play';
      default:
        return 'Offline';
    }
  }
}
