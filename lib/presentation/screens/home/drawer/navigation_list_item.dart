import 'package:flutter/material.dart';

class NavigationListItem extends StatelessWidget {
  final String title;
  final Function onPressed;

  const NavigationListItem({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, //Theme.of(context).primaryColor.withOpacity(0.7),
      child: InkWell(
        onTap: onPressed,
        highlightColor: Theme.of(context).accentColor.withOpacity(.5),
        splashColor: Theme.of(context).accentColor.withOpacity(.5),
        child: Container(
          child: ListTile(
            title: Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
      ),
    );
  }
}

// class NavigationSubListItem extends StatelessWidget {
//   final String title;
//   final Function onPressed;

//   const NavigationSubListItem({
//     Key key,
//     @required this.title,
//     @required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Theme.of(context).primaryColor.withOpacity(0.7),
//               blurRadius: 2,
//             ),
//           ],
//         ),
//         child: ListTile(
//           // contentPadding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
//           title: Text(
//             title,
//             style: Theme.of(context).textTheme.subtitle1,
//           ),
//         ),
//       ),
//     );
//   }
// }
