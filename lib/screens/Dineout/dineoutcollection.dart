import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutdetailpage.dart';
import 'package:feasturent_costomer_app/screens/Dineout/view_all_best.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Collections extends StatefulWidget {
  @override
  _CollectionsState createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  final _textstyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14);
  List collectionImage = [
    "https://media.gettyimages.com/photos/closeup-of-sommelier-serving-red-wine-at-fine-dining-restaurant-picture-id991732782?k=6&m=991732782&s=612x612&w=0&h=HZ1ke5DJK571Tj2-mEf0P7wV6eq589k6uKvwOIUSBrY=",
    "https://media.gettyimages.com/photos/enjoying-lunch-with-friends-picture-id1171787426?k=6&m=1171787426&s=612x612&w=0&h=cvdOLV4T-QGC60hZT4p8u7FHPHsUKA12FnswVCL2WB4=",
    "https://media.gettyimages.com/photos/heres-to-tonight-picture-id868935172?k=6&m=868935172&s=612x612&w=0&h=MjBYXm7f229lyNXsWqcSnmlouGWrfsNDYhQCiPJ0V6g=",
    "https://media.gettyimages.com/photos/closeup-of-sommelier-serving-red-wine-at-fine-dining-restaurant-picture-id991732782?k=6&m=991732782&s=612x612&w=0&h=HZ1ke5DJK571Tj2-mEf0P7wV6eq589k6uKvwOIUSBrY=",
  ];
  @override
  void initState() {
    super.initState();
  }

  var responseData = null;
  Future<List> getdineouts() async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  dineout");
    var response = await http.get(APP_ROUTES + 'dineout' + '?key=ALL');
    responseData = json.decode(response.body)['data'];
    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Best Collections",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.height * 0.018,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Spacer(),
                Container(
                    child: FlatButton(
                        onPressed: () {
                          if (responseData != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ViewAllDineoutCollection(
                                          data: responseData),
                                ));
                          }
                        },
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text(
                                "View All",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor),
                              ),
                            ),
                            Icon(
                              Icons.arrow_right_rounded,
                              color: kSecondaryTextColor,
                            ),
                          ],
                        )))
              ],
            ),
            Container(
              height: size.height * 0.22,
              child: FutureBuilder<List<dynamic>>(
                future: getdineouts(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DineoutDetailPage(
                                            data: snapshot.data[index],
                                          )));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                left: size.width * 0.04,
                              ),
                              height: size.height * 0.2,
                              width: size.width * 0.34,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: snapshot.data[index]['dineoutImages']
                                          .isNotEmpty
                                      ? DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              S3_BASE_PATH +
                                                  snapshot.data[index]
                                                          ['dineoutImages'][0]
                                                      ['image']),
                                          // collectionImage[index],
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: AssetImage(
                                              'assets/images/NoImage.png.jpeg'),
                                          fit: BoxFit.cover)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: size.height * 0.143),
                                    alignment: Alignment.bottomLeft,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          children: [
                                            TextSpan(
                                                text:
                                                    " ${snapshot.data[index]['name']}",
                                                style: snapshot
                                                        .data[index][
                                                            'restaurantMenuImages']
                                                        .isNotEmpty
                                                    ? TextStyle(
                                                        shadows: [
                                                            Shadow(
                                                                color: Colors
                                                                    .black,
                                                                offset: Offset(
                                                                    2, 6),
                                                                blurRadius: 3)
                                                          ],
                                                        fontSize:
                                                            size.height * 0.02,
                                                        fontWeight:
                                                            FontWeight.w600)
                                                    : TextStyle(
                                                        color: Colors.black,
                                                        shadows: [],
                                                        fontSize:
                                                            size.height * 0.02,
                                                        fontWeight:
                                                            FontWeight.w900)),
                                            // TextSpan(
                                            //     text: " 168 Places",
                                            //     style: TextStyle(
                                            //         fontSize:
                                            //             size.height * 0.018,
                                            //         fontWeight:
                                            //             FontWeight.w600)
                                            // ),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  // else if (snapshot.data == null) {
                  //   return
                  // }
                  else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ]),
        ));
  }
}
