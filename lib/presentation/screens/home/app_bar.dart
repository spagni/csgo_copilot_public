import 'package:cached_network_image/cached_network_image.dart';
import 'package:csgo_copilot/application/player/player_bloc.dart';
import 'package:csgo_copilot/domain/models/player.dart';
import 'package:csgo_copilot/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlayerBloc, PlayerState>(
      listener: (context, state) {
        if (state is PlayerError) {
          Toast.show(
            context,
            content: state.message,
            backgroundColor: Colors.redAccent,
          );
        }
      },
      builder: (context, state) {
        if (state is! PlayerDataSuccesss)
          return AppBar(
            actions: (state is PlayerError)
                ? [
                    IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () =>
                            context.read<PlayerBloc>()..add(GetPlayerData())),
                  ]
                : null,
          );

        Player _player = (state as PlayerDataSuccesss).player;

        return AppBar(
          title: Text(
            _player.personaName,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 4.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10000),
                child: CachedNetworkImage(
                  imageUrl: _player.avatarFull,
                  progressIndicatorBuilder: (_, __, ___) => SizedBox(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
