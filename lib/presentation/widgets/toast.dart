import 'dart:async';

import 'package:flutter/material.dart';

class Toast {
  static void show(
    BuildContext context, {

    /// Duration of the toast
    Duration duration = const Duration(seconds: 4),

    /// Duration of the show and exit transition
    Duration transitionDuration = const Duration(milliseconds: 300),
    @required String content,
    Color backgroundColor,
    Color color,
  }) async {
    StreamController _exitStream = StreamController();

    OverlayState overlayState = Overlay.of(context);

    OverlayEntry overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return AnimatedToast(
          content: content,
          color: color,
          backgroundColor: backgroundColor,
          exitToastStream: _exitStream.stream,
          duration: transitionDuration,
        );
      },
    );

    overlayState.insert(overlayEntry);

    Timer(duration, () async {
      _exitStream.add(null);
      await Future.delayed(
        Duration(milliseconds: transitionDuration.inMilliseconds + 100),
      );
      overlayEntry.remove();
      _exitStream.close();
    });
  }
}

class AnimatedToast extends StatefulWidget {
  final String content;
  final Color backgroundColor;
  final Color color;
  final Stream exitToastStream;
  final Duration duration;

  AnimatedToast({
    this.color,
    this.backgroundColor,
    @required this.content,
    this.exitToastStream,
    @required this.duration,
  });

  @override
  _AnimatedToastState createState() => _AnimatedToastState();
}

class _AnimatedToastState extends State<AnimatedToast>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _offset =
        Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset(0.0, 0.0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate,
      ),
    );

    _controller.forward();

    if (widget.exitToastStream != null)
      widget.exitToastStream.listen(
        (_) {
          _controller.reverse();
        },
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 48,
      left: 24.0,
      right: 24.0,
      child: SlideTransition(
        position: _offset,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () => _controller.isCompleted ? _controller.reverse() : {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  widget.content,
                  style: TextStyle(
                    color: widget.color ?? Colors.white,
                    fontSize: 17.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
