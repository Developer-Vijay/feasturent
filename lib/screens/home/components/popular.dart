import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/components/category_detail.dart';
import 'package:feasturent_costomer_app/screens/home/components/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ViewAllPopular.dart';

class PopularList extends StatefulWidget {
  @override
  _PopularListState createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  @override
  void initState() {
    fetchHomeSliderLength();
    super.initState();
  }

  var data = null;
  Future<List<dynamic>> fetchPopular() async {
    var result = await http.get(APP_ROUTES + 'getPopularMenues');
    data = json.decode(result.body)['data'];
    return data;
  }

  var sliderOffers;

  int checkDataLenght = 0;

  Future fetchHomeSliderLength() async {
    var result = await http
        .get(APP_ROUTES + 'utilities' + '?key=BYFOR' + '&for=homeSlider');
    var data = json.decode(result.body)['data'];
    if (data.isEmpty) {
      setState(() {
        checkDataLenght = 0;
      });
      print("data not here");
    } else {
      print("data here");
      if (data[0]['status'] == true) {
        setState(() {
          checkDataLenght = data.length;
        });
      } else {
        setState(() {
          checkDataLenght = 0;
        });
        print("data not here");
      }
    }

    print("data length $checkDataLenght");
  }

  Future<List<dynamic>> fetchHomeSlider() async {
    var result = await http
        .get(APP_ROUTES + 'utilities' + '?key=BYFOR' + '&for=homeSlider');
    sliderOffers = json.decode(result.body)['data'];
    if (sliderOffers.isEmpty) {
      print("data not here");
    } else {
      print("data here");
      if (sliderOffers[0]['status'] == true) {
        return sliderOffers;
      }
    }
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
                  onPressed: () {
                    if (data != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAllPopular(
                                    popularData: data,
                                  )));
                    }
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
            child: FutureBuilder<List<dynamic>>(
              future: fetchPopular(),
              builder: (context, snap) {
                if (snap.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      if (snap.data[index]['Menu'] != null) {
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
                                        var menuD;
                                        setState(() {
                                          menuD =
                                              snap.data[index]['Menu']['id'];
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoryDetailPage(
                                                      menuId: menuD,
                                                      cateID: snap.data[index]
                                                              ['Menu']
                                                          ['categoryId'],
                                                    )));
                                      },
                                      child: ClipOval(
                                          child: snap.data[index]['Menu']
                                                      ['image1'] !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl: S3_BASE_PATH +
                                                      snap.data[index]['Menu']
                                                          ['image1'],
                                                  fit: BoxFit.cover,
                                                  width: size.width * 0.2,
                                                  height: size.height * 0.2,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
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
                              snap.data[index]['Menu']['title'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.height * 0.014),
                            )
                          ],
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
        SizedBox(
          height: 9,
        ),
        checkDataLenght == 0
            ? SizedBox()
            : checkDataLenght == 1
                ? Container(
                    margin: EdgeInsets.all(8),
                    height: size.height * 0.18,
                    child: FutureBuilder<List<dynamic>>(
                      future: fetchHomeSlider(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: size.width * 1,
                                  height: 100,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Expanded(
                                              child: snapshot.data[index][
                                                              'OffersAndCoupon']
                                                          ['image'] !=
                                                      null
                                                  ? CachedNetworkImage(
                                                      imageUrl: S3_BASE_PATH +
                                                          snapshot.data[index][
                                                                  'OffersAndCoupon']
                                                              ['image'],
                                                      height: size.height * 0.1,
                                                      width: size.width * 0.18,
                                                      fit: BoxFit.fill,
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    )
                                                  : Image.asset(
                                                      "assets/images/feasturenttemp.jpeg",
                                                      height:
                                                          size.height * 0.18,
                                                      width: size.width * 0.3,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.white),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${snapshot.data[index]['OffersAndCoupon']['title']}\n",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        shadows: [
                                                          Shadow(
                                                              blurRadius: 2,
                                                              offset: Offset(
                                                                  0.6, 0.6),
                                                              color:
                                                                  Colors.white)
                                                        ]),
                                                  ),
                                                  TextSpan(
                                                    text: snapshot.data[index][
                                                                    'OffersAndCoupon']
                                                                [
                                                                'couponDiscountType'] ==
                                                            "PERCENT"
                                                        ? ""
                                                        : "₹",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: snapshot.data[index]
                                                            ['OffersAndCoupon']
                                                            ['couponDiscount']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: snapshot.data[index][
                                                                    'OffersAndCoupon']
                                                                [
                                                                'couponDiscountType'] ==
                                                            "PERCENT"
                                                        ? "%\n"
                                                        : "\n",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: snapshot.data[index]
                                                            ['OffersAndCoupon']
                                                        ['description'],
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                : Container(
                    margin: EdgeInsets.all(8),
                    height: size.height * 0.18,
                    child: FutureBuilder<List<dynamic>>(
                      future: fetchHomeSlider(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
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
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Expanded(
                                              child: snapshot.data[index][
                                                              'OffersAndCoupon']
                                                          ['image'] !=
                                                      null
                                                  ? CachedNetworkImage(
                                                      imageUrl: S3_BASE_PATH +
                                                          snapshot.data[index][
                                                                  'OffersAndCoupon']
                                                              ['image'],
                                                      height: size.height * 0.1,
                                                      width: size.width * 0.18,
                                                      fit: BoxFit.fill,
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    )
                                                  : Image.asset(
                                                      "assets/images/feasturenttemp.jpeg",
                                                      height:
                                                          size.height * 0.18,
                                                      width: size.width * 0.3,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.white),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${snapshot.data[index]['OffersAndCoupon']['title']}\n",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        shadows: [
                                                          Shadow(
                                                              blurRadius: 2,
                                                              offset: Offset(
                                                                  0.6, 0.6),
                                                              color:
                                                                  Colors.white)
                                                        ]),
                                                  ),
                                                  TextSpan(
                                                    text: snapshot.data[index][
                                                                    'OffersAndCoupon']
                                                                [
                                                                'couponDiscountType'] ==
                                                            "PERCENT"
                                                        ? ""
                                                        : "₹",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: snapshot.data[index]
                                                            ['OffersAndCoupon']
                                                            ['couponDiscount']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: snapshot.data[index][
                                                                    'OffersAndCoupon']
                                                                [
                                                                'couponDiscountType'] ==
                                                            "PERCENT"
                                                        ? "%\n"
                                                        : "\n",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: snapshot.data[index]
                                                            ['OffersAndCoupon']
                                                        ['description'],
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )),
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
