import 'dart:math';
import 'dart:ui';

import 'package:csgo_copilot/presentation/widgets/center_fitted_text.dart';
import 'package:flutter/material.dart';
import 'package:csgo_copilot/utils/extensions/double.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CircularAnimatedIndicator extends StatelessWidget {
  final double value;
  final String title;
  final Widget subTitle;

  const CircularAnimatedIndicator(
      {Key key, @required this.value, this.subTitle, this.title})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: value),
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeOutQuad,
      builder: (context, double val, child) {
        return Neumorphic(
          padding: const EdgeInsets.all(10.0),
          style: NeumorphicStyle(
            shape: NeumorphicShape.convex,
            boxShape: NeumorphicBoxShape.circle(),
            depth: 2,
            lightSource: LightSource.topLeft,
            color: Theme.of(context).primaryColor,
            intensity: 0.5,
          ),
          child: CustomPaint(
            painter: CircularIndicatorPaint(
              colors: [
                Colors.tealAccent,
                Colors.cyan[600],
                Theme.of(context).accentColor,
              ],
              value: val,
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxWidth,
                child: Neumorphic(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    boxShape: NeumorphicBoxShape.circle(),
                    depth: 1,
                    lightSource: LightSource.topLeft,
                    color: Theme.of(context).primaryColor,
                    intensity: .4,
                  ),
                  child: Column(
                    children: [
                      if (title != null)
                        Flexible(
                          flex: 1,
                          child: CenterFittedText(
                            title: title,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                      Expanded(
                        flex: 3,
                        child: Opacity(
                          opacity: (val / value).clamp(0.0, 1.0),
                          child: CenterFittedText(
                            title: val.toStringAsFixed(2),
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                      ),
                      if (subTitle != null) Flexible(flex: 1, child: subTitle),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
      // child:
    );
  }
}

class CircularIndicatorPaint extends CustomPainter {
  final List<Color> colors;
  final double value;

  CircularIndicatorPaint({
    @required this.value,
    @required this.colors,
  }) : assert(value != null);

  @override
  void paint(Canvas canvas, Size size) {
    final int intPerLap = 1;
    // Cuantas vueltas va a dar la animacion
    final int laps = (value ~/ intPerLap);
    // Restante => vuelta parcial
    final double remainder = (value % intPerLap).roundDecimalPlaces(2);
    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.grey.withOpacity(.3)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    Paint neonPaint = Paint()
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, 4.0);

    // canvas.drawCircle(center, radius, paint);

    paint..strokeCap = StrokeCap.round;

    for (var i = 0; i <= laps; i++) {
      Color color = colors.length > i ? colors[i] : Colors.red;
      // Color lastColor = (i == 0)
      //     ? color
      //     : colors.length > i - 1
      //         ? colors[i - 1]
      //         : Colors.red;

      // print('Lap $i - Color $color - TotalValue: $value Value : ${value - 1}');
      // var _colors = [color, lastColor, if (i == laps) color];
      _drawArc(canvas, value - i, center, radius, paint..color = color
          // ..shader = (i > 0)
          //     ? SweepGradient(
          //         startAngle: 3 * pi / 2,
          //         endAngle: 7 * pi / 2,
          //         colors: _colors,
          //         tileMode: TileMode.repeated,
          //         stops: [
          //           0,
          //           0.2,
          //           if(i == laps) 1.0,
          //         ],
          //       ).createShader(
          //         Rect.fromCircle(center: center, radius: radius),
          //       )
          //     : null,
          );
      //Solo pinto el glow de la anteultimavuelta. Luego se pinta el remainder
      if (i == laps - 1) {
        _drawArc(
          canvas,
          value - i,
          center,
          radius,
          neonPaint..color = color,
        );
      }
    }

    if (remainder != 0.0) {
      Color color = colors.length > laps ? colors[laps] : Colors.red;
      _drawArc(
        canvas,
        remainder,
        center,
        radius,
        paint..color = color,
      );
      _drawArc(
        canvas,
        remainder,
        center,
        radius,
        neonPaint..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;

  void _drawArc(
    Canvas canvas,
    double value,
    Offset center,
    double radius,
    Paint paint,
  ) {
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      270 * pi / 180,
      (360 * value) * pi / 180,
      false,
      paint,
    );
  }
}
