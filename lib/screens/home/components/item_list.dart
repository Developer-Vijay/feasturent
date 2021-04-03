import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/components/viewAllCategory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'category_related_menu.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({
    Key key,
  }) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  void initState() {
    super.initState();
  }

  var data = null;
  Future<List<dynamic>> fetchCategories() async {
    var result = await http.get(APP_ROUTES + 'getCategories?key=ALL');
    data = json.decode(result.body)['data'];
    return data;
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
                      if (data != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ViewAllCategory(categoryData: data),
                            ));
                      }
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
            height: size.height * 0.14,
            child: FutureBuilder<List<dynamic>>(
              future: fetchCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int legnth;
                  if (snapshot.data.length > 15) {
                    legnth = 15;
                  } else {
                    legnth = snapshot.data.length;
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: legnth,
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
                                margin:
                                    EdgeInsets.only(left: size.width * 0.011),
                                height: size.height * 0.08,
                                width: size.width * 0.24,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryRelatedMenues(
                                              categoryName: snapshot.data[index]
                                                  ['name'],
                                              categoryid: snapshot.data[index]
                                                      ['id']
                                                  .toString(),
                                            ),
                                          ));
                                    },
                                    child: ClipOval(
                                        child: snapshot.data[index]
                                                    ['iconImage'] !=
                                                null
                                            ? CachedNetworkImage(
                                                imageUrl: S3_BASE_PATH +
                                                    snapshot.data[index]
                                                        ['iconImage'],
                                                fit: BoxFit.cover,
                                                width: size.width * 0.2,
                                                height: size.height * 0.2,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                  "assets/images/feasturenttemp.jpeg",
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : Image.asset(
                                                "assets/images/feasturenttemp.jpeg",
                                                fit: BoxFit.cover,
                                                width: size.width * 0.2,
                                                height: size.height * 0.2,
                                              )),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            snapshot.data[index]['name'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: size.height * 0.014),
                          )
                        ],
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ))
      ],
    );
  }
}
