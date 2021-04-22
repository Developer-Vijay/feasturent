import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'WishListDataBase/wishlist_data_class.dart';
import 'WishListDataBase/wishlist_service.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  void initState() {
    super.initState();
    getList();
  }

  callingLoader() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => new AlertDialog(
                content: Row(
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text("Loading"),
                ),
              ],
            )));
  }

  final services = UserServices();
  int _index1 = 0;
  final wishListServices = WishListService();
  List<String> checkdata = [];
  getList() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      checkdata = cart.getStringList('addedtocart');
    });
    print(checkdata);
  }

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
      body: FutureBuilder(
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
                            top: size.width * 0.02,
                            left: size.width * 0.02,
                            right: size.width * 0.02,
                          ),
                          height: size.height * 0.14,
                          child: Dismissible(
                            key: ValueKey(index),
                            secondaryBackground: Container(
                              color: Colors.red,
                              padding: EdgeInsets.only(right: 10),
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            background: Container(
                              color: Colors.blue,
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.add_to_photos,
                                color: Colors.white,
                              ),
                            ),

                            // ignore: missing_return
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
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
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            onPressed: () async {
                                              // print(
                                              //     users[index].menuItemId);
                                              // await wishListServices
                                              //     .data(users[index]
                                              //         .menuItemId)
                                              //     .then((value) =>
                                              //         fun(value));

                                              // final SharedPreferences cart =
                                              //     await SharedPreferences
                                              //         .getInstance();
                                              // if (idCheck.contains(
                                              //     dataWishList[0]['id'])) {
                                              //   setState(() {
                                              //     countSum = countSum -
                                              //         dataWishList[0]
                                              //             ['itemCount'];
                                              //     totalPrice = totalPrice -
                                              //         (dataWishList[0][
                                              //                 'itemCount'] *
                                              //             dataWishList[0][
                                              //                 'itemPrice']);
                                              //     price = price -
                                              //         (dataWishList[0][
                                              //                 'itemCount'] *
                                              //             dataWishList[0][
                                              //                 'itemPrice']);
                                              //     cart.setInt(
                                              //         'price', price);
                                              //     wishListServices
                                              //         .deleteUser(
                                              //             dataWishList[0]
                                              //                 ['id']);
                                              //     idCheck.remove(
                                              //         dataWishList[0]
                                              //             ['id']);
                                              //     vendorIdCheck.remove(
                                              //         dataWishList[0]
                                              //             ['vendorId']);
                                              //     checkdata.remove(
                                              //         dataWishList[0]
                                              //                 ['menuItemId']
                                              //             .toString());
                                              //     print(checkdata);
                                              //     cart.setStringList(
                                              //         'addedtocart',
                                              //         checkdata);
                                              //   });

                                              //   Navigator.pop(context);
                                              // } else {
                                              //   setState(() {
                                              //     wishListServices
                                              //         .deleteUser(
                                              //             dataWishList[0]
                                              //                 ['id']);
                                              //     checkdata.remove(
                                              //         dataWishList[0]
                                              //                 ['menuItemId']
                                              //             .toString());
                                              //     print(checkdata);
                                              //     cart.setStringList(
                                              //         'addedtocart',
                                              //         checkdata);
                                              //     print(checkdata);
                                              //     price = price -
                                              //         (dataWishList[0][
                                              //                 'itemCount'] *
                                              //             dataWishList[0][
                                              //                 'itemPrice']);
                                              //     cart.setInt(
                                              //         'price', price);
                                              //   });
                                              setState(() {
                                                wishListServices.deleteUser(
                                                    users[index].id);
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });

                                return res;
                              } else if (direction ==
                                  DismissDirection.startToEnd) {
                                callingLoader();

                                final SharedPreferences cart =
                                    await SharedPreferences.getInstance();

                                int totalprice = cart.getInt('TotalPrice');
                                int gsttotal = cart.getInt('TotalGst');
                                int totalcount = cart.getInt('TotalCount');
                                int vendorId = cart.getInt('VendorId');
                                setState(() {
                                  tpye = users[index].itemtype;
                                });

                                await services
                                    .data(users[index].menuItemId)
                                    .then((value) => fun(value));

                                if (vendorId == 0 ||
                                    vendorId == users[index].vendorId) {
                                  if (data1.isEmpty) {
                                    setState(() {
                                      itemAddToCart(users[index], tpye);
                                      checkdata.add(
                                          users[index].menuItemId.toString());

                                      totalcount = totalcount + 1;
                                      gsttotal = gsttotal + users[index].gst;
                                      totalprice =
                                          totalprice + users[index].itemPrice;

                                      vendorId = users[index].vendorId;
                                      cart.setInt('VendorId', vendorId);
                                      cart.setInt('TotalPrice', totalprice);
                                      cart.setInt('TotalGst', gsttotal);
                                      cart.setInt('TotalCount', totalcount);

                                      cart.setStringList(
                                          'addedtocart', checkdata);
                                      final snackBar = SnackBar(
                                        duration: Duration(seconds: 1),
                                        backgroundColor:
                                            Colors.lightBlueAccent[200],
                                        content: Text(
                                            "${users[index].itemName} is added to cart"),
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
                                      // snackBarData =
                                      //     "${restaurantDataCopy['Menus'][index]['title']} is added to cart";
                                    });

                                    // Scaffold.of(context)
                                    //     .showSnackBar(snackBar);
                                  } else {
                                    if (data1[0]['itemName'] !=
                                        users[index].itemName) {
                                      setState(() {
                                        itemAddToCart(index, tpye);
                                        checkdata.add(
                                            users[index].menuItemId.toString());

                                        totalcount = totalcount + 1;
                                        gsttotal = gsttotal + users[index].gst;
                                        totalprice =
                                            totalprice + users[index].itemPrice;

                                        vendorId = users[index].vendorId;
                                        cart.setInt('VendorId', vendorId);
                                        cart.setInt('TotalPrice', totalprice);
                                        cart.setInt('TotalGst', gsttotal);
                                        cart.setInt('TotalCount', totalcount);

                                        cart.setStringList(
                                            'addedtocart', checkdata);
                                        final snackBar = SnackBar(
                                          duration: Duration(seconds: 1),
                                          backgroundColor:
                                              Colors.lightBlueAccent[200],
                                          content: Text(
                                              "${users[index].itemName} is added to cart"),
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
                                        // snackBarData =
                                        //     "${restaurantDataCopy['Menus'][index]['title']} is added to cart";
                                      });
                                    } else {
                                      setState(() {
                                        final snackBar = SnackBar(
                                          duration: Duration(seconds: 1),
                                          backgroundColor:
                                              Colors.lightBlueAccent[200],
                                          content: Text(
                                              "${users[index].itemName} is already added to cart"),
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
                                        // snackBarData =
                                        //     "${restaurantDataCopy['Menus'][index]['title']} is already added to cart";
                                      });
                                      print("match");
                                    }
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Please Add order from Single Resturent");
                                }

                                Navigator.pop(context);

                                //   final SharedPreferences cart =
                                //       await SharedPreferences.getInstance();
                                //   setState(() {
                                //     tpye = users[index].itemtype;
                                //   });

                                //   await services
                                //       .data(users[index].menuItemId)
                                //       .then((value) => fun(value));
                                //   if (dataWishList.isEmpty) {
                                //     setState(() {
                                //       itemAddToCart(users[index], tpye);
                                //       Fluttertoast.showToast(
                                //           msg: "${users[index].itemName} Added");
                                //       checkdata.add(
                                //           users[index].menuItemId.toString());
                                //       cart.setStringList(
                                //           'addedtocart', checkdata);
                                //     });

                                //     final snackBar = SnackBar(
                                //       duration: Duration(seconds: 1),
                                //       backgroundColor:
                                //           Colors.lightBlueAccent[200],
                                //       content: Text(
                                //           "${users[index].itemName} is added to cart"),
                                //       action: SnackBarAction(
                                //         textColor: Colors.redAccent,
                                //         label: "View Cart",
                                //         onPressed: () {
                                //           Navigator.push(
                                //               context,
                                //               MaterialPageRoute(
                                //                   builder: (context) =>
                                //                       CartScreen()));
                                //         },
                                //       ),
                                //     );

                                //     Scaffold.of(context).showSnackBar(snackBar);
                                //   } else {
                                //     if (dataWishList[0]['itemName'] !=
                                //         users[index].itemName) {
                                //       setState(() {
                                //         itemAddToCart(users[index], tpye);
                                //         checkdata.add(
                                //             users[index].menuItemId.toString());
                                //         cart.setStringList(
                                //             'addedtocart', checkdata);
                                //       });

                                //       Fluttertoast.showToast(msg: "Item Added");
                                //     } else {
                                //       Fluttertoast.showToast(
                                //           msg:
                                //               "${users[index].itemName} is already added");

                                //       print("match");
                                //     }
                                //   }

                                //   Fluttertoast.showToast(
                                //       msg: "Item added to Cart");
                              }
                            },

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
                                                        users[index].imagePath,
                                                    height: size.height * 0.1,
                                                    width: size.width * 0.26,
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
                                                        Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      "assets/images/feasturenttemp.jpeg",
                                                      fit: BoxFit.cover,
                                                    ),
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
                                      // Positioned(
                                      //   top: size.height * 0.09,
                                      //   bottom: size.height * 0.02,
                                      //   left: size.width * 0.058,
                                      //   right: size.width * 0.058,
                                      //   child: MaterialButton(
                                      //     onPressed: () async {

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
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize:
                                                        size.height * 0.019),
                                              ),
                                              Spacer(),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 12),
                                                  child: users[index]
                                                              .itemtype ==
                                                          3
                                                      ? users[index].itemtype ==
                                                              2
                                                          ? Container(
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                                                height:
                                                                    size.height *
                                                                        0.016,
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                              ),
                                                            )
                                                          : Container(
                                                              child:
                                                                  Image.asset(
                                                              "assets/images/eggeterian.png",
                                                              height:
                                                                  size.height *
                                                                      0.016,
                                                            ))
                                                      : CachedNetworkImage(
                                                          imageUrl:
                                                              'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
                                                          height: size.height *
                                                              0.016,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.005),

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
                                                    right: size.width * 0.1),
                                                child: Text(
                                                  "₹${users[index].itemPrice}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.height * 0.018,
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

      //                   ),
      //                 )),
      //           );
      //         }),
      // //   ],
      // // )
    );
  }

  itemAddToCart(index, tpye) async {
    final SharedPreferences cart = await SharedPreferences.getInstance();

    // var sum = cart.getInt('price');
    // sum = sum + index.itemPrice;
    // cart.setInt('price', sum);
    // print(sum);
    setState(() {
      // itemCount.add(value)
      services.saveUser(
          index.itemPrice,
          1,
          index.vendorId,
          index.menuItemId,
          index.imagePath,
          index.itemName,
          "Add".toString(),
          tpye,
          0,
          index.vendorName,
          62);
    });
  }

  fun(value) {
    setState(() {
      dataWishList = value;
    });
  }
}
