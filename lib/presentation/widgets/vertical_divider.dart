import 'package:flutter/material.dart';

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4,),
      height: MediaQuery.of(context).size.height * .05,
      width: 1,
      color: Colors.white12
    );
  }
}