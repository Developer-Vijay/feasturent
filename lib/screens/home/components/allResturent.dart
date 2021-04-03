import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/insideofferpage.dart';
import 'package:feasturent_costomer_app/screens/home/components/view_all_restaurant.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
    print(_authorization);
    restaurantData = json.decode(result.body)['data']['vendorInfo'];
    return restaurantData;
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
                  style:
                      TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
                )),
            Spacer(),
            Container(
                child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewallRestaurant(
                              restData: restaurantData,
                            ),
                          ));
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
                          "${snapshot.data[index]['user']['OffersAndCoupons'][0]['couponDiscount']}$symbol${snapshot.data[index]['user']['OffersAndCoupons'][0]['coupon']}";
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
                          "${snapshot.data[index]['user']['OffersAndCoupons'][0]['discount']}$symbol${snapshot.data[index]['user']['OffersAndCoupons'][0]['coupon']}";
                    }
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
                                                      Center(
                                                          child:
                                                              CircularProgressIndicator()),
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
                                              snapshot.data[index]['name'],
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
                                      snapshot.data[index]['type'] == null
                                          ? SizedBox()
                                          : Column(
                                              children: [
                                                SizedBox(
                                                  height: size.height * 0.013,
                                                ),
                                                Container(
                                                  width: size.width * 0.35,
                                                  child: Text(
                                                    snapshot.data[index]
                                                        ['type'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.015,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                            snapshot.data[index]['avgRating'] ==
                                                    null
                                                ? Text(
                                                    "Not Rated",
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
                                                          snapshot.data[index]
                                                                  ['avgRating']
                                                              .toString(),
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
                                                ? SizedBox()
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
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ],
    );
  }
}
