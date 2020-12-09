import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:feasturent_costomer_app/constants.dart';

// class HomeAppBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       leading: IconButton(
//         icon: SvgPicture.asset("assets/icons/menu.svg"),
//         onPressed: () {},
//       ),
//       title: RichText(
//         text: TextSpan(
//           style: Theme.of(context)
//               .textTheme
//               .title
//               .copyWith(fontWeight: FontWeight.bold),
//           children: [
//             TextSpan(
//               text: "Feas",
//               style: TextStyle(color: ksecondaryColor),
//             ),
//             TextSpan(
//               text: "Turent",
//               style: TextStyle(color: kPrimaryColor),
//             ),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         IconButton(
//           icon: SvgPicture.asset("assets/icons/notification.svg"),
//           onPressed: () {},
//         ),
//       ],
//     );
//   }
// }

// class HomeAppBar extends StatefulWidget {
//   @override
//   _HomeAppBarState createState() => _HomeAppBarState();
// }

// class _HomeAppBarState extends State<HomeAppBar> {
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       leading: IconButton(
//         icon: SvgPicture.asset("assets/icons/menu.svg"),
//         onPressed: () {},
//       ),
//       title: RichText(
//         text: TextSpan(
//           style: Theme.of(context)
//               .textTheme
//               .title
//               .copyWith(fontWeight: FontWeight.bold),
//           children: [
//             TextSpan(
//               text: "Feas",
//               style: TextStyle(color: ksecondaryColor),
//             ),
//             TextSpan(
//               text: "Turent",
//               style: TextStyle(color: kPrimaryColor),
//             ),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         IconButton(
//           icon: SvgPicture.asset("assets/icons/notification.svg"),
//           onPressed: () {},
//         ),
//       ],
//     );
//   }
// }

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/menu.svg"),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    ),
    title: RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .title
            .copyWith(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "Feas",
            style: TextStyle(color: ksecondaryColor),
          ),
          TextSpan(
            text: "Turent",
            style: TextStyle(color: kPrimaryColor),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: SvgPicture.asset("assets/icons/notification.svg"),
        onPressed: () {},
      ),
    ],
  );
}
