import 'package:feasturent_costomer_app/components/Bottomsheet/addRatingBottom.dart';
import 'package:feasturent_costomer_app/components/bottom_nav_bar.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double rating = 2.0;
  double rating2 = 3.0;
  double rating3 = 4.0;
  double rating4 = 5.0;

  var titlesize = 12.0;
  var textsize = 13.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(
                            context,
                            // MaterialPageRoute(
                            //     builder: (context) => Bottomnavbar()),
                          );
                        },
                      ),
                    ),
                    Text(
                      "Supreme Cheese Burger",
                      style: TextStyle(fontSize: 20, color: kTextLightColor),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 18,
              child: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      width: size.width * 0.1,
                      height: size.height * 0.2,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 8,
                                ),
                                child: CircleAvatar(
                                    radius: 32,
                                    backgroundColor: Colors.white,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Image.asset(
                                          "assets/images/avatar.png",
                                          width: size.width * 0.19,
                                          height: size.height * 0.20,
                                        ))),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 8),
                                child: Text(
                                  "Adams",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: titlesize),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 80,
                                ),
                                child: SmoothStarRating(
                                    allowHalfRating: true,
                                    onRated: (value) {
                                      setState(() {
                                        rating = value;
                                      });
                                    },
                                    starCount: 5,
                                    rating: rating,
                                    size: 23.0,
                                    isReadOnly: false,
                                    defaultIconData: Icons.star_border_outlined,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_border,
                                    color: Colors.amber,
                                    borderColor: Colors.amber,
                                    spacing: 0.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 6),
                                child: Text(
                                  "$rating ",
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(left: 9, right: 9),
                            child: Text(
                              "The Burger is Soft and Cheesy but the patty was not so good and the Vegetables were not fresh rest is good",
                              style: TextStyle(
                                  fontSize: textsize, color: Colors.blueGrey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      width: size.width * 0.1,
                      height: size.height * 0.2,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 8,
                                ),
                                child: CircleAvatar(
                                  radius: 32,
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      "assets/images/avatar.png",
                                      width: size.width * 0.19,
                                      height: size.height * 0.20,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 8),
                                child: Text(
                                  "Adams",
                                  style: TextStyle(
                                      color: kTextColor, fontSize: titlesize),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 80,
                                ),
                                child: SmoothStarRating(
                                    allowHalfRating: true,
                                    onRated: (value) {
                                      setState(() {
                                        rating2 = value;
                                      });
                                    },
                                    starCount: 5,
                                    rating: rating2,
                                    size: 23.0,
                                    isReadOnly: false,
                                    defaultIconData: Icons.star_border_outlined,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_border,
                                    color: Colors.amber,
                                    borderColor: Colors.amber,
                                    spacing: 0.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 6),
                                child: Text(
                                  "$rating2",
                                  style: TextStyle(color: kTextColor),
                                ),
                              )
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.only(left: 9, right: 9),
                              child: Text(
                                "There is Nothing like Supreme in it The Cheese is not taste like a cheese the bun was not freshed at all",
                                style: TextStyle(
                                  fontSize: textsize,
                                  color: kTextColor,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  // Another Screen
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      width: size.width * 0.1,
                      height: size.height * 0.2,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 8,
                                ),
                                child: CircleAvatar(
                                  radius: 32,
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      "assets/images/avatar.png",
                                      width: size.width * 0.19,
                                      height: size.height * 0.20,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 8),
                                child: Text(
                                  "Adams",
                                  style: TextStyle(
                                      color: kTextColor, fontSize: titlesize),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 80,
                                ),
                                child: SmoothStarRating(
                                    allowHalfRating: true,
                                    onRated: (value) {
                                      setState(() {
                                        rating3 = value;
                                      });
                                    },
                                    starCount: 5,
                                    rating: rating3,
                                    size: 23.0,
                                    isReadOnly: false,
                                    defaultIconData: Icons.star_border_outlined,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_border,
                                    color: Colors.amber,
                                    borderColor: Colors.amber,
                                    spacing: 0.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 6),
                                child: Text(
                                  "$rating3",
                                  style: TextStyle(color: kTextColor),
                                ),
                              )
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.only(left: 9, right: 9),
                              child: Text(
                                "There is Nothing like Supreme in it The Cheese is not taste like a cheese the bun was not freshed at all",
                                style: TextStyle(
                                  fontSize: textsize,
                                  color: kTextColor,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  // Another Screen
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      width: size.width * 0.1,
                      height: size.height * 0.2,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 8,
                                ),
                                child: CircleAvatar(
                                  radius: 32,
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      "assets/images/avatar.png",
                                      width: size.width * 0.19,
                                      height: size.height * 0.20,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 8),
                                child: Text(
                                  "Adams",
                                  style: TextStyle(
                                      color: kTextColor, fontSize: titlesize),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 80,
                                ),
                                child: SmoothStarRating(
                                    allowHalfRating: true,
                                    onRated: (value) {
                                      setState(() {
                                        rating4 = value;
                                      });
                                    },
                                    starCount: 5,
                                    rating: rating4,
                                    size: 23.0,
                                    isReadOnly: false,
                                    defaultIconData: Icons.star_border_outlined,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_border,
                                    color: Colors.amber,
                                    borderColor: Colors.amber,
                                    spacing: 0.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                ),
                                child: Text(
                                  "$rating4",
                                  style: TextStyle(color: kTextColor),
                                ),
                              )
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.only(left: 9, right: 9),
                              child: Text(
                                "There is Nothing like Supreme in it The Cheese is not taste like a cheese the bun was not freshed at all",
                                style: TextStyle(
                                  fontSize: textsize,
                                  color: kTextColor,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 20),
                  child: FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context, builder: (context) => AddRating());
                    },
                    child: Icon(Icons.add),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // void _onBottombar() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       Size size = MediaQuery.of(context).size;
  //       double rating = 4.0;
  //       return Column(children: [
  //         Container(
  //             alignment: Alignment.topRight,
  //             child: FlatButton(
  //               onPressed: () {},
  //               child: Text(
  //                 "Post",
  //                 style: TextStyle(fontSize: 18),
  //               ),
  //             )),
  //         Container(
  //           child: Column(
  //             children: [
  //               Row(
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 8),
  //                     child: Container(
  //                         height: size.height * 0.2,
  //                         width: size.width - 20,
  //                         child: Column(
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.only(
  //                                 left: 10,
  //                               ),
  //                               child: SmoothStarRating(
  //                                   allowHalfRating: true,
  //                                   onRated: (value) {
  //                                     setState(() {
  //                                       rating = value;
  //                                     });
  //                                   },
  //                                   starCount: 5,
  //                                   rating: rating,
  //                                   size: 45.0,
  //                                   isReadOnly: false,
  //                                   defaultIconData: Icons.star_border_outlined,
  //                                   filledIconData: Icons.star,
  //                                   halfFilledIconData: Icons.star_border,
  //                                   color: Colors.amber,
  //                                   borderColor: Colors.amber,
  //                                   spacing: 0.0),
  //                             ),
  //                             Padding(
  //                               padding:
  //                                   const EdgeInsets.only(left: 8, bottom: 6),
  //                               child: Text(
  //                                 "$rating",
  //                                 style: TextStyle(color: kTextColor),
  //                               ),
  //                             ),
  //                           ],
  //                         )),
  //                   )
  //                 ],
  //               ),
  //               Container(
  //                 margin: EdgeInsets.only(
  //                     left: size.width * 0.01, right: size.width * 0.01),
  //                 child: TextField(
  //                   autocorrect: false,
  //                   maxLength: 500,
  //                   maxLines: 4,
  //                   style: TextStyle(fontSize: 15),
  //                   decoration: InputDecoration(
  //                     border: OutlineInputBorder(
  //                       borderRadius: const BorderRadius.all(
  //                         const Radius.circular(20.0),
  //                       ),
  //                     ),
  //                     hintText: "Add an Comment",
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ]);

}
