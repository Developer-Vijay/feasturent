import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/screens/home/slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';
import '../foodlistclass.dart';

class ResturentMenu extends StatefulWidget {
  @override
  _ResturentMenuState createState() => _ResturentMenuState();
}

class _ResturentMenuState extends State<ResturentMenu> {
  int _index1 = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        itemCount: insideOfferPage.length,
        itemBuilder: (context, index) {
          print(insideOfferPage[index].discountText);
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FoodSlider()));
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
                            color: Colors.blue[50],
                            offset: Offset(1, 3),
                            spreadRadius: 2)
                      ]),
                  margin: EdgeInsets.only(
                    left: size.width * 0.02,
                    right: size.width * 0.02,
                  ),
                  height: size.height * 0.14,
                  child: Row(children: [
                    Expanded(
                        flex: 0,
                        child: Container(
                          alignment: Alignment.topCenter,
                          height: size.height * 0.2,
                          child: Stack(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(left: 4, right: 4, top: 4),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: insideOfferPage[index].foodImage,
                                    height: size.height * 0.1,
                                    width: size.width * 0.25,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // For Add Button
                              Align(
                                  widthFactor: 1.6,
                                  alignment: Alignment.bottomCenter,
                                  heightFactor: 2.2,
                                  child: Container(
                                    child: MaterialButton(
                                        onPressed: () {
                                          addBottonFunction(
                                              insideOfferPage[index].index0);

                                          // showModalBottomSheet(
                                          //     context: context,
                                          //     builder: (context) =>
                                          //         Sheet());
                                        },
                                        color: Colors.white,
                                        minWidth: size.width * 0.16,
                                        height: size.height * 0.033,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14)),
                                        textColor: Colors.white,
                                        child: buttonText(
                                            insideOfferPage[index].index0)),
                                  ))
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
                                      insideOfferPage[index].title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            insideOfferPage[index].vegsymbol,
                                        height: size.height * 0.02,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                insideOfferPage[index].subtitle,
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: insideOfferPage[index].starRating,
                                    ),
                                    Text(
                                      "3.0",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: size.width * 0.1),
                                      child: Text(
                                        "₹${insideOfferPage[index].foodPrice}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          insideOfferPage[index].discountImage,
                                      height: size.height * 0.026,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      insideOfferPage[index].discountText,
                                      style: TextStyle(
                                          fontSize: 12, color: kTextColor),
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
      ),
    );
  }

  addBottonFunction(index) {
    if (insideOfferPage[index].addedStatus == "Add") {
      print(insideOfferPage[index].index0);
      Fluttertoast.showToast(msg: "${insideOfferPage[index].title} is added");

      print(_index1);

      getItemandNavigateToCart(index);
      setState(() {
        insideOfferPage[index].addedStatus = "Added";
      });
    } else if (insideOfferPage[index].addedStatus == "Added") {
      Fluttertoast.showToast(
          msg: "${insideOfferPage[index].title} is already added");
    }
  }

  buttonText(index) {
    if (insideOfferPage[index].addedStatus == "Add") {
      return Row(
        children: [
          Icon(
            Icons.add,
            size: 15,
            color: Colors.blueGrey,
          ),
          Text(
            insideOfferPage[index].addedStatus,
            style: TextStyle(fontSize: 10, color: Colors.blueGrey),
          ),
        ],
      );
    } else if (insideOfferPage[index].addedStatus == "Added") {
      return Row(
        children: [
          Text(
            insideOfferPage[index].addedStatus,
            style: TextStyle(fontSize: 10, color: Colors.blueGrey),
          ),
        ],
      );
    }
  }

  getItemandNavigateToCart(index) async {
    // print(index1);
    print("add item");
    add2.add(addto(
        isSelected: false,
        counter: 1,
        quantity: 0,
        id: insideOfferPage[index].id,
        foodPrice: insideOfferPage[index].foodPrice,
        title: insideOfferPage[index].title.toString(),
        starRating: insideOfferPage[index].starRating,
        name: insideOfferPage[index].name.toString(),
        discountText: insideOfferPage[index].discountText,
        vegsymbol: insideOfferPage[index].vegsymbol,
        discountImage: insideOfferPage[index].discountImage,
        foodImage: insideOfferPage[index].foodImage));
  }
}
