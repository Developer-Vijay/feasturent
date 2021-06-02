import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/screens/home/SearchFiles/test_search.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../slider.dart';

class DishSearch extends StatefulWidget {
  @override
  _DishSearchState createState() => _DishSearchState();
}

class _DishSearchState extends State<DishSearch> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        child: resultData != null
            ? resultData['dish'].isNotEmpty
                ? ListView.builder(
                    itemCount: resultData['dish'].length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FoodSlider(
                                          rating: 1.0,
                                          ratinglength: 1,
                                          menuStatus: true,
                                          restaurentName: resultData['dish']
                                              [index]['VendorInfo']['name'],
                                          dishID: resultData['dish'][index]
                                              ['id'],
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      color: Colors.blue[50],
                                      offset: Offset(1, 4),
                                      spreadRadius: 2)
                                ]),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: size.width * 0.95,
                                        height: size.height * 0.128,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 0,
                                              child: Container(
                                                  alignment: Alignment.topLeft,
                                                  height: size.height * 0.2,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 4,
                                                        right: 4,
                                                        top: 4),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: resultData['dish']
                                                                      [index]
                                                                  ['image1'] !=
                                                              null
                                                          ? CachedNetworkImage(
                                                              imageUrl: S3_BASE_PATH +
                                                                  resultData['dish']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'image1'],
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              width:
                                                                  size.width *
                                                                      0.26,
                                                              fit: BoxFit.cover,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Center(
                                                                      child:
                                                                          CircularProgressIndicator()),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Image.asset(
                                                                "assets/images/feasturenttemp.jpeg",
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )
                                                          : Image.asset(
                                                              "assets/images/feasturenttemp.jpeg",
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              width:
                                                                  size.width *
                                                                      0.26,
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                  )),
                                            ),
                                            Expanded(
                                                child: Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(
                                                  left: size.width * 0.01),
                                              height: size.height * 0.2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: 6,
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.width * 0.45,
                                                          child: Text(
                                                            capitalize(
                                                                resultData['dish']
                                                                        [index]
                                                                    ['title']),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 12),
                                                            child: resultData['dish']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'isNonVeg'] ==
                                                                    true
                                                                ? CachedNetworkImage(
                                                                    imageUrl:
                                                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
                                                                    height: size
                                                                            .height *
                                                                        0.016,
                                                                  )
                                                                : resultData['dish'][index]
                                                                            [
                                                                            'isEgg'] ==
                                                                        true
                                                                    ? Container(
                                                                        child: Image
                                                                            .asset(
                                                                        "assets/images/eggeterian.png",
                                                                        height: size.height *
                                                                            0.016,
                                                                      ))
                                                                    : Container(
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                                                          height:
                                                                              size.height * 0.016,
                                                                        ),
                                                                      ))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Container(
                                                    width: size.width * 0.3,
                                                    child: Text(
                                                      resultData['dish'][index]
                                                              ['VendorInfo']
                                                          ['name'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 11),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(),
                                                        Spacer(),
                                                        Text(
                                                          "₹ ${resultData['dish'][index]['totalPrice']}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Text("No Dish available"),
                  )
            : Center(
                child: Text("Loading...."),
              ));
  }
}
