import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/resturent_menues.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/components/ontap_offer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../shimmer_effect.dart';

class OfferPageScreen extends StatefulWidget {
  @override
  _OfferPageScreenState createState() => _OfferPageScreenState();
}

class _OfferPageScreenState extends State<OfferPageScreen> {
  var random;

  int sum = 0;
  int i;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  var restaurantData;
  Future<List<dynamic>> fetchAllRestaurant() async {
    fetchOfferBanner();
    fetchposterOffer();
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  getresturent");

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
    if (result.statusCode == 200) {
      restaurantData = json.decode(result.body)['data'];
      return restaurantData;
    } else {
      var tempdata = [];
      return tempdata;
    }
  }

  var sliderOffers;
  int psteroffer;

  Future<List<dynamic>> fetchposterOffer() async {
    var result = await http
        .get(APP_ROUTES + 'utilities' + '?key=BYFOR' + '&for=posterOffer');
    sliderOffers = json.decode(result.body)['data'];
    if (sliderOffers.isEmpty) {
      sliderOffers = [];
      psteroffer = 0;
      print("emapty poster");

      return sliderOffers;
    } else {
      print("data here");
      if (sliderOffers[0]['status'] == true) {
        print("Status is true poster and ");
        psteroffer = 1;
        return sliderOffers;
      } else {
        psteroffer = 0;
        sliderOffers = [];

        print("Status is false poster and $sliderOffers");

        return sliderOffers;
      }
    }
  }

  var sliderOffer;
  int offerbanner;
  // ignore: missing_return
  Future<List<dynamic>> fetchOfferBanner() async {
    var result = await http
        .get(APP_ROUTES + 'utilities' + '?key=BYFOR' + '&for=offerBanner');
    sliderOffer = json.decode(result.body)['data'];
    if (sliderOffer.isEmpty) {
      sliderOffer = [];
      offerbanner = 0;
      print("empty banner $sliderOffer");
      return sliderOffer;
    } else {
      print("data here");
      if (sliderOffer[0]['status'] == true) {
        offerbanner = 1;
        return sliderOffer;
      } else {
        offerbanner = 0;
        sliderOffer = [];

        print("Status is false and banner $sliderOffer");
        return sliderOffer;
      }
    }
  }

  int checkposter;
  int checkbanner;
  @override
  Widget build(BuildContext context) {
    if (checkbanner != offerbanner) {
      setState(() {
        checkbanner = offerbanner;
      });
    }
    if (checkposter != psteroffer) {
      setState(() {
        checkposter = psteroffer;
      });
    }
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: ListView(
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
            psteroffer == 0
                ? SizedBox()
                : Container(
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
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OnTapOffer(
                                                data: snapshot.data[index],
                                              )));
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: size.width * 0.03),
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
                                              snapshot.data[index]
                                                  ['OffersAndCoupon']['image'],
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
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )
                                      : Image.asset(
                                          "assets/images/feasturenttemp.jpeg",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              );
                            },
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: size.width * 0.03),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: size.width * 0.34,
                                  height: size.height * 0.24,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
            SizedBox(
              height: size.height * 0.014,
            ),
            // Pamplet
            offerbanner == 0
                ? SizedBox()
                : Container(
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
                          return Swiper(
                            pagination: SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.grey[300],
                                  size: 6,
                                  activeSize: 12),
                            ),
                            itemCount: leng,
                            itemWidth: 300,
                            layout: SwiperLayout.DEFAULT,
                            autoplay: true,
                            autoplayDelay: 2000,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OnTapOffer(
                                                data: snapshot.data[index],
                                              )));
                                },
                                child: Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                          ['OffersAndCoupon']
                                                      ['image'] !=
                                                  null
                                              ? CachedNetworkImage(
                                                  width: size.width * 0.89722,
                                                  imageUrl: S3_BASE_PATH +
                                                      snapshot.data[index][
                                                              'OffersAndCoupon']
                                                          ['image'],
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill),
                                                    ),
                                                  ),
                                                  fit: BoxFit.fill,
                                                  placeholder: (context, url) =>
                                                      Center(
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
                                      SizedBox(
                                        width: size.width * 0.05,
                                      ),
                                      Container(
                                        height: size.height * 0.08,
                                        alignment: Alignment.topCenter,
                                        child: Column(children: [
                                          Container(
                                            width: size.width * 0.45,
                                            child: Text(
                                              capitalize(
                                                  "${snapshot.data[index]['OffersAndCoupon']['title']}"),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.height * 0.028,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: size.width * 0.45,
                                            child: snapshot.data[index]
                                                            ['OffersAndCoupon']
                                                        ['description'] !=
                                                    null
                                                ? Text(
                                                    "${snapshot.data[index]['OffersAndCoupon']['description']}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          size.height * 0.03,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : Text(
                                                    "${snapshot.data[index]['OffersAndCoupon']['description']}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          size.height * 0.03,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                ),
                              );
                            },
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: size.width * 0.03,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  width: size.width * 0.95,
                                  height: size.height * 0.14,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),

            SizedBox(
              height: size.height * 0.02,
            ),

            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: size.width * 0.03),
                child: Text(
                  "Offers",
                  style:
                      TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
                )),

            SizedBox(
              height: size.height * 0.017,
            ),
            // Important Data

            FutureBuilder<List<dynamic>>(
              future: fetchAllRestaurant(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: restaurantData.length,
                    itemBuilder: (context, index) {
                      // double rating = 1.0;
                      // if (snapshot
                      //     .data[index]['VendorRatingReviews'].isNotEmpty) {
                      //   int j =
                      //       snapshot.data[index]['VendorRatingReviews'].length;

                      //   for (int i = 0; i < j - 1; i++) {
                      //     rating = rating +
                      //         double.parse(snapshot.data[index]
                      //             ['VendorRatingReviews'][i]['rating']);
                      //   }
                      //   rating = rating / j;
                      // } else {
                      //   rating = 1.0;
                      // }

                      if (snapshot
                          .data[index]['user']['OffersAndCoupons'].isEmpty) {
                        return SizedBox();
                      } else {
                        var couponDetatil;
                        if (snapshot.data[index]['user']['OffersAndCoupons'][0]
                                ['discount'] ==
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
                              "${snapshot.data[index]['user']['OffersAndCoupons'][0]['couponDiscount']}$symbol off";
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
                              "${snapshot.data[index]['user']['OffersAndCoupons'][0]['discount']}$symbol off";
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
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OfferListPage(
                                        ratingVendor: snapshot.data[index]
                                            ['avgRating'],
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
                                                            snapshot.data[index]
                                                                    ['user']
                                                                ['profile'],
                                                        height:
                                                            size.height * 0.18,
                                                        width: size.width * 0.3,
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
                                                        "assets/images/defaultrestaurent.png",
                                                        height:
                                                            size.height * 0.18,
                                                        width: size.width * 0.3,
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
                                                    capitalize(snapshot
                                                        .data[index]['name']),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize:
                                                            size.height * 0.02),
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
                                            SizedBox(
                                              height: size.height * 0.005,
                                            ),
                                            categoryData == null
                                                ? SizedBox()
                                                : Container(
                                                    width: size.width * 0.5,
                                                    child: Text(
                                                      "$categoryData",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: size.height *
                                                            0.0175,
                                                        color: Colors.black,
                                                      ),
                                                    ),
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
                                                          "⭐1",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  size.height *
                                                                      0.016,
                                                              color: Colors.red,
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
                                                                "${snapshot.data[index]['avgRating']}",
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
                                                          height: size.height *
                                                              0.02,
                                                        ),
                                                  couponDetatil == null
                                                      ? snapshot.data[index]
                                                                  ['avgCost'] ==
                                                              null
                                                          ? SizedBox()
                                                          : Text(
                                                              "₹ ${snapshot.data[index]['avgCost']} Cost for ${snapshot.data[index]['forPeople']}",
                                                            )
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
                  return LoadingListPage();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
