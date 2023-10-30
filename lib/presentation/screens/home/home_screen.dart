import 'package:csgo_copilot/application/player/player_bloc.dart';
import 'package:csgo_copilot/application/stats/stats_bloc.dart';
import 'package:csgo_copilot/presentation/screens/home/app_bar.dart';
import 'package:csgo_copilot/presentation/screens/home/drawer/drawer.dart';
import 'package:csgo_copilot/presentation/screens/stats/main_stats_screen.dart';
import 'package:csgo_copilot/utils/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              Injector.getIt<PlayerBloc>()..add(GetPlayerData()),
        ),
        BlocProvider(
          create: (context) =>
              Injector.getIt<StatsBloc>()..add(GetPlayerStats()),
        ),
      ],
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: MainAppBar(),
        body: SafeArea(
          child: MainStatsScreen(),
        ),
      ),
    );
  }
}
