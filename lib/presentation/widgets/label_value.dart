import 'package:flutter/material.dart';

enum WidgetAlignment { LEFT, CENTER, RIGHT }

class LabelValueWidget extends StatelessWidget {
  final String label;
  final String value;
  final WidgetAlignment alignment;

  const LabelValueWidget({
    Key key,
    this.label,
    @required this.value,
    @required this.alignment,
  })  : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: _getAlignment(),
        children: [
          if (label != null)
            FittedBox(
              child: Text(
                label,
                textAlign: _getTextAlign(),
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
              ),
            ),
          FittedBox(
            child: Text(
              value,
              textAlign: _getTextAlign(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }

  TextAlign _getTextAlign() {
    switch (alignment) {
      case WidgetAlignment.LEFT:
        return TextAlign.start;
      case WidgetAlignment.CENTER:
        return TextAlign.center;
      case WidgetAlignment.RIGHT:
        return TextAlign.end;
      default:
        return TextAlign.center;
    }
  }

  CrossAxisAlignment _getAlignment() {
    switch (alignment) {
      case WidgetAlignment.LEFT:
        return CrossAxisAlignment.start;
      case WidgetAlignment.CENTER:
        return CrossAxisAlignment.center;
      case WidgetAlignment.RIGHT:
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.center;
    }
  }
}
