import 'package:csgo_copilot/application/stats/stats_bloc.dart';
import 'package:csgo_copilot/presentation/screens/maps/map_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapsScreen extends StatefulWidget {
  final double itemHeight;

  const MapsScreen({
    Key key,
    @required this.itemHeight,
  })  : assert(itemHeight != null),
        super(key: key);
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  ScrollController _scrollController;
  final double _separatorHeight = 12;
  double _itemHeight;

  @override
  void initState() {
    super.initState();
    _itemHeight = widget.itemHeight + _separatorHeight;
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _onScrollNotification(ScrollNotification notification) {
    int index = ((_scrollController.offset) / _itemHeight).round();

    if (notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        _scrollController.position.activity is! HoldScrollActivity) {
      _animateTo(index);
    }
    return true;
  }

  void _animateTo(int index) {
    _scrollController.animateTo(
      _itemHeight * index,
      duration: Duration(milliseconds: 1500),
      curve: Curves.elasticOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MAPS'),
      ),
      body: BlocBuilder<StatsBloc, StatsState>(builder: (context, state) {
        if (state is! StatsDataSuccess) return SizedBox();

        var data = (state as StatsDataSuccess).data.getSortedMaps();

        return NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: ListView.separated(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 24,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final _itemPositionOffset = index * _itemHeight;
              final _difference =
                  _scrollController.offset - _itemPositionOffset;
              final percent = 1.0 - (_difference / _itemHeight);
              double _opacity = percent.clamp(0.0, 1.0);
              double _scale = percent.clamp(.5, 1.0);

              return Opacity(
                opacity: _opacity,
                child: Transform(
                  transform: Matrix4.identity()..scale(_scale),
                  alignment: Alignment.center,
                  child: Hero(
                    tag: '${data[index].map.assetPath}HERO',
                    child: MapCard(
                      mapStats: data[index],
                      height: widget.itemHeight,
                      opacity: .6,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: _separatorHeight);
            },
          ),
        );
      }),
    );
  }
}
