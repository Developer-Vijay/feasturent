import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutdetailpage.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutlist.dart';
import 'package:feasturent_costomer_app/screens/Dineout/view_popular.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class PopularDininingLists extends StatefulWidget {
  @override
  _PopularDininingListsState createState() => _PopularDininingListsState();
}

class _PopularDininingListsState extends State<PopularDininingLists> {
  final popularimageslist = [
    "https://media.gettyimages.com/photos/elegant-shopping-mall-picture-id182408547?s=2048x2048",
    "https://media.gettyimages.com/photos/cafebar-in-moscow-picture-id1158221681?s=2048x2048",
    "https://media.gettyimages.com/photos/family-in-a-cafe-picture-id1089596346?k=6&m=1089596346&s=612x612&w=0&h=w3lny9JWOUDIBTQbMVNVDBu48KMw316UANpAhPV0zdk=",
  ];
  @override
  void initState() {
    super.initState();
  }

  var responseData = null;
  Future<List> getpopulardineouts() async {
    var response = await http.get(APP_ROUTES + 'popularDineout');
    print(response);

    print(responseData);
    if (response.statusCode == 200) {
      responseData = json.decode(response.body)['data'];
      return responseData;
    } else {
      return responseData;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _textstyle = TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: size.height * 0.014);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Popular Dineout Areas",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.height * 0.016,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Spacer(),
              Container(
                  child: FlatButton(
                      onPressed: () {
                        if (responseData != null) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           ViewAllPopular(data: responseData),
                          //     ));
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
              height: size.height * 0.15,
              child: FutureBuilder<List>(
                future: getpopulardineouts(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                  height: size.height * 0.11,
                                  width: size.width * 0.31,
                                  child: FlatButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             DineoutDetailPage()));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        imageUrl: popular[index].image,
                                        fit: BoxFit.cover,
                                        width: size.width * 0.31,
                                        height: size.height * 0.2,
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              child: snapshot.data[index]['VendorInfo']['name']!=null?
                              Text(
                                  "${snapshot.data[index]['VendorInfo']['name']}",
                                  style: _textstyle):Text("Name")
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )),
        ],
      ),
    );
  }
}
