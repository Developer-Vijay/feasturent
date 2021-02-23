import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/insideofferpage.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class AllResturent extends StatefulWidget {
  @override
  _AllResturentState createState() => _AllResturentState();
}

class _AllResturentState extends State<AllResturent> {
  var listlength = 0;

  void initState() {
    super.initState();
    check();
  }

  check() {
    if (foodlist.length >= 10) {
      listlength = 10;
    } else if (foodlist.length <= 10) {
      listlength = foodlist.length;
    }
    print(listlength);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: size.width * 0.05),
            child: Text(
              "All Resturent",
              style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
            )),
        SizedBox(
          height: size.height * 0.017,
        ),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listlength,
          itemBuilder: (context, index) {
            print(foodlist[index].discountText);
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OfferListPage(),
                      settings: RouteSettings(
                        arguments: foodlist[index],
                      ),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              color: Colors.grey[200],
                              offset: Offset(0, 3),
                              spreadRadius: 2)
                        ]),
                    margin: EdgeInsets.only(
                      left: size.width * 0.02,
                      right: size.width * 0.02,
                    ),
                    height: size.height * 0.135,
                    child: Row(children: [
                      Expanded(
                          flex: 0,
                          child: Container(
                            alignment: Alignment.topCenter,
                            height: size.height * 0.2,
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: foodlist[index].foodImage,
                                      height: size.height * 0.2,
                                      width: size.width * 0.3,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 6,
                          child: Container(
                            height: size.height * 0.2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 6),
                                  child: Row(
                                    children: [
                                      Text(
                                        foodlist[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 16),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: CachedNetworkImage(
                                            imageUrl: foodlist[index].vegsymbol,
                                            height: size.height * 0.02),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  foodlist[index].subtitle,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: foodlist[index].starRating,
                                      ),
                                      Text(
                                        "3.0",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      CachedNetworkImage(
                                        imageUrl: foodlist[index].discountImage,
                                        height: size.height * 0.026,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 12.0,
                                        ),
                                        child: Text(
                                          foodlist[index].discountText,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: kTextColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Container(
                                //   child: Row(
                                //     children: [
                                //       CachedNetworkImage(
                                //         imageUrl: foodlist[index].discountImage,
                                //         height: size.height * 0.026,
                                //       ),
                                //       SizedBox(
                                //         width: 2,
                                //       ),
                                //       Text(
                                //         foodlist[index].discountText,
                                //         style: TextStyle(
                                //             fontSize: 12, color: kTextColor),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ))
                    ])),
              ),
            );
          },
        )
      ],
    );
  }
}
