import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/insideofferpage.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ViewallRestaurant extends StatefulWidget {
  final restData;
  const ViewallRestaurant({Key key , this.restData}): super(key: key);
  @override
  _ViewallRestaurantState createState() => _ViewallRestaurantState();
}

class _ViewallRestaurantState extends State<ViewallRestaurant> {
  @override
  void initState(){
    super.initState();
    setState(() {
          restaurantData=widget.restData;
        });
  }
  var restaurantData;
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("All Restaurant"),),
      body:ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: restaurantData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OfferListPage(
                                  restaurantDa: restaurantData[index])));
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: foodlist[index].foodImage,
                                            height: size.height * 0.18,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: size.height * 0.02),
                                        child: Row(
                                          children: [
                                            Text(
                                              restaurantData[index]['name'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: size.height * 0.02),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12),
                                              child: CachedNetworkImage(
                                                  imageUrl:
                                                      foodlist[index].vegsymbol,
                                                  height: size.height * 0.016),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.013,
                                      ),
                                      Text(
                                        foodlist[index].subtitle,
                                        style: TextStyle(
                                            fontSize: size.height * 0.015,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
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
                                                  fontSize: size.height * 0.016,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            CachedNetworkImage(
                                              imageUrl:
                                                  foodlist[index].discountImage,
                                              height: size.height * 0.022,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 12.0,
                                              ),
                                              child: Text(
                                                foodlist[index].discountText,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        size.height * 0.016,
                                                    color: kTextColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ])),
                    ),
                  );
                },
              ));
    
  }
}