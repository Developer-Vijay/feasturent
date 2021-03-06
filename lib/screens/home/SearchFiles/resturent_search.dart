import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/resturent_menues.dart';
import 'package:feasturent_costomer_app/screens/home/SearchFiles/test_search.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class SearchResturent extends StatefulWidget {
  @override
  _SearchResturentState createState() => _SearchResturentState();
}

class _SearchResturentState extends State<SearchResturent> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        child: resultData != null
            ? resultData['restaurant'].isNotEmpty
                ? new ListView.builder(
                    itemCount: resultData['restaurant'].length,
                    itemBuilder: (context, i) {
                      int k = resultData['restaurant'][i]['cuisines'].length;
                      print(k);
                      var categoryData = '';
                      if (k != 0) {
                        for (int j = 1; j <= k - 1; j++) {
                          categoryData =
                              '$categoryData${resultData['restaurant'][i]['cuisines'][j]['Category']['name']},';
                        }
                      } else {
                        categoryData = null;
                      }
                      return new InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OfferListPage(
                                        restID: resultData['restaurant'][i]
                                            ['id'],
                                      )));
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
                                              child: resultData['restaurant'][i]
                                                          ['user']['profile'] !=
                                                      null
                                                  ? CachedNetworkImage(
                                                      imageUrl: S3_BASE_PATH +
                                                          resultData['restaurant']
                                                                  [i]['user']
                                                              ['profile'],
                                                      height:
                                                          size.height * 0.18,
                                                      width: size.width * 0.3,
                                                      fit: BoxFit.cover,
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  Image.asset(
                                                        "assets/images/defaultrestaurent.png",
                                                        height:
                                                            size.height * 0.18,
                                                        width: size.width * 0.3,
                                                        fit: BoxFit.cover,
                                                      )),
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
                                                Container(
                                                  width: size.width * 0.3,
                                                  child: Text(
                                                    capitalize(
                                                        resultData['restaurant']
                                                            [i]['name']),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize:
                                                            size.height * 0.02),
                                                  ),
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                    width: size.width * 0.05),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 12),
                                                  child:
                                                      resultData['restaurant']
                                                                      [i]
                                                                  ['avgCost'] ==
                                                              ''
                                                          ? SizedBox()
                                                          : Column(
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      size.height *
                                                                          0.013,
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                    capitalize(
                                                                        "??? ${resultData['restaurant'][i]['avgCost']} Cost for ${resultData['restaurant'][i]['forPeople']} "),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            size.height *
                                                                                0.015,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
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
                                                resultData['restaurant'][i]
                                                            ['avgRating'] ==
                                                        null
                                                    ? Text(
                                                        "???1.0",
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.height *
                                                                    0.016,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    : Text(
                                                        "???${resultData['restaurant'][i]['avgRating'].toStringAsFixed(1)}",
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.height *
                                                                    0.016,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                Spacer(),
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
                  )
                : Center(
                    child: Container(
                      child: Image.asset(
                        "assets/images/norestaurent.png",
                        height: 200,
                        width: 300,
                      ),
                    ),
                  )
            : Center(
                child: Text("Loading...."),
              ));
  }
}
