import 'dart:math';

import 'package:csgo_copilot/application/stats/stats_bloc.dart';
import 'package:csgo_copilot/domain/models/weapon_stats.dart';
import 'package:csgo_copilot/presentation/screens/weapons/weapons_table.dart';
import 'package:csgo_copilot/presentation/widgets/custom_switcher.dart';
import 'package:csgo_copilot/presentation/widgets/label_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeaponsScreen extends StatefulWidget {
  @override
  _WeaponsScreenState createState() => _WeaponsScreenState();
}

class _WeaponsScreenState extends State<WeaponsScreen> {
  bool _sortByKills;

  @override
  void initState() {
    _sortByKills = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WEAPONS'),
      ),
      body: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          if (state is! StatsDataSuccess) return SizedBox();

          var data = (state as StatsDataSuccess).data;

          return ListView(
            physics: BouncingScrollPhysics(),
            children: [
              CustomSwitcher(
                left: 'MOST KILLS',
                right: 'MOST ACCURATE',
                onChanged: (value) => {setState(() => _sortByKills = value)},
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .3,
                child: BestWeapon(
                  weapon: _sortByKills ? data.mostKillsWeapon : data.mostAccWeapon,
                ),
              ),
              const SizedBox(height: 12),
              WeaponsTable(
                data: data,
                sortByKills: _sortByKills,
              ),
            ],
          );
        },
      ),
    );
  }
}

class BestWeapon extends StatelessWidget {
  final WeaponStats weapon;

  const BestWeapon({
    Key key,
    @required this.weapon,
  })  : assert(weapon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: 6.0),
            duration: Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..rotateY(pi * value)
                  ..setEntry(3, 2, 0.002),
                child: child,
                alignment: FractionalOffset.center,
              );
            },
            child: Hero(
              tag: '${weapon.weapon.assetPath}HERO',
              child: SvgPicture.asset(
                weapon.weapon.assetPath,
                color: Colors.white70,
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * .7,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LabelValueWidget(
                    label: 'WEAPON',
                    value: '${weapon.weapon.name}',
                    alignment: WidgetAlignment.LEFT,
                  ),
                ),
              ),
              // const v.VerticalDivider(),
              Expanded(
                flex: 1,
                child: LabelValueWidget(
                  label: "KILLS",
                  value: '${weapon.totalKills}',
                  alignment: WidgetAlignment.CENTER,
                ),
              ),
              // const v.VerticalDivider(),
              Expanded(
                flex: 1,
                child: LabelValueWidget(
                  label: "ACCURACY",
                  value: '${weapon.accuracy}%',
                  alignment: WidgetAlignment.CENTER,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
