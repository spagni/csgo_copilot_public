import 'package:csgo_copilot/domain/models/player_stats.dart';
import 'package:csgo_copilot/presentation/widgets/center_fitted_text.dart';
import 'package:csgo_copilot/presentation/widgets/circular_animated_indicator.dart';
import 'package:csgo_copilot/presentation/widgets/label_value.dart';
import 'package:flutter/material.dart';

class KDRow extends StatelessWidget {
  final PlayerStats data;

  const KDRow({
    Key key,
    @required this.data,
  })  : assert(data != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: LabelValueWidget(
            label: "KILLS",
            value: data.totalKills.toString(),
            alignment: WidgetAlignment.LEFT,
          ),
        ),
        Expanded(
          flex: 3,
          child: CircularAnimatedIndicator(
            value: data.totalKDRatio,
            title: 'K/D RATIO',
            subTitle: CenterFittedText(
              title: '+/- ${data.kdDiff}',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: (data.kdDiff.isNegative) ? Colors.red : Colors.green,
                  ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: LabelValueWidget(
            label: "DEATHS",
            value: data.totalDeaths.toString(),
            alignment: WidgetAlignment.RIGHT,
          ),
        ),
      ],
    );
  }
}
