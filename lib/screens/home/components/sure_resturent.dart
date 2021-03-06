import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/resturent_menues.dart';
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

var restaurantDatafinal1;

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

  bool show = false;

  var data2;
  fetchAllRestaurant() async {
    return allresturentmemoizer.runOnce(() async {
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  get resturents");

      var result = await http.get(Uri.parse(
        APP_ROUTES +
            'getRestaurantInfos' +
            '?key=ALL' +
            '&latitude=' +
            latitude.toString() +
            '&longitude=' +
            longitude.toString(),
      ));

      print("######################!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

      if (result.statusCode == 200) {
        setState(() {
          restaurantData1 = json.decode(result.body)['data'];
          restaurantDatafinal1 = json.decode(result.body)['data'];
        });
        setState(() {
          // restaurantDatafinal1=restaurantData1['data'];
          data2 = json.decode(result.body)['data'];
          show = false;
        });

        if (restaurantData1.isEmpty) {
          return restaurantData1;
        } else {
          restaurantData1 = restaurantData1;
          return restaurantData1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: FutureBuilder(
        future: this.fetchAllRestaurant(),
        builder: (context, snapshot) {
          print('4444444444444444444444444:::::::::::::::::::::');
          print(snapshot.data);
          if (snapshot.hasData) {
            if (restaurantData1.length >= 15) {
              listlength1 = 15;
            } else if (restaurantData1.length <= 15) {
              listlength1 = restaurantData1.length;
            }
            return snapshot.data.length <= 0
                ? SizedBox()
                : Container(
                    height: size.height * 0.485,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: size.width * 0.05),
                              child: Text(
                                "Sure Choice Restaurant",
                                style: TextStyle(
                                    color: kTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.025),
                              )),
                        ),
                        Expanded(
                          flex: 10,
                          child: Container(
                            height: size.height * 0.435,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: listlength1,
                              itemBuilder: (context, index) {
                                var couponDetatil;

                                if (snapshot
                                    .data[index]['user']['OffersAndCoupons']
                                    .isEmpty) {
                                } else {
                                  if (snapshot.data[index]['user']
                                          ['OffersAndCoupons'][0]['discount'] ==
                                      null) {
                                    String symbol;
                                    if (snapshot.data[index]['user']
                                                ['OffersAndCoupons'][0]
                                            ['couponDiscountType'] ==
                                        "PERCENT") {
                                      symbol = "%";
                                    } else {
                                      symbol = "???";
                                    }

                                    couponDetatil =
                                        "${snapshot.data[index]['user']['OffersAndCoupons'][0]['couponDiscount']}$symbol off";
                                  } else {
                                    String symbol;
                                    if (snapshot.data[index]['user']
                                                ['OffersAndCoupons'][0]
                                            ['discountType'] ==
                                        "PERCENT") {
                                      symbol = "%";
                                    } else {
                                      symbol = "???";
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
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 12.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OfferListPage(
                                                          ratingVendor: snapshot
                                                              .data[index]
                                                                  ['avgRating']
                                                              .toDouble(),
                                                          restaurantDa: snapshot
                                                              .data[index])));
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                            ),
                                            margin: EdgeInsets.only(
                                                left: size.width * 0.011),
                                            height: size.height * 0.415,
                                            width: size.width * 0.6,
                                            child: Stack(
                                              children: [
                                                Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          // boxShadow: [
                                                          //   BoxShadow(
                                                          //     color: Colors.blueGrey,
                                                          //   )
                                                          // ],
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12)),
                                                        ),
                                                        child: snapshot.data[
                                                                            index]
                                                                        ['user']
                                                                    [
                                                                    'coverPicture'] !=
                                                                null
                                                            ? CachedNetworkImage(
                                                                imageUrl: S3_BASE_PATH +
                                                                    snapshot.data[index]
                                                                            [
                                                                            'user']
                                                                        [
                                                                        'coverPicture'],
                                                                fit: BoxFit
                                                                    .cover,
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    // boxShadow: [
                                                                    //   BoxShadow(
                                                                    //       blurRadius: 3,
                                                                    //       color: Colors
                                                                    //           .blueGrey,
                                                                    //       spreadRadius: 1)
                                                                    // ],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    image: DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .cover),
                                                                  ),
                                                                ),
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Image.asset(
                                                                  "assets/images/feasturenttemp.jpeg",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              )
                                                            : Container(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  // boxShadow: [
                                                                  //   BoxShadow(
                                                                  //       blurRadius: 3,
                                                                  //       color:
                                                                  //           Colors.blueGrey,
                                                                  //       spreadRadius: 1)
                                                                  // ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          "assets/images/feasturenttemp.jpeg"),
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        12),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        12)),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .blueGrey,
                                                              )
                                                            ],
                                                            color: Colors.white,
                                                          ),
                                                          height:
                                                              double.infinity,
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.035,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                    width:
                                                                        size.width *
                                                                            0.4,
                                                                    child: Text(
                                                                        "${snapshot.data[index]['name']}",
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            color:
                                                                                Color(0xff454cb0),
                                                                            fontWeight: FontWeight.bold)),
                                                                  ),
                                                                  Spacer(),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        right:
                                                                            15),
                                                                    height: 20,
                                                                    width: 40,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .green,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child: snapshot.data[index]['avgRating'] ==
                                                                              0
                                                                          ? Text(
                                                                              "???1.0",
                                                                              style: TextStyle(fontSize: size.height * 0.018, color: Colors.white, fontWeight: FontWeight.bold),
                                                                            )
                                                                          : Text(
                                                                              "???${snapshot.data[index]['avgRating']}",
                                                                              style: TextStyle(fontSize: size.height * 0.018, color: Colors.white, fontWeight: FontWeight.bold),
                                                                            ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              categoryData ==
                                                                      null
                                                                  ? SizedBox()
                                                                  : Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              10),
                                                                      width: size
                                                                              .width *
                                                                          0.5,
                                                                      child: Text(
                                                                          "$categoryData",
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                    ),
                                                              Row(
                                                                children: [
                                                                  couponDetatil ==
                                                                          null
                                                                      ? SizedBox()
                                                                      : Container(
                                                                          padding:
                                                                              EdgeInsets.only(left: 10),
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/icons/discount_icon.jpg",
                                                                            height:
                                                                                size.height * 0.04,
                                                                          ),
                                                                        ),
                                                                  couponDetatil ==
                                                                          null
                                                                      ? SizedBox()
                                                                      : Container(
                                                                          padding:
                                                                              EdgeInsets.only(left: 5),
                                                                          width:
                                                                              size.width * 0.45,
                                                                          child: Text(
                                                                              "$couponDetatil",
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(
                                                                                fontSize: 13,
                                                                                color: Colors.black,
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
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                      ),
                                                      height: size.height * 0.1,
                                                      width: size.width * 0.2,
                                                      child: snapshot.data[
                                                                          index]
                                                                      ['user']
                                                                  ['profile'] !=
                                                              null
                                                          ? CachedNetworkImage(
                                                              imageUrl: S3_BASE_PATH +
                                                                  snapshot.data[
                                                                              index]
                                                                          [
                                                                          'user']
                                                                      [
                                                                      'profile'],
                                                              fit: BoxFit.cover,
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        blurRadius:
                                                                            3,
                                                                        color: Colors
                                                                            .blueGrey,
                                                                        spreadRadius:
                                                                            1)
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              ),
                                                              height: double
                                                                  .infinity,
                                                              width: double
                                                                  .infinity,
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Icon(Icons
                                                                      .error),
                                                              placeholder:
                                                                  (context,
                                                                          url) =>
                                                                      Image
                                                                          .asset(
                                                                "assets/images/defaultrestaurent.png",
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )
                                                          : Container(
                                                              height: double
                                                                  .infinity,
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      blurRadius:
                                                                          3,
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      spreadRadius:
                                                                          1)
                                                                ],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        "assets/images/defaultrestaurent.png"),
                                                                    fit: BoxFit
                                                                        .cover),
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
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffd3fdcd),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                      ),
                                                      height:
                                                          size.height * 0.05,
                                                      width: size.width * 0.44,
                                                      child: Center(
                                                          child: Text(
                                                              "Tap to be Sure",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff454cb0),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                    ))
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          } else {
            return Container(
              height: size.height * 0.485,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: size.width * 0.05),
                        child: Text(
                          "Sure Choice Restaurant",
                          style: TextStyle(
                              color: kTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: size.height * 0.025),
                        )),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      height: size.height * 0.435,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 12.0),
                                child: InkWell(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.grey[100],
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                        margin: EdgeInsets.only(
                                            left: size.width * 0.011),
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
                                                          color:
                                                              Colors.blueGrey,
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12)),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.035,
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            width: size.width *
                                                                0.5,
                                                            color: Colors.white,
                                                          ),
                                                          Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10),
                                                              width:
                                                                  size.width *
                                                                      0.35,
                                                              color:
                                                                  Colors.white),
                                                          Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10),
                                                              width:
                                                                  size.width *
                                                                      0.28,
                                                              color:
                                                                  Colors.white),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                ),
                                                height: size.height * 0.1,
                                                width: size.width * 0.2,
                                              ),
                                            ),
                                            Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
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
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
