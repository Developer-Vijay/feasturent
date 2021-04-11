import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class DiscountCard extends StatefulWidget {
  // const DiscountCard({
  //   Key key,
  // }) : super(key: key);
  @override
  _DiscountCardState createState() => _DiscountCardState();
}

class _DiscountCardState extends State<DiscountCard> {
  @override
  void initState() {
    fetchHomeSliderLength();
    super.initState();
  }

  int dataLenght;

  Future fetchHomeSliderLength() async {
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ hitting api");

    var result = await http
        .get(APP_ROUTES + 'utilities' + '?key=BYFOR' + '&for=homeBanner');
    var data = json.decode(result.body)['data'];
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print(data);
    if (data.isEmpty) {
      if (mounted) {
        setState(() {
          dataLenght = 0;
        });
      }
      print("data not here");
    } else {
      print("data here");
      if (data[0]['status'] == true) {
        if (mounted) {
          setState(() {
            dataLenght = data.length;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            dataLenght = 0;
          });
        }

        print("data not here");
      }
    }

    print("data  $dataLenght");
  }

  var homeOffers;

  Future<List<dynamic>> fetchHomeBanner() async {
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ hitting api");

    var result = await http
        .get(APP_ROUTES + 'utilities' + '?key=BYFOR' + '&for=homeBanner');
    homeOffers = json.decode(result.body)['data'];
    if (homeOffers.isEmpty) {
      print("data not here");
    } else {
      print("data here");
      if (homeOffers[0]['status'] == true) {
        return homeOffers;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return dataLenght != 0
        ? Container(
            child: FutureBuilder<List<dynamic>>(
                future: fetchHomeBanner(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
                          return Container(
                            padding: EdgeInsets.only(right: 5),
                            width: double.infinity,
                            height: sized.height * 0.22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: CachedNetworkImageProvider(
                                    S3_BASE_PATH +
                                        snapshot.data[index]['OffersAndCoupon']
                                            ['image'],
                                  )),
                            ),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFF961F).withOpacity(0.4),
                                    kPrimaryColor.withOpacity(0.3),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        pagination: SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.grey[300], size: 6, activeSize: 12),
                        ),
                        itemCount: snapshot.data.length,
                        itemWidth: 300,
                        layout: SwiperLayout.DEFAULT,
                      ),
                    );
                  } else {
                    return Center(
                      child: Padding(
                          padding: EdgeInsets.only(top: 50, bottom: 50),
                          child: CircularProgressIndicator()),
                    );
                  }
                }))
        : Center(child: SizedBox());
  }
}
