import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/screens/home/slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants.dart';
import 'foodlistclass.dart';

class VendorCategoryPage extends StatefulWidget {
  final menudata;
  final vendorId;
  const VendorCategoryPage({Key key, this.menudata, this.vendorId})
      : super(key: key);
  @override
  _VendorCategoryPageState createState() => _VendorCategoryPageState();
}

class _VendorCategoryPageState extends State<VendorCategoryPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      menuData = widget.menudata;
      vendorID = widget.vendorId;
    });
  }

  var menuData;
  var vendorID;
  @override
  Widget build(BuildContext context) {
    print(vendorID);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          menuData['name'],
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: menuData['Menus'].length,
          itemBuilder: (context, index) {
            print("this");
            print(menuData['Menus'][index]['vendorCategoryId']);
            print("this1");
            if (menuData['Menus'][index]['vendorCategoryId'] == vendorID) {
              return InkWell(
                onTap: () {
                  var menuD;
                  setState(() {
                    menuD = menuData['Menus'][index];
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoodSlider(
                                menuData: menuD,
                              )));
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
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.topCenter,
                                  height: size.height * 0.2,
                                  width: size.width * 0.3,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: size.width * 0.01,
                                        right: size.width * 0.014,
                                        top: size.height * 0.008),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: menuData['Menus'][index]
                                                  ['image1'] !=
                                              null
                                          ? CachedNetworkImage(
                                              imageUrl: S3_BASE_PATH +
                                                  menuData['Menus'][index]
                                                      ['image1'],
                                              height: size.height * 0.1,
                                              width: size.width * 0.26,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            )
                                          : Image.asset(
                                              "assets/images/feasturenttemp.jpeg",
                                              height: size.height * 0.1,
                                              width: size.width * 0.26,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: size.height * 0.09,
                                  bottom: size.height * 0.02,
                                  left: size.width * 0.06,
                                  right: size.width * 0.06,
                                  child: Container(
                                    child: MaterialButton(
                                      onPressed: () {
                                        if (insideOfferPage[index]
                                                .addedStatus ==
                                            "Add") {
                                          final snackBar = SnackBar(
                                            backgroundColor:
                                                Colors.lightBlueAccent[200],
                                            content: Text(
                                                "${insideOfferPage[index].title} is added to cart"),
                                            action: SnackBarAction(
                                              textColor: Colors.redAccent,
                                              label: "View Cart",
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CartScreen()));
                                              },
                                            ),
                                          );

                                          Scaffold.of(context)
                                              .showSnackBar(snackBar);
                                          getItemandNavigateToCart(index);
                                          setState(() {
                                            insideOfferPage[index].addedStatus =
                                                "Added";
                                          });
                                        } else if (insideOfferPage[index]
                                                .addedStatus ==
                                            "Added") {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "${insideOfferPage[index].title} is already added");
                                        }
                                      },
                                      color: Colors.white,
                                      minWidth: size.width * 0.16,
                                      height: size.height * 0.033,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      textColor: Colors.white,
                                      child:
                                          insideOfferPage[index].addedStatus ==
                                                  "Add"
                                              ? Text(
                                                  insideOfferPage[index]
                                                      .addedStatus,
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015,
                                                      color: Colors.blueGrey),
                                                )
                                              : Text(
                                                  insideOfferPage[index]
                                                      .addedStatus,
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015,
                                                      color: Colors.blueGrey),
                                                ),
                                    ),
                                  ),
                                )
                              ],
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
                                    margin: EdgeInsets.only(
                                        top: size.height * 0.01),
                                    child: Row(
                                      children: [
                                        Text(
                                          menuData['Menus'][index]['title'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: size.height * 0.019),
                                        ),
                                        Spacer(),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12),
                                            child: menuData['Menus'][index]
                                                        ['isNonVeg'] ==
                                                    false
                                                ? menuData['Menus'][index]
                                                            ['isEgg'] ==
                                                        false
                                                    ? Container(
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                                          height: size.height *
                                                              0.016,
                                                        ),
                                                      )
                                                    : Container(
                                                        child: Image.asset(
                                                        "assets/images/eggeterian.png",
                                                        height:
                                                            size.height * 0.016,
                                                      ))
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
                                                    height: size.height * 0.016,
                                                  ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.005),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          child: menuData['Menus'][index]
                                                          ['Category']
                                                      ['iconImage'] ==
                                                  "null"
                                              ? CachedNetworkImage(
                                                  imageUrl:
                                                      insideOfferPage[index]
                                                          .discountImage,
                                                  height: size.height * 0.02,
                                                )
                                              : SizedBox(),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.006,
                                        ),
                                        Text(
                                          menuData['Menus'][index]['Category']
                                              ['name'],
                                          style: TextStyle(
                                              fontSize: size.height * 0.014,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.002,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          child:
                                              insideOfferPage[index].starRating,
                                        ),
                                        Text(
                                          "3.0",
                                          style: TextStyle(
                                              fontSize: size.height * 0.014,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: size.width * 0.1),
                                          child: Text(
                                            "₹${menuData['Menus'][index]['totalPrice']}",
                                            style: TextStyle(
                                                fontSize: size.height * 0.018,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.003,
                                  ),
                                  Container(
                                    child: Container(
                                        child: menuData['Menus'][index]
                                                        ['MenuOffers']
                                                    .length !=
                                                0
                                            ? Row(
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl:
                                                        insideOfferPage[index]
                                                            .discountImage,
                                                    height: size.height * 0.02,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.006,
                                                  ),
                                                  Container(
                                                    child: menuData['Menus']
                                                                        [index][
                                                                    'MenuOffers']
                                                                .length >=
                                                            2
                                                        ? Row(
                                                            children: [
                                                              Text(
                                                                "OfferID ${menuData['Menus'][index]['MenuOffers'][0]['offerId']}, ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.height *
                                                                            0.015,
                                                                    color:
                                                                        kTextColor),
                                                              ),
                                                              Text(
                                                                "OfferID ${menuData['Menus'][index]['MenuOffers'][1]['offerId']}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.height *
                                                                            0.015,
                                                                    color:
                                                                        kTextColor),
                                                              ),
                                                            ],
                                                          )
                                                        : Text(
                                                            "OfferID ${menuData['Menus'][index]['MenuOffers'][0]['offerId']}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.015,
                                                                color:
                                                                    kTextColor),
                                                          ),
                                                  ),
                                                ],
                                              )
                                            : SizedBox()),
                                  ),
                                ],
                              ),
                            ))
                      ])),
                ),
              );
            } else {
              print("data");
              return SizedBox();
            }
          },
        ),

        // ListView.builder(
        //   padding: EdgeInsets.symmetric(horizontal: 10),
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   itemCount: tandorilist.length,
        //   itemBuilder: (context, index) {
        //     return InkWell(
        //       onTap: () {
        //         var menuD;
        //         setState(() {
        //           menuD = menuData[index];
        //         });
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => FoodSlider(
        //                       menuData: menuD,
        //                     )));
        //       },
        //       child: Padding(
        //         padding: const EdgeInsets.only(bottom: 14),
        //         child: Container(
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(10),
        //                 color: Colors.white,
        //                 boxShadow: [
        //                   BoxShadow(
        //                       blurRadius: 2,
        //                       color: Colors.blue[50],
        //                       offset: Offset(1, 3),
        //                       spreadRadius: 2)
        //                 ]),
        //             margin: EdgeInsets.only(
        //               left: size.width * 0.02,
        //               right: size.width * 0.02,
        //             ),
        //             height: size.height * 0.136,
        //             child: Row(children: [
        //               Expanded(
        //                   flex: 0,
        //                   child: Container(
        //                     alignment: Alignment.topCenter,
        //                     height: size.height * 0.22,
        //                     child: Stack(
        //                       children: [
        //                         Container(
        //                           margin: EdgeInsets.only(
        //                               left: size.width * 0.01,
        //                               right: size.width * 0.01,
        //                               top: size.height * 0.005),
        //                           child: ClipRRect(
        //                             borderRadius: BorderRadius.circular(10),
        //                             child: CachedNetworkImage(
        //                               imageUrl: tandorilist[index].foodImage,
        //                               height: size.height * 0.1,
        //                               width: size.width * 0.26,
        //                               fit: BoxFit.fill,
        //                             ),
        //                           ),
        //                         ),
        //                         // For Add Button
        //                         Align(
        //                             widthFactor: size.width * 0.00368,
        //                             alignment: Alignment.bottomCenter,
        //                             heightFactor: size.height * 0.003,
        //                             child: Container(
        //                               child: MaterialButton(
        //                                 onPressed: () {
        //                                   setState(() {
        //                                     _index1 = tandorilist[index].index0;
        //                                   });

        //                                   getItemandNavigateToCart(_index1);
        //                                 },
        //                                 color: Colors.white,
        //                                 minWidth: size.width * 0.16,
        //                                 height: size.height * 0.033,
        //                                 shape: RoundedRectangleBorder(
        //                                     borderRadius:
        //                                         BorderRadius.circular(14)),
        //                                 textColor: Colors.white,
        //                                 child: Row(
        //                                   children: [
        //                                     Icon(
        //                                       Icons.add,
        //                                       size: size.height * 0.02,
        //                                       color: Colors.blueGrey,
        //                                     ),
        //                                     Text(
        //                                       "ADD",
        //                                       style: TextStyle(
        //                                           fontSize: size.height * 0.013,
        //                                           color: Colors.blueGrey),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ),
        //                             ))
        //                       ],
        //                     ),
        //                   )),
        //               Expanded(
        //                   flex: 6,
        //                   child: Container(
        //                     height: size.height * 0.2,
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       mainAxisSize: MainAxisSize.max,
        //                       children: [
        //                         Container(
        //                           margin: EdgeInsets.only(
        //                             top: size.height * 0.008,
        //                           ),
        //                           child: Row(
        //                             children: [
        //                               Text(
        //                                 tandorilist[index].title,
        //                                 style: TextStyle(
        //                                     fontWeight: FontWeight.bold,
        //                                     color: Colors.black,
        //                                     fontSize: size.height * 0.018),
        //                               ),
        //                               Spacer(),
        //                               Padding(
        //                                 padding:
        //                                     const EdgeInsets.only(right: 12),
        //                                 child: CachedNetworkImage(
        //                                   imageUrl:
        //                                       tandorilist[index].vegsymbol,
        //                                   height: size.height * 0.02,
        //                                 ),
        //                               )
        //                             ],
        //                           ),
        //                         ),
        //                         SizedBox(height: 4),
        //                         Text(
        //                           tandorilist[index].subtitle,
        //                           style: TextStyle(
        //                               fontSize: size.height * 0.016,
        //                               fontWeight: FontWeight.bold),
        //                         ),
        //                         SizedBox(
        //                           height: size.height * 0.006,
        //                         ),
        //                         Container(
        //                           child: Row(
        //                             children: [
        //                               Container(
        //                                 child: tandorilist[index].starRating,
        //                               ),
        //                               Text(
        //                                 "3.0",
        //                                 style: TextStyle(
        //                                     fontSize: size.height * 0.016,
        //                                     color: Colors.red,
        //                                     fontWeight: FontWeight.bold),
        //                               ),
        //                               Spacer(),
        //                               Container(
        //                                 margin: EdgeInsets.only(
        //                                     right: size.width * 0.1),
        //                                 child: Text(
        //                                   "₹${tandorilist[index].foodPrice}",
        //                                   style: TextStyle(
        //                                       fontSize: size.height * 0.016,
        //                                       color: Colors.black,
        //                                       fontWeight: FontWeight.bold),
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                         SizedBox(
        //                           height: 5,
        //                         ),
        //                       ],
        //                     ),
        //                   ))
        //             ])),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }

  getItemandNavigateToCart(_index1) async {
    add2.add(addto(
        isSelected: false,
        counter: 0,
        quantity: 0,
        id: tandorilist[_index1].id,
        foodPrice: tandorilist[_index1].foodPrice,
        title: tandorilist[_index1].title.toString(),
        starRating: tandorilist[_index1].starRating,
        // name: tandorilist[_index1].name.toString(),
        discountText: tandorilist[_index1].discountText,
        vegsymbol: tandorilist[_index1].vegsymbol,
        discountImage: tandorilist[_index1].discountImage,
        foodImage: tandorilist[_index1].foodImage));

    Fluttertoast.showToast(msg: "Items Added TO the Cart $_index1");
  }
}
