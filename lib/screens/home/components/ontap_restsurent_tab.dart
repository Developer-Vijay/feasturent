import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/resturent_menues.dart';
import 'package:flutter/material.dart';
import 'ontap_offer.dart';
import '../../../constants.dart';

class OnTapResturentTab extends StatefulWidget {
  @override
  _OnTapResturentTabState createState() => _OnTapResturentTabState();
}

class _OnTapResturentTabState extends State<OnTapResturentTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        child: offerTapData != null
            ? offerTapData['restaurant'].isNotEmpty
                ? new ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: offerTapData['restaurant'].length,
                    itemBuilder: (context, i) {
                      // print(offerTapData['restaurant'][i]['VendorInfo']
                      //     ['cuisines']);
                      // int k = offerTapData['restaurant'][i]['VendorInfo']
                      //         ['cuisines']
                      //     .length;
                      int k = 0;
                      print(k);
                      var categoryData = '';
                      if (k != 0) {
                        for (int j = 0; j <= k - 1; j++) {
                          categoryData =
                              '$categoryData${offerTapData['restaurant'][i]['VendorInfo']['cuisines'][j]['Category']['name']},';
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
                                        restID: offerTapData['restaurant'][i]
                                            ['VendorInfo']['id'],
                                        ratingVendor: offerTapData['restaurant']
                                                [i]['VendorInfo']
                                            ['reviewAndRatingAvg'],
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
                                              child: offerTapData['restaurant']
                                                              [i]['VendorInfo']
                                                          ['user']['profile'] !=
                                                      null
                                                  ? CachedNetworkImage(
                                                      imageUrl: S3_BASE_PATH +
                                                          offerTapData['restaurant']
                                                                      [i]
                                                                  ['VendorInfo']
                                                              [
                                                              'user']['profile'],
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
                                                    capitalize(offerTapData[
                                                            'restaurant'][i]
                                                        ['VendorInfo']['name']),
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
                                                  child: offerTapData['restaurant']
                                                                      [i]
                                                                  ['VendorInfo']
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
                                                                    "₹ ${offerTapData['restaurant'][i]['VendorInfo']['avgCost']} Cost for ${offerTapData['restaurant'][i]['VendorInfo']['forPeople']} "),
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
                                                                        FontWeight
                                                                            .bold),
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
                                                offerTapData['restaurant'][i]
                                                                ['VendorInfo'][
                                                            'reviewAndRatingAvg']
                                                        .isEmpty
                                                    ? Text(
                                                        "⭐1.0",
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
                                                        "⭐${offerTapData['restaurant'][i]['VendorInfo']['reviewAndRatingAvg'][0]['avgRating'].toStringAsFixed(1)}",
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
                    child: Text("No resturent available"),
                  )
            : Center(
                child: Text("Loading...."),
              ));
  }
}
