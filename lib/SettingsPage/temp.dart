// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:feasturent_costomer_app/constants.dart';
// import 'package:feasturent_costomer_app/screens/home/components/viewAllCategory.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shimmer/shimmer.dart';
// import 'dart:convert';

// class Categories extends StatefulWidget {
//   const Categories({
//     Key key,
//   }) : super(key: key);

//   @override
//   _CategoriesState createState() => _CategoriesState();
// }

// class _CategoriesState extends State<Categories> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   var data;
//   Future<List<dynamic>> fetchCategories() async {
//     print(
//         "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  hitting api category");

//     var result = await http.get(APP_ROUTES + 'getCategories?key=ALL');
//     data = json.decode(result.body)['data'];
//     return data;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Container(
//               margin: EdgeInsets.only(left: size.width * 0.05),
//               child: Text(
//                 "Categories",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: kTextColor,
//                     fontSize: size.height * 0.025),
//               ),
//             ),
//             Spacer(),
//             Container(
//                 child: FlatButton(
//                     onPressed: () {
//                       if (data != null) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   ViewAllCategory(categoryData: data),
//                             ));
//                       }
//                     },
//                     child: Row(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(left: 15),
//                           child: Text(
//                             "View All",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: kPrimaryColor,
//                             ),
//                           ),
//                         ),
//                         Icon(
//                           Icons.arrow_right_rounded,
//                           color: kSecondaryTextColor,
//                         ),
//                       ],
//                     )))
//           ],
//         ),
//         Container(
//             child: FutureBuilder<List<dynamic>>(
//           future: fetchCategories(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               int legnth;
//               if (snapshot.data.length >= 5) {
//                 legnth = 5;
//               } else {
//                 legnth = snapshot.data.length;
//               }
//               return
//             }
//           },
//         ))
//       ],
//     );
//   }
// }
