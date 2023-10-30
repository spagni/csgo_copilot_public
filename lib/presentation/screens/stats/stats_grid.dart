import 'package:csgo_copilot/domain/models/player_stats.dart';
import 'package:csgo_copilot/presentation/screens/stats/map_tile.dart';
import 'package:csgo_copilot/presentation/screens/stats/weapon_tile.dart';
import 'package:csgo_copilot/presentation/widgets/label_value.dart';
import 'package:flutter/material.dart';

class StatsGrid extends StatelessWidget {
  final PlayerStats data;

  const StatsGrid({
    Key key,
    @required this.data,
  })  : assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: LabelValueWidget(
                    label: "WINRATE",
                    value: '${data.winRatePerc}%',
                    alignment: WidgetAlignment.LEFT,
                  ),
                ),
                Expanded(
                  child: LabelValueWidget(
                    label: "HEADSHOT",
                    value: '${data.headshotPerc}%',
                    alignment: WidgetAlignment.CENTER,
                  ),
                ),
                Expanded(
                  child: LabelValueWidget(
                    label: "ACCURACY",
                    value: '${data.accuracy}%',
                    alignment: WidgetAlignment.RIGHT,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: LabelValueWidget(
                    label: "MVPs",
                    value: '${data.totalMVPs}',
                    alignment: WidgetAlignment.LEFT,
                  ),
                ),
                Expanded(
                  child: LabelValueWidget(
                    label: "ADR",
                    value: '${data.averageADR}',
                    alignment: WidgetAlignment.CENTER,
                  ),
                ),
                Expanded(
                  child: LabelValueWidget(
                    label: "TIME PLAYED",
                    value: '${data.totalTimePlayed.inHours} hs.',
                    alignment: WidgetAlignment.CENTER,
                  ),
                ),
                // Spacer(),
              ],
            ),
          ),
          Expanded(
            child: WeaponTile(
              weaponStats: data.mostKillsWeapon,
              title: 'BEST WEAPON',
            ),
          ),
          Expanded(
            child: MapTile(
              mapStats: data.bestMap,
              title: 'BEST MAP',
            ),
          ),
        ],
      ),
    );
  }
}
