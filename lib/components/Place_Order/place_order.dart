import 'dart:async';
import 'dart:convert';
import 'package:feasturent_costomer_app/components/Bottomsheet/offerBottomsheet.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/dataClass.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/Place_Order/order_confirm.dart';
import 'package:feasturent_costomer_app/components/Place_Order/select_address.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'offer_bottom_Sheet.dart';

class PlaceOrder extends StatefulWidget {
  final resturentOfferData;
  final deliveryTime;
  final data;
  const PlaceOrder(
      {Key key, this.data, this.deliveryTime, this.resturentOfferData})
      : super(key: key);
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  final services = UserServices();
  @override
  void initState() {
    super.initState();
    createstorage();
    dataForOffer = widget.data;
  }

  var dataForOffer;

  @override
  void dispose() {
    super.dispose();
  }

  callingLoader() {
    showDialog(
        barrierDismissible: false,
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

  List<String> checkitem = [];

  createstorage() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      checkitem = cart.getStringList('addedtocart');
      totalprice1 = cart.getInt('TotalPrice');
      gsttotal1 = cart.getInt('TotalGst');
      totalcount1 = cart.getInt('TotalCount');
      vendorId1 = cart.getInt('VendorId');
    });
    if (offerid != 0) {
      int k = dataForOffer['OffersAndCoupons'].length - 1;
      for (int i = 0; i <= k; i++) {
        if (offerid == dataForOffer['OffersAndCoupons'][i]['id']) {
          if (dataForOffer['OffersAndCoupons'][i]['discount'] == null) {
            if (dataForOffer['OffersAndCoupons'][i]['couponDiscountType'] ==
                "PERCENT") {
              setState(() {
                discount = (totalprice1 *
                        dataForOffer['OffersAndCoupons'][i]['couponDiscount']) /
                    100;
              });
              print("coupon percent discount $discount");
            } else {
              if (totalprice1 <
                  double.parse(dataForOffer['OffersAndCoupons'][i]
                          ['couponDiscount']
                      .toString())) {
                setState(() {
                  discount = double.parse(totalprice1.toString());
                });
              } else {
                setState(() {
                  discount = double.parse(dataForOffer['OffersAndCoupons'][i]
                          ['couponDiscount']
                      .toString());
                });
              }
            }
          } else {
            if (dataForOffer['OffersAndCoupons'][i]['discountType'] ==
                "PERCENT") {
              setState(() {
                discount = (totalprice1 *
                        dataForOffer['OffersAndCoupons'][i]['discount']) /
                    100;
              });
            } else {
              if (totalprice1 <
                  double.parse(dataForOffer['OffersAndCoupons'][i]['discount']
                      .toString())) {
                setState(() {
                  discount = double.parse(totalprice1.toString());
                });
              } else {
                setState(() {
                  discount = double.parse(dataForOffer['OffersAndCoupons'][i]
                          ['discount']
                      .toString());
                });
              }
            }
          }
        }
      }
    } else {
      setState(() {
        discount = 0;
      });
    }
    print("list");
    print(checkitem);
  }

  int gsttotal1;
  int totalprice1;
  int totalcount1;
  int vendorId1;

  fun(value) {
    setState(() {
      data1 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        setState(() {
          discount = 0;
          offerid = 0;
        });
        Navigator.pop(context, true);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        height: size.height * 0.75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    discount = 0;
                    offerid = 0;
                  });
                  Navigator.pop(context, true);
                },
                child: Icon(
                  Icons.clear,
                ),
              ),
            ),
            Container(
              height: size.height * 0.06,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.green,
                        size: size.height * 0.025,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Delivery at-",
                      style: TextStyle(fontSize: 13),
                    ),
                    Expanded(
                      flex: 9,
                      child: Text(
                        "$addAddress",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        flex: 2,
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_drop_down_rounded,
                            ),
                            onPressed: () async {
                              final result = await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => SelectAddress());
                              if (result) {
                                setState(() {});
                                createstorage();
                              }
                            })),
                  ],
                ),
              ),
            ),
            Divider(
              height: 7,
              color: Colors.grey,
            ),
            Container(
              height: size.height * 0.06,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer_rounded,
                      color: Colors.green,
                      size: size.height * 0.025,
                    ),
                    Text("Estimated time of delivery "),
                    Text("${widget.deliveryTime} mins."),
                  ],
                ),
              ),
            ),
            Divider(
              height: 7,
              color: Colors.grey,
            ),
            Expanded(
              child: ListView(
                children: [
                  FutureBuilder(
                      future: services.fetchUsers(),
                      builder: (ctx, snap) {
                        List<AddToCart> users = snap.data;
                        if (!snap.hasData) {
                          return Center(
                            child: Text('No data found'),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: users.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (
                                context,
                                index,
                              ) {
                                {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 2,
                                                  color: Colors.blue[50],
                                                  offset: Offset(1, 4),
                                                  spreadRadius: 2)
                                            ]),
                                        child: Dismissible(
                                          direction:
                                              DismissDirection.endToStart,
                                          // ignore: missing_return
                                          confirmDismiss: (direction) async {
                                            if (direction ==
                                                DismissDirection.endToStart) {
                                              final bool res = await showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          "Are you sure you want to delete ${users[index].itemName}?"),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          onPressed: () {
                                                            print(users[index]
                                                                .id);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        FlatButton(
                                                          child: Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          onPressed: () async {
                                                            callingLoader();

                                                            final SharedPreferences
                                                                cart =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            int totalprice =
                                                                cart.getInt(
                                                                    'TotalPrice');
                                                            int gsttotal =
                                                                cart.getInt(
                                                                    'TotalGst');
                                                            int totalcount =
                                                                cart.getInt(
                                                                    'TotalCount');
                                                            int vendorId =
                                                                cart.getInt(
                                                                    'VendorId');

                                                            if (users[index]
                                                                    .itemCount ==
                                                                totalcount) {
                                                              setState(() {
                                                                totalcount =
                                                                    totalcount -
                                                                        users[index]
                                                                            .itemCount;
                                                                gsttotal = gsttotal -
                                                                    (users[index]
                                                                            .itemCount *
                                                                        users[index]
                                                                            .gst);
                                                                totalprice = totalprice -
                                                                    (users[index]
                                                                            .itemCount *
                                                                        users[index]
                                                                            .itemPrice);
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
                                                                services.deleteUser(
                                                                    users[index]
                                                                        .menuItemId);
                                                                checkitem.remove(users[
                                                                        index]
                                                                    .menuItemId
                                                                    .toString());
                                                                print(
                                                                    checkitem);
                                                                cart.setStringList(
                                                                    'addedtocart',
                                                                    checkitem);
                                                                print(
                                                                    checkitem);
                                                              });
                                                            } else {
                                                              setState(() {
                                                                totalcount =
                                                                    totalcount -
                                                                        users[index]
                                                                            .itemCount;
                                                                gsttotal = gsttotal -
                                                                    (users[index]
                                                                            .itemCount *
                                                                        users[index]
                                                                            .gst);
                                                                totalprice = totalprice -
                                                                    (users[index]
                                                                            .itemCount *
                                                                        users[index]
                                                                            .itemPrice);

                                                                cart.setInt(
                                                                    'TotalPrice',
                                                                    totalprice);
                                                                cart.setInt(
                                                                    'TotalGst',
                                                                    gsttotal);
                                                                cart.setInt(
                                                                    'TotalCount',
                                                                    totalcount);
                                                                services.deleteUser(
                                                                    users[index]
                                                                        .menuItemId);
                                                                checkitem.remove(users[
                                                                        index]
                                                                    .menuItemId
                                                                    .toString());
                                                                print(
                                                                    checkitem);
                                                                cart.setStringList(
                                                                    'addedtocart',
                                                                    checkitem);
                                                                print(
                                                                    checkitem);
                                                              });
                                                            }
                                                            await Future
                                                                .delayed(
                                                                    Duration(
                                                                        seconds:
                                                                            1));
                                                            setState(() {});
                                                            createstorage();

                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
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
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: size.width * 0.69,
                                                      height:
                                                          size.height * 0.128,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 0,
                                                            child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                height:
                                                                    size.height *
                                                                        0.2,
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              4,
                                                                          right:
                                                                              4,
                                                                          top:
                                                                              4),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    child: users[index].imagePath !=
                                                                            null
                                                                        ? CachedNetworkImage(
                                                                            imageUrl:
                                                                                S3_BASE_PATH + users[index].imagePath,
                                                                            height:
                                                                                size.height * 0.1,
                                                                            width:
                                                                                size.width * 0.26,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            placeholder: (context, url) =>
                                                                                Center(child: CircularProgressIndicator()),
                                                                            errorWidget: (context, url, error) =>
                                                                                Icon(Icons.error),
                                                                          )
                                                                        : Image
                                                                            .asset(
                                                                            "assets/images/feasturenttemp.jpeg",
                                                                            height:
                                                                                size.height * 0.1,
                                                                            width:
                                                                                size.width * 0.26,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                  ),
                                                                )),
                                                          ),
                                                          Expanded(
                                                              child: Container(
                                                            margin: EdgeInsets.only(
                                                                left:
                                                                    size.width *
                                                                        0.01),
                                                            height:
                                                                size.height *
                                                                    0.2,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top: 6,
                                                                  ),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width: size.width *
                                                                            0.3,
                                                                        child:
                                                                            Text(
                                                                          users[index]
                                                                              .itemName,
                                                                          maxLines:
                                                                              2,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black,
                                                                              fontSize: 14),
                                                                        ),
                                                                      ),
                                                                      Spacer(),
                                                                      Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(right: 12),
                                                                          child: users[index].itemtype == 3
                                                                              ? CachedNetworkImage(
                                                                                  imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
                                                                                  height: size.height * 0.016,
                                                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                                                )
                                                                              : users[index].itemtype == 2
                                                                                  ? Container(
                                                                                      child: Image.asset(
                                                                                      "assets/images/eggeterian.png",
                                                                                      height: size.height * 0.016,
                                                                                    ))
                                                                                  : Container(
                                                                                      child: CachedNetworkImage(
                                                                                        imageUrl: 'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                                                                        height: size.height * 0.016,
                                                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                                                      ),
                                                                                    ))
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                          child:
                                                                              Text("⭐")),
                                                                      Text(
                                                                        "3.0",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Colors.red,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            45,
                                                                      ),
                                                                      Text(
                                                                        "₹ ${users[index].itemPrice}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            20,
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
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                padding:
                                                    EdgeInsets.only(right: 0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 2,
                                                        spreadRadius: 2,
                                                        color: Colors.grey[300],
                                                        offset: Offset(0, 3))
                                                  ],
                                                ),
                                                margin: EdgeInsets.only(
                                                    right: size.width * 0.0),
                                                child: ButtonBar(
                                                  buttonPadding:
                                                      EdgeInsets.all(3),
                                                  children: [
                                                    InkWell(
                                                        onTap: () async {
                                                          final SharedPreferences
                                                              cart =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          int totalprice =
                                                              cart.getInt(
                                                                  'TotalPrice');
                                                          int gsttotal =
                                                              cart.getInt(
                                                                  'TotalGst');
                                                          int totalcount =
                                                              cart.getInt(
                                                                  'TotalCount');
                                                          int vendorId =
                                                              cart.getInt(
                                                                  'VendorId');

                                                          if (users[index]
                                                                  .itemCount >
                                                              1) {
                                                            callingLoader();

                                                            setState(() {
                                                              totalcount--;

                                                              gsttotal =
                                                                  gsttotal -
                                                                      users[index]
                                                                          .gst;
                                                              totalprice =
                                                                  totalprice -
                                                                      users[index]
                                                                          .itemPrice;
                                                              services.decrementItemCounter(
                                                                  users[index]
                                                                      .id,
                                                                  users[index]
                                                                      .itemCount);

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
                                                            await Future
                                                                .delayed(
                                                                    Duration(
                                                                        seconds:
                                                                            1));
                                                            setState(() {});
                                                            Navigator.pop(
                                                                context);
                                                          } else if (users[
                                                                      index]
                                                                  .itemCount ==
                                                              1) {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    content: Text(
                                                                        "Are you sure you want to delete ${users[index].itemName}?"),
                                                                    actions: <
                                                                        Widget>[
                                                                      FlatButton(
                                                                        child:
                                                                            Text(
                                                                          "Cancel",
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                      FlatButton(
                                                                        child:
                                                                            Text(
                                                                          "Delete",
                                                                          style:
                                                                              TextStyle(color: Colors.red),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          callingLoader();

                                                                          final SharedPreferences
                                                                              cart =
                                                                              await SharedPreferences.getInstance();
                                                                          int totalprice =
                                                                              cart.getInt('TotalPrice');
                                                                          int gsttotal =
                                                                              cart.getInt('TotalGst');
                                                                          int totalcount =
                                                                              cart.getInt('TotalCount');
                                                                          int vendorId =
                                                                              cart.getInt('VendorId');

                                                                          if (users[index].itemCount ==
                                                                              totalcount) {
                                                                            setState(() {
                                                                              totalcount = totalcount - users[index].itemCount;
                                                                              gsttotal = gsttotal - (users[index].itemCount * users[index].gst);
                                                                              totalprice = totalprice - (users[index].itemCount * users[index].itemPrice);
                                                                              vendorId = 0;

                                                                              cart.setInt('VendorId', vendorId);
                                                                              cart.setInt('TotalPrice', totalprice);
                                                                              cart.setInt('TotalGst', gsttotal);
                                                                              cart.setInt('TotalCount', totalcount);
                                                                              services.deleteUser(users[index].menuItemId);
                                                                              checkitem.remove(users[index].menuItemId.toString());
                                                                              print(checkitem);
                                                                              cart.setStringList('addedtocart', checkitem);
                                                                              print(checkitem);
                                                                            });
                                                                          } else {
                                                                            setState(() {
                                                                              totalcount = totalcount - users[index].itemCount;
                                                                              gsttotal = gsttotal - (users[index].itemCount * users[index].gst);
                                                                              totalprice = totalprice - (users[index].itemCount * users[index].itemPrice);

                                                                              cart.setInt('TotalPrice', totalprice);
                                                                              cart.setInt('TotalGst', gsttotal);
                                                                              cart.setInt('TotalCount', totalcount);
                                                                              services.deleteUser(users[index].menuItemId);
                                                                              checkitem.remove(users[index].menuItemId.toString());
                                                                              print(checkitem);
                                                                              cart.setStringList('addedtocart', checkitem);
                                                                              print(checkitem);
                                                                            });
                                                                          }
                                                                          await Future.delayed(
                                                                              Duration(seconds: 1));
                                                                          setState(
                                                                              () {});
                                                                          createstorage();

                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          }
                                                          createstorage();
                                                        },
                                                        child:
                                                            Icon(Icons.remove)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        "${users[index].itemCount}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    InkWell(
                                                      child: Icon(Icons.add),
                                                      onTap: () async {
                                                        callingLoader();

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

                                                        setState(() {
                                                          totalcount++;

                                                          gsttotal = gsttotal +
                                                              users[index].gst;
                                                          totalprice =
                                                              totalprice +
                                                                  users[index]
                                                                      .itemPrice;
                                                          services
                                                              .incrementItemCounter(
                                                                  users[index]
                                                                      .id,
                                                                  users[index]
                                                                      .itemCount)
                                                              .then((value) =>
                                                                  fun(value));

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
                                                        await Future.delayed(
                                                            Duration(
                                                                seconds: 1));
                                                        setState(() {});
                                                        print(
                                                            "@@@@@@@hjjjjjjjjjjjjjjjjjj@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                                                        Navigator.pop(context);
                                                        createstorage();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              });
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: size.height * 0.15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " Donation for Social cause",
                            style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: size.height * 0.03),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (donate[0].value == false) {
                                    DonationFunction(0);
                                  } else {
                                    setState(() {
                                      donate[0].value = false;
                                      donateAmount = 0;
                                    });
                                  }
                                },
                                child: Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: donate[0].value == false
                                        ? Colors.white
                                        : Colors.blue[200],
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black54),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "₹ ${donate[0].amount}",
                                    style: TextStyle(color: Colors.black54),
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (donate[1].value == false) {
                                    DonationFunction(1);
                                  } else {
                                    setState(() {
                                      donate[1].value = false;
                                      donateAmount = 0;
                                    });
                                  }
                                },
                                child: Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: donate[1].value == false
                                        ? Colors.white
                                        : Colors.blue[200],
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black54),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "₹ ${donate[1].amount}",
                                    style: TextStyle(color: Colors.black54),
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (donate[2].value == false) {
                                    DonationFunction(2);
                                  } else {
                                    setState(() {
                                      donate[2].value = false;
                                      donateAmount = 0;
                                    });
                                  }
                                },
                                child: Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: donate[2].value == false
                                        ? Colors.white
                                        : Colors.blue[200],
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black54),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "₹ ${donate[2].amount}",
                                    style: TextStyle(color: Colors.black54),
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (donate[3].value == false) {
                                    DonationFunction(3);
                                  } else {
                                    setState(() {
                                      donate[3].value = false;
                                      donateAmount = 0;
                                    });
                                  }
                                },
                                child: Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: donate[3].value == false
                                        ? Colors.white
                                        : Colors.blue[200],
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black54),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "₹ ${donate[3].amount}",
                                    style: TextStyle(color: Colors.black54),
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (donate[4].value == false) {
                                    DonationFunction(4);
                                  } else {
                                    setState(() {
                                      donate[4].value = false;
                                      donateAmount = 0;
                                    });
                                  }
                                },
                                child: Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: donate[4].value == false
                                        ? Colors.white
                                        : Colors.blue[200],
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black54),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "₹ ${donate[4].amount}",
                                    style: TextStyle(color: Colors.black54),
                                  )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: size.height * 0.15,
                      color: Colors.blue[50],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Offers",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          dataForOffer['OffersAndCoupons'].isEmpty
                              ? Text("No offer avialable.. ")
                              : Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
                                      height: size.height * 0.045,
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    Text("Select a promo code"),
                                    Spacer(),
                                    InkWell(
                                      onTap: () async {
                                        if (dataForOffer['OffersAndCoupons']
                                            .isEmpty) {
                                          Fluttertoast.showToast(
                                              msg: "No offer avialable.. ");
                                        } else {
                                          final result =
                                              await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  isDismissible: false,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) =>
                                                      OfferForPlaceOrder(
                                                        data: dataForOffer[
                                                            'OffersAndCoupons'],
                                                      ));
                                          if (result == 0) {
                                            setState(() {
                                              offerid = result;
                                              createstorage();
                                            });
                                          } else {
                                            setState(() {
                                              offerid = result;
                                              createstorage();
                                            });
                                          }
                                          print("reulyt $result");
                                        }
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 100,
                                        child: Center(
                                          child: Text(
                                            "View offers",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(flex: 9, child: Text("Price")),
                            Expanded(flex: 5, child: SizedBox()),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  "₹${totalprice1 - gsttotal1}.0",
                                  textDirection: TextDirection.rtl,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(flex: 9, child: Text("Discount Offer")),
                            Expanded(flex: 5, child: SizedBox()),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  "₹$discount -",
                                  textDirection: TextDirection.rtl,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(flex: 9, child: Text("GST Added")),
                            Expanded(flex: 5, child: SizedBox()),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  "₹$gsttotal1.0",
                                  textDirection: TextDirection.rtl,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(flex: 9, child: Text("Donation")),
                            Expanded(flex: 5, child: SizedBox()),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  "₹$donateAmount.0",
                                  textDirection: TextDirection.rtl,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 9,
                                child: Text(
                                  "Grand Total",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.0276),
                                )),
                            Expanded(flex: 5, child: SizedBox()),
                            Expanded(
                                flex: 4,
                                child: Text(
                                  "₹${totalprice1 + donateAmount - discount}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.0273),
                                  textDirection: TextDirection.rtl,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: size.height * 0.1,
                      color: Colors.blue[50],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ordering for",
                          ),
                          Text(
                            "$userNameWithNumber",
                            style: TextStyle(
                                fontSize: size.height * 0.023,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              flex: 16,
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.0, bottom: 5.0),
                      width: size.width * 0.35,
                      height: size.height * 0.2,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Pay Using"),
                              dataForOffer['Setting']['isCod'] == null
                                  ? PopupMenuButton(
                                      padding: EdgeInsets.all(10),
                                      icon: Icon(Icons.arrow_drop_down),
                                      onSelected: (value) {
                                        if (value == 0) {
                                          setState(() {
                                            paymentMode = "Online Mode";
                                          });
                                        } else if (value == 1) {
                                          setState(() {
                                            paymentMode = "Cash On Delivery";
                                          });
                                        } else if (value == 2) {
                                          setState(() {
                                            paymentMode = "Wallet";
                                          });
                                        }
                                      },
                                      itemBuilder: (BuildContext) => [
                                        PopupMenuItem(
                                          child: Text("Online Mode"),
                                          value: 0,
                                        ),
                                        PopupMenuItem(
                                          child: Text("Cash On Delivery"),
                                          value: 1,
                                        ),
                                        PopupMenuItem(
                                          child: Text("Wallet"),
                                          value: 2,
                                        ),
                                      ],
                                    )
                                  : dataForOffer['Setting']['isCod'] == true
                                      ? PopupMenuButton(
                                          padding: EdgeInsets.all(10),
                                          icon: Icon(Icons.arrow_drop_down),
                                          onSelected: (value) {
                                            if (value == 0) {
                                              setState(() {
                                                paymentMode = "Online Mode";
                                              });
                                            } else if (value == 1) {
                                              setState(() {
                                                paymentMode =
                                                    "Cash On Delivery";
                                              });
                                            } else if (value == 2) {
                                              setState(() {
                                                paymentMode = "Wallet";
                                              });
                                            }
                                          },
                                          itemBuilder: (BuildContext) => [
                                            PopupMenuItem(
                                              child: Text("Online Mode"),
                                              value: 0,
                                            ),
                                            PopupMenuItem(
                                              child: Text("Cash On Delivery"),
                                              value: 1,
                                            ),
                                            PopupMenuItem(
                                              child: Text("Wallet"),
                                              value: 2,
                                            ),
                                          ],
                                        )
                                      : PopupMenuButton(
                                          padding: EdgeInsets.all(10),
                                          icon: Icon(Icons.arrow_drop_down),
                                          onSelected: (value) {
                                            if (value == 0) {
                                              setState(() {
                                                paymentMode = "Online Mode";
                                              });
                                            } else if (value == 2) {
                                              setState(() {
                                                paymentMode = "Wallet";
                                              });
                                            }
                                          },
                                          itemBuilder: (BuildContext) => [
                                            PopupMenuItem(
                                              child: Text("Online Mode"),
                                              value: 0,
                                            ),
                                            PopupMenuItem(
                                              child: Text("Wallet"),
                                              value: 2,
                                            ),
                                          ],
                                        )
                            ],
                          ),
                          Text(paymentMode),
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                        onTap: () async {
                          if (userNameWithNumber == "Select Delivery Address") {
                            final result = await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => SelectAddress());
                            if (result) {
                              setState(() {});
                              createstorage();
                            }
                          } else {
                            if (totalprice1 != 0) {
                              showModalBottomSheet(
                                  enableDrag: false,
                                  isDismissible: false,
                                  isScrollControlled: false,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => PlaceOrderCheck());
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please select any item to place order");
                            }
                          }
                        },
                        child: checkAddress(size))
                  ],
                ),
              ),
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }

  DonationFunction(data) {
    for (int i = 0; i <= donate.length - 1; i++) {
      setState(() {
        donate[i].value = false;
      });
    }
    setState(() {
      donate[data].value = true;
      donateAmount = donate[data].amount;
    });
  }

  checkAddress(size) {
    if (userNameWithNumber == "Select Delivery Address") {
      return Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(7)),
          height: size.height * 0.08,
          width: size.width * 0.52,
          child: Center(
            child: Row(
              children: [
                Text(
                  '''
Select Address at next
step''',
                  style: TextStyle(
                      color: Colors.white, fontSize: size.height * 0.02),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: size.height * 0.02,
                ),
              ],
            ),
          ));
    } else {
      return Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(7)),
          height: size.height * 0.1,
          width: size.width * 0.52,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("₹${totalprice1 + donateAmount - discount}",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  Text("Total", style: TextStyle(fontSize: size.height * 0.017))
                ],
              ),
              Spacer(),
              Text(
                "Place Order",
                style: TextStyle(
                    color: Colors.white, fontSize: size.height * 0.025),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: size.height * 0.02,
              ),
            ],
          ));
    }
  }
}

class PlaceOrderCheck extends StatefulWidget {
  @override
  _PlaceOrderCheckState createState() => _PlaceOrderCheckState();
}

class _PlaceOrderCheckState extends State<PlaceOrderCheck> {
  Razorpay _razorpay;
  String _authorization = '';
  String _refreshtoken = '';

  var emailid;
  var userid;
  var usernamed;
  var phonenumber;

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //FirebaseUser user = await FirebaseAuth.instance.currentUser();

    var takeUser = prefs.getString('loginBy');
    print(takeUser);
    emailid = prefs.getString('userEmail');
    userid = prefs.getString('userId');
    phonenumber.getString('userNumber');
    usernamed = prefs.getString('name');
  }

  Future<bool> onPlaceBack() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("You don't Want to place order"),
              actions: [
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
                FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    List<int> data = [
                      1,
                      2,
                      3,
                      54,
                    ];
                    int k = data.length;
                    print(k);
                    for (int i = 0; i <= k; i++) {
                      print(i);
                    }
                    placeTimer.cancel();
                    placePrecent = 0;
                    placeValue = 0;
                    Navigator.pop(context);
                    Navigator.pop(context, true);
                  },
                )
              ],
            ));
  }

  @override
  void initState() {
    getList();
    getMenuDetails();

    createstorage();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    placeTimer = Timer.periodic(Duration(milliseconds: 100), (_) {
      setState(() {
        placePrecent++;
      });
      if (placePrecent >= 100) {
        placeTimer.cancel();
        placePrecent = 0;
        placeValue = 1;

        // int k = add2.length - 1;

        // for (int i = 0; i <= k; i++) {
        //   if (add2[i].isSelected == true) {
        //     print("remove from cart ${add2[i].title}");
        //   } else {
        //     print("item not selected  ${add2[i].title}");
        //   }
        // }
        // API hit will be from here

        if (paymentMode == "Online Mode") {
          _checkout();
        } else if (paymentMode == "Cash On Delivery") {
          cashPayment();
        } else if (paymentMode == "Wallet") {
          walletPayment();
        }
      } else {
        setState(() {
          placeValue = placePrecent / 100;
        });
      }
    });
    super.initState();
  }

  createstorage() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      totalprice1 = cart.getInt('TotalPrice');
      gsttotal1 = cart.getInt('TotalGst');
      totalcount1 = cart.getInt('TotalCount');
      vendorId1 = cart.getInt('VendorId');
    });
  }

  int gsttotal1;
  int totalprice1;
  int totalcount1;
  int vendorId1;

  final services = UserServices();
  String jsonTags;
  getMenuDetails() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      checkitem = cart.getStringList('addedtocart');
    });
    int k = checkitem.length;
    print(
        "++++++++++++++++++++++++++++++++++++++++++++++++  string list length $k");
    for (int i = 0; i <= k - 1; i++) {
      print("ID:-$i");
      var data = int.parse(checkitem[i]);
      await services.data(data).then((value) => fun(value));
      String menuName = data1[0]['itemName'];

      int menuID = data1[0]['menuItemId'];
      int menuQty = data1[0]['itemCount'];
      print("***************************new data*************************");
      print(
          "MenuName = $menuName and MenuId = $menuID and MenuQuantity = $menuQty");
      print("***************************data close*************************");
      menuidAndQty.add(MenuData(menuID, menuQty));
    }
    print("***************************final*************************");
    print(menuidAndQty);
    print(
        "***************************Simple list printed*************************");

    setState(() {
      jsonTags = jsonEncode(menuidAndQty);
      // jsonTags = jsonDecode(jsonTags);
    });

    print(jsonTags);
    print(
        "***************************final address id $addressID*************************");
  }

  fun(value) {
    setState(() {
      data1 = value;
    });
  }

  List<String> checkitem = [];
  getList() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      checkitem = cart.getStringList('addedtocart');
    });
    print("list");
    print(checkitem);
  }

  List<MenuData> menuidAndQty = [];

  removeDataFromCart() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      checkitem = cart.getStringList('addedtocart');
    });
    print(
        "*********************************   idcheck length********    ${idCheck.length}");
    int k = checkitem.length;
    print("*********************************   k length********    $k");
    for (int i = 0; i <= k - 1; i++) {
      print("*********************************   for loop stated********");
      print("*********************************   i  ********    $i");
      print("ID:-$i");
      final SharedPreferences cart = await SharedPreferences.getInstance();

      var data = int.parse(checkitem[i]);
      await services.data(data).then((value) => func(value));

      setState(() {
        services.deleteUser(data);
      });
    }
    setState(() {
      gsttotal1 = 0;
      totalcount1 = 0;
      totalprice1 = 0;
      discount = 0;
      offerid = 0;
      vendorId1 = 0;
      cart.setInt('VendorId', vendorId1);

      cart.setInt('TotalPrice', totalprice1);
      cart.setInt('TotalGst', gsttotal1);
      cart.setInt('TotalCount', totalcount1);

      checkitem.clear();
      print(checkitem);
      cart.setStringList('addedtocart', checkitem);
    });
  }

  walletPayment() async {
    print("*****************************************");
    final prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('userId');

    _authorization = prefs.getString('sessionToken');
    _refreshtoken = prefs.getString('refreshToken');
    Map data = {
      "menuId": menuidAndQty,
      "vendorId": "$vendorId1",
      "userId": "$userid",
      "addressId": addressID,
      "orderPrice": "$totalprice1.00",
      "donation": "$donateAmount",
      "gst": "$gsttotal1.00",
      "discountPrice": "$discount",
      "offerId": "$offerid",
      "paymentMode": "WALLET",
      "razorpay_payment_id": null,
      "razo rpay_order_id": null,
      "razorpay_signature": null
    };
    var requestBody = jsonEncode(data);
    print("*****************HEloo************************");
    print("*****************World************************");
    print("*****************Heloo************************");
    print("*****************************************");
    print("*****************************************");
    print("*****************************************");

    print(requestBody);
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  place order");

    var response =
        await http.post(APP_ROUTES + 'itemOrder', body: requestBody, headers: {
      "authorization": _authorization,
      "refreshtoken": _refreshtoken,
      "Content-Type": "application/json"
    });
    print(response.statusCode);

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      removeDataFromCart();
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderConfirmResturent()));
      });
    } else if (response.statusCode == 401) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(
        'name',
      );
      prefs.remove('sessionToken');
      prefs.remove('refreshToken');
      prefs.remove('userNumber');
      prefs.remove('userProfile');
      prefs.remove('customerName');
      prefs.remove('userId');
      prefs.remove('loginId');
      prefs.remove('userEmail');
      prefs.remove("loginBy");
      takeUser = false;
      emailid = null;
      photo = null;
      userName = null;

      prefs.setBool("_isAuthenticate", false);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      print(responseData['message']);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: responseData['message']);
    }
  }

  cashPayment() async {
    print("*****************************************");
    final prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('userId');

    _authorization = prefs.getString('sessionToken');
    _refreshtoken = prefs.getString('refreshToken');
    Map data = {
      "menuId": menuidAndQty,
      "vendorId": "$vendorId1",
      "userId": "$userid",
      "addressId": addressID,
      "orderPrice": "$totalprice1.00",
      "donation": "$donateAmount",
      "gst": "$gsttotal1",
      "discountPrice": "$discount",
      "offerId": "$offerid",
      "paymentMode": "CASH",
      "razorpay_payment_id": null,
      "razo rpay_order_id": null,
      "razorpay_signature": null
    };
    var requestBody = jsonEncode(data);
    print("*****************HEloo************************");
    print("*****************World************************");
    print("*****************Heloo************************");
    print("*****************************************");
    print("*****************************************");
    print("*****************************************");

    print(requestBody);
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  place order");
    var response =
        await http.post(APP_ROUTES + 'itemOrder', body: requestBody, headers: {
      "authorization": _authorization,
      "refreshtoken": _refreshtoken,
      "Content-Type": "application/json"
    });
    print(response.statusCode);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      removeDataFromCart();
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderConfirmResturent()));
      });
    } else if (response.statusCode == 401) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(
        'name',
      );
      prefs.remove('sessionToken');
      prefs.remove('refreshToken');
      prefs.remove('userNumber');
      prefs.remove('userProfile');
      prefs.remove('customerName');
      prefs.remove('userId');
      prefs.remove('loginId');
      prefs.remove('userEmail');
      prefs.remove("loginBy");
      takeUser = false;
      emailid = null;
      photo = null;
      userName = null;

      prefs.setBool("_isAuthenticate", false);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      print(response.statusCode);
      Fluttertoast.showToast(msg: "Something went Wrong");
    }
  }

  func(value) {
    setState(() {
      data2 = value;
    });
  }

  Future<void> _checkout() async {
    var amount = totalprice1 + donateAmount - discount;
    var options = {
      'key': 'rzp_test_7iDSklI4oMeTUd',
      'amount': num.parse(amount.toString()) * 100,
      'name': usernamed,
      'description': 'Tasty',
      'prefill': {'contact': phonenumber, 'email': emailid}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse responsed) async {
    var responsepaymentid = responsed.paymentId;
    var responseorderid = responsed.orderId;
    var responsesignature = responsed.signature;
    final prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('userId');

    _authorization = prefs.getString('sessionToken');
    _refreshtoken = prefs.getString('refreshToken');
    Map data = {
      "menuId": menuidAndQty,
      "vendorId": "$vendorId1",
      "userId": "$userid",
      "addressId": addressID,
      "orderPrice": "$totalprice1.00",
      "donation": "$donateAmount",
      "gst": "$gsttotal1.00",
      "discountPrice": "$discount",
      "offerId": "$offerid",
      "paymentMode": "ONLINE",
      "razorpay_payment_id": "$responsepaymentid",
      "razo rpay_order_id": "$responseorderid",
      "razorpay_signature": "$responsesignature"
    };
    var requestBody = jsonEncode(data);
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  place order");
    var response =
        await http.post(APP_ROUTES + 'itemOrder', body: requestBody, headers: {
      "authorization": _authorization,
      "refreshtoken": _refreshtoken,
      "Content-Type": "application/json"
    });

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      removeDataFromCart();
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderConfirmResturent()));
      });
    } else if (response.statusCode == 401) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(
        'name',
      );
      prefs.remove('sessionToken');
      prefs.remove('refreshToken');
      prefs.remove('userNumber');
      prefs.remove('userProfile');
      prefs.remove('customerName');
      prefs.remove('userId');
      prefs.remove('loginId');
      prefs.remove('userEmail');
      prefs.remove("loginBy");
      takeUser = false;
      emailid = null;
      photo = null;
      userName = null;

      prefs.setBool("_isAuthenticate", false);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      Fluttertoast.showToast(msg: "Something went Wrong");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      print("error");
      print(response.code);
      print(response.message);
      Navigator.pop(context, PlaceOrder());
      showDialog(context: context, builder: dialogFunction());
    });
  }

  dialogFunction() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      title: new Text(
        "Payment Failed",
        style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.bold),
      ),
      content: new Text(
        "Something Went Wrong",
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => OrderConfirmResturent()));
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onPlaceBack,
      child: Container(
        padding: EdgeInsets.all(10),
        height: size.height * 0.5,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      "Place Order",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text("DELIVERY AT"),
                    Spacer(),
                    Text(
                      addAddress,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.height * 0.016,
                      ),
                    ),
                    Spacer(),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      Text(
                          "PAY USING with GST ( ₹${totalprice1 + donateAmount - discount})"),
                      Spacer(),
                      Text(
                        paymentMode,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.height * 0.025,
                        ),
                      ),
                      Spacer(),
                    ])),
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text("PROMO CODE"),
                    Spacer(),
                    Text(
                      "No promo code applied",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.height * 0.025,
                      ),
                    ),
                    Spacer(),
                  ],
                )),
            Divider(),
            Expanded(
                child: Row(
              children: [
                Container(
                  height: size.height * 0.04,
                  width: size.width * 0.65,
                  child: LiquidLinearProgressIndicator(
                    value: placeValue,
                    valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                    backgroundColor: Colors.grey[200],
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context, true);
                        placeTimer.cancel();
                        placePrecent = 0;
                        placeValue = 0;
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: size.height * 0.03,
                        ),
                      )),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
