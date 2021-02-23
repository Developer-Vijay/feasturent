import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/insideofferpage.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OfferPageScreen extends StatefulWidget {
  @override
  _OfferPageScreenState createState() => _OfferPageScreenState();
}

class _OfferPageScreenState extends State<OfferPageScreen> {
  int _index1 = 0;
  var _temp;
  int sum = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ListView(
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
              Container(
                height: size.height * 0.24,
                margin: EdgeInsets.only(top: size.height * 0.008),
                child: CarouselSlider(
                  items: [
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
                                    style: TextStyle(color: Colors.amberAccent),
                                    children: [
                                      TextSpan(
                                        text: "Up To \n",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "20% off \n",
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "with \n",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: "Axis Bank\n",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.amberAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: "Credit Card",
                                        style: TextStyle(
                                            fontSize: 18,
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
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "30% \n",
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Instant \n",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: "Discount\n",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: "at any Time",
                                        style: TextStyle(
                                            fontSize: 18,
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
                                    style: TextStyle(color: Colors.pink[800]),
                                    children: [
                                      TextSpan(
                                        text: "Flat\n",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "20% off \n",
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "on  \n",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: "Your First \n",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: "order",
                                        style: TextStyle(
                                            fontSize: 18,
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
                  ],
                  options: CarouselOptions(
                      autoPlay: false,
                      height: size.height * 0.23,
                      enlargeCenterPage: false,
                      viewportFraction: 0.36),
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
                          right: size.width * 0.3,
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://media.gettyimages.com/vectors/happy-new-year-sale-banner-seasonal-sale-template-stock-illustration-vector-id1282815171?k=6&m=1282815171&s=612x612&w=0&h=0loPSRONAt2KAFZXPGNKVYZ2Gf-AghfEpgxtmOi9bJo=",
                          height: size.height * 0.1,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    DottedLine(
                      dashGapLength: 0,
                      dashGapRadius: 0,
                      dashGapColor: Colors.white,
                      lineThickness: 2,
                      dashColor: Colors.white,
                      lineLength: 40,
                      direction: Axis.vertical,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(
                          top: size.height * 0.04, left: size.width * 0.02),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Extra 10 % off \n",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "via NetPayment \n",
                            style: TextStyle(
                                fontSize: 18,
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

              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: foodlist.length,
                itemBuilder: (context, index) {
                  print(foodlist[index].discountText);
                  return InkWell(
                    onTap: () {
                      print(foodlist[index].index0);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OfferListPage(),
                            settings: RouteSettings(
                              arguments: foodlist[index],
                            ),
                          ));
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
                          height: size.height * 0.14,
                          child: Row(children: [
                            Expanded(
                                flex: 0,
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  height: size.height * 0.2,
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 4, right: 4, top: 4),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: foodlist[index].foodImage,
                                            height: size.height * 0.1,
                                            width: size.width * 0.25,
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
                                        margin: EdgeInsets.only(top: 6),
                                        child: Row(
                                          children: [
                                            Text(
                                              foodlist[index].title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12),
                                              child: CachedNetworkImage(
                                                  imageUrl:
                                                      foodlist[index].vegsymbol,
                                                  height: size.height * 0.02),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        foodlist[index].subtitle,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              child: foodlist[index].starRating,
                                            ),
                                            Text(
                                              "3.0",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    right: size.width * 0.1),
                                                child: Text(
                                                  "₹${foodlist[index].foodPrice}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  foodlist[index].discountImage,
                                              height: size.height * 0.026,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              foodlist[index].discountText,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: kTextColor),
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
              )
            ]),
          ],
        ),
      ),
    );
  }
}
