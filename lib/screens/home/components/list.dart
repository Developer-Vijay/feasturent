import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Practice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var rating = 3.0;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                height: size.height * 0.1,
                alignment: Alignment.topCenter,
                child: Image.asset("assets/images/Pizzas.jpg"),
              ),
            ),
          ],
        ),
        // Container For Back button
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.01, vertical: size.height * 0.03),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
            color: Colors.white,
            iconSize: 30,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.symmetric(vertical: 200, horizontal: 10),
          child: Text(
            "Pizzas",
            style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                      blurRadius: 4,
                      color: Colors.blueGrey,
                      offset: Offset(5, 5))
                ]),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            height: 800,
            margin: EdgeInsets.only(top: 250),
            child: ListView(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "100 Items",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    // Decoration of List Started
                    Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: InkWell(
                          onTap: () {
                            print("tapped");
                          },
                          child: Container(
                            width: size.width - 20,
                            margin: EdgeInsets.only(
                                left: size.width * 0.02,
                                right: size.width * 0.01),
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(blurRadius: 5)],
                              // shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              // boxShadow: [BoxShadow(blurRadius: 1,color: Colors.red),]
                            ),
                            child: Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(6),
                                    child:
                                        // I have to get back in it
                                        ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        "https://image.shutterstock.com/z/stock-photo-taking-slice-of-tasty-pepperoni-pizza-on-black-table-closeup-1686772804.jpg",
                                        fit: BoxFit.cover,
                                        height: size.height * 0.12,
                                        width: size.width * 0.2,
                                      ),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            "Peppy Paneer",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.2,
                                        ),
                                        Container(
                                          //color: Colors.deepOrange,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.01,
                                              right: size.width * 0.03),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Container(
                                      //color: Colors.cyan,
                                      margin: EdgeInsets.only(
                                          right: size.width * 0.4),
                                      child: Text(
                                        "Vijay Da Dhaba",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    SizedBox(
                                      width: size.width * 0.09,
                                    ),

                                    // Star rating

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            child: SmoothStarRating(
                                                allowHalfRating: false,
                                                onRated: (v) {
                                                  Text("23");
                                                },
                                                starCount: 1,
                                                rating: rating,
                                                size: 23.0,
                                                isReadOnly: false,
                                                defaultIconData:
                                                    Icons.star_border_outlined,
                                                filledIconData: Icons.star,
                                                halfFilledIconData:
                                                    Icons.star_border,
                                                color: Colors.red,
                                                borderColor: Colors.red,
                                                spacing: 0.0)),

                                        SizedBox(
                                          width: size.width * 0.02,
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(),
                                          child: Text(
                                            "4.9",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.02,
                                        ),

                                        // Money

                                        Container(
                                            child: SvgPicture.asset(
                                                "assets/icons/rupee.svg",
                                                height: 14)),
                                        SizedBox(
                                          width: size.width * 0.01,
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(right: 140),
                                          child: Text(
                                            "250",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
