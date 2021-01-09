import 'dart:convert';

import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/screens/details/details-screen.dart';
import 'package:feasturent_costomer_app/screens/home/components/item_card.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
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
              future: fetchCategories(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  print("HEY");
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemCard(
                          categoryIcon: snapshot.data[index]['iconImage'],
                          title: snapshot.data[index]['name'],
                          shopName: "",
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
