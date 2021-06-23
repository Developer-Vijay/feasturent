import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/resturent_menues.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutdetailpage.dart';
import 'package:flutter/material.dart';
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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final services = UserServices();
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
      key: _scaffoldKey,
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
              print(snap.data);
              final children = <Widget>[];
              users.forEach((doc) {
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                if (doc.isDineout == 1) {
                  children.add(Padding(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Container(
                      color: Colors.white,
                      height: size.height * 0.195,
                      width: size.height * 0.22,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => (DineoutDetailPage(
                                        dineID: doc.idDR,
                                      ))));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Stack(
                              children: [
                                doc.imagepath != null
                                    ? CachedNetworkImage(
                                        imageUrl: S3_BASE_PATH + doc.imagepath,
                                        height: size.height * 0.35,
                                        width: size.height * 0.35,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: size.height * 0.35,
                                          width: size.height * 0.35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          "assets/images/defaultdineout.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )
                                    : Image.asset(
                                        "assets/images/defaultdineout.jpg",
                                        height: size.height * 0.35,
                                        width: size.height * 0.35,
                                        fit: BoxFit.cover,
                                      ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    height: size.height * 0.07,
                                    width: size.width * 1,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: size.height * 0.063,
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            padding: EdgeInsets.only(
                                                left: 5, top: 10),
                                            alignment: Alignment.topLeft,
                                            child: RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                        text: capitalize(
                                                            "${doc.name}\n"),
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.height *
                                                                    0.022,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextSpan(
                                                        text: " ${doc.address}",
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.height *
                                                                    0.018,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
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
                  ));
                }
                // if (document['id'] == nomines[0] ||
                //     document['id'] == nomines[1])
                // children.add(
                //   Container(
                //     child: InkWell(
                //       onTap: () {
                //         vote(document['id']).then((a) {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) =>
                //                   Waitresults(),
                //             ),
                //           );
                //         });
                //       },
                //       child: OvalPic(document['photo'], document['couleur']),
                //     ),
                //   ),
                // );
              });

              return ListView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: users.length,
                    // ignore: missing_return
                    itemBuilder: (context, index) {
                      print("index $index");
                      var couponDetatil;
                      if (users[index].isResturent == 1) {
                        return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                margin: EdgeInsets.only(
                                  top: size.width * 0.02,
                                  left: size.width * 0.02,
                                  right: size.width * 0.02,
                                ),
                                height: size.height * 0.14,
                                child: Dismissible(
                                  key: ValueKey(index),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    color: Colors.red,
                                    padding: EdgeInsets.only(right: 10),
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),

                                  // ignore: missing_return
                                  confirmDismiss: (direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      final bool res = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Text(
                                                  "Are you sure you want to delete ${users[index].name}?"),
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
                                                    setState(() {
                                                      wishListServices
                                                          .deleteUser(
                                                              users[index].id);
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          });

                                      return res;
                                    }
                                  },

                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OfferListPage(
                                                    restID: users[index].idDR,
                                                  )));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 14),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                  alignment:
                                                      Alignment.topCenter,
                                                  height: size.height * 0.2,
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        margin:
                                                            EdgeInsets.all(8),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: users[index]
                                                                      .imagepath !=
                                                                  null
                                                              ? CachedNetworkImage(
                                                                  imageUrl: S3_BASE_PATH +
                                                                      users[index]
                                                                          .imagepath,
                                                                  height:
                                                                      size.height *
                                                                          0.18,
                                                                  width:
                                                                      size.width *
                                                                          0.3,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Image
                                                                          .asset(
                                                                    "assets/images/defaultrestaurent.png",
                                                                    height: size
                                                                            .height *
                                                                        0.18,
                                                                    width:
                                                                        size.width *
                                                                            0.3,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                )
                                                              : Image.asset(
                                                                  "assets/images/defaultrestaurent.png",
                                                                  height:
                                                                      size.height *
                                                                          0.18,
                                                                  width:
                                                                      size.width *
                                                                          0.3,
                                                                  fit: BoxFit
                                                                      .cover,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: size.height *
                                                                0.02),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              capitalize(
                                                                  users[index]
                                                                      .name),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      size.height *
                                                                          0.02),
                                                            ),
                                                            Spacer(),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          12),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.005,
                                                      ),
                                                      users[index].cusines ==
                                                              null
                                                          ? SizedBox()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.38,
                                                              child: Text(
                                                                "${users[index].cusines}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: size
                                                                          .height *
                                                                      0.0175,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.015,
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            users[index].rating ==
                                                                    null
                                                                ? users[index]
                                                                            .rating ==
                                                                        'null'
                                                                    ? Text(
                                                                        "⭐1.0",
                                                                        style: TextStyle(
                                                                            fontSize: size.height *
                                                                                0.016,
                                                                            color:
                                                                                Colors.red,
                                                                            fontWeight: FontWeight.bold),
                                                                      )
                                                                    : Text(
                                                                        "⭐1.0",
                                                                        style: TextStyle(
                                                                            fontSize: size.height *
                                                                                0.016,
                                                                            color:
                                                                                Colors.red,
                                                                            fontWeight: FontWeight.bold),
                                                                      )
                                                                : Container(
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          child:
                                                                              Text("⭐"),
                                                                        ),
                                                                        Text(
                                                                          "${double.parse(users[index].rating).toStringAsFixed(1)}",
                                                                          style: TextStyle(
                                                                              fontSize: size.height * 0.016,
                                                                              color: Colors.red,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                            Spacer(),
                                                            couponDetatil ==
                                                                    null
                                                                ? SizedBox()
                                                                : Image.asset(
                                                                    "assets/icons/discount_icon.jpg",
                                                                    height: size
                                                                            .height *
                                                                        0.02,
                                                                  ),
                                                            couponDetatil ==
                                                                    null
                                                                ? users[index]
                                                                            .average ==
                                                                        null
                                                                    ? SizedBox()
                                                                    : Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          right:
                                                                              12.0,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "₹ ${users[index].average}",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: size.height * 0.016,
                                                                              color: kTextColor),
                                                                        ),
                                                                      )
                                                                : Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      right:
                                                                          12.0,
                                                                    ),
                                                                    child: Text(
                                                                      couponDetatil,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: size.height *
                                                                              0.016,
                                                                          color:
                                                                              kTextColor),
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
                                  ),
                                )),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: children),
                ],
              );
            } else if (snap.data == null) {
              return Center(
                child: Text("no data"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  // addButtonFunction(tpye, index, users) async {
  //   final SharedPreferences cart = await SharedPreferences.getInstance();

  //   int totalprice = cart.getInt('TotalPrice');
  //   int gsttotal = cart.getInt('TotalGst');
  //   int totalcount = cart.getInt('TotalCount');
  //   int vendorId = cart.getInt('VendorId');
  //   setState(() {
  //     tpye = users[index].itemtype;
  //   });

  //   await services.data(users[index].menuItemId).then((value) => fun(value));

  //   if (vendorId == 0 || vendorId == users[index].vendorId) {
  //     callingLoader();
  //     if (data1.isEmpty) {
  //       setState(() {
  //         itemAddToCart(users[index], tpye);
  //         checkdata.add(users[index].menuItemId.toString());

  //         totalcount = totalcount + 1;
  //         gsttotal = gsttotal + users[index].gst;
  //         totalprice = totalprice + users[index].itemPrice;

  //         vendorId = users[index].vendorId;
  //         cart.setInt('VendorId', vendorId);
  //         cart.setInt('TotalPrice', totalprice);
  //         cart.setInt('TotalGst', gsttotal);
  //         cart.setInt('TotalCount', totalcount);

  //         cart.setStringList('addedtocart', checkdata);
  //         final snackBar = SnackBar(
  //           duration: Duration(seconds: 1),
  //           backgroundColor: Colors.lightBlueAccent[400],
  //           content: Text("${users[index].itemName} is added to cart"),
  //           action: SnackBarAction(
  //             textColor: Colors.redAccent,
  //             label: "View Cart",
  //             onPressed: () {
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => CartScreen()));
  //             },
  //           ),
  //         );

  //         _scaffoldKey.currentState.showSnackBar(snackBar);
  //       });
  //     } else {
  //       if (data1[0]['menuItemId'] != users[index].menuItemId) {
  //         setState(() {
  //           itemAddToCart(index, tpye);
  //           checkdata.add(users[index].menuItemId.toString());

  //           totalcount = totalcount + 1;
  //           gsttotal = gsttotal + users[index].gst;
  //           totalprice = totalprice + users[index].itemPrice;

  //           vendorId = users[index].vendorId;
  //           cart.setInt('VendorId', vendorId);
  //           cart.setInt('TotalPrice', totalprice);
  //           cart.setInt('TotalGst', gsttotal);
  //           cart.setInt('TotalCount', totalcount);

  //           cart.setStringList('addedtocart', checkdata);
  //           final snackBar = SnackBar(
  //             duration: Duration(seconds: 1),
  //             backgroundColor: Colors.lightBlueAccent[400],
  //             content: Text("${users[index].itemName} is added to cart"),
  //             action: SnackBarAction(
  //               textColor: Colors.redAccent,
  //               label: "View Cart",
  //               onPressed: () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => CartScreen()));
  //               },
  //             ),
  //           );

  //           _scaffoldKey.currentState.showSnackBar(snackBar);
  //         });
  //       } else {
  //         setState(() {
  //           final snackBar = SnackBar(
  //             duration: Duration(seconds: 1),
  //             backgroundColor: Colors.lightBlueAccent[400],
  //             content:
  //                 Text("${users[index].itemName} is already added to cart"),
  //             action: SnackBarAction(
  //               textColor: Colors.redAccent,
  //               label: "View Cart",
  //               onPressed: () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => CartScreen()));
  //               },
  //             ),
  //           );

  //           _scaffoldKey.currentState.showSnackBar(snackBar);
  //         });
  //         print("match");
  //       }
  //     }
  //     Navigator.pop(context);
  //   } else {
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //               content:
  //                   Text("Do you want to order food from different resturent"),
  //               actions: <Widget>[
  //                 FlatButton(
  //                   child: Text(
  //                     "No",
  //                     style: TextStyle(color: Colors.black),
  //                   ),
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //                 FlatButton(
  //                   child: Text(
  //                     "Yes",
  //                     style: TextStyle(color: Colors.black),
  //                   ),
  //                   onPressed: () async {
  //                     callingLoader();
  //                     removeCartForNewData();
  //                     setState(() {});
  //                     getList();
  //                     Navigator.pop(context);
  //                     Navigator.pop(context);
  //                     await addButtonFunction(tpye, index, users);
  //                   },
  //                 ),
  //               ]);
  //         });
  //   }
  // }

  // itemAddToCart(index, tpye) async {
  //   setState(() {
  //     services.saveUser(
  //         index.itemPrice,
  //         1,
  //         index.vendorId,
  //         index.menuItemId,
  //         index.imagePath,
  //         index.itemName,
  //         "Add".toString(),
  //         tpye,
  //         0,
  //         index.vendorName,
  //         index.gst,
  //         0,
  //         null,
  //         index.rating.toString());
  //   });
  // }

  fun(value) {
    setState(() {
      dataWishList = value;
    });
  }
}
