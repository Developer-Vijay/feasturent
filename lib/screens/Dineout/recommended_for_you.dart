import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class RecommendedForU extends StatefulWidget {
  @override
  _RecommendedForUState createState() => _RecommendedForUState();
}

class _RecommendedForUState extends State<RecommendedForU> {
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
      print(responseData1);
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
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                "Recommended For You",
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
            height: size.height * 0.25,
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
                                      height: size.height * 0.24,
                                      width: size.width * 0.4,
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
                                                      "https://im1.dineout.co.in/images/uploads/restaurant/sharpen/2/e/p/p20298-1484731590587f34c63a2a1.jpg?tr=tr:n-medium",
                                                  fit: BoxFit.cover,
                                                  height: size.height * 0.24,
                                                  width: size.width * 0.4,
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
                                                    height:
                                                        size.height * 0.0875,
                                                    width: size.width * 1,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'EAT, SAVE, REPEAT.',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.015,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            'Flat 20% off',
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
                                                            'the Total Bill',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.015,
                                                                color: Colors
                                                                    .white),
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
