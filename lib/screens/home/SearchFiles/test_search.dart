import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/screens/home/SearchFiles/dineout_search.dart';
import 'package:feasturent_costomer_app/screens/home/SearchFiles/dishSearch.dart';
import 'package:feasturent_costomer_app/screens/home/SearchFiles/resturent_search.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController controller = new TextEditingController();

  // Get json result and convert it to model. Then add
  // Future<Null> getUserDetails() async {
  //   final response = await http.get(url);
  //   final responseJson = json.decode(response.body);

  //   setState(() {
  //     for (Map user in responseJson['data']) {
  //       _userDetails.add(UserDetails.fromJson(user));
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();

    onSearchTextChanged('');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: AppBar(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            style: TextStyle(color: Colors.white),
            decoration: new InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Search',
                border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          actions: [
            new IconButton(
              icon: new Icon(Icons.cancel),
              onPressed: () {
                if (controller.text.isEmpty) {
                  Navigator.pop(context);
                } else {
                  controller.clear();
                  onSearchTextChanged('');
                }
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Dishes"),
              Tab(text: "Resturent"),
              Tab(text: "DineOut")
            ],
          ),
        ),
        body: TabBarView(children: [
          DishSearch(),
          SearchResturent(),
          DineoutSearch(),

          //  new Column(
          //   children: <Widget>[

          // new Container(
          //   color: Theme.of(context).primaryColor,
          //   child: new Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: new Card(
          //       child: new ListTile(
          //         leading: new Icon(Icons.search),
          //         title: new TextField(
          //           controller: controller,
          //           decoration: new InputDecoration(
          //               hintText: 'Search', border: InputBorder.none),
          //           onChanged: onSearchTextChanged,
          //         ),
          //         trailing: new IconButton(
          //           icon: new Icon(Icons.cancel),
          //           onPressed: () {
          //             controller.clear();
          //             onSearchTextChanged('');
          //           },
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // new Expanded(
          // child:

          // resultData != null
          //     ? resultData['restaurant'].isNotEmpty &&
          //             resultData['dineout'].isNotEmpty &&
          //             resultData['dish'].isNotEmpty
          //         ?
          // Container(
          //     child: CustomScrollView(
          //       slivers: <Widget>[
          //         resultData['dish'].isNotEmpty
          //             ? Container(
          //                 child: SliverGrid(
          //                   gridDelegate:
          //                       SliverGridDelegateWithFixedCrossAxisCount(
          //                           crossAxisCount: 3),
          //                   delegate: SliverChildListDelegate(
          //                     List.generate(
          //                       resultData['dish'].length,
          //                       (i) {
          //                         return new Column(
          //                           children: [
          //                             Padding(
          //                               padding:
          //                                   const EdgeInsets.only(
          //                                       top: 8.0),
          //                               child: Container(
          //                                   decoration:
          //                                       BoxDecoration(
          //                                     shape:
          //                                         BoxShape.circle,
          //                                     boxShadow: [
          //                                       BoxShadow(
          //                                           blurRadius: 3,
          //                                           color: Colors
          //                                               .blueGrey,
          //                                           spreadRadius:
          //                                               1)
          //                                     ],
          //                                   ),
          //                                   margin: EdgeInsets.only(
          //                                       left: size.width *
          //                                           0.011),
          //                                   height: size.height *
          //                                       0.14,
          //                                   width:
          //                                       size.width * 0.4,
          //                                   child: CircleAvatar(
          //                                     backgroundColor:
          //                                         Colors.white,
          //                                     child: FlatButton(
          //                                       onPressed: () {
          //                                         // var menuD;
          //                                         // setState(() {
          //                                         //   menuD = snap.data[index];
          //                                         // });
          //                                         // Navigator.push(
          //                                         //     context,
          //                                         //     MaterialPageRoute(
          //                                         //         builder: (context) =>
          //                                         //             CategoryDetailPage(
          //                                         //               menuData: menuD,
          //                                         //             )));
          //                                       },
          //                                       child: ClipRRect(
          //                                           borderRadius:
          //                                               BorderRadius
          //                                                   .circular(
          //                                                       60),
          //                                           child: resultData['dish'][i]
          //                                                       [
          //                                                       'image1'] !=
          //                                                   null
          //                                               ? CachedNetworkImage(
          //                                                   imageUrl:
          //                                                       S3_BASE_PATH + resultData['dish'][i]['image1'],
          //                                                   fit: BoxFit
          //                                                       .cover,
          //                                                   width:
          //                                                       size.width * 0.35,
          //                                                   height:
          //                                                       size.height * 0.25,
          //                                                   errorWidget: (context, url, error) =>
          //                                                       Icon(Icons.error),
          //                                                   placeholder: (context, url) =>
          //                                                       Image.asset(
          //                                                     "assets/images/feasturenttemp.jpeg",
          //                                                     fit:
          //                                                         BoxFit.cover,
          //                                                   ),
          //                                                 )
          //                                               : Image
          //                                                   .asset(
          //                                                   "assets/images/feasturenttemp.jpeg",
          //                                                   fit: BoxFit
          //                                                       .cover,
          //                                                   width:
          //                                                       size.width * 0.32,
          //                                                   height:
          //                                                       size.height * 0.2,
          //                                                 )),
          //                                     ),
          //                                   )),
          //                             ),
          //                             SizedBox(
          //                               height:
          //                                   size.height * 0.01,
          //                             ),
          //                             Container(
          //                               width: size.width * 0.2,
          //                               child: Center(
          //                                 child: Text(
          //                                   resultData['dish'][i]
          //                                       ['title'],
          //                                   overflow: TextOverflow
          //                                       .ellipsis,
          //                                   style: TextStyle(
          //                                       color:
          //                                           Colors.black,
          //                                       fontWeight:
          //                                           FontWeight
          //                                               .w600,
          //                                       fontSize:
          //                                           size.height *
          //                                               0.014),
          //                                 ),
          //                               ),
          //                             )
          //                           ],
          //                         );

          //                         // Card(
          //                         //   child: new ListTile(
          //                         //     leading: new CircleAvatar(
          //                         //       backgroundImage: resultData[
          //                         //                       'dish'][i]
          //                         //                   ['image1'] ==
          //                         //               null
          //                         //           ? NetworkImage(
          //                         //               S3_BASE_PATH +
          //                         //                   'menues/image/10/FeastaurentImage871373-1619165007984.jpg',
          //                         //             )
          //                         //           : new NetworkImage(
          //                         //               S3_BASE_PATH +
          //                         //                   resultData['dish']
          //                         //                       [i]['image1'],
          //                         //             ),
          //                         //     ),
          //                         //     title: new Text(
          //                         //         resultData['dish'][i]
          //                         //                 ['title'] +
          //                         //             ' from ' +
          //                         //             resultData['dish'][i]
          //                         //                     ['VendorInfo']
          //                         //                 ['name']),
          //                         //   ),
          //                         //   margin: const EdgeInsets.all(0.0),
          //                         // );
          //                       },
          //                     ),
          //                     // [
          //                     //   BodyWidget(Colors.blue),
          //                     //   BodyWidget(Colors.green),
          //                     //   BodyWidget(Colors.yellow),
          //                     //   BodyWidget(Colors.orange),
          //                     //   BodyWidget(Colors.blue),
          //                     //   BodyWidget(Colors.red),
          //                     // ],
          //                   ),
          //                 ),
          //               )
          //             : SizedBox(),
          //         resultData['restaurant'].isNotEmpty
          //             ? SliverList(
          //                 delegate:
          //                     SliverChildListDelegate(List
          //                             .generate(
          //                                 resultData['restaurant']
          //                                     .length,
          //                                 (i) => InkWell(
          //                                       onTap: () {
          //                                         // Navigator.push(
          //                                         //     context,
          //                                         //     MaterialPageRoute(
          //                                         //         builder: (context) =>
          //                                         //             OfferListPage(
          //                                         //                 restaurantDa:
          //                                         //                     restaurantData[
          //                                         //                         index])));
          //                                       },
          //                                       child: Padding(
          //                                         padding:
          //                                             const EdgeInsets
          //                                                     .only(
          //                                                 bottom:
          //                                                     14),
          //                                         child:
          //                                             Container(
          //                                                 decoration: BoxDecoration(
          //                                                     borderRadius: BorderRadius.circular(
          //                                                         10),
          //                                                     color: Colors
          //                                                         .white,
          //                                                     boxShadow: [
          //                                                       BoxShadow(blurRadius: 2, color: Colors.grey[200], offset: Offset(0, 3), spreadRadius: 2)
          //                                                     ]),
          //                                                 margin: EdgeInsets
          //                                                     .only(
          //                                                   left: size.width *
          //                                                       0.02,
          //                                                   right:
          //                                                       size.width * 0.02,
          //                                                 ),
          //                                                 height: size.height *
          //                                                     0.135,
          //                                                 child: Row(
          //                                                     children: [
          //                                                       Expanded(
          //                                                           flex: 0,
          //                                                           child: Container(
          //                                                             alignment: Alignment.topCenter,
          //                                                             height: size.height * 0.2,
          //                                                             child: Stack(
          //                                                               children: [
          //                                                                 Container(
          //                                                                   margin: EdgeInsets.all(8),
          //                                                                   child: ClipRRect(
          //                                                                     borderRadius: BorderRadius.circular(10),
          //                                                                     child: resultData['restaurant'][i]['user']['profile'] != null
          //                                                                         ? CachedNetworkImage(
          //                                                                             imageUrl: S3_BASE_PATH + resultData['restaurant'][i]['user']['profile'],
          //                                                                             height: size.height * 0.18,
          //                                                                             width: size.width * 0.3,
          //                                                                             fit: BoxFit.cover,
          //                                                                             placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          //                                                                             errorWidget: (context, url, error) => Icon(Icons.error),
          //                                                                           )
          //                                                                         : Image.asset(
          //                                                                             "assets/images/feasturenttemp.jpeg",
          //                                                                             height: size.height * 0.18,
          //                                                                             width: size.width * 0.3,
          //                                                                             fit: BoxFit.cover,
          //                                                                           ),
          //                                                                   ),
          //                                                                 ),
          //                                                               ],
          //                                                             ),
          //                                                           )),
          //                                                       Expanded(
          //                                                           flex: 6,
          //                                                           child: Container(
          //                                                             height: size.height * 0.2,
          //                                                             child: Column(
          //                                                               crossAxisAlignment: CrossAxisAlignment.start,
          //                                                               mainAxisSize: MainAxisSize.max,
          //                                                               children: [
          //                                                                 Container(
          //                                                                   margin: EdgeInsets.only(top: size.height * 0.02),
          //                                                                   child: Row(
          //                                                                     children: [
          //                                                                       Text(
          //                                                                         resultData['restaurant'][i]['name'],
          //                                                                         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: size.height * 0.02),
          //                                                                       ),
          //                                                                       Spacer(),
          //                                                                       Padding(
          //                                                                         padding: const EdgeInsets.only(right: 12),
          //                                                                       )
          //                                                                     ],
          //                                                                   ),
          //                                                                 ),
          //                                                                 resultData['restaurant'][i]['avgCost'] == null
          //                                                                     ? SizedBox()
          //                                                                     : Column(
          //                                                                         children: [
          //                                                                           SizedBox(
          //                                                                             height: size.height * 0.013,
          //                                                                           ),
          //                                                                           Container(
          //                                                                             width: size.width * 0.35,
          //                                                                             child: Text(
          //                                                                               "${resultData['restaurant'][i]['avgCost']} for ${resultData['restaurant'][i]['forPeople']} ",
          //                                                                               overflow: TextOverflow.ellipsis,
          //                                                                               style: TextStyle(fontSize: size.height * 0.015, fontWeight: FontWeight.bold),
          //                                                                             ),
          //                                                                           ),
          //                                                                         ],
          //                                                                       ),
          //                                                                 SizedBox(
          //                                                                   height: size.height * 0.015,
          //                                                                 ),
          //                                                                 Container(
          //                                                                   child: Row(
          //                                                                     children: [
          //                                                                       1 == 1
          //                                                                           ? Text(
          //                                                                               "⭐1",
          //                                                                               style: TextStyle(fontSize: size.height * 0.016, color: Colors.red, fontWeight: FontWeight.bold),
          //                                                                             )
          //                                                                           : Text(
          //                                                                               "⭐1",
          //                                                                               style: TextStyle(fontSize: size.height * 0.016, color: Colors.red, fontWeight: FontWeight.bold),
          //                                                                             ),
          //                                                                       Spacer(),
          //                                                                       // couponDetatil ==
          //                                                                       //         null
          //                                                                       //     ? SizedBox()
          //                                                                       //     : Image
          //                                                                       //         .asset(
          //                                                                       //         "assets/icons/discount_icon.jpg",
          //                                                                       //         height: size.height * 0.02,
          //                                                                       //       ),
          //                                                                       // couponDetatil ==
          //                                                                       //         null
          //                                                                       //     ? SizedBox()
          //                                                                       //     : Padding(
          //                                                                       //         padding: const EdgeInsets.only(
          //                                                                       //           right: 12.0,
          //                                                                       //         ),
          //                                                                       //         child: Text(
          //                                                                       //           couponDetatil,
          //                                                                       //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.height * 0.016, color: kTextColor),
          //                                                                       //         ),
          //                                                                       //       ),
          //                                                                     ],
          //                                                                   ),
          //                                                                 ),
          //                                                               ],
          //                                                             ),
          //                                                           ))
          //                                                     ])),
          //                                       ),
          //                                     ))
          //                         // [
          //                         //   HeaderWidget("Header 1"),
          //                         //   HeaderWidget("Header 2"),
          //                         //   HeaderWidget("Header 3"),
          //                         //   HeaderWidget("Header 4"),
          //                         // ],
          //                         ),
          //               )
          //             : SizedBox(),
          //         resultData['dineout'].isNotEmpty
          //             ? SliverList(
          //                 delegate:
          //                     SliverChildListDelegate(List
          //                             .generate(
          //                                 resultData['dineout']
          //                                     .length,
          //                                 (i) => Card(
          //                                       child:
          //                                           new ListTile(
          //                                         leading:
          //                                             new CircleAvatar(
          //                                           backgroundImage: resultData['dineout'][i]['user']
          //                                                       [
          //                                                       'profile'] ==
          //                                                   null
          //                                               ? NetworkImage(
          //                                                   S3_BASE_PATH +
          //                                                       'menues/image/10/FeastaurentImage871373-1619165007984.jpg',
          //                                                 )
          //                                               : new NetworkImage(
          //                                                   S3_BASE_PATH +
          //                                                       resultData['dineout'][i]['user']['profile'],
          //                                                 ),
          //                                         ),
          //                                         title: new Text(
          //                                             resultData['dineout']
          //                                                     [i][
          //                                                 'name']),
          //                                       ),
          //                                       margin:
          //                                           const EdgeInsets
          //                                               .all(0.0),
          //                                     ))
          //                         // [
          //                         //   BodyWidget(Colors.blue),
          //                         //   BodyWidget(Colors.red),
          //                         //   BodyWidget(Colors.green),
          //                         //   BodyWidget(Colors.orange),
          //                         //   BodyWidget(Colors.blue),
          //                         //   BodyWidget(Colors.red),
          //                         // ],
          //                         ),
          //               )
          //             : SizedBox(),
          //       ],
          //     ),
          //   )

          //     ListView(
          //         children: [
          //           resultData['restaurant'].isNotEmpty
          //               ? Column(
          //                   children: [
          //                     Text("Resturents"),
          //                     new ListView.builder(
          //                       shrinkWrap: true,
          //                       physics:
          //                           NeverScrollableScrollPhysics(),
          //                       itemCount:
          //                           resultData['restaurant'].length,
          //                       itemBuilder: (context, i) {
          //                         return new InkWell(
          //                           onTap: () {
          //                             // Navigator.push(
          //                             //     context,
          //                             //     MaterialPageRoute(
          //                             //         builder: (context) =>
          //                             //             OfferListPage(
          //                             //                 restaurantDa:
          //                             //                     restaurantData[
          //                             //                         index])));
          //                           },
          //                           child: Padding(
          //                             padding: const EdgeInsets.only(
          //                                 bottom: 14),
          //                             child: Container(
          //                                 decoration: BoxDecoration(
          //                                     borderRadius:
          //                                         BorderRadius
          //                                             .circular(10),
          //                                     color: Colors.white,
          //                                     boxShadow: [
          //                                       BoxShadow(
          //                                           blurRadius: 2,
          //                                           color: Colors
          //                                               .grey[200],
          //                                           offset:
          //                                               Offset(0, 3),
          //                                           spreadRadius: 2)
          //                                     ]),
          //                                 margin: EdgeInsets.only(
          //                                   left: size.width * 0.02,
          //                                   right: size.width * 0.02,
          //                                 ),
          //                                 height: size.height * 0.135,
          //                                 child: Row(children: [
          //                                   Expanded(
          //                                       flex: 0,
          //                                       child: Container(
          //                                         alignment: Alignment
          //                                             .topCenter,
          //                                         height:
          //                                             size.height *
          //                                                 0.2,
          //                                         child: Stack(
          //                                           children: [
          //                                             Container(
          //                                               margin:
          //                                                   EdgeInsets
          //                                                       .all(
          //                                                           8),
          //                                               child:
          //                                                   ClipRRect(
          //                                                 borderRadius:
          //                                                     BorderRadius.circular(
          //                                                         10),
          //                                                 child: resultData['restaurant'][i]['user']['profile'] !=
          //                                                         null
          //                                                     ? CachedNetworkImage(
          //                                                         imageUrl:
          //                                                             S3_BASE_PATH + resultData['restaurant'][i]['user']['profile'],
          //                                                         height:
          //                                                             size.height * 0.18,
          //                                                         width:
          //                                                             size.width * 0.3,
          //                                                         fit:
          //                                                             BoxFit.cover,
          //                                                         placeholder: (context, url) =>
          //                                                             Center(child: CircularProgressIndicator()),
          //                                                         errorWidget: (context, url, error) =>
          //                                                             Icon(Icons.error),
          //                                                       )
          //                                                     : Image
          //                                                         .asset(
          //                                                         "assets/images/feasturenttemp.jpeg",
          //                                                         height:
          //                                                             size.height * 0.18,
          //                                                         width:
          //                                                             size.width * 0.3,
          //                                                         fit:
          //                                                             BoxFit.cover,
          //                                                       ),
          //                                               ),
          //                                             ),
          //                                           ],
          //                                         ),
          //                                       )),
          //                                   Expanded(
          //                                       flex: 6,
          //                                       child: Container(
          //                                         height:
          //                                             size.height *
          //                                                 0.2,
          //                                         child: Column(
          //                                           crossAxisAlignment:
          //                                               CrossAxisAlignment
          //                                                   .start,
          //                                           mainAxisSize:
          //                                               MainAxisSize
          //                                                   .max,
          //                                           children: [
          //                                             Container(
          //                                               margin: EdgeInsets.only(
          //                                                   top: size
          //                                                           .height *
          //                                                       0.02),
          //                                               child: Row(
          //                                                 children: [
          //                                                   Text(
          //                                                     resultData['restaurant'][i]
          //                                                         [
          //                                                         'name'],
          //                                                     style: TextStyle(
          //                                                         fontWeight:
          //                                                             FontWeight.bold,
          //                                                         color: Colors.black,
          //                                                         fontSize: size.height * 0.02),
          //                                                   ),
          //                                                   Spacer(),
          //                                                   Padding(
          //                                                     padding:
          //                                                         const EdgeInsets.only(right: 12),
          //                                                   )
          //                                                 ],
          //                                               ),
          //                                             ),
          //                                             resultData['restaurant'][i]
          //                                                         [
          //                                                         'avgCost'] ==
          //                                                     null
          //                                                 ? SizedBox()
          //                                                 : Column(
          //                                                     children: [
          //                                                       SizedBox(
          //                                                         height:
          //                                                             size.height * 0.013,
          //                                                       ),
          //                                                       Container(
          //                                                         width:
          //                                                             size.width * 0.35,
          //                                                         child:
          //                                                             Text(
          //                                                           "${resultData['restaurant'][i]['avgCost']} for ${resultData['restaurant'][i]['forPeople']} ",
          //                                                           overflow: TextOverflow.ellipsis,
          //                                                           style: TextStyle(fontSize: size.height * 0.015, fontWeight: FontWeight.bold),
          //                                                         ),
          //                                                       ),
          //                                                     ],
          //                                                   ),
          //                                             SizedBox(
          //                                               height:
          //                                                   size.height *
          //                                                       0.015,
          //                                             ),
          //                                             Container(
          //                                               child: Row(
          //                                                 children: [
          //                                                   1 == 1
          //                                                       ? Text(
          //                                                           "⭐1",
          //                                                           style: TextStyle(fontSize: size.height * 0.016, color: Colors.red, fontWeight: FontWeight.bold),
          //                                                         )
          //                                                       : Text(
          //                                                           "⭐1",
          //                                                           style: TextStyle(fontSize: size.height * 0.016, color: Colors.red, fontWeight: FontWeight.bold),
          //                                                         ),
          //                                                   Spacer(),
          //                                                   // couponDetatil ==
          //                                                   //         null
          //                                                   //     ? SizedBox()
          //                                                   //     : Image
          //                                                   //         .asset(
          //                                                   //         "assets/icons/discount_icon.jpg",
          //                                                   //         height: size.height * 0.02,
          //                                                   //       ),
          //                                                   // couponDetatil ==
          //                                                   //         null
          //                                                   //     ? SizedBox()
          //                                                   //     : Padding(
          //                                                   //         padding: const EdgeInsets.only(
          //                                                   //           right: 12.0,
          //                                                   //         ),
          //                                                   //         child: Text(
          //                                                   //           couponDetatil,
          //                                                   //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.height * 0.016, color: kTextColor),
          //                                                   //         ),
          //                                                   //       ),
          //                                                 ],
          //                                               ),
          //                                             ),
          //                                           ],
          //                                         ),
          //                                       ))
          //                                 ])),
          //                           ),
          //                         );

          //                         // Card(
          //                         //   child: new ListTile(
          //                         //     leading: new CircleAvatar(
          //                         //       backgroundImage:
          //                         //           resultData['restaurant']
          //                         //                               [i]
          //                         //                           ['user']
          //                         //                       ['profile'] ==
          //                         //                   null
          //                         //               ? NetworkImage(
          //                         //                   S3_BASE_PATH +
          //                         //                       'menues/image/10/FeastaurentImage871373-1619165007984.jpg',
          //                         //                 )
          //                         //               : new NetworkImage(
          //                         //                   S3_BASE_PATH +
          //                         //                       resultData['restaurant']
          //                         //                                   [
          //                         //                                   i]
          //                         //                               [
          //                         //                               'user']
          //                         //                           [
          //                         //                           'profile'],
          //                         //                 ),
          //                         //     ),
          //                         //     title: new Text(
          //                         //         resultData['restaurant'][i]
          //                         //             ['name']),
          //                         //   ),
          //                         //   margin: const EdgeInsets.all(0.0),
          //                         // );
          //                       },
          //                     ),
          //                   ],
          //                 )
          //               : SizedBox(),
          //           resultData['dineout'].isNotEmpty
          //               ? Column(
          //                   children: [
          //                     Text("DineOut"),
          //                     Container(
          //                       child: new ListView.builder(
          //                         // scrollDirection: Axis.horizontal,
          //                         shrinkWrap: true,
          //                         physics:
          //                             NeverScrollableScrollPhysics(),
          //                         itemCount:
          //                             resultData['dineout'].length,
          //                         itemBuilder: (context, i) {
          //                           return new Card(
          //                             child: new ListTile(
          //                               leading: new CircleAvatar(
          //                                 backgroundImage:
          //                                     resultData['dineout']
          //                                                         [i]
          //                                                     ['user']
          //                                                 [
          //                                                 'profile'] ==
          //                                             null
          //                                         ? NetworkImage(
          //                                             S3_BASE_PATH +
          //                                                 'menues/image/10/FeastaurentImage871373-1619165007984.jpg',
          //                                           )
          //                                         : new NetworkImage(
          //                                             S3_BASE_PATH +
          //                                                 resultData['dineout'][i]
          //                                                         [
          //                                                         'user']
          //                                                     [
          //                                                     'profile'],
          //                                           ),
          //                               ),
          //                               title: new Text(
          //                                   resultData['dineout'][i]
          //                                       ['name']),
          //                             ),
          //                             margin:
          //                                 const EdgeInsets.all(0.0),
          //                           );
          //                         },
          //                       ),
          //                     ),
          //                   ],
          //                 )
          //               : SizedBox(),
          //           resultData['dish'].isNotEmpty
          //               ? Column(
          //                   children: [
          //                     Text("Dishes"),
          //                     GridView.count(
          //                       crossAxisCount: 2,
          //                       children: List.generate(
          //                         resultData['dish'].length,
          //                         (i) {
          //                           return new Column(
          //                             children: [
          //                               Padding(
          //                                 padding:
          //                                     const EdgeInsets.only(
          //                                         top: 8.0),
          //                                 child: Container(
          //                                     decoration:
          //                                         BoxDecoration(
          //                                       shape:
          //                                           BoxShape.circle,
          //                                       boxShadow: [
          //                                         BoxShadow(
          //                                             blurRadius: 3,
          //                                             color: Colors
          //                                                 .blueGrey,
          //                                             spreadRadius: 1)
          //                                       ],
          //                                     ),
          //                                     margin: EdgeInsets.only(
          //                                         left: size.width *
          //                                             0.011),
          //                                     height:
          //                                         size.height * 0.08,
          //                                     width:
          //                                         size.width * 0.24,
          //                                     child: CircleAvatar(
          //                                       backgroundColor:
          //                                           Colors.white,
          //                                       child: FlatButton(
          //                                         onPressed: () {
          //                                           // var menuD;
          //                                           // setState(() {
          //                                           //   menuD = snap.data[index];
          //                                           // });
          //                                           // Navigator.push(
          //                                           //     context,
          //                                           //     MaterialPageRoute(
          //                                           //         builder: (context) =>
          //                                           //             CategoryDetailPage(
          //                                           //               menuData: menuD,
          //                                           //             )));
          //                                         },
          //                                         child: ClipOval(
          //                                             child: resultData['dish'][i]
          //                                                         [
          //                                                         'image1'] !=
          //                                                     null
          //                                                 ? CachedNetworkImage(
          //                                                     imageUrl:
          //                                                         S3_BASE_PATH +
          //                                                             resultData['dish'][i]['image1'],
          //                                                     fit: BoxFit
          //                                                         .cover,
          //                                                     width: size.width *
          //                                                         0.2,
          //                                                     height: size.height *
          //                                                         0.2,
          //                                                     errorWidget: (context,
          //                                                             url,
          //                                                             error) =>
          //                                                         Icon(Icons.error),
          //                                                     placeholder:
          //                                                         (context, url) =>
          //                                                             Image.asset(
          //                                                       "assets/images/feasturenttemp.jpeg",
          //                                                       fit: BoxFit
          //                                                           .cover,
          //                                                     ),
          //                                                   )
          //                                                 : Image
          //                                                     .asset(
          //                                                     "assets/images/feasturenttemp.jpeg",
          //                                                     fit: BoxFit
          //                                                         .cover,
          //                                                     width: size.width *
          //                                                         0.2,
          //                                                     height: size.height *
          //                                                         0.2,
          //                                                   )),
          //                                       ),
          //                                     )),
          //                               ),
          //                               SizedBox(
          //                                 height: size.height * 0.01,
          //                               ),
          //                               Container(
          //                                 width: size.width * 0.2,
          //                                 child: Center(
          //                                   child: Text(
          //                                     resultData['dish'][i]
          //                                         ['title'],
          //                                     overflow: TextOverflow
          //                                         .ellipsis,
          //                                     style: TextStyle(
          //                                         color: Colors.black,
          //                                         fontWeight:
          //                                             FontWeight.w600,
          //                                         fontSize:
          //                                             size.height *
          //                                                 0.014),
          //                                   ),
          //                                 ),
          //                               )
          //                             ],
          //                           );

          //                           // Card(
          //                           //   child: new ListTile(
          //                           //     leading: new CircleAvatar(
          //                           //       backgroundImage: resultData[
          //                           //                       'dish'][i]
          //                           //                   ['image1'] ==
          //                           //               null
          //                           //           ? NetworkImage(
          //                           //               S3_BASE_PATH +
          //                           //                   'menues/image/10/FeastaurentImage871373-1619165007984.jpg',
          //                           //             )
          //                           //           : new NetworkImage(
          //                           //               S3_BASE_PATH +
          //                           //                   resultData['dish']
          //                           //                       [i]['image1'],
          //                           //             ),
          //                           //     ),
          //                           //     title: new Text(
          //                           //         resultData['dish'][i]
          //                           //                 ['title'] +
          //                           //             ' from ' +
          //                           //             resultData['dish'][i]
          //                           //                     ['VendorInfo']
          //                           //                 ['name']),
          //                           //   ),
          //                           //   margin: const EdgeInsets.all(0.0),
          //                           // );
          //               //           },
          //               //         ),
          //               //       ),
          //               //     ],
          //               //   )
          //               // : SizedBox()
          //     //     ],
          //     //   )
          //     //     : Center(
          //     //         child: Text("No search related data available "),
          //     //       )
          //     // : Center(
          //     //     child: Text("Search item..."),
          //     //   )

          //     // : new ListView.builder(
          //     //     itemCount: _userDetails.length,
          //     //     itemBuilder: (context, index) {
          //     //       return new Card(
          //     //         child: new ListTile(
          //     //           leading: new CircleAvatar(
          //     //             backgroundImage:
          //     //                 _userDetails[index].profileUrl == null
          //     //                     ? NetworkImage(
          //     //                         S3_BASE_PATH +
          //     //                             'menues/image/10/FeastaurentImage871373-1619165007984.jpg',
          //     //                       )
          //     //                     : new NetworkImage(
          //     //                         S3_BASE_PATH +
          //     //                             _userDetails[index].profileUrl,
          //     //                       ),
          //     //           ),
          //     //           title: new Text(_userDetails[index].title +
          //     //               ' from ' +
          //     //               _userDetails[index].lastName),
          //     //         ),
          //     //         margin: const EdgeInsets.all(0.0),
          //     //       );
          //     //     },
          //     //   ),
          //     // ),
          //   ],
          // ),
        ]),
      ),
    ));
  }

  // var searchWord = '';
  onSearchTextChanged(String text) async {
    print("#################### $text");
    // searchWord = text;
    final response = await http.get(
        'https://feasturent.in/api/appRoutes/appSearch?searchKey=$text&latitude=$latitude&longitude=$longitude');
    // _searchResult.clear();
    // if (text.isEmpty) {
    //   setState(() {});
    //   return;
    // }

    // _userDetails.forEach((userDetail) {
    //   if (userDetail.title.contains(text) || userDetail.lastName.contains(text))
    //     _searchResult.add(userDetail);
    // });

    if (mounted) {
      setState(() {
        resultData = json.decode(response.body)['data'];
      });
    }
  }
// }

// List<UserDetails> _searchResult = [];

// List<UserDetails> _userDetails = [];

// final String url = 'https://feasturent.in/api/appRoutes/getPopularMenues';

// class UserDetails {
//   final int id;
//   final String title, lastName, profileUrl;

//   UserDetails({
//     this.id,
//     this.title,
//     this.lastName,
//     this.profileUrl,
//   });

//   factory UserDetails.fromJson(Map<String, dynamic> json) {
//     return new UserDetails(
//         id: json['menuId'],
//         title: json['title'],
//         lastName: json['restaurantName'],
//         profileUrl: json['menuImage1']);
//   }
}

var resultData;
