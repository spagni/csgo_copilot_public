import 'package:flutter/material.dart';

class CenterFittedText extends StatelessWidget {
  const CenterFittedText({Key key, @required this.title, @required this.style})
      : super(key: key);

  final String title;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }
}
