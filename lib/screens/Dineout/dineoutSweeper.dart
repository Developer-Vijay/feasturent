import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/ResturentInfo/resturentDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../constants.dart';

class Swipper extends StatefulWidget {
  @override
  _SwipperState createState() => _SwipperState();
}

class _SwipperState extends State<Swipper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRect(
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ResturentDetail()));
        },
        child: Container(
          margin: EdgeInsets.only(
            left: size.width * 0.03,
            right: size.width * 0.03,
          ),
          height: size.height * 0.3,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(imageList[index]),
                        fit: BoxFit.fitWidth)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.only(
                            left: size.width * 0.01, top: size.height * 0.18),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Get 25% off via dineoutsky \n",
                              style: TextStyle(
                                shadows: [Shadow(blurRadius: 3,color: Colors.white,
                                offset: Offset(0,5)
                                )],
                                fontSize: size.height * 0.023,
                              ),
                            ),
                            TextSpan(
                                text: "Clue \n",
                                style: TextStyle(
                                  shadows: [Shadow(blurRadius: 2,color: Colors.white,
                                offset: Offset(0,4)
                                )],
                                  fontSize:  size.height * 0.023)),
                            TextSpan(
                                text: "Live events on rooftop",
                                style: TextStyle(shadows: [Shadow(blurRadius: 3,color: Colors.white,
                                offset: Offset(0,5)
                                )],
                                  fontSize: size.height * 0.023)),
                          ]),
                        )),
                  ],
                ),
              );
            },
            pagination: SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                  color: Colors.grey[300], size: 6, activeSize: 12),
            ),
            itemCount: imageList.length,
            itemWidth: 300,
            layout: SwiperLayout.DEFAULT,
          ),
        ),
      ),
    );
  }
}
