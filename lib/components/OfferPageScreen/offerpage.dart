import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/insideofferpage.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OfferPageScreen extends StatefulWidget {
  @override
  _OfferPageScreenState createState() => _OfferPageScreenState();
}

class _OfferPageScreenState extends State<OfferPageScreen> {
  var random;

  int _currentMax = 10;
  int sum = 0;
  int i;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  void initState() {
    super.initState();

    refreshList();
  }

  Future refreshList() async {}

  var restaurantData;
  Future<List<dynamic>> fetchAllRestaurant() async {
    var result = await http.get(
      APP_ROUTES +
          'getRestaurantInfos' +
          '?key=ALL' +
          '&latitude=' +
          latitude.toString() +
          '&longitude=' +
          longitude.toString(),
    );
    print("data fetch");
    restaurantData = json.decode(result.body)['data']['vendorInfo'];
    return restaurantData;
  }

  var sliderOffers;
  Future<List<dynamic>> fetchposterOffer() async {
    var result = await http
        .get(APP_ROUTES + 'utilities' + '?key=BYFOR' + '&for=posterOffer');
    sliderOffers = json.decode(result.body)['data'];
    if (sliderOffers.isEmpty) {
      print("data not here");
    } else {
      print("data here");
      if (sliderOffers[0]['status'] == true) {
        return sliderOffers;
      }
    }
  }

  Future<List<dynamic>> fetchOfferBanner() async {
    var result = await http
        .get(APP_ROUTES + 'utilities' + '?key=BYFOR' + '&for=offerBanner');
    var sliderOffer = json.decode(result.body)['data'];
    if (sliderOffer.isEmpty) {
      print("data not here");
    } else {
      print("data here");
      if (sliderOffer[0]['status'] == true) {
        return sliderOffer;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var disountNumber = size.width * 0.04;
    var discountuptp = size.height * 0.026;
    var discountwith = size.height * 0.034;
    var discountby = size.width * 0.05;

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: refreshList,
          child: ListView(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: size.width * 0.03),
                  child: Text(
                    "Best Offers",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
              // Slider
              Container(
                height: size.height * 0.24,
                width: size.width * 1,
                margin: EdgeInsets.only(top: size.height * 0.008),
                child: FutureBuilder<List<dynamic>>(
                  future: fetchposterOffer(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left: size.width * 0.03),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: size.width * 0.34,
                            height: size.height * 0.24,
                            child: snapshot.data[index]['OffersAndCoupon']
                                        ['image'] !=
                                    null
                                ? CachedNetworkImage(
                                    width: size.width * 0.89722,
                                    imageUrl: S3_BASE_PATH +
                                        snapshot.data[index]['OffersAndCoupon']
                                            ['image'],
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  )
                                : Image.asset(
                                    "assets/images/feasturenttemp.jpeg",
                                    fit: BoxFit.cover,
                                  ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.014,
              ),
              // Pamplet
              Container(
                height: size.height * 0.14,
                width: size.width * 1,
                child: FutureBuilder<List<dynamic>>(
                  future: fetchOfferBanner(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var leng;
                      if (snapshot.data.length > 4) {
                        leng = 4;
                      } else {
                        leng = snapshot.data.length;
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: leng,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                              left: size.width * 0.03,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index == 0
                                  ? Colors.orange[600]
                                  : index == 1
                                      ? Colors.red[300]
                                      : index == 2
                                          ? Colors.blue[300]
                                          : Colors.deepPurple,
                            ),
                            width: size.width * 0.95,
                            height: size.height * 0.14,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: size.height * 0.1,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: EdgeInsets.only(
                                      right: size.width * 0.0,
                                      left: size.width * 0.1,
                                    ),
                                    child: snapshot.data[index]
                                                ['OffersAndCoupon']['image'] !=
                                            null
                                        ? CachedNetworkImage(
                                            width: size.width * 0.89722,
                                            imageUrl: S3_BASE_PATH +
                                                snapshot.data[index]
                                                        ['OffersAndCoupon']
                                                    ['image'],
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          )
                                        : Image.asset(
                                            "assets/images/feasturenttemp.jpeg",
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.05,
                                ),
                                DottedLine(
                                  dashGapLength: 0,
                                  dashGapRadius: 0,
                                  dashGapColor: Colors.white,
                                  lineThickness: 2,
                                  dashColor: Colors.white,
                                  lineLength: size.height * 0.08,
                                  direction: Axis.vertical,
                                ),
                                Container(
                                  height: size.height * 0.08,
                                  alignment: Alignment.topCenter,
                                  // margin: EdgeInsets.only(
                                  //     top: size.height * 0.04, left: size.width * 0.019),
                                  child: Column(children: [
                                    Container(
                                      width: size.width * 0.5,
                                      child: Text(
                                        "${snapshot.data[index]['OffersAndCoupon']['title']}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.height * 0.03,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 0.5,
                                      child: Text(
                                        "${snapshot.data[index]['OffersAndCoupon']['description']}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.height * 0.03,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),

              SizedBox(
                height: size.height * 0.02,
              ),
              // List Starts from Here

              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: size.width * 0.03),
                  child: Text(
                    "Offers",
                    style: TextStyle(
                        color: kTextColor, fontWeight: FontWeight.bold),
                  )),

              SizedBox(
                height: size.height * 0.017,
              ),
              // Important Data

              FutureBuilder<List<dynamic>>(
                future: fetchAllRestaurant(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // if (restaurantData.length >= 10) {
                    //   listlength = 10;
                    // } else if (restaurantData.length <= 10) {
                    //   listlength = restaurantData.length;
                    // }
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: restaurantData.length,
                      itemBuilder: (context, index) {
                        if (snapshot
                            .data[index]['user']['OffersAndCoupons'].isEmpty) {
                          return SizedBox();
                        } else {
                          var couponDetatil;
                          if (snapshot.data[index]['user']['OffersAndCoupons']
                                  [0]['discount'] ==
                              null) {
                            String symbol;
                            if (snapshot.data[index]['user']['OffersAndCoupons']
                                    [0]['couponDiscountType'] ==
                                "PERCENT") {
                              symbol = "%";
                            } else {
                              symbol = "₹";
                            }

                            couponDetatil =
                                "${snapshot.data[index]['user']['OffersAndCoupons'][0]['couponDiscount']}$symbol${snapshot.data[index]['user']['OffersAndCoupons'][0]['coupon']}";
                          } else {
                            String symbol;
                            if (snapshot.data[index]['user']['OffersAndCoupons']
                                    [0]['discountType'] ==
                                "PERCENT") {
                              symbol = "%";
                            } else {
                              symbol = "₹";
                            }

                            couponDetatil =
                                "${snapshot.data[index]['user']['OffersAndCoupons'][0]['discount']}$symbol${snapshot.data[index]['user']['OffersAndCoupons'][0]['coupon']}";
                          }
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OfferListPage(
                                          restaurantDa: snapshot.data[index])));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 2,
                                            color: Colors.grey[200],
                                            offset: Offset(0, 3),
                                            spreadRadius: 2)
                                      ]),
                                  margin: EdgeInsets.only(
                                    left: size.width * 0.02,
                                    right: size.width * 0.02,
                                  ),
                                  height: size.height * 0.135,
                                  child: Row(children: [
                                    Expanded(
                                        flex: 0,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          height: size.height * 0.2,
                                          child: Stack(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(8),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: snapshot.data[index]
                                                                  ['user']
                                                              ['profile'] !=
                                                          null
                                                      ? CachedNetworkImage(
                                                          imageUrl: S3_BASE_PATH +
                                                              snapshot.data[
                                                                          index]
                                                                      ['user']
                                                                  ['profile'],
                                                          height: size.height *
                                                              0.18,
                                                          width:
                                                              size.width * 0.3,
                                                          fit: BoxFit.fill,
                                                          placeholder: (context,
                                                                  url) =>
                                                              Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        )
                                                      : Image.asset(
                                                          "assets/images/feasturenttemp.jpeg",
                                                          height: size.height *
                                                              0.18,
                                                          width:
                                                              size.width * 0.3,
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                    Expanded(
                                        flex: 6,
                                        child: Container(
                                          height: size.height * 0.2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: size.height * 0.02),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      snapshot.data[index]
                                                          ['name'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize:
                                                              size.height *
                                                                  0.02),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 12),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              snapshot.data[index]['type'] ==
                                                      null
                                                  ? SizedBox()
                                                  : Column(
                                                      children: [
                                                        SizedBox(
                                                          height: size.height *
                                                              0.013,
                                                        ),
                                                        Container(
                                                          width:
                                                              size.width * 0.35,
                                                          child: Text(
                                                            snapshot.data[index]
                                                                ['type'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.015,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                              SizedBox(
                                                height: size.height * 0.015,
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    snapshot.data[index]
                                                                ['avgRating'] ==
                                                            null
                                                        ? Text(
                                                            "Not Rated",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.016,
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : Container(
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  child:
                                                                      Text("⭐"),
                                                                ),
                                                                Text(
                                                                  snapshot.data[
                                                                          index]
                                                                          [
                                                                          'avgRating']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          size.height *
                                                                              0.016,
                                                                      color: Colors
                                                                          .red,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                    Spacer(),
                                                    couponDetatil == null
                                                        ? SizedBox()
                                                        : Image.asset(
                                                            "assets/icons/discount_icon.jpg",
                                                            height:
                                                                size.height *
                                                                    0.02,
                                                          ),
                                                    couponDetatil == null
                                                        ? SizedBox()
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 12.0,
                                                            ),
                                                            child: Text(
                                                              couponDetatil,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      size.height *
                                                                          0.016,
                                                                  color:
                                                                      kTextColor),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                  ])),
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
