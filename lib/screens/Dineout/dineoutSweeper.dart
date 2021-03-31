import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;

class Swipper extends StatefulWidget {
  @override
  _SwipperState createState() => _SwipperState();
}

class _SwipperState extends State<Swipper> {
  var responseData;
  Future getDineoutBanner() async {
    var response = await http
        .get(APP_ROUTES + 'utilities' + '?key=BYFOR&for=dineoutBanner');
    responseData = jsonDecode(response.body)['data'];
    print(responseData);
    return responseData;
  }

  @override
  void initState() {
    super.initState();
    getDineoutBanner();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: getDineoutBanner(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data != null
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ClipRect(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(
                            left: size.width * 0.03,
                            right: size.width * 0.03,
                          ),
                          height: size.height * 0.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          width: MediaQuery.of(context).size.width,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: snapshot
                                                .data[index]['OffersAndCoupon']
                                                    ['image']
                                                .isNotEmpty
                                            ? CachedNetworkImageProvider(
                                                S3_BASE_PATH +
                                                    snapshot.data[index]
                                                            ['OffersAndCoupon']
                                                        ['image'])
                                            : Image.asset(
                                                "assets/images/NoImage.png.jpeg",
                                                fit: BoxFit.cover,
                                              ),
                                        fit: BoxFit.cover)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        alignment: Alignment.bottomLeft,
                                        margin: EdgeInsets.only(
                                            left: size.width * 0.01,
                                            top: size.height * 0.18),
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: snapshot
                                                      .data[index]
                                                          ['OffersAndCoupon']
                                                          ['title']
                                                      .isNotEmpty
                                                  ? "  ${snapshot.data[index]['OffersAndCoupon']['title']}"
                                                  : "Offer Title",
                                              style: TextStyle(
                                                fontSize: size.height * 0.023,
                                              ),
                                            ),
                                            TextSpan(
                                                text: "\n",
                                                style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.023)),
                                            TextSpan(
                                                text: snapshot
                                                        .data[index]
                                                            ['OffersAndCoupon']
                                                            ['description']
                                                        .isNotEmpty
                                                    ? "  ${snapshot.data[index]['OffersAndCoupon']['description']}"
                                                    : "Offer Description",
                                                style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.023)),
                                          ]),
                                        )),
                                  ],
                                ),
                              );
                            },
                            pagination: SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.grey[300],
                                  size: 6,
                                  activeSize: 12),
                            ),
                            itemCount: snapshot
                                        .data[index]['OffersAndCoupon']['image']
                                        .length <
                                    1
                                ? snapshot
                                    .data[index]['OffersAndCoupon']['image']
                                    .length
                                : 1,
                            itemWidth: 300,
                            layout: SwiperLayout.DEFAULT,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : SizedBox();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
