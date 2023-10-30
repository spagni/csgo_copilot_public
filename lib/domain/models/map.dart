import 'package:meta/meta.dart';

class Map {
  final String assetPath;
  final String name;

  Map({
    @required this.assetPath,
    @required this.name,
  })  : assert(assetPath != null),
        assert(name != null);
}
