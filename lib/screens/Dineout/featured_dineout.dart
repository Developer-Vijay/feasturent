import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dineoutSweeper.dart';
import '../../constants.dart';
import 'dineoutdetailpage.dart';

class FeaturedDineout extends StatefulWidget {
  @override
  _FeaturedDineoutState createState() => _FeaturedDineoutState();
}

class _FeaturedDineoutState extends State<FeaturedDineout> {
  @override
  void initState() {
    super.initState();
  }

  List<String> idDataList = [];
  List<String> datadine = [];
  fetchDineoutShared() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    idDataList = cart.getStringList('idDineout');
    datadine = cart.getStringList('recommendDineout');
    // String data = datadine.toString();
    // datadine = json.decode(data);
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");

    print("dinneout is list $idDataList");
  }

  var responseData;
  // ignore: missing_return
  getdineouts() async {
    fetchDineoutShared();
    getDineoutBanner();
    return feturememoizer.runOnce(() async {
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  dineout");
      var response =
          await http.get(Uri.parse(APP_ROUTES + 'dineout' + '?key=ALL'));
      if (response.statusCode == 200) {
        responseData = json.decode(response.body)['data'];
        print(
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ done @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        List listToShow = new List.generate(
            10, (_) => responseData[_random.nextInt(responseData.length)]);

        return listToShow;
      } else if (response.statusCode == 204) {
        responseData = [];
        return responseData;
      }
    });
  }

  final _random = new Random();

  Future getDineoutBanner() async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  utiltsedineout");

    var result = await http.get(
        Uri.parse(APP_ROUTES + 'utilities' + '?key=BYFOR&for=dineoutBanner'));
    if (result.statusCode == 200) {
      var homeOffers = json.decode(result.body)['data'];
      if (homeOffers.isEmpty) {
        dineoutofferlength = 0;
      } else {
        print("data here");
        if (homeOffers[0]['status'] == true) {
          dineoutofferlength = 1;
        } else {
          dineoutofferlength = 0;
        }
      }
    } else {
      dineoutofferlength = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Container(
            child: FutureBuilder(
      future: getdineouts(),
// ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data.isEmpty
              ? SizedBox()
              : Container(
                  height: size.height * 0.36,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, bottom: 5, top: 20),
                            child: Text(
                              "Featured Dineout",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kTextColor,
                                  fontSize: size.height * 0.025),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                            height: size.height * 0.31,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length >= 10
                                  ? 10
                                  : snapshot.data.length,
                              itemBuilder: (context, index) {
                                var couponDetatil;

                                if (snapshot
                                    .data[index]['user']['OffersAndCoupons']
                                    .isNotEmpty) {
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
                                      symbol = "₹";
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
                                      symbol = "₹";
                                    }

                                    couponDetatil =
                                        "${snapshot.data[index]['user']['OffersAndCoupons'][0]['discount']}$symbol off";
                                  }

                                  if (snapshot.data[index]['user']
                                          ['OffersAndCoupons'][0]['title'] !=
                                      '') {
                                    couponDetatil =
                                        "$couponDetatil ${snapshot.data[index]['user']['OffersAndCoupons'][0]['title']}";
                                  }
                                } else {
                                  couponDetatil = null;
                                }
                                print(couponDetatil);
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4.0, left: 15),
                                  child: Container(
                                      height: size.height * 0.303,
                                      width: size.width * 0.6,
                                      child: InkWell(
                                        onTap: () async {
                                          final SharedPreferences cart =
                                              await SharedPreferences
                                                  .getInstance();
                                          var dataAddtoList =
                                              snapshot.data[index];
                                          var newdata =
                                              json.encode(dataAddtoList);
                                          if (idDataList.contains(snapshot
                                              .data[index]['id']
                                              .toString())) {
                                            print("removing adding dinout");
                                            int k = idDataList.indexOf(snapshot
                                                .data[index]['id']
                                                .toString());
                                            datadine.removeAt(k);
                                            idDataList.removeAt(k);

                                            idDataList.add(snapshot.data[index]
                                                    ['id']
                                                .toString());
                                            datadine.add(newdata);
                                            cart.setStringList(
                                                'recommendDineout', datadine);
                                            cart.setStringList(
                                                'idDineout', idDataList);
                                          } else {
                                            idDataList.add(snapshot.data[index]
                                                    ['id']
                                                .toString());
                                            datadine.add(newdata);
                                            cart.setStringList(
                                                'recommendDineout', datadine);
                                            cart.setStringList(
                                                'idDineout', idDataList);
                                          }
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DineoutDetailPage(
                                                        data: snapshot
                                                            .data[index],
                                                      )));
                                        },
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Stack(
                                              children: [
                                                snapshot.data[index]['user']
                                                            ['profile'] ==
                                                        null
                                                    ? Image.asset(
                                                        "assets/images/defaultdineout.jpg",
                                                        height:
                                                            size.height * 0.303,
                                                        width: size.width * 0.6,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : CachedNetworkImage(
                                                        imageUrl: S3_BASE_PATH +
                                                            snapshot.data[index]
                                                                    ['user']
                                                                ['profile'],
                                                        height:
                                                            size.height * 0.303,
                                                        width: size.width * 0.6,
                                                        fit: BoxFit.fill,
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Container(
                                                    height: size.height * 0.14,
                                                    width: size.width * 1,
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 20,
                                                            width: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "⭐4.2",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.height *
                                                                            0.018,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: size.width *
                                                                0.55,
                                                            child: Text(
                                                              capitalize(
                                                                  "${snapshot.data[index]['name']}"),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.height *
                                                                          0.033,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          Text(
                                                            '${snapshot.data[index]['Address']['city']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.015,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          couponDetatil == null
                                                              ? SizedBox()
                                                              : Container(
                                                                  width:
                                                                      size.width *
                                                                          0.55,
                                                                  child: Text(
                                                                    '🛍️ $couponDetatil',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            size.height *
                                                                                0.015,
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      )),
                                );
                              },
                            )),
                      ),
                    ],
                  ),
                );
        } else {
          return Container(
            height: size.height * 0.36,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, bottom: 5, top: 20),
                      child: Text(
                        "Featured Dineout",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                            fontSize: size.height * 0.025),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                      height: size.height * 0.31,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 15),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[100],
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white),
                                height: size.height * 0.27,
                                width: size.width * 0.6,
                              ),
                            ),
                          );
                        },
                      )),
                ),
              ],
            ),
          );
        }
      },
    )));
  }
}
