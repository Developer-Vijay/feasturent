import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'ontap_offer.dart';
import 'package:async/async.dart';
int dataLenght;

class DiscountCard extends StatefulWidget {
  @override
  _DiscountCardState createState() => _DiscountCardState();
}
class _DiscountCardState extends State<DiscountCard> {
  @override
  void initState() {
    super.initState();
    print(
        "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
    print("home banner initstate");
  }

  var homeOffers;

  // ignore: missing_return
   fetchHomeBanner() async {
        return discountmemoizer.runOnce(() async {

    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ hitting api home banner fetch");

    var result = await http
        .get(
          Uri.parse( APP_ROUTES + 'utilities' + '?key=BYFOR' + '&for=homeBanner')
         );
    if (result.statusCode == 200) {
      homeOffers = json.decode(result.body)['data'];
      if (homeOffers.isEmpty) {
        if (mounted) {
          setState(() {
            dataLenght = 0;
          });
        }
        print(" discount home slider data not here");
      } else {
        print("data here");
        if (homeOffers[0]['status'] == true) {
          print(" discount home slider staus true");

          return homeOffers;
        } else {
          print(" discount home slider staus false");

          if (mounted) {
            setState(() {
              dataLenght = 0;
            });
          }
          homeOffers = [];
          return homeOffers;
        }
      }
    }
  }
        );}
  int checher;
  @override
  Widget build(BuildContext context) {
    print("checher = $checher");
    print("datalength = $dataLenght");
    if (checher != dataLenght) {
      setState(() {
        checher = dataLenght;
      });
      print("discount cherher change screen refresh");
    }
    print("home banner build%%%%%%%%%%%%%%%%%%%%^^^^^^^^^^^^^^^^^^^^^");
    // fetchHomeSliderLength();

    Size sized = MediaQuery.of(context).size;
    return dataLenght != 0
        ? Container(
            child: FutureBuilder(
                future: this.fetchHomeBanner(),
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
                                    padding: EdgeInsets.only(
                                      right: 5,
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    width: double.infinity,
                                    height: sized.height * 0.22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              'assets/images/feasturenttemp.jpeg')),
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
                                  )
                                : Container(
                                    padding: EdgeInsets.only(
                                      right: 5,
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    width: double.infinity,
                                    height: sized.height * 0.22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: CachedNetworkImageProvider(
                                            S3_BASE_PATH +
                                                snapshot.data[index]
                                                        ['OffersAndCoupon']
                                                    ['image'],
                                          )),
                                    ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                        autoplay: true,
                        autoplayDelay: 2000,
                      ),
                    );
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
                }))
        : Center(child: SizedBox());
  }
}
