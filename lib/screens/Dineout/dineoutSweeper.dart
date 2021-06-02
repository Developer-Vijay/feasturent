import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/screens/home/components/ontap_offer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;

int dineoutofferlength;

class Swipper extends StatefulWidget {
  @override
  _SwipperState createState() => _SwipperState();
}

class _SwipperState extends State<Swipper> {
  var homeOffers;
  // ignore: missing_return
  Future<List<dynamic>> getDineoutBanner() async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  utiltsedineout");

    var result = await http
        .get(APP_ROUTES + 'utilities' + '?key=BYFOR&for=dineoutBanner');
    if (result.statusCode == 200) {
      homeOffers = json.decode(result.body)['data'];
      if (homeOffers.isEmpty) {
        homeOffers = [];
        dineoutofferlength = 0;
        return homeOffers;
      } else {
        print("data here");
        if (homeOffers[0]['status'] == true) {
          dineoutofferlength = 1;
          return homeOffers;
        } else {
          homeOffers = [];
          dineoutofferlength = 0;

          return homeOffers;
        }
      }
    } else {
      homeOffers = [];
      dineoutofferlength = 0;

      return homeOffers;
    }
  }

  int checkbanner;
  @override
  Widget build(BuildContext context) {
    if (checkbanner != dineoutofferlength) {
      setState(() {
        checkbanner = dineoutofferlength;
      });
    }
    Size sized = MediaQuery.of(context).size;

    return dineoutofferlength == 0
        ? SizedBox()
        : Container(
            child: FutureBuilder<List<dynamic>>(
                future: getDineoutBanner(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                              left: sized.width * 0.03,
                              right: sized.width * 0.03,
                            ),
                            height: sized.height * 0.22,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            child: Swiper(
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
                                  child: snapshot.data[index]['OffersAndCoupon']
                                              ['image'] ==
                                          null
                                      ? Container(
                                          padding: EdgeInsets.only(right: 5),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          width: double.infinity,
                                          height: sized.height * 0.22,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                  "assets/images/feasturenttemp.jpeg",
                                                ),
                                              )),
                                        )
                                      : Container(
                                          padding: EdgeInsets.only(right: 5),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          width: double.infinity,
                                          height: sized.height * 0.22,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: snapshot.data[index][
                                                                'OffersAndCoupon']
                                                            ['image'] ==
                                                        null
                                                    ? Image.asset(
                                                        "assets/images/feasturenttemp.jpeg",
                                                        fit: BoxFit.fill,
                                                      )
                                                    : CachedNetworkImageProvider(
                                                        S3_BASE_PATH +
                                                            snapshot.data[index]
                                                                    [
                                                                    'OffersAndCoupon']
                                                                ['image'],
                                                      )),
                                          ),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
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
                              itemCount: snapshot.data.length,
                              itemWidth: 300,
                              layout: SwiperLayout.DEFAULT,
                              autoplay: true,
                              autoplayDelay: 2000,
                            ),
                          );
                        });
                  } else {
                    return Container(
                      margin: EdgeInsets.only(
                        left: sized.width * 0.03,
                        right: sized.width * 0.03,
                      ),
                      height: sized.height * 0.22,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width,
                      child: Shimmer.fromColors(
                        child: Container(
                          height: sized.height * 0.22,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                        ),
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                      ),
                    );
                  }
                }));
  }
}
