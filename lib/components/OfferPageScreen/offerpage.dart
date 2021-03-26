import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/insideofferpage.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OfferPageScreen extends StatefulWidget {
  @override
  _OfferPageScreenState createState() => _OfferPageScreenState();
}

class _OfferPageScreenState extends State<OfferPageScreen> {
  var random;

  int _currentMax = 10;
  int sum = 0;
  int i;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  void initState() {
    super.initState();

    refreshList();
  }

  Future refreshList() async {}

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
    print("data fetch");
    restaurantData = json.decode(result.body)['data'];
    return restaurantData;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var disountNumber = size.width * 0.04;
    var discountuptp = size.height * 0.026;
    var discountwith = size.height * 0.034;
    var discountby = size.width * 0.05;

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: refreshList,
          child: ListView(
            children: [
              Column(children: [
                Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: size.width * 0.03),
                    child: Text(
                      "Best Offers",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                // Slider
                Container(
                  height: size.height * 0.24,
                  margin: EdgeInsets.only(top: size.height * 0.008),
                  child: SingleChildScrollView(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        // First Item
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue[400],
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    color: Colors.blue[400],
                                    spreadRadius: 1,
                                    offset: Offset(0, 3))
                              ]),
                          width: size.width * 0.34,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.amberAccent),
                                        children: [
                                          TextSpan(
                                            text: "Up To \n",
                                            style: TextStyle(
                                              fontSize: discountuptp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "20% off \n",
                                            style: TextStyle(
                                              fontSize: disountNumber,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "with \n",
                                            style: TextStyle(
                                                fontSize: discountwith,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: "Axis Bank\n",
                                            style: TextStyle(
                                                fontSize: discountby,
                                                color: Colors.amberAccent,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: "Credit Card",
                                            style: TextStyle(
                                                fontSize: discountby,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.amberAccent),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        // Second SLide
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red[400],
                              boxShadow: [
                                BoxShadow(blurRadius: 1, spreadRadius: 0)
                              ]),
                          width: size.width * 0.34,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(color: Colors.white),
                                        children: [
                                          TextSpan(
                                            text: "Get\n",
                                            style: TextStyle(
                                              fontSize: discountuptp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "30% \n",
                                            style: TextStyle(
                                              fontSize: disountNumber,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "Instant \n",
                                            style: TextStyle(
                                                fontSize: discountwith,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: "Discount\n",
                                            style: TextStyle(
                                                fontSize: discountby,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: "at any Time",
                                            style: TextStyle(
                                                fontSize: discountby,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        // Third Slide
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [BoxShadow(blurRadius: 1)]),
                          width: size.width * 0.34,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        style:
                                            TextStyle(color: Colors.pink[800]),
                                        children: [
                                          TextSpan(
                                            text: "Flat\n",
                                            style: TextStyle(
                                              fontSize: size.height * 0.026,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "20% off \n",
                                            style: TextStyle(
                                              fontSize: disountNumber,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "on  \n",
                                            style: TextStyle(
                                                fontSize: discountwith,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: "Your First \n",
                                            style: TextStyle(
                                                fontSize: discountby,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: "order",
                                            style: TextStyle(
                                                fontSize: discountby,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.012,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.014,
                ),
                // Pamplet
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange[600],
                  ),
                  width: size.width * 0.95,
                  height: size.height * 0.14,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.only(
                            right: size.width * 0.0,
                            left: size.width * 0.1,
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://media.gettyimages.com/vectors/happy-new-year-sale-banner-seasonal-sale-template-stock-illustration-vector-id1282815171?k=6&m=1282815171&s=612x612&w=0&h=0loPSRONAt2KAFZXPGNKVYZ2Gf-AghfEpgxtmOi9bJo=",
                            height: size.height * 0.1,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.2,
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
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(
                            top: size.height * 0.04, left: size.width * 0.019),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Extra 10 % off \n",
                              style: TextStyle(
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "via NetPayment \n",
                              style: TextStyle(
                                  fontSize: size.height * 0.03,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                // List Starts from Here

                Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: size.width * 0.03),
                    child: Text(
                      "Offers",
                      style: TextStyle(
                          color: kTextColor, fontWeight: FontWeight.bold),
                    )),

                SizedBox(
                  height: size.height * 0.017,
                ),
// Important Data
                FutureBuilder<List<dynamic>>(
                  future: fetchAllRestaurant(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // if (restaurantData.length >= 10) {
                      //   listlength = 10;
                      // } else if (restaurantData.length <= 10) {
                      //   listlength = restaurantData.length;
                      // }
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: restaurantData.length,
                        itemBuilder: (context, index) {
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
                                                  child: snapshot.data[index]
                                                                  ['user']
                                                              ['profile'] !=
                                                          null
                                                      ? CachedNetworkImage(
                                                          imageUrl: S3_BASE_PATH +
                                                              snapshot.data[
                                                                          index]
                                                                      ['user']
                                                                  ['profile'],
                                                          height: size.height *
                                                              0.18,
                                                          width:
                                                              size.width * 0.3,
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
                                                          "assets/images/feasturenttemp.jpeg",
                                                          height: size.height *
                                                              0.18,
                                                          width:
                                                              size.width * 0.3,
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
                                                      snapshot.data[index]
                                                          ['name'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize:
                                                              size.height *
                                                                  0.02),
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
                                              snapshot.data[index]['type'] ==
                                                      null
                                                  ? SizedBox()
                                                  : Column(
                                                      children: [
                                                        SizedBox(
                                                          height: size.height *
                                                              0.013,
                                                        ),
                                                        Container(
                                                          width:
                                                              size.width * 0.35,
                                                          child: Text(
                                                            snapshot.data[index]
                                                                ['type'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.015,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
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
                                                    Container(child: Text("⭐")),
                                                    Text(
                                                      "3.0",
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.height *
                                                                  0.016,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Spacer(),
                                                    Image.asset(
                                                      "assets/icons/discount_icon.jpg",
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        right: 12.0,
                                                      ),
                                                      child: Text(
                                                        "40%SW12345678",
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
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
