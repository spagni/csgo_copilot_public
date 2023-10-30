import 'package:csgo_copilot/application/stats/stats_bloc.dart';
import 'package:csgo_copilot/domain/models/map_stats.dart';
import 'package:csgo_copilot/presentation/screens/maps/map_card.dart';
import 'package:csgo_copilot/presentation/screens/maps/maps_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapTile extends StatelessWidget {
  final MapStats mapStats;
  final String title;

  const MapTile({
    Key key,
    @required this.mapStats,
    this.title,
  })  : assert(mapStats != null),
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
              child: MapsScreen(
                itemHeight: MediaQuery.of(context).size.height * .2,
              ),
            ),
          ),
        );
      },
      child: Hero(
        tag: '${mapStats.map.assetPath}HERO',
        child: MapCard(
          mapStats: mapStats,
          title: title,
        ),
      ),
    );
  }
}
