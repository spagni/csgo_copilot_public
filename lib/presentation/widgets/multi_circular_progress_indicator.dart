import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class MultiCircularProgressIndicator extends StatefulWidget {
  final Color color;

  /// This radius will be multiplied by 3 for the bigger ring
  final double baseRadius;

  /// Duration of a 360 sweep
  final Duration duration;

  const MultiCircularProgressIndicator({
    Key key,
    this.color,
    this.baseRadius = 18.0,
    this.duration = const Duration(milliseconds: 2000),
  }) : super(key: key);

  @override
  _MultiCircularProgressIndicatorState createState() =>
      _MultiCircularProgressIndicatorState();
}

class _MultiCircularProgressIndicatorState
    extends State<MultiCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: CircularPainter(
              value: _animation.value,
              baseRadius: widget.baseRadius,
              color: (widget.color == null)
                  ? Theme.of(context).accentColor
                  : widget.color,
            ),
          );
        },
      ),
    );
  }
}

class CircularPainter extends CustomPainter {
  final double value;
  final Color color;

  /// This radius will be multiplied by 3 for the bigger ring
  final double baseRadius;

  CircularPainter({
    @required this.value,
    @required this.color,
    @required this.baseRadius,
  })  : assert(value != null),
        assert(color != null),
        assert(baseRadius != null);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    _drawArc(canvas, paint, value, baseRadius * 3);
    _drawArc(
      canvas,
      paint..color = color.withOpacity(.8),
      value * 2,
      baseRadius * 2,
    );
    _drawArc(
      canvas,
      paint..color = color.withOpacity(.6),
      value * 3,
      baseRadius,
    );
  }

  void _drawArc(Canvas canvas, Paint paint, double value, double radius) {
    return canvas.drawArc(
      Rect.fromCircle(
        center: Offset.zero,
        radius: radius,
      ),
      pi * lerpDouble(-.5, 1.5, value),
      90 * pi / 180,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => old != this;
}
