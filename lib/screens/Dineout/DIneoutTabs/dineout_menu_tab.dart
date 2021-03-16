import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:photo_view/photo_view.dart';

class MenuDart extends StatefulWidget {
  @override
  _MenuDartState createState() => _MenuDartState();
}

class _MenuDartState extends State<MenuDart> {
  SwiperController controller;

  List menubarImages = [
    "https://lh3.googleusercontent.com/HCx6Uvc5IFXGkMemiUcI9YE1Iiko5nvgCC7BTkcybJMF0Ewckc31xY5cDzSF8oMWhSU7q9MTDe7-oQop7-x1u17DVLeg=w1000",
    "https://lh3.googleusercontent.com/DEVCB-ppe4sGQ_dKsMk2ypGxZj8uWrpEq5qM5v7mh__XkIA8Nq2s4S0yHMriHj5FgEf7207IlOUPs90on9-9gO7MeN8=w1000",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN5S8kzdkpEbsa29sFgSWBDhtE8nxi04lBZg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQvXgWEYUF0rSiMyqh5fHPtG9e6-LqLfSI8A&usqp=CAU",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Swiper(
            itemCount: menubarImages.length,
            controller: controller,
            pagination: SwiperPagination(builder: SwiperPagination.fraction),
            loop: true,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: menubarImages[index],
                imageBuilder: (context, imageProvider) => PhotoView(
                  backgroundDecoration: BoxDecoration(color: Colors.white),
                  imageProvider: imageProvider,
                ),
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: "Loading",
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              );
            }));
  }
}
