import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/components/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ViewAllPopular.dart';

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
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewAllPopular())),
                    print('View All')
                  },
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
        Container(
          height: size.height * 0.14,
          child: ListView.builder(
            itemCount: popularonfeast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
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
                        margin: EdgeInsets.only(left: size.width * 0.02),
                        height: size.height * 0.08,
                        width: size.width * 0.24,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
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
                                imageUrl: popularonfeast[index].categoryImage,
                                fit: BoxFit.cover,
                                width: size.width * 0.16,
                                height: size.height * 0.2,
                              ),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: size.height * 0.016,
                  ),
                  Text(
                    popularonfeast[index].categoryName,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: size.height * 0.0136),
                  )
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
