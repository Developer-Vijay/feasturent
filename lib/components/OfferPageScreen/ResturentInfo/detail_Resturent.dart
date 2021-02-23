import 'package:cached_network_image/cached_network_image.dart';
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
                  itemCount: foodlist.length,
                  layout: SwiperLayout.DEFAULT,
                  itemBuilder: (BuildContext context, int index) =>
                      CachedNetworkImage(
                    imageUrl: foodlist[index].foodImage,
                    fit: BoxFit.fill,
                  ),
                  autoplayDelay: 2000,
                  autoplay: true,
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
                                fontSize: size.height * 0.03,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(right: 15, top: 10),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Center(
                                child: Text(
                              "4.8",
                              style: TextStyle(
                                  fontSize: size.height * 0.025,
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
                                fontSize: size.height * 0.018,
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
                                    Icons.timer,
                                    size: size.height * 0.045,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    foodlist[0].timing,
                                    style: TextStyle(color: Colors.black54),
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
                                    size: size.height * 0.045,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    foodlist[0].distance,
                                    style: TextStyle(color: Colors.black54),
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
                                    size: size.height * 0.045,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    foodlist[0].serviceType,
                                    style: TextStyle(color: Colors.black54),
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
