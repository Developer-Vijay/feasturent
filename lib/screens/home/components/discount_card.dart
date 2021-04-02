import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:feasturent_costomer_app/constants.dart';
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
    var result = await http
        .get(APP_ROUTES + 'utilities' + '?key=BYFOR' + '&for=homeBanner');
    var data = json.decode(result.body)['data'];
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
        ? Center(
            child: FutureBuilder<List<dynamic>>(
                future: fetchHomeBanner(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      height: sized.height * 0.22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(
                              S3_BASE_PATH +
                                  snapshot.data[0]['OffersAndCoupon']['image'],
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
                        // child: Padding(
                        //   padding: const EdgeInsets.all(20.0),
                        //   child: Row(
                        //     children: <Widget>[
                        //       Expanded(flex: 1, child: SizedBox()),
                        //       Expanded(
                        //         flex: 1,
                        //         child: RichText(
                        //           text: TextSpan(
                        //             style: TextStyle(color: Colors.white),
                        //             children: [
                        //               TextSpan(
                        //                 text:
                        //                     "${snapshot.data[0]['OffersAndCoupon']['title']} \n",
                        //                 style: TextStyle(
                        //                   fontSize: sized.height * 0.0275,
                        //                 ),
                        //               ),
                        //               TextSpan(
                        //                 text: snapshot.data[0]
                        //                                 ['OffersAndCoupon']
                        //                             ['couponDiscountType'] ==
                        //                         "PERCENT"
                        //                     ? ""
                        //                     : "₹",
                        //                 style: TextStyle(
                        //                   fontSize: sized.height * 0.06,
                        //                   fontWeight: FontWeight.bold,
                        //                 ),
                        //               ),
                        //               TextSpan(
                        //                 text: snapshot.data[0]
                        //                         ['OffersAndCoupon']
                        //                         ['couponDiscount']
                        //                     .toString(),
                        //                 style: TextStyle(
                        //                   fontSize: sized.height * 0.06,
                        //                   fontWeight: FontWeight.bold,
                        //                 ),
                        //               ),
                        //               TextSpan(
                        //                 text: snapshot.data[0]
                        //                                 ['OffersAndCoupon']
                        //                             ['couponDiscountType'] ==
                        //                         "PERCENT"
                        //                     ? "%\n"
                        //                     : "\n",
                        //                 style: TextStyle(
                        //                   fontSize: sized.height * 0.06,
                        //                   fontWeight: FontWeight.bold,
                        //                 ),
                        //               ),
                        //               TextSpan(
                        //                 text:
                        //                     "${snapshot.data[0]['OffersAndCoupon']['description']} \n",
                        //                 style: TextStyle(
                        //                   fontSize: sized.height * 0.015,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ),
                    );
                  } else {
                    return Padding(
                        padding: EdgeInsets.only(top: 50, bottom: 50),
                        child: CircularProgressIndicator());
                  }
                }))
        : SizedBox();
  }
}
