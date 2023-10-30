import 'package:csgo_copilot/domain/models/map_stats.dart';
import 'package:flutter/material.dart';
import 'package:csgo_copilot/presentation/widgets/label_value.dart';
import 'package:csgo_copilot/presentation/widgets/vertical_divider.dart' as v;

class MapCard extends StatelessWidget {
  final MapStats mapStats;
  final String title;
  final double height;
  final double opacity;

  const MapCard({
    Key key,
    @required this.mapStats,
    this.title,
    this.height,
    this.opacity,
  })  : assert(mapStats != null),
        super(key: key);

  BorderRadius get _borderRadius => BorderRadius.circular(12.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      height: height ?? MediaQuery.of(context).size.height * .15,
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: _borderRadius,
            child: Image.asset(
              mapStats.map.assetPath,
              fit: BoxFit.cover,
              // En el caso de error muestro una imagen generica
              errorBuilder: (BuildContext context, _, __) {
                return Image.asset(
                  'assets/images/maps/csgo_banner.jpg',
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor.withOpacity(opacity ?? .7),
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LabelValueWidget(
                    label: title,
                    value: '${mapStats.map.name}',
                    alignment: WidgetAlignment.LEFT,
                  ),
                ),
              ),
              const v.VerticalDivider(),
              Expanded(
                flex: 1,
                child: LabelValueWidget(
                  label: "ROUNDS WINS",
                  value: '${mapStats.totalRoundsWon}',
                  alignment: WidgetAlignment.CENTER,
                ),
              ),
              const v.VerticalDivider(),
              Expanded(
                flex: 1,
                child: LabelValueWidget(
                  label: "WINRATE",
                  value: '${mapStats.winRatePerc}%',
                  alignment: WidgetAlignment.CENTER,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
