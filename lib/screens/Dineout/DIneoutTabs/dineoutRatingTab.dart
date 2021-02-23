import 'package:feasturent_costomer_app/components/Bottomsheet/addRatingBottom.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingBarTab extends StatefulWidget {
  @override
  _RatingBarTabState createState() => _RatingBarTabState();
}

class _RatingBarTabState extends State<RatingBarTab> {
  double rating = 2.0;
  double rating2 = 3.0;
  double rating3 = 4.0;
  double rating4 = 5.0;

  var titlesize = 12.0;
  var textsize = 13.0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
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
                            padding: const EdgeInsets.only(left: 12.0, top: 8),
                            child: Text(
                              "Adams",
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: titlesize),
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
                                isReadOnly: true,
                                defaultIconData: Icons.star_border_outlined,
                                filledIconData: Icons.star,
                                halfFilledIconData: Icons.star_border,
                                color: Colors.amber,
                                borderColor: Colors.amber,
                                spacing: 0.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 6),
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
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            alignment: Alignment.center,
            child: MaterialButton(
              color: Colors.blue,
              minWidth: 340,
              textColor: Colors.white,
              onPressed: () {
                showModalBottomSheet(
                    context: context, builder: (context) => AddRating());
              },
              child: Text("Rate Your Experience"),
            ),
          ),
        ),
      ],
    );
  }
}
