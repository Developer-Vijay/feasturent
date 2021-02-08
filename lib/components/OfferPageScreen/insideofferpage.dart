import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:feasturent_costomer_app/components/Bottomsheet/offerBottomsheet.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/offerpage.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class OfferListPage extends StatefulWidget {
  @override
  _OfferListPageState createState() => _OfferListPageState();
}

class _OfferListPageState extends State<OfferListPage> {
  final _containerDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(
          blurRadius: 2,
          offset: Offset(3, 3),
          color: Colors.grey[300],
          spreadRadius: 2)
    ],
    borderRadius: BorderRadius.circular(5),
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 25,
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OfferPageScreen()),
                    );
                  },
                ),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(
                      top: size.height * 0.02, left: size.width * 0.036),
                  child: Text(
                    "Gupta Chat Bhandar",
                    style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 5, left: 15),
                  child: Text(
                    "Indian",
                    style: offerCommonStyle,
                  )),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 5, left: 15),
                  child: Text(
                    "Burari | 17km",
                    style: offerCommonStyle,
                  )),
              SizedBox(
                height: 24,
              ),
              DottedLine(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: SmoothStarRating(
                                allowHalfRating: false,
                                onRated: (v) {
                                  Text("23");
                                },
                                starCount: 1,
                                rating: 3.0,
                                size: 23.0,
                                isReadOnly: false,
                                defaultIconData: Icons.star_border_outlined,
                                filledIconData: Icons.star,
                                halfFilledIconData: Icons.star_border,
                                color: Colors.black,
                                borderColor: Colors.black,
                                spacing: 0.0),
                          ),
                          Text(
                            "4.1",
                            style: offerRowHeadingStyle,
                          ),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(left: size.width * 0.04),
                          child: Text(
                            "Taste 80%",
                            style: offerCommonStyle,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "39 minutes",
                        style: offerRowHeadingStyle,
                      ),
                      Text("Delivery Time")
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: size.width * 0.02),
                    child: Column(
                      children: [
                        Text("₹ 75", style: offerRowHeadingStyle),
                        Text("Cost for one")
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              DottedLine(),
              SizedBox(
                height: 15,
              ),

              // List of Discounts

              Container(
                height: size.height * 0.1,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => OnOfferBottomSheet());
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            height: size.height * 0.064,
                            width: size.width * 0.4,
                            decoration: _containerDecoration,
                            child: Column(children: [
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.02,
                                          top: size.height * 0.01),
                                      child: SvgPicture.asset(
                                        "assets/icons/offer.svg",
                                        width: 15,
                                      )),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: size.width * 0.002,
                                        top: size.height * 0.01),
                                    child: Text(
                                      "50%OFFUPTO100",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.04,
                                      top: size.height * 0.002),
                                  child: Text("Use Welcome50"))
                            ]),
                          ),
                        ),
                        // Second List
                        SizedBox(
                          width: 12,
                        ),

                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => OnOfferBottomSheet());
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            height: size.height * 0.064,
                            width: size.width * 0.4,
                            decoration: _containerDecoration,
                            child: Column(children: [
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.02,
                                          top: size.height * 0.01),
                                      child: SvgPicture.asset(
                                        "assets/icons/offer.svg",
                                        width: 15,
                                      )),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: size.width * 0.002,
                                        top: size.height * 0.01),
                                    child: Text(
                                      "30%OFFUPTO100",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.04,
                                      top: size.height * 0.002),
                                  child: Text("Use Welcome50"))
                            ]),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),

                        // Third List
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => OnOfferBottomSheet());
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            height: size.height * 0.064,
                            width: size.width * 0.4,
                            decoration: _containerDecoration,
                            child: Column(children: [
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.02,
                                          top: size.height * 0.01),
                                      child: SvgPicture.asset(
                                        "assets/icons/offer.svg",
                                        width: 15,
                                      )),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: size.width * 0.002,
                                        top: size.height * 0.01),
                                    child: Text(
                                      "20%OFFUPTO100",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.04,
                                      top: size.height * 0.002),
                                  child: Text("Use Welcome50"))
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: size.width * 0.02),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.freepik.com/free-vector/pure-vegetarian-badge_1017-486.jpg",
                        height: 30,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        left: size.width * 0.03,
                      ),
                      child: Text(
                        "PURE VEG",
                        style: offerRowHeadingStyle,
                      ))
                ],
              )),
              SizedBox(
                height: size.height * 0.055,
              ),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: size.width * 0.05),
                  child: Text("Recommended", style: offerRecommendStyle)),

              SizedBox(
                height: size.height * 0.022,
              ),

              // List 1
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                    margin: EdgeInsets.only(
                        left: size.width * 0.02, right: size.width * 0.02),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(blurRadius: 2)]),
                    height: size.height * 0.138,
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.02,
                                      top: size.height * 0.01),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://media.gettyimages.com/photos/aloo-tikki-chaat-picture-id159801149?k=6&m=159801149&s=612x612&w=0&h=96ZMbIqHXuhaJepXw_xfls7wxs8CgqKOUHkbKFdgwqE=",
                                      fit: BoxFit.cover,
                                      height: size.height * 0.12,
                                      width: size.width * 0.26,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: size.width * 0.001),
                                child: Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: size.width * 0.02),
                                            child: Text(
                                              "Aloo Tikki",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Container(
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png",
                                              height: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: size.width * 0.11),
                                              child: Text(
                                                "North Indian ",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              child: SmoothStarRating(
                                                  allowHalfRating: false,
                                                  onRated: (v) {
                                                    Text("23");
                                                  },
                                                  starCount: 1,
                                                  rating: 3,
                                                  size: 20.0,
                                                  isReadOnly: false,
                                                  defaultIconData: Icons
                                                      .star_border_outlined,
                                                  filledIconData: Icons.star,
                                                  halfFilledIconData:
                                                      Icons.star_border,
                                                  color: Colors.red,
                                                  borderColor: Colors.red,
                                                  spacing: 0.0),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: size.width * 0.1),
                                              child: Text(
                                                "3.0",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SvgPicture.asset(
                                                "assets/icons/rupee.svg",
                                                height: 12),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              child: Text(
                                                "80",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.01),
                                          child: Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    "https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg",
                                                height: size.height * 0.026,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.013,
                                              ),
                                              Text(
                                                "20 % | Use Code SW100",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: kTextColor),
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: size.height * 0.01,
                                      right: size.width * 0.04),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    color: Colors.blue,
                                    minWidth: 30,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    textColor: Colors.white,
                                    child: Text(
                                      "Add",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ),

              SizedBox(
                height: 20,
              ),
              // List 2

              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                    margin: EdgeInsets.only(
                        left: size.width * 0.02, right: size.width * 0.02),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(blurRadius: 2)]),
                    height: size.height * 0.138,
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.02,
                                      top: size.height * 0.01),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://media.gettyimages.com/photos/pani-puri-picture-id1140993688?k=6&m=1140993688&s=612x612&w=0&h=uHU55pv3ECgx9yQtwHUwOKS5DgNk3S_cS9DCILvLqU4=",
                                      fit: BoxFit.cover,
                                      height: size.height * 0.12,
                                      width: size.width * 0.26,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: size.width * 0.001),
                                child: Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: size.width * 0.02),
                                            child: Text(
                                              "Gol Gappey",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Container(
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png",
                                              height: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: size.width * 0.11),
                                              child: Text(
                                                "North Indian ",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              child: SmoothStarRating(
                                                  allowHalfRating: false,
                                                  onRated: (v) {
                                                    Text("23");
                                                  },
                                                  starCount: 1,
                                                  rating: 3,
                                                  size: 20.0,
                                                  isReadOnly: false,
                                                  defaultIconData: Icons
                                                      .star_border_outlined,
                                                  filledIconData: Icons.star,
                                                  halfFilledIconData:
                                                      Icons.star_border,
                                                  color: Colors.red,
                                                  borderColor: Colors.red,
                                                  spacing: 0.0),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: size.width * 0.1),
                                              child: Text(
                                                "3.0",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SvgPicture.asset(
                                                "assets/icons/rupee.svg",
                                                height: 12),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              child: Text(
                                                "100",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.01),
                                          child: Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    "https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg",
                                                height: size.height * 0.026,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.013,
                                              ),
                                              Text(
                                                "20 % | Use Code SW100",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: kTextColor),
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: size.height * 0.01,
                                      right: size.width * 0.04),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    color: Colors.blue,
                                    minWidth: 30,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    textColor: Colors.white,
                                    child: Text(
                                      "Add",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ),

              SizedBox(
                height: 20,
              ),

              // List 3

              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                    margin: EdgeInsets.only(
                        left: size.width * 0.02, right: size.width * 0.02),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(blurRadius: 2)]),
                    height: size.height * 0.138,
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.02,
                                      top: size.height * 0.01),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://media.gettyimages.com/photos/delhi-dahi-papdi-from-the-indigo-restaurant-in-lindfield-3-february-picture-id539729151?s=2048x2048",
                                      fit: BoxFit.cover,
                                      height: size.height * 0.12,
                                      width: size.width * 0.26,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: size.width * 0.001),
                                child: Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: size.width * 0.02),
                                            child: Text(
                                              "Dahi Papdi",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Container(
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png",
                                              height: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: size.width * 0.11),
                                              child: Text(
                                                "North Indian ",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              child: SmoothStarRating(
                                                  allowHalfRating: false,
                                                  onRated: (v) {
                                                    Text("23");
                                                  },
                                                  starCount: 1,
                                                  rating: 3,
                                                  size: 20.0,
                                                  isReadOnly: false,
                                                  defaultIconData: Icons
                                                      .star_border_outlined,
                                                  filledIconData: Icons.star,
                                                  halfFilledIconData:
                                                      Icons.star_border,
                                                  color: Colors.red,
                                                  borderColor: Colors.red,
                                                  spacing: 0.0),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: size.width * 0.1),
                                              child: Text(
                                                "3.0",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SvgPicture.asset(
                                                "assets/icons/rupee.svg",
                                                height: 12),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              child: Text(
                                                "100",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.01),
                                          child: Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    "https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg",
                                                height: size.height * 0.026,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.013,
                                              ),
                                              Text(
                                                "20 % | Use Code SW100",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: kTextColor),
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: size.height * 0.01,
                                      right: size.width * 0.04),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    color: Colors.blue,
                                    minWidth: 30,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    textColor: Colors.white,
                                    child: Text(
                                      "Add",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          )
        ],
      )),
    );
  }
}
