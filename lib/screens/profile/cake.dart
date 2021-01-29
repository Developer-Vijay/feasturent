import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class List1 extends StatefulWidget {
  @override
  _List1State createState() => _List1State();
}

class _List1State extends State<List1> {
  ScrollController controller = ScrollController();

  bool closeTopController = false;
  double topContainer = 0;

  void initstate() {
    super.initState();
    controller.addListener(() {
      setState(() {
        closeTopController = controller.offset > 40;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var rating = 3.0;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: size.width,
                  alignment: Alignment.topCenter,
                  height: closeTopController ? 0 : size.height * 0.4,
                  child: Container(
                    child: ClipPath(
                      clipper: WaveClipperOne(),
                      child: Container(
                          color: Colors.blue,
                          height: size.height * 0.5,
                          width: size.width * 0.999,
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () {},
                                  )),
                              Container(
                                child: Text("Hello"),
                              )
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: ListView(
                  controller: controller,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.02,
                                    right: size.width * 0.02),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(blurRadius: 5)]),
                                height: size.height * 0.13,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            "assets/images/Cake.jpg",
                                            fit: BoxFit.cover,
                                            height: size.height * 0.2,
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
                                                    left: 10, top: 5),
                                                child: Text(
                                                  "Red Velvet",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 24),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.04,
                                                width: size.width * 0.32,
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
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, top: 7),
                                                child: Text(
                                                  "Hot Cake",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, bottom: 24),
                                                child: SmoothStarRating(
                                                    allowHalfRating: false,
                                                    onRated: (v) {
                                                      Text("23");
                                                    },
                                                    starCount: 1,
                                                    rating: rating,
                                                    size: 23.0,
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
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3, bottom: 24),
                                                child: Text(
                                                  "4.9",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13, bottom: 20),
                                                child: SvgPicture.asset(
                                                    "assets/icons/rupee.svg",
                                                    height: 14),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 20),
                                                child: Text(
                                                  "250",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 38,
                                              ),
                                              MaterialButton(
                                                onPressed: () {},
                                                color: Colors.red,
                                                textColor: Colors.white,
                                                minWidth: 30,
                                                height: 32,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  "offer",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.02,
                                    right: size.width * 0.02),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(blurRadius: 5)]),
                                height: size.height * 0.13,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            "assets/images/Cake.jpg",
                                            fit: BoxFit.cover,
                                            height: size.height * 0.2,
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
                                                    left: 10, top: 5),
                                                child: Text(
                                                  "Red Velvet",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 24),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.04,
                                                width: size.width * 0.32,
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
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, top: 7),
                                                child: Text(
                                                  "Hot Cake",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, bottom: 24),
                                                child: SmoothStarRating(
                                                    allowHalfRating: false,
                                                    onRated: (v) {
                                                      Text("23");
                                                    },
                                                    starCount: 1,
                                                    rating: rating,
                                                    size: 23.0,
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
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3, bottom: 24),
                                                child: Text(
                                                  "4.9",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13, bottom: 20),
                                                child: SvgPicture.asset(
                                                    "assets/icons/rupee.svg",
                                                    height: 14),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 20),
                                                child: Text(
                                                  "250",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 38,
                                              ),
                                              MaterialButton(
                                                onPressed: () {},
                                                color: Colors.red,
                                                textColor: Colors.white,
                                                minWidth: 30,
                                                height: 32,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  "offer",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.02,
                                    right: size.width * 0.02),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(blurRadius: 5)]),
                                height: size.height * 0.13,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            "assets/images/Cake.jpg",
                                            fit: BoxFit.cover,
                                            height: size.height * 0.2,
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
                                                    left: 10, top: 5),
                                                child: Text(
                                                  "Red Velvet",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 24),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.04,
                                                width: size.width * 0.32,
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
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, top: 7),
                                                child: Text(
                                                  "Hot Cake",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, bottom: 24),
                                                child: SmoothStarRating(
                                                    allowHalfRating: false,
                                                    onRated: (v) {
                                                      Text("23");
                                                    },
                                                    starCount: 1,
                                                    rating: rating,
                                                    size: 23.0,
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
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3, bottom: 24),
                                                child: Text(
                                                  "4.9",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13, bottom: 20),
                                                child: SvgPicture.asset(
                                                    "assets/icons/rupee.svg",
                                                    height: 14),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 20),
                                                child: Text(
                                                  "250",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 38,
                                              ),
                                              MaterialButton(
                                                onPressed: () {},
                                                color: Colors.red,
                                                textColor: Colors.white,
                                                minWidth: 30,
                                                height: 32,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  "offer",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.02,
                                    right: size.width * 0.02),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(blurRadius: 5)]),
                                height: size.height * 0.13,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            "assets/images/Cake.jpg",
                                            fit: BoxFit.cover,
                                            height: size.height * 0.2,
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
                                                    left: 10, top: 5),
                                                child: Text(
                                                  "Red Velvet",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 24),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.04,
                                                width: size.width * 0.32,
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
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, top: 7),
                                                child: Text(
                                                  "Hot Cake",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, bottom: 24),
                                                child: SmoothStarRating(
                                                    allowHalfRating: false,
                                                    onRated: (v) {
                                                      Text("23");
                                                    },
                                                    starCount: 1,
                                                    rating: rating,
                                                    size: 23.0,
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
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3, bottom: 24),
                                                child: Text(
                                                  "4.9",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13, bottom: 20),
                                                child: SvgPicture.asset(
                                                    "assets/icons/rupee.svg",
                                                    height: 14),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 20),
                                                child: Text(
                                                  "250",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 38,
                                              ),
                                              MaterialButton(
                                                onPressed: () {},
                                                color: Colors.red,
                                                textColor: Colors.white,
                                                minWidth: 30,
                                                height: 32,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  "offer",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.02,
                                    right: size.width * 0.02),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(blurRadius: 5)]),
                                height: size.height * 0.13,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            "assets/images/Cake.jpg",
                                            fit: BoxFit.cover,
                                            height: size.height * 0.2,
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
                                                    left: 10, top: 5),
                                                child: Text(
                                                  "Red Velvet",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 24),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.04,
                                                width: size.width * 0.32,
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
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, top: 7),
                                                child: Text(
                                                  "Hot Cake",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, bottom: 24),
                                                child: SmoothStarRating(
                                                    allowHalfRating: false,
                                                    onRated: (v) {
                                                      Text("23");
                                                    },
                                                    starCount: 1,
                                                    rating: rating,
                                                    size: 23.0,
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
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3, bottom: 24),
                                                child: Text(
                                                  "4.9",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13, bottom: 20),
                                                child: SvgPicture.asset(
                                                    "assets/icons/rupee.svg",
                                                    height: 14),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 20),
                                                child: Text(
                                                  "250",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 38,
                                              ),
                                              MaterialButton(
                                                onPressed: () {},
                                                color: Colors.red,
                                                textColor: Colors.white,
                                                minWidth: 30,
                                                height: 32,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  "offer",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
