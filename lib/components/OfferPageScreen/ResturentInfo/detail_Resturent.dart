import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../foodlistclass.dart';

class DetailResturent extends StatelessWidget {
  final int intIndex;
  const DetailResturent({Key key, this.intIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                child: Swiper(
                  itemCount: imageList.length,
                  layout: SwiperLayout.DEFAULT,
                  itemBuilder: (BuildContext context, index) =>
                      CachedNetworkImage(
                    imageUrl: imageList[index],
                    fit: BoxFit.fill,
                  ),
                  autoplay: false,
                ),
              ),
            ),
            Expanded(
              flex: 13,
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 10),
                            child: Text(
                              foodlist[0].title,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.028,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(right: 15, top: 10),
                            height: size.height * 0.06,
                            width: size.width * 0.09,
                            decoration: BoxDecoration(
                              color: Colors.blue[600],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Center(
                                child: Text(
                              "4.8",
                              style: TextStyle(
                                  fontSize: size.height * 0.017,
                                  color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 10),
                          child: Text(
                            "Sweets, North Indian, South Indian",
                            style: TextStyle(
                                fontSize: size.height * 0.016,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          )),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: size.height * 0.1,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Spacer(),
                            Container(
                              width: size.width * 0.25,
                              // color: Colors.red,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: size.height * 0.036,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    foodlist[0].timing,
                                    style: TextStyle(color: Colors.black54,fontSize:size.height * 0.016 )
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: size.width * 0.25,
                              // color: Colors.red,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: size.height * 0.036,
                                    color: Colors.grey[700],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    foodlist[0].distance,
                                    style: TextStyle(color: Colors.black54,fontSize:size.height * 0.016 ),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: size.width * 0.25,
                              // color: Colors.red,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.delivery_dining,
                                    size: size.height * 0.036,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    foodlist[0].serviceType,
                                    style: TextStyle(color: Colors.black54,fontSize:size.height * 0.016),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/map.svg",
                              height: size.height * 0.035,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              foodlist[0].address,
                              style: TextStyle(color: Colors.black54),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Get Direction",
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: size.height * 0.035,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "9810559845",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 15,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          foodlist[0].resturentDetails,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
