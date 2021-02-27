import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/components/viewAllCategory.dart';
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
            Spacer(),
          Container(
                child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewAllCategory(),
                          ));
                    },
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
                        Icon(
                          Icons.arrow_right_rounded,
                          color: kSecondaryTextColor,
                        ),
                      ],
                    )))
          ],
        ),
        Container(
          height: size.height * 0.12,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.length,
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
                        margin: EdgeInsets.only(left: size.width * 0.011),
                        height: size.height * 0.08,
                        width: size.width * 0.24,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: FlatButton(
                            onPressed: () {},
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: category[index].categoryImage,
                                fit: BoxFit.cover,
                                width: size.width * 0.2,
                                height: size.height * 0.2,
                              ),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    category[index].categoryName,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: size.height * 0.014),
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
