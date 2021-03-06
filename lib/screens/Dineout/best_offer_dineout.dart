import 'package:feasturent_costomer_app/screens/Dineout/offer_related_dineout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'dart:convert';
import '../../constants.dart';

class BestOfferDineout extends StatefulWidget {
  @override
  _BestOfferDineoutState createState() => _BestOfferDineoutState();
}

class _BestOfferDineoutState extends State<BestOfferDineout> {
  @override
  void initState() {
    super.initState();
  }

  int status = 1;
  var responseData1;
  // ignore: missing_return
  getpopulardineouts() async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  dineoutpopular");
    return bestoffermemoizer.runOnce(() async {
      var response = await http
          .get(Uri.parse(APP_ROUTES + 'bestOfferDineout' + '?limit =null'));

      if (response.statusCode == 200) {
        responseData1 = json.decode(response.body)['data'];
        print(
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ done @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

        return responseData1;
      } else if (response.statusCode == 204) {
        responseData1 = [];
        return responseData1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            child: FutureBuilder(
          future: getpopulardineouts(),
// ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.isEmpty
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.only(top: 15),
                      height: size.height * 0.26,
                      child: Column(
                        children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Best Offers",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kTextColor,
                                    fontSize: size.height * 0.025),
                              ),
                            ),
                          ]),
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(
                                    top: 8, left: 15, bottom: 5),
                                height: size.height * 0.20,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.length >= 7
                                      ? 7
                                      : snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    var discount = 0;
                                    var symbol;
                                    if (snapshot.data[index]['discount'] ==
                                        null) {
                                      discount = snapshot.data[index]
                                          ['couponDiscount'];
                                      if (snapshot.data[index]
                                              ['couponDiscountType'] ==
                                          'PERCENT') {
                                        symbol = '%';
                                      } else {
                                        symbol = '???';
                                      }
                                    } else {
                                      discount =
                                          snapshot.data[index]['discount'];
                                      if (snapshot.data[index]
                                              ['discountType'] ==
                                          'PERCENT') {
                                        symbol = '%';
                                      } else {
                                        symbol = '???';
                                      }
                                    }
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OfferRelatedDineout(
                                                      data: snapshot.data[index]
                                                          ['vendoroffers'],
                                                    )));
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          height: size.height * 0.15,
                                          width: size.width * 0.25,
                                          decoration: BoxDecoration(
                                            // border: Border.all(color: Colors.black54),
                                            color: colors[index],
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15, left: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    color: color[index],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "FLAT",
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.height *
                                                                  0.025,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "$discount",
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.height *
                                                                  0.05,
                                                          color: color[index],
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "$symbol",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  size.height *
                                                                      0.025,
                                                              color:
                                                                  color[index],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "OFF",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  size.height *
                                                                      0.025,
                                                              color:
                                                                  color[index],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  snapshot.data[index]
                                                      ['description'],
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.height * 0.02,
                                                      color: color[index],
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
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
                margin: EdgeInsets.only(top: 15),
                height: size.height * 0.26,
                child: Column(
                  children: [
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Best Offers",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kTextColor,
                              fontSize: size.height * 0.025),
                        ),
                      ),
                    ]),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(top: 8, left: 15, bottom: 5),
                          height: size.height * 0.20,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(top: 15, left: 5),
                                  margin: EdgeInsets.only(left: 10),
                                  height: size.height * 0.08,
                                  width: size.width * 0.25,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
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
        )),
      ],
    ));
  }
}
