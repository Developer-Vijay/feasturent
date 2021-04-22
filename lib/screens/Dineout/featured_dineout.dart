import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class FeaturedDineout extends StatefulWidget {
  @override
  _FeaturedDineoutState createState() => _FeaturedDineoutState();
}

class _FeaturedDineoutState extends State<FeaturedDineout> {
  @override
  void initState() {
    super.initState();
  }

  int status = 1;
  var responseData1;
  Future<List> getpopulardineouts() async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  dineoutpopular");

    var response = await http.get(APP_ROUTES + 'popularDineout');

    if (response.statusCode == 200) {
      responseData1 = json.decode(response.body)['data'];
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ done @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

      return responseData1;
    } else if (response.statusCode == 204) {
      responseData1 = [];
      return responseData1;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _textstyle = TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: size.height * 0.014);
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 5, top: 20),
              child: Text(
                "Featured Dineout",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: kTextColor),
              ),
            ),
            // Spacer(),
            // Container(
            //     child: FlatButton(
            //         onPressed: () {
            //           if (responseData1 != null) {
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) =>
            //                       ViewAllPopular(data: responseData1),
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
            //         ))
            // )
          ],
        ),
        Container(
            height: size.height * 0.28,
            child: FutureBuilder<List>(
              future: getpopulardineouts(),
// ignore: missing_return
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data.isEmpty
                      ? SizedBox(
                          child: Center(
                            child: Text("No data Available"),
                          ),
                        )
                      : Container(
                          child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4.0, left: 15),
                                  child: Container(
                                      height: size.height * 0.27,
                                      width: size.width * 0.6,
                                      child: InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             DineoutDetailPage(
                                          //               data: snapshot.data[index]
                                          //                   ['VendorInfo'],
                                          //             )));
                                        },
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl:
                                                      "https://im1.dineout.co.in/images/uploads/restaurant/sharpen/2/u/y/p20941-15700828565d959028e9f28.jpg?tr=tr:n-medium",
                                                  height: size.height * 0.27,
                                                  width: size.width * 0.6,
                                                  fit: BoxFit.fill,
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Container(
                                                    height: size.height * 0.11,
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
                                                          Text(
                                                            'Noon Mirch',
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
                                                          Text(
                                                            'Indirapuram, Ghaziabad',
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
                                                          Text(
                                                            '🛍️ Flat 25% Off The total bill',
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      )),
                                ),
                              ],
                            );
                          },
                        ));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )),
      ],
    ));
  }
}
