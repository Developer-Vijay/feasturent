import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:feasturent_costomer_app/OfferPageScreen/insideofferpage.dart';
import 'package:feasturent_costomer_app/components/bottom_nav_bar.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class OfferPageScreen extends StatefulWidget {
  @override
  _OfferPageScreenState createState() => _OfferPageScreenState();
}

class _OfferPageScreenState extends State<OfferPageScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Column(children: [
              Container(
                margin: EdgeInsets.only(top: size.height * 0.04),
                child: Row(
                  children: [
                    Container(
                        child: IconButton(
                      icon: Icon(Icons.arrow_back_sharp),
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Bottomnavbar()),
                        );
                      },
                      iconSize: 25,
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "offer",
                          style: TextStyle(fontSize: 24, color: kTextColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),

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
                          boxShadow: [BoxShadow(blurRadius: 1,color: Colors.blue[400],spreadRadius: 1,offset: Offset(0,3))]),
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
                  color: Colors.purple[300],
                ),
                width: size.width * 0.95,
                height: size.height * 0.14,
                child: Row(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.only(
                          left: size.width * 0.03,
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://image.shutterstock.com/z/stock-vector-weekly-deals-in-flat-colours-with-d-style-shadow-697185868.jpg",
                            height: size.height * 0.11,
                          ),
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
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OfferListPage()),
                    );
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          left: size.width * 0.02, right: size.width * 0.02),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(blurRadius: 2)]),
                      height: size.height * 0.142,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://image.shutterstock.com/z/stock-photo-aloo-chana-chaat-street-food-in-kolkata-india-705349216.jpg",
                                      fit: BoxFit.cover,
                                      height: size.height * 0.12,
                                      width: size.width * 0.22,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3, top: 8),
                                          child: Text(
                                            "Gupta Chat Corner",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        SizedBox(width: 85,),
                                        CachedNetworkImage(
                                          height: 15,
                                        imageUrl:
                                            "https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png",
                                      )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6, top: 2),
                                          child: Text(
                                            "North Indian ",
                                            style: TextStyle(
                                              fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                        
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 0),
                                          child: SmoothStarRating(
                                              allowHalfRating: false,
                                              onRated: (v) {
                                                Text("23");
                                              },
                                              starCount: 1,
                                              rating: 3,
                                              size: 20.0,
                                              isReadOnly: false,
                                              defaultIconData:
                                                  Icons.star_border_outlined,
                                              filledIconData: Icons.star,
                                              halfFilledIconData:
                                                  Icons.star_border,
                                              color: Colors.red,
                                              borderColor: Colors.red,
                                              spacing: 0.0),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3, bottom: 0),
                                          child: Text(
                                            "4.9",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 13, bottom: 00),
                                          child: SvgPicture.asset(
                                              "assets/icons/rupee.svg",
                                              height: 12),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, bottom: 0),
                                          child: Text(
                                            "250",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: size.width * 0.01),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/offer.svg",
                                              height: size.height * 0.021,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.016,
                                            ),
                                            Text(
                                              "40 % | Use Code SW100",
                                              style:
                                                  TextStyle(color: kTextColor,fontSize: 12),
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
              // Another List
              SizedBox(
                height: size.height * 0.017,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Container(
                    margin: EdgeInsets.only(
                        left: size.width * 0.02, right: size.width * 0.02),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(blurRadius: 2)]),
                    height: size.height * 0.165,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://image.shutterstock.com/image-photo/healthy-salad-bowl-quinoa-tomatoes-600w-521741356.jpg",
                                    fit: BoxFit.cover,
                                    height: size.height * 0.14,
                                    width: size.width * 0.246,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3, top: 8),
                                        child: Text(
                                          "Healthybuddy",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, top: 2),
                                        child: Text(
                                          "Health ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, bottom: 0),
                                        child: SmoothStarRating(
                                            allowHalfRating: false,
                                            onRated: (v) {
                                              Text("23");
                                            },
                                            starCount: 1,
                                            rating: 3,
                                            size: 23.0,
                                            isReadOnly: false,
                                            defaultIconData:
                                                Icons.star_border_outlined,
                                            filledIconData: Icons.star,
                                            halfFilledIconData:
                                                Icons.star_border,
                                            color: Colors.red,
                                            borderColor: Colors.red,
                                            spacing: 0.0),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3, bottom: 0),
                                        child: Text(
                                          "5",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 13, bottom: 00),
                                        child: SvgPicture.asset(
                                            "assets/icons/rupee.svg",
                                            height: 14),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 0),
                                        child: Text(
                                          "200",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.01),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/offer.svg",
                                            height: size.height * 0.023,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.016,
                                          ),
                                          Text(
                                            "20 % | Use Code SWPK100",
                                            style: TextStyle(color: kTextColor),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              // One More List
              SizedBox(
                height: size.height * 0.017,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Container(
                    margin: EdgeInsets.only(
                        left: size.width * 0.02, right: size.width * 0.02),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(blurRadius: 2)]),
                    height: size.height * 0.165,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://image.shutterstock.com/z/stock-photo-concept-promotional-flyer-and-poster-for-restaurants-or-pizzerias-template-with-delicious-taste-1060535249.jpg",
                                    fit: BoxFit.cover,
                                    height: size.height * 0.14,
                                    width: size.width * 0.246,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3, top: 8),
                                        child: Text(
                                          "Pizza King",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, top: 2),
                                        child: Text(
                                          "Italian ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, bottom: 0),
                                        child: SmoothStarRating(
                                            allowHalfRating: false,
                                            onRated: (v) {
                                              Text("23");
                                            },
                                            starCount: 1,
                                            rating: 3,
                                            size: 23.0,
                                            isReadOnly: false,
                                            defaultIconData:
                                                Icons.star_border_outlined,
                                            filledIconData: Icons.star,
                                            halfFilledIconData:
                                                Icons.star_border,
                                            color: Colors.red,
                                            borderColor: Colors.red,
                                            spacing: 0.0),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3, bottom: 0),
                                        child: Text(
                                          "3.2",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 13, bottom: 00),
                                        child: SvgPicture.asset(
                                            "assets/icons/rupee.svg",
                                            height: 14),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 0),
                                        child: Text(
                                          "99",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.01),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/offer.svg",
                                            height: size.height * 0.023,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.016,
                                          ),
                                          Text(
                                            "10 % | Use Code VIJSSHIN001",
                                            style: TextStyle(color: kTextColor),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
