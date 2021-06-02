import 'package:feasturent_costomer_app/screens/home/components/ontap_dineout_tab.dart';
import 'package:feasturent_costomer_app/screens/home/components/ontap_restsurent_tab.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'offer_filter.dart ';

var offerTapData;

class OnTapOffer extends StatefulWidget {
  final id;
  final data;
  const OnTapOffer({Key key, this.data, this.id}) : super(key: key);
  @override
  _OnTapOfferState createState() => _OnTapOfferState();
}

class _OnTapOfferState extends State<OnTapOffer>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    offerTapData = null;
    data = widget.data;

    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
    fetchData();
  }

  var data;
  int dinelength = 00;
  int restLength = 00;
  var restaurantData;
  fetchData() async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  get resturents");

    var result = await http.get(
      APP_ROUTES + 'OfferOnVendor/${data['offerId']}',
    );
    if (result.statusCode == 200) {
      restaurantData = json.decode(result.body)['data'];
      if (mounted) {
        setState(() {
          offerTapData = restaurantData;
          print("this is offer data ");
          print(offerTapData);
        });
        if (offerTapData['dineout'].isNotEmpty) {
          setState(() {
            dinelength = offerTapData['dineout'].length;
          });
        }
        if (offerTapData['restaurant'].isNotEmpty) {
          setState(() {
            restLength = offerTapData['restaurant'].length;
          });
        }
      }
    }
  }

  int listlength;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   leading: IconButton(
          //     icon: Icon(
          //       Icons.arrow_back,
          //       color: Colors.black,
          //     ),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          //   title: Text(
          //     "Best Offer",
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          body: CustomScrollView(
              // physics: NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
              slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              forceElevated: true,
              toolbarHeight: 40,
              expandedHeight: size.height * 0.4,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: size.width * 0.65,
                  width: size.width * 1,
                  child: data['OffersAndCoupon']['image'] != null
                      ? CachedNetworkImage(
                          imageUrl:
                              S3_BASE_PATH + data['OffersAndCoupon']['image'],
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                      : Image.asset(
                          "assets/images/feasturenttemp.jpeg",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              bottom: TabBar(
                controller: _controller,
                indicatorColor: Colors.white,
                tabs: [Tab(text: "Resturent"), Tab(text: "DineOut")],
              ),
              title: Text(
                "Best Offer",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SliverFillRemaining(
              child: Column(
                children: [
                  restLength == 0 && dinelength == 0
                      ? Expanded(child: SizedBox())
                      : Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                _selectedIndex == 0
                                    ? Text(
                                        "$restLength Neareby Resturents",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: size.height * 0.02),
                                      )
                                    : Text(
                                        "$dinelength Neareby Dineouts",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: size.height * 0.02),
                                      ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) => OfferFilter(
                                            // data: restaurantDataCopy[
                                            //             'user'][
                                            //         'OffersAndCoupons']
                                            //     [index],
                                            // amount: couponDetatil,
                                            ));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.sort,
                                        color: Colors.blue,
                                        size: size.height * 0.03,
                                      ),
                                      Text(
                                        "Sort/Filter",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: size.height * 0.02),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          flex: 1,
                        ),
                  Expanded(
                    flex: 8,
                    child: TabBarView(controller: _controller, children: [
                      OnTapResturentTab(),
                      OnTapDineOutTab(),
                    ]),
                  ),
                ],
              ),
            ),
          ])

          //  ListView(
          //   children: [
          //     Container(
          //       height: size.width * 0.65,
          //       width: size.width * 1,
          //       child: data['OffersAndCoupon']['image'] != null
          //           ? CachedNetworkImage(
          //               imageUrl: S3_BASE_PATH + data['OffersAndCoupon']['image'],
          //               fit: BoxFit.fill,
          //               errorWidget: (context, url, error) => Icon(Icons.error),
          //             )
          //           : Image.asset(
          //               "assets/images/feasturenttemp.jpeg",
          //               fit: BoxFit.cover,
          //             ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.all(15.0),
          //       child: TabBar(
          //         indicatorColor: Colors.white,
          //         tabs: [Tab(text: "Resturent"), Tab(text: "DineOut")],
          //       ),
          //     ),
          // Padding(
          //   padding: EdgeInsets.all(15.0),
          //   child: Row(
          //     children: [
          //       Text(
          //         "000 Neareby Resturents",
          //         style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             color: Colors.black,
          //             fontSize: size.height * 0.02),
          //       ),
          //       Spacer(),
          //       InkWell(
          //         onTap: () {
          //           showModalBottomSheet(
          //               context: context,
          //               builder: (context) => OfferFilter(
          //                   // data: restaurantDataCopy[
          //                   //             'user'][
          //                   //         'OffersAndCoupons']
          //                   //     [index],
          //                   // amount: couponDetatil,
          //                   ));
          //         },
          //         child: Row(
          //           children: [
          //             Icon(
          //               Icons.sort,
          //               color: Colors.blue,
          //               size: size.height * 0.03,
          //             ),
          //             Text(
          //               "Sort/Filter",
          //               style: TextStyle(
          //                   color: Colors.blue, fontSize: size.height * 0.02),
          //             )
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          //     // SizedBox(
          //     //   height: size.height * 0.01,
          //     // ),

          //     TabBarView(children: [
          //       OnTapResturentTab(),
          //       OnTapDineOutTab(),
          //     ]),
          //     FutureBuilder<List<dynamic>>(
          //       future: fetchAllRestaurant(),
          //       builder: (context, snapshot) {
          //         if (snapshot.hasData) {
          //           if (restaurantData.length >= 10) {
          //             listlength = 10;
          //           } else if (restaurantData.length <= 10) {
          //             listlength = restaurantData.length;
          //           }

          //           return ListView.builder(
          //             padding: EdgeInsets.symmetric(horizontal: 10),
          //             shrinkWrap: true,
          //             physics: NeverScrollableScrollPhysics(),
          //             itemCount: listlength,
          //             itemBuilder: (context, index) {
          //               var couponDetatil;

          //               if (snapshot
          //                   .data[index]['user']['OffersAndCoupons'].isEmpty) {
          //               } else {
          //                 if (snapshot.data[index]['user']['OffersAndCoupons'][0]
          //                         ['discount'] ==
          //                     null) {
          //                   String symbol;
          //                   if (snapshot.data[index]['user']['OffersAndCoupons'][0]
          //                           ['couponDiscountType'] ==
          //                       "PERCENT") {
          //                     symbol = "%";
          //                   } else {
          //                     symbol = "₹";
          //                   }

          //                   couponDetatil =
          //                       "${snapshot.data[index]['user']['OffersAndCoupons'][0]['couponDiscount']}$symbol off";
          //                 } else {
          //                   String symbol;
          //                   if (snapshot.data[index]['user']['OffersAndCoupons'][0]
          //                           ['discountType'] ==
          //                       "PERCENT") {
          //                     symbol = "%";
          //                   } else {
          //                     symbol = "₹";
          //                   }

          //                   couponDetatil =
          //                       "${snapshot.data[index]['user']['OffersAndCoupons'][0]['discount']}$symbol off";
          //                 }
          //               }

          //               int k = snapshot.data[index]['cuisines'].length;
          //               print(k);
          //               var categoryData = '';
          //               if (k != 0) {
          //                 for (int j = 1; j <= k - 1; j++) {
          //                   categoryData =
          //                       '$categoryData${snapshot.data[index]['cuisines'][j]['Category']['name']},';
          //                 }
          //               } else {
          //                 categoryData = null;
          //               }
          //               return InkWell(
          //                 onTap: () {
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) => OfferListPage(
          //                               restaurantDa: snapshot.data[index])));
          //                 },
          //                 child: Padding(
          //                   padding: const EdgeInsets.only(bottom: 14),
          //                   child: Container(
          //                       decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.circular(10),
          //                           color: Colors.white,
          //                           boxShadow: [
          //                             BoxShadow(
          //                                 blurRadius: 2,
          //                                 color: Colors.grey[200],
          //                                 offset: Offset(0, 3),
          //                                 spreadRadius: 2)
          //                           ]),
          //                       margin: EdgeInsets.only(
          //                         left: size.width * 0.02,
          //                         right: size.width * 0.02,
          //                       ),
          //                       height: size.height * 0.135,
          //                       child: Row(children: [
          //                         Expanded(
          //                             flex: 0,
          //                             child: Container(
          //                               alignment: Alignment.topCenter,
          //                               height: size.height * 0.2,
          //                               child: Stack(
          //                                 children: [
          //                                   Container(
          //                                     margin: EdgeInsets.all(8),
          //                                     child: ClipRRect(
          //                                       borderRadius:
          //                                           BorderRadius.circular(10),
          //                                       child: snapshot.data[index]['user']
          //                                                   ['profile'] !=
          //                                               null
          //                                           ? CachedNetworkImage(
          //                                               imageUrl: S3_BASE_PATH +
          //                                                   snapshot.data[index]
          //                                                       ['user']['profile'],
          //                                               height: size.height * 0.18,
          //                                               width: size.width * 0.3,
          //                                               fit: BoxFit.fill,
          //                                               placeholder:
          //                                                   (context, url) =>
          //                                                       Image.asset(
          //                                                 "assets/images/feasturenttemp.jpeg",
          //                                                 height:
          //                                                     size.height * 0.18,
          //                                                 width: size.width * 0.3,
          //                                                 fit: BoxFit.cover,
          //                                               ),
          //                                               errorWidget:
          //                                                   (context, url, error) =>
          //                                                       Icon(Icons.error),
          //                                             )
          //                                           : Image.asset(
          //                                               "assets/images/feasturenttemp.jpeg",
          //                                               height: size.height * 0.18,
          //                                               width: size.width * 0.3,
          //                                               fit: BoxFit.cover,
          //                                             ),
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                             )),
          //                         Expanded(
          //                             flex: 6,
          //                             child: Container(
          //                               height: size.height * 0.2,
          //                               child: Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 mainAxisSize: MainAxisSize.max,
          //                                 children: [
          //                                   Container(
          //                                     margin: EdgeInsets.only(
          //                                         top: size.height * 0.02),
          //                                     child: Row(
          //                                       children: [
          //                                         Text(
          //                                           capitalize(snapshot.data[index]
          //                                               ['name']),
          //                                           style: TextStyle(
          //                                               fontWeight: FontWeight.bold,
          //                                               color: Colors.black,
          //                                               fontSize:
          //                                                   size.height * 0.02),
          //                                         ),
          //                                         Spacer(),
          //                                         Padding(
          //                                           padding: const EdgeInsets.only(
          //                                               right: 12),
          //                                         )
          //                                       ],
          //                                     ),
          //                                   ),
          //                                   SizedBox(
          //                                     height: size.height * 0.005,
          //                                   ),
          //                                   categoryData == null
          //                                       ? SizedBox()
          //                                       : Container(
          //                                           width: size.width * 0.38,
          //                                           child: Text(
          //                                             "$categoryData",
          //                                             overflow:
          //                                                 TextOverflow.ellipsis,
          //                                             style: TextStyle(
          //                                               fontSize:
          //                                                   size.height * 0.0175,
          //                                               color: Colors.black,
          //                                             ),
          //                                           ),
          //                                         ),
          //                                   SizedBox(
          //                                     height: size.height * 0.015,
          //                                   ),
          //                                   Container(
          //                                     child: Row(
          //                                       children: [
          //                                         snapshot.data[index]
          //                                                     ['avgRating'] ==
          //                                                 null
          //                                             ? Text(
          //                                                 "⭐1",
          //                                                 style: TextStyle(
          //                                                     fontSize:
          //                                                         size.height *
          //                                                             0.016,
          //                                                     color: Colors.red,
          //                                                     fontWeight:
          //                                                         FontWeight.bold),
          //                                               )
          //                                             : Container(
          //                                                 child: Row(
          //                                                   children: [
          //                                                     Container(
          //                                                       child: Text("⭐"),
          //                                                     ),
          //                                                     Text(
          //                                                       snapshot.data[index]
          //                                                               [
          //                                                               'avgRating']
          //                                                           .toString(),
          //                                                       style: TextStyle(
          //                                                           fontSize:
          //                                                               size.height *
          //                                                                   0.016,
          //                                                           color:
          //                                                               Colors.red,
          //                                                           fontWeight:
          //                                                               FontWeight
          //                                                                   .bold),
          //                                                     ),
          //                                                   ],
          //                                                 ),
          //                                               ),
          //                                         Spacer(),
          //                                         couponDetatil == null
          //                                             ? SizedBox()
          //                                             : Image.asset(
          //                                                 "assets/icons/discount_icon.jpg",
          //                                                 height:
          //                                                     size.height * 0.02,
          //                                               ),
          //                                         couponDetatil == null
          //                                             ? snapshot.data[index]
          //                                                         ['avgCost'] ==
          //                                                     null
          //                                                 ? SizedBox()
          //                                                 : Padding(
          //                                                     padding:
          //                                                         const EdgeInsets
          //                                                             .only(
          //                                                       right: 12.0,
          //                                                     ),
          //                                                     child: Text(
          //                                                       "₹ ${snapshot.data[index]['avgCost']} Cost for ${snapshot.data[index]['forPeople']}",
          //                                                       style: TextStyle(
          //                                                           fontWeight:
          //                                                               FontWeight
          //                                                                   .bold,
          //                                                           fontSize:
          //                                                               size.height *
          //                                                                   0.016,
          //                                                           color:
          //                                                               kTextColor),
          //                                                     ),
          //                                                   )
          //                                             : Padding(
          //                                                 padding:
          //                                                     const EdgeInsets.only(
          //                                                   right: 12.0,
          //                                                 ),
          //                                                 child: Text(
          //                                                   couponDetatil,
          //                                                   style: TextStyle(
          //                                                       fontWeight:
          //                                                           FontWeight.bold,
          //                                                       fontSize:
          //                                                           size.height *
          //                                                               0.016,
          //                                                       color: kTextColor),
          //                                                 ),
          //                                               ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ))
          //                       ])),
          //                 ),
          //               );
          //             },
          //           );
          //         } else {
          //           return LoadingListPage();
          //         }
          //       },
          //     )
          //   ],
          // ),
          ),
    );
  }
}
