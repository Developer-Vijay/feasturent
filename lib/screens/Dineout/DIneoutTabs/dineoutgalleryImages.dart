import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:photo_view/photo_view.dart';

class DineoutGallery extends StatefulWidget {
  @override
  _DineoutGalleryState createState() => _DineoutGalleryState();
}

class _DineoutGalleryState extends State<DineoutGallery> {
  @override
  Widget build(BuildContext context) {
    //  final DineoutDetailPage images2 = ModalRoute.of(context).settings.arguments;

    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              actions: [
                Icon(Icons.share)
              ],
            ),
            body: Container(
                child: Swiper(
                    itemCount: barimages.length,
                    pagination:
                        SwiperPagination(builder: SwiperPagination.fraction),
                    loop: false,
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: barimages[index],
                        imageBuilder: (context, imageProvider) => PhotoView(
                          // backgroundDecoration:
                          //     BoxDecoration(color: Colors.white),
                          imageProvider: imageProvider,
                        ),
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            semanticsLabel: "Loading",
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      );
                    }))));
  }
}
