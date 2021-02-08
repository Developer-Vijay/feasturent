import 'package:carousel_slider/carousel_slider.dart';
import 'package:feasturent_costomer_app/components/Bottomsheet/addbar.dart';
import 'package:feasturent_costomer_app/screens/profile/components/rating.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FoodSlider extends StatefulWidget {
  @override
  _FoodSliderState createState() => _FoodSliderState();
}

class _FoodSliderState extends State<FoodSlider> {
  var rating = 3.0;
  int _current = 0;
  int selectedRadioTile;

  var pad = 34;

  void initeState() {
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * 0.5,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 70),
                    child: CarouselSlider(
                      items: [
                        // First Image
                        Container(
                          height: size.height * 0.9,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Burger.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Container(
                          height: size.height * 0.1,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/images/burger.png"),
                            fit: BoxFit.cover,
                          )),
                        ),
                      ],
                      options: CarouselOptions(
                        autoPlay: false,
                        enableInfiniteScroll: true,
                        viewportFraction: 1,
                        //enlargeCenterPage: true,
                        aspectRatio: 10 / 7.61,
                        initialPage: 0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                // Main Container which Overlaps
                Align(
                  alignment: Alignment.center,
                  heightFactor: size.height * 0.0025,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.2, right: 0.2),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      height: size.height * 0.7,
                      width: size.width * 0.999,
                      child: Column(children: [
                        Container(
                            child: Row(
                          children: [
                            // Location
                            Padding(
                              padding: const EdgeInsets.only(left: 34, top: 20),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 21),
                              child: Text(
                                "Mc Donalds",
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          ],
                        )),

                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    //color: Colors.red,

                                    child: Text(
                                      '''Veg Cheese Burger''',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 15,
                                  ),
                                  child: Text(
                                    "₹ 250",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ]),
                        ),

                        // Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 2),
                              child: SmoothStarRating(
                                  allowHalfRating: false,
                                  onRated: (v) {
                                    Text("23");
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
                              padding: const EdgeInsets.only(left: 15),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RatingPage()),
                                  );
                                },
                                child: Text("24 Views"),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 30, right: 20),
                          child: Container(
                            child: Text(
                              "Nowadays,making printed materials have become fast, easy and simple.if you want your promotional material to be an eye catching object you should make it colored by way of using inkjet printer this is not hard to make . we will Provise the Edges of all The Content and anything which is their to here listen each and everthing this food is very tasty and healthy in eating",
                              style: TextStyle(wordSpacing: 2, fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.only(
                              left: size.width * 0.11,
                              right: size.width * 0.11),
                          child: MaterialButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Sheet());
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            height: 60,
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 60),
                                  child: Icon(
                                    Icons.shopping_bag,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Order Now",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MaterialButtonWidget extends StatefulWidget {
  @override
  _MaterialButtonWidgetState createState() => _MaterialButtonWidgetState();
}

class _MaterialButtonWidgetState extends State<MaterialButtonWidget> {
  bool _show = true;
  @override
  Widget build(BuildContext context) {
    return _show
        ? MaterialButton(
            onPressed: () {
              var sheetController = showBottomSheet(
                  context: context, builder: (context) => Bottomsheetwidget());
              _showButton(false);
              sheetController.closed.then((value) {
                _showButton(true);
              });
            },
          )
        : Container();
  }

  void _showButton(bool value) {
    setState(() {
      _show = value;
    });
  }
}
