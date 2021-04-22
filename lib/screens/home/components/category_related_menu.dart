import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/screens/home/slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'category_detail.dart';

class CategoryRelatedMenues extends StatefulWidget {
  final categoryName;
  final categoryid;
  const CategoryRelatedMenues({Key key, this.categoryName, this.categoryid})
      : super(key: key);
  @override
  _CategoryRelatedMenuesState createState() => _CategoryRelatedMenuesState();
}

class _CategoryRelatedMenuesState extends State<CategoryRelatedMenues> {
  @override
  void initState() {
    super.initState();
    setState(() {
      menuName = widget.categoryName;
      cateId = widget.categoryid;
    });
    print(menuName);
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

  String snackBarData = "Items in cart";

  var menuName;
  var cateId;

  final services = UserServices();

  List<String> checkitem = [];
  getList() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      checkitem = cart.getStringList('addedtocart');
    });
    print("list");
    print(checkitem);
  }

  var restaurantDataCopy;
  var restaurantMenu;
  Future<List<dynamic>> fetchMenues() async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  get menues");

    var result =
        await http.get(APP_ROUTES + 'getMenues?key=BYCATID&id=' + cateId);
    restaurantMenu = json.decode(result.body)['data'];
    return restaurantMenu;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(menuName),
        ),
        body: FutureBuilder<List<dynamic>>(
            future: fetchMenues(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                      flex: 23,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          {
                            int tpye = 0;
                            return InkWell(
                              onTap: () async {
                                var menuD;
                                setState(() {
                                  menuD = snapshot.data[index];
                                });
                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CategoryDetailPage(
                                              menuData: menuD,
                                            )));
                                if (result) {
                                  setState(() {});
                                  getList();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 14),
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
                                                      "Are you sure you want to delete ${snapshot.data[index]['title']}?"),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
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
                                                        callingLoader();

                                                        await services
                                                            .data(snapshot
                                                                    .data[index]
                                                                ['menuId'])
                                                            .then((value) =>
                                                                fun(value));

                                                        final SharedPreferences
                                                            cart =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        int totalprice =
                                                            cart.getInt(
                                                                'TotalPrice');
                                                        int gsttotal = cart
                                                            .getInt('TotalGst');
                                                        int totalcount =
                                                            cart.getInt(
                                                                'TotalCount');
                                                        int vendorId = cart
                                                            .getInt('VendorId');

                                                        if (checkitem
                                                                .isNotEmpty &&
                                                            checkitem.contains(
                                                                snapshot
                                                                    .data[index]
                                                                        [
                                                                        'menuId']
                                                                    .toString())) {
                                                          if (data1[0][
                                                                  'itemCount'] ==
                                                              totalcount) {
                                                            setState(() {
                                                              snackBarData =
                                                                  "${snapshot.data[index]['title']} is remove from cart";
                                                              totalcount =
                                                                  totalcount -
                                                                      data1[0][
                                                                          'itemCount'];
                                                              gsttotal = gsttotal -
                                                                  (data1[0][
                                                                          'itemCount'] *
                                                                      data1[0][
                                                                          'gst']);
                                                              totalprice = totalprice -
                                                                  (data1[0][
                                                                          'itemCount'] *
                                                                      data1[0][
                                                                          'itemPrice']);
                                                              vendorId = 0;
                                                              cart.setInt(
                                                                  'VendorId',
                                                                  vendorId);
                                                              cart.setInt(
                                                                  'TotalPrice',
                                                                  totalprice);
                                                              cart.setInt(
                                                                  'TotalGst',
                                                                  gsttotal);
                                                              cart.setInt(
                                                                  'TotalCount',
                                                                  totalcount);

                                                              // vendorIdCheck
                                                              //     .remove(data1[
                                                              //             0][
                                                              //         'vendorId']);
                                                              checkitem.remove(data1[
                                                                          0][
                                                                      'menuItemId']
                                                                  .toString());
                                                              print(checkitem);
                                                              cart.setStringList(
                                                                  'addedtocart',
                                                                  checkitem);
                                                              services.deleteUser(
                                                                  data1[0][
                                                                      'menuItemId']);
                                                            });
                                                          } else {
                                                            setState(() {
                                                              snackBarData =
                                                                  "${snapshot.data[index]['title']} is remove from cart";
                                                              totalcount =
                                                                  totalcount -
                                                                      data1[0][
                                                                          'itemCount'];
                                                              gsttotal = gsttotal -
                                                                  (data1[0][
                                                                          'itemCount'] *
                                                                      data1[0][
                                                                          'gst']);
                                                              totalprice = totalprice -
                                                                  (data1[0][
                                                                          'itemCount'] *
                                                                      data1[0][
                                                                          'itemPrice']);

                                                              cart.setInt(
                                                                  'TotalPrice',
                                                                  totalprice);
                                                              cart.setInt(
                                                                  'TotalGst',
                                                                  gsttotal);
                                                              cart.setInt(
                                                                  'TotalCount',
                                                                  totalcount);

                                                              // vendorIdCheck
                                                              //     .remove(data1[
                                                              //             0][
                                                              //         'vendorId']);
                                                              checkitem.remove(data1[
                                                                          0][
                                                                      'menuItemId']
                                                                  .toString());
                                                              print(checkitem);
                                                              cart.setStringList(
                                                                  'addedtocart',
                                                                  checkitem);
                                                              services.deleteUser(
                                                                  data1[0][
                                                                      'menuItemId']);
                                                            });
                                                          }
                                                        } else {
                                                          setState(() {
                                                            snackBarData =
                                                                "${snapshot.data[index]['title']} is already remove from cart";
                                                          });
                                                        }
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
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
                                                  alignment:
                                                      Alignment.topCenter,
                                                  height: size.height * 0.2,
                                                  width: size.width * 0.3,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: size.width * 0.01,
                                                        right:
                                                            size.width * 0.014,
                                                        top: size.height *
                                                            0.008),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: snapshot.data[
                                                                      index][
                                                                  'menuImage1'] !=
                                                              null
                                                          ? CachedNetworkImage(
                                                              imageUrl: S3_BASE_PATH +
                                                                  snapshot.data[
                                                                          index]
                                                                      [
                                                                      'menuImage1'],
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
                                                                  Icon(Icons
                                                                      .error),
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
                                                  ),
                                                ),
                                                Positioned(
                                                  top: size.height * 0.09,
                                                  bottom: size.height * 0.02,
                                                  left: size.width * 0.058,
                                                  right: size.width * 0.058,
                                                  child: MaterialButton(
                                                    onPressed: () async {
                                                      final SharedPreferences
                                                          cart =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      int totalprice = cart
                                                          .getInt('TotalPrice');
                                                      int gsttotal = cart
                                                          .getInt('TotalGst');
                                                      int totalcount = cart
                                                          .getInt('TotalCount');
                                                      int vendorId = cart
                                                          .getInt('VendorId');
                                                      if (snapshot.data[index]
                                                              ['isNonVeg'] ==
                                                          false) {
                                                        if (snapshot.data[index]
                                                                ['isEgg'] ==
                                                            false) {
                                                          tpye = 1;
                                                        } else {
                                                          tpye = 2;
                                                        }
                                                      } else {
                                                        tpye = 3;
                                                      }

                                                      await services
                                                          .data(snapshot
                                                                  .data[index]
                                                              ['menuId'])
                                                          .then((value) =>
                                                              fun(value));
                                                      if (vendorId == 0 ||
                                                          vendorId ==
                                                              snapshot.data[
                                                                      index][
                                                                  'vendorId']) {
                                                        if (data1.isEmpty) {
                                                          setState(() {
                                                            var data =
                                                                snapshot.data;
                                                            itemAddToCart(index,
                                                                tpye, data);
                                                            setState(() {
                                                              snackBarData =
                                                                  "${snapshot.data[index]['title']} is added to cart";

                                                              totalcount =
                                                                  totalcount +
                                                                      1;
                                                              gsttotal = gsttotal +
                                                                  snapshot.data[
                                                                          index]
                                                                      [
                                                                      'gstAmount'];
                                                              totalprice = totalprice +
                                                                  snapshot.data[
                                                                          index]
                                                                      [
                                                                      'totalPrice'];

                                                              vendorId = snapshot
                                                                          .data[
                                                                      index]
                                                                  ['vendorId'];
                                                              cart.setInt(
                                                                  'VendorId',
                                                                  vendorId);
                                                              cart.setInt(
                                                                  'TotalPrice',
                                                                  totalprice);
                                                              cart.setInt(
                                                                  'TotalGst',
                                                                  gsttotal);
                                                              cart.setInt(
                                                                  'TotalCount',
                                                                  totalcount);
                                                            });

                                                            checkitem.add(snapshot
                                                                .data[index]
                                                                    ['menuId']
                                                                .toString());
                                                            cart.setStringList(
                                                                'addedtocart',
                                                                checkitem);
                                                          });
                                                        } else {
                                                          if (data1[0][
                                                                  'itemName'] !=
                                                              snapshot.data[
                                                                      index]
                                                                  ['title']) {
                                                            setState(() {
                                                              var data =
                                                                  snapshot.data;
                                                              itemAddToCart(
                                                                  index,
                                                                  tpye,
                                                                  data);
                                                              setState(() {
                                                                snackBarData =
                                                                    "${snapshot.data[index]['title']} is added to cart";

                                                                totalcount =
                                                                    totalcount +
                                                                        1;
                                                                gsttotal = gsttotal +
                                                                    snapshot.data[
                                                                            index]
                                                                        [
                                                                        'gstAmount'];
                                                                totalprice = totalprice +
                                                                    snapshot.data[
                                                                            index]
                                                                        [
                                                                        'totalPrice'];

                                                                vendorId = snapshot
                                                                            .data[
                                                                        index][
                                                                    'vendorId'];
                                                                cart.setInt(
                                                                    'VendorId',
                                                                    vendorId);
                                                                cart.setInt(
                                                                    'TotalPrice',
                                                                    totalprice);
                                                                cart.setInt(
                                                                    'TotalGst',
                                                                    gsttotal);
                                                                cart.setInt(
                                                                    'TotalCount',
                                                                    totalcount);
                                                              });

                                                              checkitem.add(snapshot
                                                                  .data[index]
                                                                      ['menuId']
                                                                  .toString());
                                                              cart.setStringList(
                                                                  'addedtocart',
                                                                  checkitem);
                                                            });
                                                          } else {
                                                            setState(() {
                                                              snackBarData =
                                                                  "${snapshot.data[index]['title']} is already added to cart";
                                                            });

                                                            print("match");
                                                          }
                                                        }
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Add order from Single Resturent");
                                                      }
                                                    },
                                                    color: Colors.white,
                                                    minWidth: size.width * 0.16,
                                                    height: size.height * 0.033,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14)),
                                                    textColor: Colors.white,
                                                    child: checkitem.isEmpty
                                                        ? Center(
                                                            child: Text(
                                                              "Add",
                                                              style: TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.015,
                                                                  color: Colors
                                                                      .blueGrey),
                                                            ),
                                                          )
                                                        : checkitem.contains(
                                                                snapshot
                                                                    .data[index]
                                                                        [
                                                                        'menuId']
                                                                    .toString())
                                                            ? Center(
                                                                child: Text(
                                                                  "Added",
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.015,
                                                                      color: Colors
                                                                          .blueGrey),
                                                                ),
                                                              )
                                                            : Center(
                                                                child: Text(
                                                                  "Add",
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.015,
                                                                      color: Colors
                                                                          .blueGrey),
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top:
                                                            size.height * 0.01),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          snapshot.data[index]
                                                              ['title'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  size.height *
                                                                      0.019),
                                                        ),
                                                        Spacer(),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 12),
                                                            child: snapshot.data[
                                                                            index]
                                                                        [
                                                                        'isNonVeg'] ==
                                                                    false
                                                                ? snapshot.data[index]
                                                                            [
                                                                            'isEgg'] ==
                                                                        false
                                                                    ? Container(
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                                                          height:
                                                                              size.height * 0.016,
                                                                          errorWidget: (context, url, error) =>
                                                                              Icon(Icons.error),
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        child: Image
                                                                            .asset(
                                                                        "assets/images/eggeterian.png",
                                                                        height: size.height *
                                                                            0.016,
                                                                      ))
                                                                : CachedNetworkImage(
                                                                    imageUrl:
                                                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
                                                                    height: size
                                                                            .height *
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
                                                      height:
                                                          size.height * 0.005),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          child: snapshot.data[
                                                                              index]
                                                                          [
                                                                          'categories']
                                                                      [
                                                                      'iconImage'] ==
                                                                  "null"
                                                              ? CachedNetworkImage(
                                                                  imageUrl:
                                                                      'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
                                                                  height:
                                                                      size.height *
                                                                          0.02,
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                )
                                                              : SizedBox(),
                                                        ),
                                                        SizedBox(
                                                          width: size.width *
                                                              0.006,
                                                        ),
                                                        Text(
                                                          snapshot.data[index][
                                                              'restaurantName'],
                                                          style: TextStyle(
                                                              fontSize:
                                                                  size.height *
                                                                      0.014,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                          child: Text(
                                                            "⭐",
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "3.0",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  size.height *
                                                                      0.014,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              right:
                                                                  size.width *
                                                                      0.1),
                                                          child: Text(
                                                            "₹${snapshot.data[index]['totalPrice']}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.018,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
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
                                                        child: snapshot
                                                                    .data[index]
                                                                        [
                                                                        'offers']
                                                                    .length !=
                                                                0
                                                            ? Row(
                                                                children: [
                                                                  Container(
                                                                      child: snapshot.data[index]['offers'].length !=
                                                                              0
                                                                          ? Row(
                                                                              children: [
                                                                                Image.asset(
                                                                                  "assets/icons/discount_icon.jpg",
                                                                                  height: size.height * 0.02,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: size.width * 0.006,
                                                                                ),
                                                                                Container(
                                                                                  child: snapshot.data[index]['offers'].length >= 2
                                                                                      ? Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              "OfferID ${snapshot.data[index]['offers'][0]['OffersAndCoupon']['coupon']}, ",
                                                                                              style: TextStyle(fontSize: size.height * 0.015, color: kTextColor),
                                                                                            ),
                                                                                            Text(
                                                                                              "OfferID ${snapshot.data[index]['offers'][1]['OffersAndCoupon']['coupon']}",
                                                                                              style: TextStyle(fontSize: size.height * 0.015, color: kTextColor),
                                                                                            ),
                                                                                          ],
                                                                                        )
                                                                                      : Text(
                                                                                          "OfferID ${snapshot.data[index]['offers'][0]['OffersAndCoupon']['coupon']}",
                                                                                          style: TextStyle(fontSize: size.height * 0.015, color: kTextColor),
                                                                                        ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          : SizedBox()),
                                                                ],
                                                              )
                                                            : SizedBox()),
                                                  ),
                                                ],
                                              ),
                                            ))
                                      ]),
                                    )),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          height: size.height * 1,
                          color: Colors.white,
                          child: Container(
                            height: size.height * 0.01,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: size.width * 1,
                            color: Colors.lightBlueAccent[200],
                            child: Row(
                              children: [
                                Container(
                                  width: size.width * 0.65,
                                  child: Text(
                                    snackBarData,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Spacer(),
                                FlatButton(
                                  textColor: Colors.redAccent,
                                  child: Text("View Cart"),
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CartScreen()));
                                    if (result) {
                                      setState(() {});
                                      getList();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                );
              } else {
                print("no data00");
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  itemAddToCart(index, tpye, data) async {
    final SharedPreferences cart = await SharedPreferences.getInstance();

    // var sum = cart.getInt('price');
    // sum = sum + data[index]['totalPrice'];
    // cart.setInt('price', sum);
    // print(sum);
    setState(() {
      // itemCount.add(value);
      services.saveUser(
          data[index]['totalPrice'],
          1,
          data[index]['vendorId'],
          data[index]['menuId'],
          data[index]['image1'],
          data[index]['title'],
          "Add".toString(),
          tpye,
          0,
          data[index]['restaurantName'],
          data[index]['gstAmount']);
    });
  }

  fun(value) {
    setState(() {
      data1 = value;
    });
  }
}
