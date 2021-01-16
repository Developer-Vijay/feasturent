import 'package:feasturent_costomer_app/components/appDrawer.dart';
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


  

  

class HomeAppBar1 extends StatefulWidget {
  @override
  _HomeAppBar1State createState() => _HomeAppBar1State();
}

class _HomeAppBar1State extends State<HomeAppBar1> {
 
   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    

    return Padding(
      padding: const EdgeInsets.only(top:30),
      child: Scaffold(
          key: _scaffoldKey,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset("assets/icons/menu.svg"),
            onPressed: () { print("Test");}
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
              icon: SvgPicture.asset("assets/icons/search.svg"),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset("assets/icons/notification.svg"),
              onPressed: () {},
            ),
          ],
      ),
      
      ),
    );
//     return Padding(
//       padding: const EdgeInsets.only(top: 20),
//       child: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: SvgPicture.asset("assets/icons/menu.svg"),
//           onPressed: () {
//              Scaffold.of(context).openDrawer();
//           },
//         ),
//         title: RichText(
//           text: TextSpan(
//             style: Theme.of(context)
//                 .textTheme
//                 .title
//                 .copyWith(fontWeight: FontWeight.bold),
//             children: [
//               TextSpan(
//                 text: "Feas",
//                 style: TextStyle(color: ksecondaryColor),
//               ),
//               TextSpan(
//                 text: "Turent",
//                 style: TextStyle(color: kPrimaryColor),
//               ),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: SvgPicture.asset("assets/icons/notification.svg"),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }

// AppBar homeAppBar(BuildContext context) {
//   return AppBar(
//     backgroundColor: Colors.white,
//     elevation: 0,
//     leading: IconButton(
//       icon: SvgPicture.asset("assets/icons/menu.svg"),
//       onPressed: () {
//         Scaffold.of(context).openDrawer();
//       },
//     ),
//     title: RichText(
//       text: TextSpan(
//         style: Theme.of(context)
//             .textTheme
//             .title
//             .copyWith(fontWeight: FontWeight.bold),
//         children: [
//           TextSpan(
//             text: "Feas",
//             style: TextStyle(color: ksecondaryColor),
//           ),
//           TextSpan(
//             text: "Turent",
//             style: TextStyle(color: kPrimaryColor),
//           ),
//         ],
//       ),
//     ),
//     actions: <Widget>[
//       IconButton(
//         icon: SvgPicture.asset("assets/icons/notification.svg"),
//         onPressed: () {},
//       ),
//     ],
//   );
// }
  }
}