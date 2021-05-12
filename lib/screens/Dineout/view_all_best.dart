import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutdetailpage.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ViewAllDineoutCollection extends StatelessWidget {
  var data;
  ViewAllDineoutCollection({this.data});
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Best Collections"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(data.length, (index) {
          return Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Container(
              color: Colors.red,
              height: sized.height * 0.195,
              width: sized.height * 0.22,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (DineoutDetailPage(
                                data: data[index],
                              ))));
                },
                child:
                    //  Container(
                    //   alignment: Alignment.bottomCenter,
                    //   height: sized.height * 0.195,
                    //   width: sized.height * 0.3,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(5),
                    //       image: data[index]['dineoutImages'].isNotEmpty
                    //           ? DecorationImage(
                    //               image: CachedNetworkImageProvider(S3_BASE_PATH +
                    //                   data[index]['dineoutImages'][0]['image']),
                    //               // collectionImage[index],
                    //               fit: BoxFit.cover)
                    //           : DecorationImage(
                    //               image: CachedNetworkImageProvider(
                    //                   "https://im1.dineout.co.in/images/uploads/restaurant/sharpen/2/u/y/p20941-15700828565d959028e9f28.jpg?tr=tr:n-medium"),
                    //               // collectionImage[index],
                    //               fit: BoxFit.cover)),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         height: sized.height * 0.062,
                    //         color: Colors.black.withOpacity(0.4),
                    //         margin: EdgeInsets.only(top: sized.height * 0.143),
                    //         padding: EdgeInsets.only(left: 5, top: 10),
                    //         alignment: Alignment.topLeft,
                    //         child: RichText(
                    //           text: TextSpan(
                    //               style: TextStyle(
                    //                 color: Colors.white,
                    //               ),
                    //               children: [
                    //                 TextSpan(
                    //                     text: " ${data[index]['name']}\n",
                    //                     style: TextStyle(
                    //                         fontSize: sized.height * 0.022,
                    //                         fontWeight: FontWeight.bold)),
                    //                 TextSpan(
                    //                     text: " ${data[index]['Address']['city']}",
                    //                     style: TextStyle(
                    //                         fontSize: sized.height * 0.018,
                    //                         fontWeight: FontWeight.w600)),
                    //               ]),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Stack(
                          children: [
                            data[index]['dineoutImages'].isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: S3_BASE_PATH +
                                        data[index]['dineoutImages'][0]
                                            ['image'],
                                    fit: BoxFit.cover,
                                    height: sized.height * 0.35,
                                    width: sized.height * 0.35,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  )
                                : Image.asset(
                                    "assets/images/feasturenttemp.jpeg",
                                    height: sized.height * 0.35,
                                    width: sized.height * 0.35,
                                    fit: BoxFit.cover,
                                  ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                height: sized.height * 0.063,
                                width: sized.width * 1,
                                // color: Colors.black.withOpacity(0.7),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: sized.height * 0.063,
                                        color: Colors.black.withOpacity(0.4),
                                        // margin: EdgeInsets.only(
                                        //     top: sized.height * 0.143),
                                        padding:
                                            EdgeInsets.only(left: 5, top: 10),
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              children: [
                                                TextSpan(
                                                    text: capitalize(
                                                        "${data[index]['name']}\n"),
                                                    style: TextStyle(
                                                        fontSize: sized.height *
                                                            0.022,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text:
                                                        " ${data[index]['Address']['city']}",
                                                    style: TextStyle(
                                                        fontSize: sized.height *
                                                            0.018,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
              ),
            ),
          );
        }),
      ),
    );
  }
}
