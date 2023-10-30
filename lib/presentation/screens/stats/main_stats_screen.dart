import 'package:csgo_copilot/application/stats/stats_bloc.dart';
import 'package:csgo_copilot/presentation/screens/stats/kd_row.dart';
import 'package:csgo_copilot/presentation/screens/stats/stats_grid.dart';
import 'package:csgo_copilot/presentation/widgets/multi_circular_progress_indicator.dart';
import 'package:csgo_copilot/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainStatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatsBloc, StatsState>(
      listener: (context, state) {
        if (state is StatsError) {
          Toast.show(
            context,
            content: state.message,
            backgroundColor: Colors.redAccent,
          );
        }
      },
      builder: (context, state) {
        if (state is StatsError)
          //TODO: SHOW PAGE WITH ERROR MESSAGE AND RELOAD BUTTON
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          );

        return AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          switchInCurve: Curves.easeOut,
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: (state is StatsDataSuccess)
              ? _buildBody(state, context)
              : Center(
                  child: MultiCircularProgressIndicator(),
                ),
        );
      },
    );
  }

  Widget _buildBody(StatsDataSuccess state, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<StatsBloc>()..add(GetPlayerStats());
        // For UI purpose only
        await Future.delayed(Duration(milliseconds: 350));
        return Future.value(true);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: KDRow(
                      data: state.data,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Expanded(
                    flex: 4,
                    child: StatsGrid(
                      data: state.data,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
