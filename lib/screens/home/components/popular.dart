import 'dart:convert';

import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/components/popularItem.dart';
import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/screens/details/details-screen.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular on feasturent",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: kTextColor),
              ),
              FlatButton(
                  onPressed: () => {print('View All')},
                  child: Row(
                    children: [
                      Text(
                        "View All",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: kPrimaryColor),
                      ),
                      Icon(
                        Icons.arrow_right_rounded,
                        color: kSecondaryTextColor,
                      )
                    ],
                  ))
            ],
          ),
        ),
        Container(
          height: 150,
          child: FutureBuilder<List<dynamic>>(
              future: fetchPopularMenues(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  print("HEY");
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PopularItem(
                          menuId: snapshot.data[index]['id'],
                          menuIcon: snapshot.data[index]['image1'],
                          title: snapshot.data[index]['title'],
                          shopName: "Feasturent",
                          price: snapshot.data[index]['price'],
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailsScreen();
                                },
                              ),
                            );
                          },
                        );
                      });
                } else {
                  return Container(
                    child: Text('Adam'),
                  );
                }
              }),
        ),
      ],
    );
  }
}
