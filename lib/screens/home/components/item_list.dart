import 'dart:convert';

import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/components/list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    Key key,
  }) : super(key: key);

  Future<List<dynamic>> fetchCategories() async {
    var result =
        await http.get(ADMIN_API + 'category?key=STATUS&id=2&status=1');
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
              margin: EdgeInsets.only(left: size.width * 0.05),
              child: Text(
                "Categories",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: kTextColor),
              ),
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: size.width * 0.4),
                    child: FlatButton(
                        onPressed: () => {print('View All')},
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
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
                        ))),
              ],
            )
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
                      margin: EdgeInsets.only(left: size.width * 0.011),
                      height: size.height * 0.08,
                      width: size.width * 0.24,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: FlatButton(
                          onPressed: () {},
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/thali.jpg",
                              fit: BoxFit.cover,
                              width: size.width * 0.2,
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
                  "Thali",
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
                  padding: const EdgeInsets.only(top: 8),
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
                    margin: EdgeInsets.only(left: size.width * 0.01),
                    height: size.height * 0.08,
                    width: size.width * 0.24,
                    child: FlatButton(
                      onPressed: () {},
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/SouthIndian.jpg",
                          fit: BoxFit.cover,
                          width: size.width * 0.2,
                          height: size.height * 0.2,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "South Indian",
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
                      margin: EdgeInsets.only(left: size.width * 0.01),
                      height: size.height * 0.08,
                      width: size.width * 0.24,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: FlatButton(
                          onPressed: () {},
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/Cake.jpg",
                              fit: BoxFit.cover,
                              width: size.width * 0.2,
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
                  "Cake & Desserts",
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
                              spreadRadius: 2)
                        ],
                      ),
                      margin: EdgeInsets.only(left: size.width * 0.01),
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
                                  builder: (context) => Practice()),
                            );
                          },
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/Burger.jpg",
                              fit: BoxFit.cover,
                              width: size.width * 0.2,
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
                  "Burger",
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
                      margin: EdgeInsets.only(left: size.width * 0.01),
                      height: size.height * 0.08,
                      width: size.width * 0.24,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: FlatButton(
                          onPressed: () {},
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/Chinese.jpg",
                              fit: BoxFit.cover,
                              width: size.width * 0.2,
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
                  "Chinese",
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
                      margin: EdgeInsets.only(left: size.width * 0.01),
                      height: size.height * 0.08,
                      width: size.width * 0.24,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: FlatButton(
                          onPressed: () {},
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/rajmaChawal.jpg",
                              fit: BoxFit.cover,
                              width: size.width * 0.2,
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
                  "North Indian",
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
                      margin: EdgeInsets.only(left: size.width * 0.01),
                      height: size.height * 0.08,
                      width: size.width * 0.24,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: FlatButton(
                          onPressed: () {},
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/Tea.jpg",
                              fit: BoxFit.cover,
                              width: size.width * 0.2,
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
                  "Snacks and Beverages",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 10),
                )
              ],
            ),
          ]),
        ),
      ],
    );
  }
}
