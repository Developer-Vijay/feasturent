import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/resturent_menues.dart';
import 'package:feasturent_costomer_app/screens/home/components/view_all_restaurant.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'discount_card.dart';
import 'popular.dart';
import '../../../shimmer_effect.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class AllResturent extends StatefulWidget {
  const AllResturent({
    Key key,
  }) : super(key: key);
  @override
  _AllResturentState createState() => _AllResturentState();
}

class _AllResturentState extends State<AllResturent> {
  var listlength = 0;
  String _authorization = '';
  void initState() {
    super.initState();
  }

  Future fetchHomebaanerLength() async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ hitting api length home banner");

    var result = await http
        .get(APP_ROUTES + 'utilities' + '?key=BYFOR' + '&for=homeBanner');
    if (result.statusCode == 200) {
      var data = json.decode(result.body)['data'];
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      if (data.isEmpty) {
        if (mounted) {
          dataLenght = 0;
        }
        print("data not here");
      } else {
        print("data here");
        if (data[0]['status'] == true) {
          if (mounted) {
            dataLenght = 1;
          }
        } else {
          if (mounted) {
            dataLenght = 0;
          }

          print("data not here");
        }
      }

      print("data  $dataLenght");
    } else {
      if (mounted) {
        dataLenght = 0;
      }
    }
  }

  Future fetchHomeSliderLength() async {
    var result = await http
        .get(APP_ROUTES + 'utilities' + '?key=BYFOR' + '&for=homeSlider');
    var data = json.decode(result.body)['data'];
    if (data.isEmpty) {
      if (mounted) {
        checkDataLenght = 0;
      }
      print("data not here");
    } else {
      print("data her e");
      if (data[0]['status'] == true) {
        if (mounted) {
          checkDataLenght = data.length;
        }
      } else {
        if (mounted) {
          checkDataLenght = 0;
        }
        print("data not here");
      }
    }

    print("data length $checkDataLenght");
  }

  var restaurantData;
  Future<List<dynamic>> fetchAllRestaurant() async {
    fetchHomeSliderLength();
    fetchHomebaanerLength();
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  get resturents");

    var result = await http.get(
      APP_ROUTES +
          'getRestaurantInfos' +
          '?key=ALL' +
          '&latitude=' +
          latitude.toString() +
          '&longitude=' +
          longitude.toString(),
    );
    print(_authorization);
    restaurantData = json.decode(result.body)['data'];
    if (restaurantData.isEmpty) {
      return restaurantData;
    } else {
      restaurantData = restaurantData;
      return restaurantData;
    }
  }

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
                  "All Restaurant",
                  style: TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.025),
                )),
            Spacer(),
            Container(
                child: FlatButton(
                    onPressed: () {
                      if (restaurantData != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewallRestaurant(
                                restData: restaurantData,
                              ),
                            ));
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            "View All",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_rounded,
                          color: kSecondaryTextColor,
                        ),
                      ],
                    )))
          ],
        ),
        SizedBox(
          height: size.height * 0.017,
        ),
        FutureBuilder<List<dynamic>>(
          future: fetchAllRestaurant(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (restaurantData.length >= 10) {
                listlength = 10;
              } else if (restaurantData.length <= 10) {
                listlength = restaurantData.length;
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listlength,
                itemBuilder: (context, index) {
                  var couponDetatil;
                  double rating = 1.0;
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
                    for (int j = 1; j <= k - 1; j++) {
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
                                  ratingVendor: rating,
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
                                          child: snapshot.data[index]['user']
                                                      ['profile'] !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl: S3_BASE_PATH +
                                                      snapshot.data[index]
                                                          ['user']['profile'],
                                                  height: size.height * 0.18,
                                                  width: size.width * 0.3,
                                                  fit: BoxFit.fill,
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                    "assets/images/feasturenttemp.jpeg",
                                                    height: size.height * 0.18,
                                                    width: size.width * 0.3,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                )
                                              : Image.asset(
                                                  "assets/images/feasturenttemp.jpeg",
                                                  height: size.height * 0.18,
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
                                              capitalize(
                                                  snapshot.data[index]['name']),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: size.height * 0.02),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
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
                                              width: size.width * 0.38,
                                              child: Text(
                                                "$categoryData",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize:
                                                      size.height * 0.0175,
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
                                            snapshot.data[index]['avgRating'] ==
                                                    null
                                                ? Text(
                                                    "⭐1",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.016,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          child: Text("⭐"),
                                                        ),
                                                        Text(
                                                          "${rating.toInt()}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  size.height *
                                                                      0.016,
                                                              color: Colors.red,
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
                                                    height: size.height * 0.02,
                                                  ),
                                            couponDetatil == null
                                                ? snapshot.data[index]
                                                            ['avgCost'] ==
                                                        null
                                                    ? SizedBox()
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          right: 12.0,
                                                        ),
                                                        child: Text(
                                                          "₹ ${snapshot.data[index]['avgCost']} Cost for ${snapshot.data[index]['forPeople']}",
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
                                                      )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 12.0,
                                                    ),
                                                    child: Text(
                                                      couponDetatil,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              size.height *
                                                                  0.016,
                                                          color: kTextColor),
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
                },
              );
            } else {
              return LoadingListPage();
            }
          },
        )
      ],
    );
  }
}
