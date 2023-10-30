import 'package:csgo_copilot/domain/models/enums_helper.dart';
import 'package:csgo_copilot/domain/models/player_stats.dart';
import 'package:csgo_copilot/presentation/widgets/label_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeaponsTable extends StatelessWidget {
  final PlayerStats data;
  final bool sortByKills;

  const WeaponsTable({
    Key key,
    @required this.data,
    this.sortByKills = true,
  })  : assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = this.data.getSortedWeapons(
          orderBy:
              this.sortByKills ? WeaponSortBy.KILLS : WeaponSortBy.ACCURACY,
        );

    if (data.length > 1) data = data.sublist(1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.symmetric(
          inside: BorderSide(
            color: Theme.of(context).accentColor.withOpacity(.4),
            width: .5,
          ),
        ),
        children: [
          TableRow(children: [
            SizedBox(),
            _buildTableLabel(context, 'WEAPON'),
            _buildTableLabel(context, 'KILLS'),
            _buildTableLabel(context, 'ACC'),
          ]),
          // sublist para no mostrar la best weapon
          for (var item in data)
            TableRow(
              children: [
                SvgPicture.asset(
                  item.weapon.assetPath,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LabelValueWidget(
                    value: '${item.weapon.name}',
                    alignment: WidgetAlignment.CENTER,
                  ),
                ),
                // const v.VerticalDivider(),
                LabelValueWidget(
                  value: '${item.totalKills}',
                  alignment: WidgetAlignment.CENTER,
                ),
                // const v.VerticalDivider(),
                LabelValueWidget(
                  value: '${item.accuracy}%',
                  alignment: WidgetAlignment.CENTER,
                ),
              ],
            ),
        ],
      ),
    );
  }

  FittedBox _buildTableLabel(BuildContext context, String label) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        label,
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Theme.of(context).accentColor,
            ),
      ),
    );
  }
}
