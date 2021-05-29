import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../slider.dart';
import 'ViewAllPopular.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'ontap_offer.dart';

int checkDataLenght;

class PopularList extends StatefulWidget {
  @override
  _PopularListState createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  @override
  void initState() {
    super.initState();
  }

  var data;
  Future<List<dynamic>> fetchPopular() async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  getpopular menues");

    var result = await http.get(APP_ROUTES + 'getPopularMenues');
    if (result.statusCode == 200) {
      data = json.decode(result.body)['data'];
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      return data;
    } else {
      data = [];
      return data;
    }
  }

  var sliderOffers;

  // ignore: missing_return
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

  int checher;

  @override
  Widget build(BuildContext context) {
    if (checher != checkDataLenght) {
      setState(() {
        checher = checkDataLenght;
      });
      print("discount cherher change screen refresh");
    }
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
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                    fontSize: size.height * 0.025),
              ),
            ),
            Spacer(),
            Container(
                alignment: Alignment.topRight,
                child: FlatButton(
                  onPressed: () {
                    // showModalBottomSheet(
                    //     enableDrag: true,
                    //     isScrollControlled: true,
                    //     context: context,
                    //     builder: (context) => Container(
                    //         height: size.height * 0.8,
                    //         child: AddRatingPage(data: data)));

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
                  int legnth;
                  if (snap.data.length >= 50) {
                    legnth = 50;
                  } else {
                    legnth = snap.data.length;
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: legnth,
                    itemBuilder: (context, index) {
                      if (snap.data[index] != null) {
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
                                          menuD = snap.data[index];
                                        });
                                        List<ChangeJson> dataList = [];
                                        List addonList = menuD['variant'];
                                        addonList.addAll(menuD['addon']);
                                        print("this is list");
                                        List<AddonMenus> createListAddon = [];

                                        if (addonList.isNotEmpty) {
                                          int k = addonList.length;
                                          for (int i = 0; i <= k - 1; i++) {
                                            createListAddon.add(AddonMenus(
                                                addonList[i]['id'],
                                                menuD['menuId'],
                                                addonList[i]['type'],
                                                addonList[i]['title'],
                                                addonList[i]['amount'],
                                                addonList[i]['gst'],
                                                addonList[i]['gstAmount']
                                                    .toInt()));
                                          }
                                        }
                                        print("this is without encode list");
                                        print(createListAddon);

                                        print("this is  encode list");
                                        var dataencoded =
                                            jsonEncode(createListAddon);
                                        print(dataencoded);
                                        print("this is  dencode list");
                                        var datadecode =
                                            jsonDecode(dataencoded);
                                        print(datadecode);

                                        dataList.add(ChangeJson(
                                            menuD['menuId'],
                                            menuD['vendorId'],
                                            menuD['title'],
                                            menuD['description'],
                                            menuD['itemPrice'],
                                            menuD['gst'],
                                            menuD['gstAmount'],
                                            menuD['totalPrice'],
                                            menuD['deliveryTime'],
                                            menuD['isNonVeg'],
                                            menuD['isEgg'],
                                            menuD['isCombo'],
                                            menuD['menuImage1'],
                                            menuD['menuImage2'],
                                            menuD['menuImage3'],
                                            datadecode, []));
                                        print("this is data list open #####");
                                        var dataNew = jsonEncode(dataList[0]);
                                        var finaldata = jsonDecode(dataNew);
                                        print(finaldata);
                                        print("this is data list close #####");

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FoodSlider(
                                                      menuData: finaldata,
                                                      menuStatus: true,
                                                      restaurentName: menuD[
                                                          'restaurantName'],
                                                      rating: 1.0,
                                                      ratinglength: 1,
                                                    )));
                                      },
                                      child: ClipOval(
                                          child: snap.data[index]
                                                      ['menuImage1'] !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl: S3_BASE_PATH +
                                                      snap.data[index]
                                                          ['menuImage1'],
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
                            Container(
                              width: size.width * 0.2,
                              child: Center(
                                child: Text(
                                  capitalize(snap.data[index]['title']),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: size.height * 0.017),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return SizedBox();
                      }
                    },
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
            )),
        SizedBox(
          height: size.height * 0.01,
        ),
        checkDataLenght == 0
            ? SizedBox()
            : Container(
                margin: EdgeInsets.all(16),
                height: size.height * 0.18,
                child: FutureBuilder<List<dynamic>>(
                  future: fetchHomeSlider(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data.length >= 2
                          ? Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OnTapOffer(
                                                    data: snapshot.data[index],
                                                  )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      width: size.width * 1,
                                      height: size.height * 0.2,
                                      child: snapshot.data[index]
                                                      ['OffersAndCoupon']
                                                  ['image'] !=
                                              null
                                          ? CachedNetworkImage(
                                              width: size.width * 0.89722,
                                              imageUrl: S3_BASE_PATH +
                                                  snapshot.data[index]
                                                          ['OffersAndCoupon']
                                                      ['image'],
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            )
                                          : Image.asset(
                                              "assets/images/feasturenttemp.jpeg",
                                              fit: BoxFit.cover,
                                            ),
                                    ));
                              },
                              pagination: SwiperPagination(
                                alignment: Alignment.bottomCenter,
                                builder: DotSwiperPaginationBuilder(
                                    color: Colors.grey[300],
                                    size: 6,
                                    activeSize: 12),
                              ),
                              itemCount: snapshot.data.length,
                              itemWidth: 300,
                              layout: SwiperLayout.DEFAULT,
                              autoplay: true,
                              autoplayDelay: 2000,
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OnTapOffer(
                                              data: snapshot.data[0],
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: size.width * 1,
                                height: size.height * 0.2,
                                child: snapshot.data[0]['OffersAndCoupon']
                                            ['image'] !=
                                        null
                                    ? CachedNetworkImage(
                                        width: size.width * 0.89722,
                                        imageUrl: S3_BASE_PATH +
                                            snapshot.data[0]['OffersAndCoupon']
                                                ['image'],
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )
                                    : Image.asset(
                                        "assets/images/feasturenttemp.jpeg",
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            );
                    } else {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: Container(
                          margin: EdgeInsets.all(16),
                          height: size.height * 0.18,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      );
                    }
                  },
                ))
      ],
    );
  }
}
