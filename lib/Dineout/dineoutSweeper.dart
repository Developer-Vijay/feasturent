import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Swipper extends StatefulWidget {
  @override
  _SwipperState createState() => _SwipperState();
}

class _SwipperState extends State<Swipper> {
  final imageList = [
    "https://media.gettyimages.com/photos/nightclub-picture-id157532720?k=6&m=157532720&s=612x612&w=0&h=oan-SIIOcol4NRhRWpJ_Vd2k6FzFE24Ub4zmK4SjNzM=",
    "https://media.gettyimages.com/photos/interior-of-empty-bar-at-night-picture-id826837298?k=6&m=826837298&s=612x612&w=0&h=-hIbnJFk265RDKqfykcNmKXlge91c0ynk3hDAGvjESI=",
    "https://media.gettyimages.com/photos/empty-nightclub-dance-floor-picture-id1053940970?k=6&m=1053940970&s=612x612&w=0&h=2VsbM5AKs7sLlklQ7m0iN6lTg_7ulDB4jZfdrG5t36M="
    "https://media.gettyimages.com/photos/bartender-making-cocktails-at-retro-bar-for-mature-couple-picture-id991839156?k=6&m=991839156&s=612x612&w=0&h=nXyZjg1b9XlVeNQUJp3wy3WkiAirt0ZkocsPmBrQe00="
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRect(
      
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
                      image: NetworkImage(imageList[index]),
                      fit: BoxFit.fitWidth)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(
                          left: size.width * 0.01, top: size.height * 0.14),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Get 25% off via dineoutsky \n",
                            style: TextStyle(fontSize: 16),
                          ),
                          TextSpan(
                              text: "Clue \n", style: TextStyle(fontSize: 16)),
                          TextSpan(
                              text: "Live events on rooftop",
                              style: TextStyle(fontSize: 16)),
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
    );
  }
}
