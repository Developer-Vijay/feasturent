import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';
import 'WishListDataBase/wishlist_data_class.dart';
import 'WishListDataBase/wishlist_service.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  int _index1 = 0;
  final wishListServices = WishListService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Favourites",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:
          // Column(
          //   children: [
          FutureBuilder(
              future: wishListServices.fetchUsers(),
              builder: (ctx, snap) {
                print(snap.data);
                List<WishListClass> users = snap.data;
                print(users);
                if (snap.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      int tpye = 0;

                      return InkWell(
                        onTap: () {},
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
                              child: Dismissible(
                                direction: DismissDirection.endToStart,
                                // ignore: missing_return
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    final bool res = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Text(
                                                "Are you sure you want to delete ${users[index].itemName}?"),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              FlatButton(
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                onPressed: () async {
                                                  // print(restaurantDataCopy[
                                                  //     'Menus'][index]['id']);
                                                  // await services
                                                  //     .data(restaurantDataCopy[
                                                  //         'Menus'][index]['id'])
                                                  //     .then((value) =>
                                                  //         fun(value));

                                                  // final SharedPreferences cart =
                                                  //     await SharedPreferences
                                                  //         .getInstance();
                                                  // if (idCheck.contains(
                                                  //     data1[0]['id'])) {
                                                  //   setState(() {
                                                  //     countSum = countSum -
                                                  //         data1[0]['itemCount'];
                                                  //     totalPrice = totalPrice -
                                                  //         (data1[0][
                                                  //                 'itemCount'] *
                                                  //             data1[0][
                                                  //                 'itemPrice']);
                                                  //     price = price -
                                                  //         (data1[0][
                                                  //                 'itemCount'] *
                                                  //             data1[0][
                                                  //                 'itemPrice']);
                                                  //     cart.setInt(
                                                  //         'price', price);
                                                  //     services.deleteUser(
                                                  //         data1[0]['id']);
                                                  //     idCheck.remove(
                                                  //         data1[0]['id']);
                                                  //     vendorIdCheck.remove(
                                                  //         data1[0]['vendorId']);
                                                  //     checkdata.remove(data1[0]
                                                  //             ['menuItemId']
                                                  //         .toString());
                                                  //     print(checkdata);
                                                  //     cart.setStringList(
                                                  //         'addedtocart',
                                                  //         checkdata);
                                                  //   });

                                                  //   Navigator.pop(context);
                                                  // } else {
                                                  //   setState(() {
                                                  //     services.deleteUser(
                                                  //         data1[0]['id']);
                                                  //     checkdata.remove(data1[0]
                                                  //             ['menuItemId']
                                                  //         .toString());
                                                  //     print(checkdata);
                                                  //     cart.setStringList(
                                                  //         'addedtocart',
                                                  //         checkdata);
                                                  //     print(checkdata);
                                                  //     price = price -
                                                  //         (data1[0][
                                                  //                 'itemCount'] *
                                                  //             data1[0][
                                                  //                 'itemPrice']);
                                                  //     cart.setInt(
                                                  //         'price', price);
                                                  //   });

                                                  //   Navigator.pop(context);
                                                  // }
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                    return res;
                                  }
                                },
                                key: ValueKey(index),
                                background: Container(
                                  color: Colors.red,
                                  padding: EdgeInsets.only(right: 10),
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: users[index].imagePath !=
                                                        null
                                                    ? CachedNetworkImage(
                                                        imageUrl: S3_BASE_PATH +
                                                            users[index]
                                                                .imagePath,
                                                        height:
                                                            size.height * 0.1,
                                                        width:
                                                            size.width * 0.26,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                          "assets/images/feasturenttemp.jpeg",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : Image.asset(
                                                        "assets/images/feasturenttemp.jpeg",
                                                        height:
                                                            size.height * 0.1,
                                                        width:
                                                            size.width * 0.26,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          // Positioned(
                                          //   top: size.height * 0.09,
                                          //   bottom: size.height * 0.02,
                                          //   left: size.width * 0.058,
                                          //   right: size.width * 0.058,
                                          //   child: MaterialButton(
                                          //     onPressed: () async {
                                          //       // if (status == true) {
                                          //       //   final SharedPreferences cart =
                                          //       //       await SharedPreferences
                                          //       //           .getInstance();
                                          //       //   if (restaurantDataCopy[
                                          //       //               'Menus'][index]
                                          //       //           ['isNonVeg'] ==
                                          //       //       false) {
                                          //       //     if (restaurantDataCopy[
                                          //       //                 'Menus'][index]
                                          //       //             ['isEgg'] ==
                                          //       //         false) {
                                          //       //       tpye = 1;
                                          //       //     } else {
                                          //       //       tpye = 2;
                                          //       //     }
                                          //       //   } else {
                                          //       //     tpye = 3;
                                          //       //   }

                                          //       //   await services
                                          //       //       .data(restaurantDataCopy[
                                          //       //           'Menus'][index]['id'])
                                          //       //       .then((value) =>
                                          //       //           fun(value));
                                          //       //   if (data1.isEmpty) {
                                          //       //     setState(() {
                                          //       //       itemAddToCart(
                                          //       //           index, tpye);
                                          //       //       Fluttertoast.showToast(
                                          //       //           msg:
                                          //       //               "${restaurantDataCopy['Menus'][index]['title']} Added");
                                          //       //       checkdata.add(
                                          //       //           restaurantDataCopy[
                                          //       //                       'Menus']
                                          //       //                   [index]['id']
                                          //       //               .toString());
                                          //       //       cart.setStringList(
                                          //       //           'addedtocart',
                                          //       //           checkdata);
                                          //       //     });

                                          //       //     final snackBar = SnackBar(
                                          //       //       duration:
                                          //       //           Duration(seconds: 1),
                                          //       //       backgroundColor: Colors
                                          //       //           .lightBlueAccent[200],
                                          //       //       content: Text(
                                          //       //           "${restaurantDataCopy['Menus'][index]['title']} is added to cart"),
                                          //       //       action: SnackBarAction(
                                          //       //         textColor:
                                          //       //             Colors.redAccent,
                                          //       //         label: "View Cart",
                                          //       //         onPressed: () {
                                          //       //           Navigator.push(
                                          //       //               context,
                                          //       //               MaterialPageRoute(
                                          //       //                   builder:
                                          //       //                       (context) =>
                                          //       //                           CartScreen()));
                                          //       //         },
                                          //       //       ),
                                          //       //     );

                                          //       //     Scaffold.of(context)
                                          //       //         .showSnackBar(snackBar);
                                          //       //   } else {
                                          //       //     if (data1[0]['itemName'] !=
                                          //       //         restaurantDataCopy[
                                          //       //                 'Menus'][index]
                                          //       //             ['title']) {
                                          //       //       setState(() {
                                          //       //         itemAddToCart(
                                          //       //             index, tpye);
                                          //       //         checkdata.add(
                                          //       //             restaurantDataCopy[
                                          //       //                         'Menus']
                                          //       //                     [
                                          //       //                     index]['id']
                                          //       //                 .toString());
                                          //       //         cart.setStringList(
                                          //       //             'addedtocart',
                                          //       //             checkdata);
                                          //       //       });

                                          //       //       Fluttertoast.showToast(
                                          //       //           msg: "Item Added");
                                          //       //     } else {
                                          //       //       Fluttertoast.showToast(
                                          //       //           msg:
                                          //       //               "${restaurantDataCopy['Menus'][index]['title']} is already added");

                                          //       //       print("match");
                                          //       //     }
                                          //       //   }
                                          //       // } else {
                                          //       //   Fluttertoast.showToast(
                                          //       //       msg:
                                          //       //           "Not taking orders now");
                                          //       // }
                                          //     },
                                          //     color: Colors.white,
                                          //     minWidth: size.width * 0.16,
                                          //     height: size.height * 0.033,
                                          //     shape: RoundedRectangleBorder(
                                          //         borderRadius:
                                          //             BorderRadius.circular(
                                          //                 14)),
                                          //     textColor: Colors.white,
                                          //     child: checkdata.isEmpty
                                          //         ? Center(
                                          //             child: Text(
                                          //               "Add",
                                          //               style: TextStyle(
                                          //                   fontSize: MediaQuery.of(
                                          //                               context)
                                          //                           .size
                                          //                           .height *
                                          //                       0.015,
                                          //                   color: Colors
                                          //                       .blueGrey),
                                          //             ),
                                          //           )
                                          //         : checkdata.contains(
                                          //                 restaurantDataCopy[
                                          //                             'Menus']
                                          //                         [index]['id']
                                          //                     .toString())
                                          //             ? Center(
                                          //                 child: Text(
                                          //                   "Added",
                                          //                   style: TextStyle(
                                          //                       fontSize: MediaQuery.of(
                                          //                                   context)
                                          //                               .size
                                          //                               .height *
                                          //                           0.015,
                                          //                       color: Colors
                                          //                           .blueGrey),
                                          //                 ),
                                          //               )
                                          //             : Center(
                                          //                 child: Text(
                                          //                   "Add",
                                          //                   style: TextStyle(
                                          //                       fontSize: MediaQuery.of(
                                          //                                   context)
                                          //                               .size
                                          //                               .height *
                                          //                           0.015,
                                          //                       color: Colors
                                          //                           .blueGrey),
                                          //                 ),
                                          //               ),
                                          //   ),
                                          // )
                                        ],
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
                                                  top: size.height * 0.01),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    users[index].itemName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: size.height *
                                                            0.019),
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 12),
                                                      child: users[index]
                                                                  .itemtype ==
                                                              3
                                                          ? users[index]
                                                                      .itemtype ==
                                                                  2
                                                              ? Container(
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl:
                                                                        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                                                    height: size
                                                                            .height *
                                                                        0.016,
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  child: Image
                                                                      .asset(
                                                                  "assets/images/eggeterian.png",
                                                                  height:
                                                                      size.height *
                                                                          0.016,
                                                                ))
                                                          : CachedNetworkImage(
                                                              imageUrl:
                                                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
                                                              height:
                                                                  size.height *
                                                                      0.016,
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Icon(Icons
                                                                      .error),
                                                            ))
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: size.height * 0.005),

                                            Container(
                                              child: Row(
                                                children: [
                                                  Container(child: Text("⭐")),
                                                  Text(
                                                    "3.0",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.014,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            size.width * 0.1),
                                                    child: Text(
                                                      "₹${users[index].itemPrice}",
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.height *
                                                                  0.018,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.003,
                                            ),
                                            // Container(
                                            //   child: Container(
                                            //       child: restaurantDataCopy[
                                            //                               'Menus']
                                            //                           [index]
                                            //                       ['MenuOffers']
                                            //                   .length !=
                                            //               0
                                            //           ? Row(
                                            //               children: [
                                            //                 Image.asset(
                                            //                   "assets/icons/discount_icon.jpg",
                                            //                   height:
                                            //                       size.height *
                                            //                           0.02,
                                            //                 ),
                                            //                 SizedBox(
                                            //                   width:
                                            //                       size.width *
                                            //                           0.006,
                                            //                 ),
                                            //                 Container(
                                            //                   child: restaurantDataCopy['Menus'][index]
                                            //                                   [
                                            //                                   'MenuOffers']
                                            //                               .length >=
                                            //                           2
                                            //                       ? Row(
                                            //                           children: [
                                            //                             Text(
                                            //                               "OfferID ${restaurantDataCopy['Menus'][index]['MenuOffers'][0]['offerId']}, ",
                                            //                               style: TextStyle(
                                            //                                   fontSize: size.height * 0.015,
                                            //                                   color: kTextColor),
                                            //                             ),
                                            //                             Text(
                                            //                               "OfferID ${restaurantDataCopy['Menus'][index]['MenuOffers'][1]['offerId']}",
                                            //                               style: TextStyle(
                                            //                                   fontSize: size.height * 0.015,
                                            //                                   color: kTextColor),
                                            //                             ),
                                            //                           ],
                                            //                         )
                                            //                       : Text(
                                            //                           "OfferID ${restaurantDataCopy['Menus'][index]['MenuOffers'][0]['offerId']}",
                                            //                           style: TextStyle(
                                            //                               fontSize: size.height *
                                            //                                   0.015,
                                            //                               color:
                                            //                                   kTextColor),
                                            //                         ),
                                            //                 ),
                                            //               ],
                                            //             )
                                            //           : SizedBox()),
                                            // ),
                                          ],
                                        ),
                                      ))
                                ]),
                              )),
                        ),
                      );
                    },
                  );
                } else {
                  return Text("no data");
                }
              }),
      //     ListView.builder(
      //         itemCount: favourite.length,
      //         itemBuilder: (context, index) {
      //           return Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: InkWell(
      //                 onLongPress: () {
      //                   Fluttertoast.showToast(msg: "Long Presses");
      //                 },
      //                 child: Container(
      //                   decoration: BoxDecoration(
      //                       color: Colors.white,
      //                       borderRadius: BorderRadius.circular(10),
      //                       boxShadow: [
      //                         BoxShadow(
      //                             blurRadius: 2,
      //                             color: Colors.blue[50],
      //                             spreadRadius: 3,
      //                             offset: Offset(0, 3))
      //                       ]),
      //                   child: Dismissible(
      //                     child: Row(
      //                       children: [
      //                         Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Container(
      //                                 width: size.width * 0.76,
      //                                 height: size.height * 0.11,
      //                                 child: Row(
      //                                   children: [
      //                                     Expanded(
      //                                       flex: 0,
      //                                       child: Container(
      //                                           alignment: Alignment.topLeft,
      //                                           height: size.height * 0.2,
      //                                           child: Container(
      //                                             margin: EdgeInsets.only(
      //                                                 left: 4,
      //                                                 right: 4,
      //                                                 top: 4),
      //                                             child: ClipRRect(
      //                                               borderRadius:
      //                                                   BorderRadius.circular(
      //                                                       10),
      //                                               child: CachedNetworkImage(
      //                                                 imageUrl:
      //                                                     favourite[index]
      //                                                         .foodImage,
      //                                                 errorWidget: (context,
      //                                                         url, error) =>
      //                                                     Icon(Icons.error),
      //                                                 height:
      //                                                     size.height * 0.09,
      //                                                 fit: BoxFit.contain,
      //                                               ),
      //                                             ),
      //                                           )),
      //                                     ),
      //                                     Expanded(
      //                                         flex: 6,
      //                                         child: Container(
      //                                           margin:
      //                                               EdgeInsets.only(left: 4),
      //                                           height: size.height * 0.2,
      //                                           child: Column(
      //                                             crossAxisAlignment:
      //                                                 CrossAxisAlignment
      //                                                     .start,
      //                                             mainAxisAlignment:
      //                                                 MainAxisAlignment.start,
      //                                             children: [
      //                                               Container(
      //                                                 margin: EdgeInsets.only(
      //                                                   top: 6,
      //                                                 ),
      //                                                 child: Row(
      //                                                   crossAxisAlignment:
      //                                                       CrossAxisAlignment
      //                                                           .start,
      //                                                   children: [
      //                                                     Text(
      //                                                       favourite[index]
      //                                                           .title,
      //                                                       style: TextStyle(
      //                                                           fontWeight:
      //                                                               FontWeight
      //                                                                   .bold,
      //                                                           color: Colors
      //                                                               .black,
      //                                                           fontSize: 14),
      //                                                     ),
      //                                                     Spacer(),
      //                                                     Padding(
      //                                                       padding:
      //                                                           const EdgeInsets
      //                                                                   .only(
      //                                                               right:
      //                                                                   12),
      //                                                       child:
      //                                                           CachedNetworkImage(
      //                                                         imageUrl: favourite[
      //                                                                 index]
      //                                                             .vegsymbol,
      //                                                         errorWidget: (context,
      //                                                                 url,
      //                                                                 error) =>
      //                                                             Icon(Icons
      //                                                                 .error),
      //                                                         height:
      //                                                             size.height *
      //                                                                 0.016,
      //                                                       ),
      //                                                     )
      //                                                   ],
      //                                                 ),
      //                                               ),
      //                                               SizedBox(
      //                                                 height: 5,
      //                                               ),
      //                                               Container(
      //                                                 child: Text(
      //                                                   "${favourite[index].subtitle}",
      //                                                 ),
      //                                               ),
      //                                               SizedBox(
      //                                                 height: 5,
      //                                               ),
      //                                               Container(
      //                                                 child: Row(
      //                                                   children: [
      //                                                     Container(
      //                                                       child: favourite[
      //                                                               index]
      //                                                           .starRating,
      //                                                     ),
      //                                                     Text(
      //                                                       "3.0",
      //                                                       style: TextStyle(
      //                                                           fontSize: 15,
      //                                                           color: Colors
      //                                                               .red,
      //                                                           fontWeight:
      //                                                               FontWeight
      //                                                                   .bold),
      //                                                     ),
      //                                                     SizedBox(
      //                                                       width: 50,
      //                                                     ),
      //                                                     Text(
      //                                                       "₹${favourite[index].foodPrice}",
      //                                                       style: TextStyle(
      //                                                           color: Colors
      //                                                               .black,
      //                                                           fontWeight:
      //                                                               FontWeight
      //                                                                   .bold),
      //                                                     ),
      //                                                     SizedBox(
      //                                                       width: 20,
      //                                                     ),
      //                                                   ],
      //                                                 ),
      //                                               ),
      //                                             ],
      //                                           ),
      //                                         )),
      //                                   ],
      //                                 )),
      //                           ],
      //                         ),
      //                       ],
      //                     ),

      //                     key: ValueKey(index),
      //                     secondaryBackground: Container(
      //                       color: Colors.red,
      //                       padding: EdgeInsets.only(right: 10),
      //                       alignment: Alignment.centerRight,
      //                       child: Icon(
      //                         Icons.delete,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                     background: Container(
      //                       color: Colors.blue,
      //                       padding: EdgeInsets.only(left: 10),
      //                       alignment: Alignment.centerLeft,
      //                       child: Icon(
      //                         Icons.add_to_photos,
      //                         color: Colors.white,
      //                       ),
      //                     ),

      //                     // ignore: missing_return
      //                     confirmDismiss: (direction) async {
      //                       if (direction == DismissDirection.endToStart) {
      //                         final bool res = await showDialog(
      //                             context: context,
      //                             builder: (BuildContext context) {
      //                               return AlertDialog(
      //                                 content: Text(
      //                                     "Are you sure you want to delete ${favourite[index].title}?"),
      //                                 actions: <Widget>[
      //                                   FlatButton(
      //                                     child: Text(
      //                                       "Cancel",
      //                                       style: TextStyle(
      //                                           color: Colors.black),
      //                                     ),
      //                                     onPressed: () {
      //                                       Navigator.of(context).pop();
      //                                     },
      //                                   ),
      //                                   FlatButton(
      //                                     child: Text(
      //                                       "Delete",
      //                                       style:
      //                                           TextStyle(color: Colors.red),
      //                                     ),
      //                                     onPressed: () {
      //                                       setState(() {
      //                                         favourite.removeAt(index);
      //                                       });
      //                                       Navigator.of(context).pop();
      //                                     },
      //                                   ),
      //                                 ],
      //                               );
      //                             });

      //                         return res;
      //                       } else if (direction ==
      //                           DismissDirection.startToEnd) {
      //                         if (favourite[index].counter == 0) {
      //                           print("move to cart fuction not written");
      //                         }

      //                         Fluttertoast.showToast(
      //                             msg: "Item added to Cart");
      //                       }
      //                     },
      //                   ),
      //                 )),
      //           );
      //         }),
      //   ],
      // )
    );
  }
}
