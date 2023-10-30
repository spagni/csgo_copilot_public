import 'package:csgo_copilot/application/stats/stats_bloc.dart';
import 'package:csgo_copilot/domain/models/weapon_stats.dart';
import 'package:csgo_copilot/presentation/screens/weapons/weapons_screen.dart';
import 'package:csgo_copilot/presentation/widgets/label_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:csgo_copilot/presentation/widgets/vertical_divider.dart' as v;

class WeaponTile extends StatelessWidget {
  final WeaponStats weaponStats;
  final String title;

  const WeaponTile({
    Key key,
    @required this.weaponStats,
    this.title,
  })  : assert(weaponStats != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider<StatsBloc>.value(
              value: context.read<StatsBloc>(),
              child: WeaponsScreen(),
            ),
          ),
        );
      },
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Hero(
              tag: '${weaponStats.weapon.assetPath}HERO',
              child: SvgPicture.asset(
                weaponStats.weapon.assetPath,
                color: Colors.white,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LabelValueWidget(
                label: title,
                value: '${weaponStats.weapon.name}',
                alignment: WidgetAlignment.LEFT,
              ),
            ),
          ),
          const v.VerticalDivider(),
          Expanded(
            flex: 1,
            child: LabelValueWidget(
              label: "KILLS",
              value: '${weaponStats.totalKills}',
              alignment: WidgetAlignment.CENTER,
            ),
          ),
          const v.VerticalDivider(),
          Expanded(
            flex: 1,
            child: LabelValueWidget(
              label: "ACCURACY",
              value: '${weaponStats.accuracy}%',
              alignment: WidgetAlignment.CENTER,
            ),
          ),
        ],
      ),
    );
  }
}
