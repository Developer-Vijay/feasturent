import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:feasturent_costomer_app/components/Bottomsheet/addbar.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/insideofferpage.dart';
import 'package:feasturent_costomer_app/components/bottom_nav_bar.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class OfferPageScreen extends StatefulWidget {
  @override
  _OfferPageScreenState createState() => _OfferPageScreenState();
}

class _OfferPageScreenState extends State<OfferPageScreen> {
  List<ListofFood> foodlist = [
    ListofFood(
      foodImage:
          'https://media.gettyimages.com/photos/view-of-papri-chat-on-november-10-2015-in-kolkata-india-picture-id542764412?k=6&m=542764412&s=612x612&w=0&h=6IEwFhfeYFwdt8H8hdgzePPRyusFHnu25xYFxfRXvNU=',
      discountImage:
          'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
      discountText: '40 % | Use Code SW100',
      foodPrice: '₹100',
      title: 'Gupta Chart',
      subtitle: 'NorthIndian',
      vegsymbol:
          'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
      starRating: SmoothStarRating(
          allowHalfRating: false,
          onRated: (v) {
            Text("23");
          },
          starCount: 1,
          rating: 3,
          size: 20.0,
          isReadOnly: false,
          defaultIconData: Icons.star_border_outlined,
          filledIconData: Icons.star,
          halfFilledIconData: Icons.star_border,
          color: Colors.red,
          borderColor: Colors.red,
          spacing: 0.0),
    ),
// Another List
    ListofFood(
      foodImage:
          'https://media.gettyimages.com/photos/spring-salad-shot-from-above-on-rustic-wood-table-picture-id505685702?k=6&m=505685702&s=612x612&w=0&h=dw2v57OlDMM8xUBbg2EHGaWP4zWX9iKLXS6mS2qPaB4=',
      discountImage:
          'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
      discountText: '20 % | Use Code WS100',
      foodPrice: '₹100',
      title: 'Salad',
      ratingText: '3.0',
      subtitle: 'NorthIndian',
      vegsymbol:
          'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
      starRating: SmoothStarRating(
          allowHalfRating: false,
          onRated: (v) {
            Text("23");
          },
          starCount: 1,
          rating: 3,
          size: 20.0,
          isReadOnly: false,
          defaultIconData: Icons.star_border_outlined,
          filledIconData: Icons.star,
          halfFilledIconData: Icons.star_border,
          color: Colors.red,
          borderColor: Colors.red,
          spacing: 0.0),
    ),
  ];

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
                  color: Colors.purple[300],
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

              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                itemCount: foodlist.length,
                itemBuilder: (context, index) {
                  print(foodlist[index].discountText);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(blurRadius: 2, color: Colors.grey)
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
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: foodlist[index].foodImage,
                                          height: size.height * 0.1,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    // For Add Button
                                    Align(
                                        widthFactor: 1.42,
                                        alignment: Alignment.bottomCenter,
                                        heightFactor: 2.2,
                                        child: Container(
                                          child: MaterialButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) =>
                                                      Sheet());
                                            },
                                            color: Colors.white,
                                            minWidth: 80,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                            textColor: Colors.white,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: Colors.blueGrey,
                                                ),
                                                Text(
                                                  "ADD",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.blueGrey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 6,
                              child: Container(
                                height: size.height * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                fontSize: 18),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  foodlist[index].vegsymbol,
                                              height: 18,
                                            ),
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
                                                fontSize: 15,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: size.width * 0.1),
                                              child: Text(
                                                foodlist[index].foodPrice,
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
