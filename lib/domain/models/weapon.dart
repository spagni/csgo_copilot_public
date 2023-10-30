import 'package:meta/meta.dart';

class Weapon {
  final String assetPath;
  final String name;

  Weapon({
    @required this.assetPath,
    @required this.name,
  })  : assert(assetPath != null),
        assert(name != null);
}
