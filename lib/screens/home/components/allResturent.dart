import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/insideofferpage.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AllResturent extends StatefulWidget {
  const AllResturent({
    Key key,
  }) : super(key: key);
  @override
  _AllResturentState createState() => _AllResturentState();
}

class _AllResturentState extends State<AllResturent> {
  var listlength = 0;
  String _customerProfile;
  String _customerEmail;
  String _authorization = '';
  String _refreshtoken = '';
  void initState() {
    super.initState();
  }

  var restaurantData;
  Future<List<dynamic>> fetchAllRestaurant() async {
    final prefs = await SharedPreferences.getInstance();
    _authorization = prefs.getString('sessionToken');
    _refreshtoken = prefs.getString('refreshToken');
    var result = await http.get(APP_ROUTES + 'getRestaurantInfos' + '?key=ALL',
        headers: {
          "authorization": _authorization,
          "Content-Type": "application/json"
        });
    print(_authorization);
    restaurantData = json.decode(result.body)['data'];
    check();
    print("hello");
    print(restaurantData);
    print("hello");

    return restaurantData;
  }

  check() {
    if (restaurantData.length >= 10) {
      listlength = 10;
    } else if (restaurantData.length <= 10) {
      listlength = restaurantData.length;
    }
    print(listlength);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: size.width * 0.05),
            child: Text(
              "All Resturent",
              style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
            )),
        SizedBox(
          height: size.height * 0.017,
        ),
        FutureBuilder<List<dynamic>>(
          future: fetchAllRestaurant(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listlength,
                itemBuilder: (context, index) {
                  print("this is data");
                  print(snapshot.data);
                  return InkWell(
                    onTap: () {
                      print(snapshot.data[index]);
                      // var restaurantData = snapshot.data[index];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OfferListPage(
                                  restaurantDa: snapshot.data[index])
                              // settings: RouteSettings(
                              //   arguments: ,
                              // ),
                              ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.grey[200],
                                    offset: Offset(0, 3),
                                    spreadRadius: 2)
                              ]),
                          margin: EdgeInsets.only(
                            left: size.width * 0.02,
                            right: size.width * 0.02,
                          ),
                          height: size.height * 0.135,
                          child: Row(children: [
                            Expanded(
                                flex: 0,
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  height: size.height * 0.2,
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(8),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: foodlist[index].foodImage,
                                            height: size.height * 0.18,
                                            width: size.width * 0.3,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 6,
                                child: Container(
                                  height: size.height * 0.2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: size.height * 0.02),
                                        child: Row(
                                          children: [
                                            Text(
                                              snapshot.data[index]['name'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: size.height * 0.02),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12),
                                              child: CachedNetworkImage(
                                                  imageUrl:
                                                      foodlist[index].vegsymbol,
                                                  height: size.height * 0.016),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.013,
                                      ),
                                      Text(
                                        foodlist[index].subtitle,
                                        style: TextStyle(
                                            fontSize: size.height * 0.015,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              child: foodlist[index].starRating,
                                            ),
                                            Text(
                                              "3.0",
                                              style: TextStyle(
                                                  fontSize: size.height * 0.016,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            CachedNetworkImage(
                                              imageUrl:
                                                  foodlist[index].discountImage,
                                              height: size.height * 0.022,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 12.0,
                                              ),
                                              child: Text(
                                                foodlist[index].discountText,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        size.height * 0.016,
                                                    color: kTextColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ])),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ],
    );
  }
}
