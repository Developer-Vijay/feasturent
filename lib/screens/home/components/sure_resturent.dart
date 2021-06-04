import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/resturent_menues.dart';
import 'package:feasturent_costomer_app/screens/home/components/discount_card.dart';
import 'package:feasturent_costomer_app/screens/home/components/popular.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class SureResturent extends StatefulWidget {
  const SureResturent({
    Key key,
  }) : super(key: key);
  @override
  _SureResturentState createState() => _SureResturentState();
}
  var listlength1 = 0;
var restaurantData1;
class _SureResturentState extends State<SureResturent> {
  String _authorization = '';
  void initState() {
    super.initState();
  }

  
fetchAllRestaurant() async {
        return allresturentmemoizer.runOnce(() async {





    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  get resturents");

    var result = await http.get(
      Uri.parse( APP_ROUTES +
          'getRestaurantInfos' +
          '?key=ALL' +
          '&latitude=' +
          latitude.toString() +
          '&longitude=' +
          longitude.toString(),)
     
    );
    print(_authorization);
    restaurantData1 = json.decode(result.body)['data'];
    if (restaurantData1.isEmpty) {
      return restaurantData1;
    } else {
      restaurantData1 = restaurantData1;
      return restaurantData1;
    }
  });}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: size.width * 0.05),
                child: Text(
                  "Sure Choice Restaurant",
                  style: TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.025),
                )),
            Spacer(),
            // Container(
            //     child: FlatButton(
            //         onPressed: () {
            //           if (restaurantData != null) {
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) => ViewallRestaurant(
            //                     restData: restaurantData,
            //                   ),
            //                 ));
            //           }
            //         },
            //         child: Row(
            //           children: [
            //             Container(
            //               margin: EdgeInsets.only(left: 15),
            //               child: Text(
            //                 "View All",
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     color: kPrimaryColor),
            //               ),
            //             ),
            //             Icon(
            //               Icons.arrow_right_rounded,
            //               color: kSecondaryTextColor,
            //             ),
            //           ],
            //         )))
          ],
        ),
        SizedBox(
          height: size.height * 0.017,
        ),
        FutureBuilder(
          future: this.fetchAllRestaurant(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (restaurantData1.length >= 5) {
                listlength1 = 5;
              } else if (restaurantData1.length <= 5) {
                listlength1 = restaurantData1.length;
              }

              return Container(
                height: size.height * 0.435,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listlength1,
                  itemBuilder: (context, index) {
                    var couponDetatil;
                    // double rating = 1.0;
                    // int j = snapshot.data[index]['VendorRatingReviews'].length;

                    // for (int i = 0; i < j - 1; i++) {
                    //   rating = rating +
                    //       double.parse(snapshot.data[index]['VendorRatingReviews']
                    //           [i]['rating']);
                    // }
                    // rating = rating / j;

                    if (snapshot
                        .data[index]['user']['OffersAndCoupons'].isEmpty) {
                    } else {
                      if (snapshot.data[index]['user']['OffersAndCoupons'][0]
                              ['discount'] ==
                          null) {
                        String symbol;
                        if (snapshot.data[index]['user']['OffersAndCoupons'][0]
                                ['couponDiscountType'] ==
                            "PERCENT") {
                          symbol = "%";
                        } else {
                          symbol = "₹";
                        }

                        couponDetatil =
                            "${snapshot.data[index]['user']['OffersAndCoupons'][0]['couponDiscount']}$symbol off";
                      } else {
                        String symbol;
                        if (snapshot.data[index]['user']['OffersAndCoupons'][0]
                                ['discountType'] ==
                            "PERCENT") {
                          symbol = "%";
                        } else {
                          symbol = "₹";
                        }

                        couponDetatil =
                            "${snapshot.data[index]['user']['OffersAndCoupons'][0]['discount']}$symbol off";
                      }
                    }

                    int k = snapshot.data[index]['cuisines'].length;
                    print(k);
                    var categoryData = '';
                    if (k != 0) {
                      for (int j = 0; j <= k - 1; j++) {
                        categoryData =
                            '$categoryData${snapshot.data[index]['cuisines'][j]['Category']['name']},';
                      }
                    } else {
                      categoryData = null;
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OfferListPage(
                                          ratingVendor: snapshot.data[index]
                                              ['avgRating'],
                                          restaurantDa: snapshot.data[index])));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                margin:
                                    EdgeInsets.only(left: size.width * 0.011),
                                height: size.height * 0.415,
                                width: size.width * 0.6,
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     color: Colors.blueGrey,
                                              //   )
                                              // ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                            ),
                                            child: snapshot.data[index]['user']
                                                        ['coverPicture'] !=
                                                    null
                                                ? CachedNetworkImage(
                                                    imageUrl: S3_BASE_PATH +
                                                        snapshot.data[index]
                                                                ['user']
                                                            ['coverPicture'],
                                                    fit: BoxFit.cover,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        // boxShadow: [
                                                        //   BoxShadow(
                                                        //       blurRadius: 3,
                                                        //       color: Colors
                                                        //           .blueGrey,
                                                        //       spreadRadius: 1)
                                                        // ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                      "assets/images/feasturenttemp.jpeg",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      // boxShadow: [
                                                      //   BoxShadow(
                                                      //       blurRadius: 3,
                                                      //       color:
                                                      //           Colors.blueGrey,
                                                      //       spreadRadius: 1)
                                                      // ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/feasturenttemp.jpeg"),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(12),
                                                    bottomRight:
                                                        Radius.circular(12)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.blueGrey,
                                                  )
                                                ],
                                                color: Colors.white,
                                              ),
                                              height: double.infinity,
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: size.height * 0.035,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    width: size.width * 0.5,
                                                    child: Text(
                                                        "${snapshot.data[index]['name']}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color: Color(
                                                                0xff454cb0),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  categoryData == null
                                                      ? SizedBox()
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          width:
                                                              size.width * 0.5,
                                                          child: Text(
                                                              "$categoryData",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                  Row(
                                                    children: [
                                                      couponDetatil == null
                                                          ? SizedBox()
                                                          : Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10),
                                                              child:
                                                                  Image.asset(
                                                                "assets/icons/discount_icon.jpg",
                                                                height:
                                                                    size.height *
                                                                        0.04,
                                                              ),
                                                            ),
                                                      couponDetatil == null
                                                          ? SizedBox()
                                                          : Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5),
                                                              width:
                                                                  size.width *
                                                                      0.5,
                                                              child: Text(
                                                                  "$couponDetatil",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black,
                                                                  )),
                                                            ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          width: double.infinity,
                                          height: 15,
                                        )
                                      ],
                                    ),
                                    Positioned(
                                      top: size.height * 0.155,
                                      left: size.width * 0.034,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                          ),
                                          height: size.height * 0.1,
                                          width: size.width * 0.2,
                                          child: snapshot.data[index]['user']
                                                      ['profile'] !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl: S3_BASE_PATH +
                                                      snapshot.data[index]
                                                          ['user']['profile'],
                                                  fit: BoxFit.cover,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 3,
                                                            color:
                                                                Colors.blueGrey,
                                                            spreadRadius: 1)
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                    "assets/images/feasturenttemp.jpeg",
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Container(
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          blurRadius: 3,
                                                          color:
                                                              Colors.blueGrey,
                                                          spreadRadius: 1)
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/feasturenttemp.jpeg"),
                                                        fit: BoxFit.cover),
                                                  ),
                                                )
                                          // Image.asset(
                                          //     "assets/images/feasturenttemp.jpeg",
                                          //     fit: BoxFit.cover,
                                          //     height: double.infinity,
                                          //     width: double.infinity,
                                          //   ),
                                          ),
                                    ),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffd3fdcd),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                          ),
                                          height: size.height * 0.05,
                                          width: size.width * 0.44,
                                          child: Center(
                                              child: Text("Tap to be Sure",
                                                  style: TextStyle(
                                                      color: Color(0xff454cb0),
                                                      fontWeight:
                                                          FontWeight.bold))),
                                        ))
                                  ],
                                )),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else {
              return Container(
                height: size.height * 0.435,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                          child: InkWell(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[100],
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                  margin:
                                      EdgeInsets.only(left: size.width * 0.011),
                                  height: size.height * 0.415,
                                  width: size.width * 0.6,
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.blueGrey,
                                                  )
                                                ],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.blueGrey,
                                                    )
                                                  ],
                                                ),
                                                height: double.infinity,
                                                width: double.infinity,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.035,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      width: size.width * 0.5,
                                                      color: Colors.white,
                                                    ),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        width:
                                                            size.width * 0.35,
                                                        color: Colors.white),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        width:
                                                            size.width * 0.28,
                                                        color: Colors.white),
                                                  ],
                                                )),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 15,
                                          )
                                        ],
                                      ),
                                      Positioned(
                                        top: size.height * 0.155,
                                        left: size.width * 0.034,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                          ),
                                          height: size.height * 0.1,
                                          width: size.width * 0.2,
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                            ),
                                            height: size.height * 0.05,
                                            width: size.width * 0.44,
                                          ))
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }
          },
        )
      ],
    );
  }
}
