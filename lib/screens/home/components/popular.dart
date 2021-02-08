import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/components/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PopularList extends StatelessWidget {
  const PopularList({
    Key key,
  }) : super(key: key);

  Future<List<dynamic>> fetchPopularMenues() async {
    var result = await http.get(VENDOR_API + 'menues?key=ALL&id=5');
    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
              top: size.height * 0.01, bottom: size.height * 0.01),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: size.width * 0.04),
              child: Text(
                "Popular on Feasturent",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: kTextColor),
              ),
            ),
            Spacer(),
            Container(
                alignment: Alignment.topRight,
                child: FlatButton(
                  onPressed: () => {print('View All')},
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          "View All",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.zero,
                          child: Icon(
                            Icons.arrow_right_rounded,
                            color: kSecondaryTextColor,
                          )),
                    ],
                  ),
                ))
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.blueGrey,
                              spreadRadius: 1)
                        ],
                      ),
                      margin: EdgeInsets.only(left: 4),
                      height: size.height * 0.08,
                      width: size.width * 0.24,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PizzaList()),
                            );
                          },
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://image.shutterstock.com/z/stock-photo-chole-bhature-or-chick-pea-curry-and-fried-puri-served-in-terracotta-crockery-over-white-1072270610.jpg",
                              fit: BoxFit.cover,
                              width: size.width * 0.16,
                              height: size.height * 0.2,
                            ),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "Chole Bhature",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 10),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.blueGrey,
                              spreadRadius: 1)
                        ],
                      ),
                      margin: EdgeInsets.only(left: 4),
                      height: size.height * 0.08,
                      width: size.width * 0.24,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: FlatButton(
                          onPressed: () {},
                          child: ClipOval(
                            child: CachedNetworkImage(
                                imageUrl:
                                    "https://image.shutterstock.com/z/stock-photo-traditional-dumpling-vegetarian-momos-food-from-nepal-served-with-tomato-chutney-over-moody-plate-1719536887.jpg",
                                fit: BoxFit.cover,
                                width: size.width * 0.16,
                                height: size.height * 0.2),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "Special Momos",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 10),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.blueGrey,
                              spreadRadius: 1)
                        ],
                      ),
                      margin: EdgeInsets.only(left: 4),
                      height: size.height * 0.08,
                      width: size.width * 0.24,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: FlatButton(
                          onPressed: () {},
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://image.shutterstock.com/image-photo/arabian-spicy-food-concept-homemade-600w-1199926645.jpg",
                              fit: BoxFit.cover,
                              width: size.width * 0.16,
                              height: size.height * 0.2,
                            ),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "Tandori Chicken",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 10),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.blueGrey,
                              spreadRadius: 1)
                        ],
                      ),
                      margin: EdgeInsets.only(left: 4),
                      height: size.height * 0.08,
                      width: size.width * 0.24,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: FlatButton(
                          onPressed: () {},
                          child: ClipOval(
                            child: CachedNetworkImage(
                                imageUrl:
                                    "https://image.shutterstock.com/z/stock-photo-big-cheeseburger-with-lots-of-cheese-stock-photo-side-view-of-a-cheeseburger-on-a-black-brick-wall-1680415567.jpg",
                                fit: BoxFit.cover,
                                width: size.width * 0.16,
                                height: size.height * 0.2),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  " Cheese Burger",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 10),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.blueGrey,
                              spreadRadius: 1)
                        ],
                      ),
                      margin: EdgeInsets.only(left: 4),
                      height: size.height * 0.08,
                      width: size.width * 0.24,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: FlatButton(
                          onPressed: () {},
                          child: ClipOval(
                            child: CachedNetworkImage(
                                imageUrl:
                                    "https://image.shutterstock.com/z/stock-photo-chicken-kabsa-homemade-arabian-biryani-overhead-view-1048188121.jpg",
                                fit: BoxFit.cover,
                                width: size.width * 0.16,
                                height: size.height * 0.2),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "Chicken Biryani",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 10),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.blueGrey,
                              spreadRadius: 1)
                        ],
                      ),
                      margin: EdgeInsets.only(left: 4),
                      height: size.height * 0.08,
                      width: size.width * 0.24,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: FlatButton(
                          onPressed: () {},
                          child: ClipOval(
                            child: CachedNetworkImage(
                                imageUrl:
                                    "https://image.shutterstock.com/z/stock-photo-palak-paneer-curry-made-up-of-spinach-and-cottage-cheese-popular-indian-healthy-lunch-dinner-food-620862170.jpg",
                                fit: BoxFit.cover,
                                width: size.width * 0.16,
                                height: size.height * 0.2),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "Palak Paneer ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 10),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.blueGrey,
                              spreadRadius: 1)
                        ],
                      ),
                      margin: EdgeInsets.only(left: 4),
                      height: size.height * 0.08,
                      width: size.width * 0.24,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: FlatButton(
                          onPressed: () {},
                          child: ClipOval(
                            child: CachedNetworkImage(
                                imageUrl:
                                    "https://image.shutterstock.com/z/stock-photo-masala-dosa-indian-savory-crepes-with-potato-filling-top-down-view-783911236.jpg",
                                fit: BoxFit.cover,
                                width: size.width * 0.16,
                                height: size.height * 0.2),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "Masala Dosa",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 10),
                )
              ],
            ),
          ]),
        ),
        SizedBox(
          height: 9,
        ),

        // Discount Page or offer

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 190,
                  height: 100,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Image.asset(
                              "assets/images/king.png",
                              height: 60,
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.white),
                                children: [
                                  TextSpan(
                                    text: "Get Discount of \n",
                                    style: TextStyle(fontSize: 12, shadows: [
                                      Shadow(
                                          blurRadius: 2,
                                          offset: Offset(0.6, 0.6),
                                          color: Colors.white)
                                    ]),
                                  ),
                                  TextSpan(
                                    text: "40% \n",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "at Burger King",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Second Image
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 190,
                height: 100,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(
                            "assets/images/K.png",
                            height: 60,
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.white),
                              children: [
                                TextSpan(
                                  text: "Get Discount of \n",
                                  style: TextStyle(fontSize: 12, shadows: [
                                    Shadow(
                                        blurRadius: 2,
                                        offset: Offset(0.6, 0.6),
                                        color: Colors.white)
                                  ]),
                                ),
                                TextSpan(
                                  text: "20% \n",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "at KFC",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Third Image
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 190,
                  height: 100,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Image.asset(
                              "assets/images/Baskin.png",
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.white),
                                children: [
                                  TextSpan(
                                    text: "Get Discount of \n",
                                    style: TextStyle(fontSize: 12, shadows: [
                                      Shadow(
                                          blurRadius: 2,
                                          offset: Offset(0.6, 0.6),
                                          color: Colors.white)
                                    ]),
                                  ),
                                  TextSpan(
                                    text: "20% \n",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "at BaskinRobbin",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Top Brands For You
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(
            "Top Brands For You",
            style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: SingleChildScrollView(
              child: Row(
            children: [
              Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.blueGrey,
                              spreadRadius: 2)
                        ],
                      ),
                      margin: EdgeInsets.only(left: 4),
                      height: size.height * 0.08,
                      width: size.width * 0.24,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: FlatButton(
                          onPressed: () {},
                          child: ClipOval(
                            child: Image.asset("assets/images/M3.png",
                                fit: BoxFit.cover,
                                width: size.width * 0.14,
                                height: size.height * 0.2),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "McDonalds",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 10),
                  )
                ],
              ),
              Column(children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            color: Colors.blueGrey,
                            spreadRadius: 2)
                      ],
                    ),
                    margin: EdgeInsets.only(left: 4),
                    height: size.height * 0.08,
                    width: size.width * 0.24,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 0,
                      child: FlatButton(
                        onPressed: () {},
                        child: ClipOval(
                          child: Image.asset("assets/images/king.png",
                              fit: BoxFit.cover,
                              width: size.width * 0.14,
                              height: size.height * 0.2),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "Burger King",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 10),
                ),
              ]),
              Column(children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            color: Colors.blueGrey,
                            spreadRadius: 2)
                      ],
                    ),
                    margin: EdgeInsets.only(left: 4),
                    height: size.height * 0.08,
                    width: size.width * 0.24,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      child: FlatButton(
                        onPressed: () {},
                        child: ClipOval(
                          child: Image.asset("assets/images/K.png",
                              fit: BoxFit.cover,
                              width: size.width * 0.14,
                              height: size.height * 0.2),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 7,
                ),
                Text("KFC",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 10)),
              ])
            ],
          )),
        ),
      ],
    );
  }
}
