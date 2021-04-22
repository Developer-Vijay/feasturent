import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;

class Swipper extends StatefulWidget {
  @override
  _SwipperState createState() => _SwipperState();
}

class _SwipperState extends State<Swipper> {
  var responseData;
  Future getDineoutBanner() async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  utiltsedineout");

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
          return snapshot.data.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ClipRect(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(
                            left: size.width * 0.03,
                            right: size.width * 0.03,
                          ),
                          height: size.height * 0.22,
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
                                                        ['image'],
                                              )
                                            : Image.asset(
                                                "assets/images/NoImage.png.jpeg",
                                                fit: BoxFit.fill,
                                              ),
                                        fit: BoxFit.fill)),
                              );
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
                          ),
                        ),
                      ),
                    );
                  },
                )
              : SizedBox(
                  child: Center(
                    child: Text("No data Available"),
                  ),
                );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
