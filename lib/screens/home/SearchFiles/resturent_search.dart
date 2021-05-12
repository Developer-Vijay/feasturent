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
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
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
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    )
                                                  : Image.asset(
                                                      "assets/images/feasturenttemp.jpeg",
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
                                                  width: size.width * 0.4,
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 12),
                                                  child:
                                                      resultData['restaurant']
                                                                      [i]
                                                                  ['avgCost'] ==
                                                              null
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
                                                                        "${resultData['restaurant'][i]['avgCost']} for ${resultData['restaurant'][i]['forPeople']} "),
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
                                                1 == 1
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
                                                    : Text(
                                                        "⭐1",
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
                                                // couponDetatil ==
                                                //         null
                                                //     ? SizedBox()
                                                //     : Image
                                                //         .asset(
                                                //         "assets/icons/discount_icon.jpg",
                                                //         height: size.height * 0.02,
                                                //       ),
                                                // couponDetatil ==
                                                //         null
                                                //     ? SizedBox()
                                                //     : Padding(
                                                //         padding: const EdgeInsets.only(
                                                //           right: 12.0,
                                                //         ),
                                                //         child: Text(
                                                //           couponDetatil,
                                                //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.height * 0.016, color: kTextColor),
                                                //         ),
                                                //       ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                              ])),
                        ),
                      );

                      // Card(
                      //   child: new ListTile(
                      //     leading: new CircleAvatar(
                      //       backgroundImage:
                      //           resultData['restaurant']
                      //                               [i]
                      //                           ['user']
                      //                       ['profile'] ==
                      //                   null
                      //               ? NetworkImage(
                      //                   S3_BASE_PATH +
                      //                       'menues/image/10/FeastaurentImage871373-1619165007984.jpg',
                      //                 )
                      //               : new NetworkImage(
                      //                   S3_BASE_PATH +
                      //                       resultData['restaurant']
                      //                                   [
                      //                                   i]
                      //                               [
                      //                               'user']
                      //                           [
                      //                           'profile'],
                      //                 ),
                      //     ),
                      //     title: new Text(
                      //         resultData['restaurant'][i]
                      //             ['name']),
                      //   ),
                      //   margin: const EdgeInsets.all(0.0),
                      // );
                    },
                  )
                : Center(
                    child: Text("No resturent available"),
                  )
            : Center(
                child: Text("Loading...."),
              ));
  }
}