import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/components/viewAllCategory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'dart:convert';
import 'category_related_resturent.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({
    Key key,
  }) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

var catdata;

class _CategoriesListState extends State<CategoriesList> {
  @override
  void initState() {
    super.initState();
  }

  fetchCategories() async {
    return categorymemoizer.runOnce(() async {
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  hitting api category");

      var result =
          await http.get(Uri.parse(APP_ROUTES + 'getCategories?key=ALL'));
      catdata = json.decode(result.body)['data'];
      return catdata;
    });
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
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                    fontSize: size.height * 0.025),
              ),
            ),
            Spacer(),
            Container(
                child: TextButton(
                    onPressed: () {
                      if (catdata != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ViewAllCategory(categoryData: catdata),
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
                              color: kPrimaryColor,
                            ),
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
            child: FutureBuilder(
          future: this.fetchCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int legnth;
              if (snapshot.data.length >= 50) {
                legnth = 50;
              } else {
                legnth = snapshot.data.length;
              }
              return Container(
                height: size.height * 0.14,
                child: ListView.builder(
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
                              margin: EdgeInsets.only(left: size.width * 0.011),
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
                          capitalize(snapshot.data[index]['name']),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: size.height * 0.017),
                        )
                      ],
                    );
                  },
                ),
              );
            } else {
              return Container(
                height: size.height * 0.14,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 10,
                      ),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          margin: EdgeInsets.only(left: size.width * 0.011),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ))
      ],
    );
  }
}
