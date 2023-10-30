import 'package:flutter/material.dart';

class CustomSwitcher extends StatefulWidget {
  final bool initialValue;
  final Function(bool) onChanged;
  final String left;
  final String right;

  const CustomSwitcher({
    Key key,
    this.initialValue = true,
    @required this.onChanged,
    @required this.left,
    @required this.right,
  })  : assert(onChanged != null),
        assert(left != null),
        assert(right != null),
        super(key: key);
  @override
  _CustomSwitcherState createState() => _CustomSwitcherState();
}

class _CustomSwitcherState extends State<CustomSwitcher> {
  bool value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() => value = !value);
          widget.onChanged(value);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
          height: 35,
          width: MediaQuery.of(context).size.width * .6,
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(70),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Center(
                              child: Text(
                                widget.left,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Center(
                              child: Text(
                                widget.right,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: value ? null : 0.0,
                    left: value ? 0.0 : null,
                    top: 0.0,
                    bottom: 0.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      width: constraints.maxWidth * .5,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(70),
                      ),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            value ? widget.left : widget.right,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
