import 'dart:async';
import 'dart:convert';
import 'package:feasturent_costomer_app/components/Bottomsheet/offerBottomsheet.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/dataClass.dart';
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

class PlaceOrder extends StatefulWidget {
  final data;
  const PlaceOrder({Key key, this.data}) : super(key: key);
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

int price = 0;

class _PlaceOrderState extends State<PlaceOrder> {
  final services = UserServices();
  @override
  void initState() {
    super.initState();
    createstorage();

    refresh();
    dataForOffer = widget.data;
    print(dataForOffer);
    getList();
  }

  var dataForOffer;

  Timer placeTimer;

  refresh() {
    placeTimer = Timer.periodic(Duration(seconds: 1), (_) {
      placeTimer.cancel();
      if (mounted) {
        setState(() {});
        refresh();
        // Your state change code goes here

      }
    });
  }

  @override
  void dispose() {
    refresh();
    placeTimer.cancel();
    super.dispose();
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

  createstorage() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      price = cart.getInt('price');
    });
  }

  onGoBack(dynamic value) {
    print("hello data refresh");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
                Navigator.pop(context, () {
                  setState(() {});
                });
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
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => SelectAddress());
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
                  Text("Delivery in "),
                  Text("50 mins."),
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
                              if (idCheck.contains(users[index].id)) {
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
                                        direction: DismissDirection.endToStart,
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
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        onPressed: () {
                                                          print(
                                                              users[index].id);
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
                                                          final SharedPreferences
                                                              cart =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          price = cart
                                                              .getInt('price');
                                                          if (idCheck.contains(
                                                              users[index]
                                                                  .id)) {
                                                            setState(() {
                                                              countSum = countSum -
                                                                  users[index]
                                                                      .itemCount;
                                                              totalPrice = totalPrice -
                                                                  (users[index]
                                                                          .itemCount *
                                                                      users[index]
                                                                          .itemPrice);
                                                              price = price -
                                                                  (users[index]
                                                                          .itemCount *
                                                                      users[index]
                                                                          .itemPrice);
                                                              cart.setInt(
                                                                  'price',
                                                                  price);
                                                              services.deleteUser(
                                                                  users[index]
                                                                      .id);
                                                              idCheck.remove(
                                                                  users[index]
                                                                      .id);
                                                              vendorIdCheck
                                                                  .remove(users[
                                                                          index]
                                                                      .vendorId);
                                                              checkitem.remove(
                                                                  users[index]
                                                                      .menuItemId
                                                                      .toString());
                                                              print(checkitem);
                                                              cart.setStringList(
                                                                  'addedtocart',
                                                                  checkitem);
                                                            });

                                                            Navigator.pop(
                                                                context);
                                                          }
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
                                                    height: size.height * 0.128,
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
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 4,
                                                                        right:
                                                                            4,
                                                                        top: 4),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child: users[index]
                                                                              .imagePath !=
                                                                          null
                                                                      ? CachedNetworkImage(
                                                                          imageUrl:
                                                                              S3_BASE_PATH + users[index].imagePath,
                                                                          height:
                                                                              size.height * 0.1,
                                                                          width:
                                                                              size.width * 0.26,
                                                                          fit: BoxFit
                                                                              .cover,
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
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                ),
                                                              )),
                                                        ),
                                                        Expanded(
                                                            child: Container(
                                                          margin: EdgeInsets.only(
                                                              left: size.width *
                                                                  0.01),
                                                          height:
                                                              size.height * 0.2,
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
                                                                    Text(
                                                                      users[index]
                                                                          .itemName,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    Spacer(),
                                                                    Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            right:
                                                                                12),
                                                                        child: users[index].itemtype ==
                                                                                3
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
                                                                        child: Text(
                                                                            "⭐")),
                                                                    Text(
                                                                      "3.0",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color: Colors
                                                                              .red,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 45,
                                                                    ),
                                                                    Text(
                                                                      "₹ ${users[index].itemPrice}",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 20,
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
                                              alignment: Alignment.centerRight,
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
                                                        if (idCheck.contains(
                                                            users[index].id)) {
                                                          if (users[index]
                                                                  .itemCount >
                                                              1) {
                                                            setState(() {
                                                              countSum--;

                                                              sumtotal = sumtotal -
                                                                  users[index]
                                                                      .itemPrice;
                                                              totalPrice =
                                                                  totalPrice -
                                                                      users[index]
                                                                          .itemPrice;
                                                              services.decrementItemCounter(
                                                                  users[index]
                                                                      .id,
                                                                  users[index]
                                                                      .itemCount);
                                                              price = price -
                                                                  users[index]
                                                                      .itemPrice;
                                                              cart.setInt(
                                                                  'price',
                                                                  price);
                                                            });
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
                                                                          final SharedPreferences
                                                                              cart =
                                                                              await SharedPreferences.getInstance();
                                                                          price =
                                                                              cart.getInt('price');
                                                                          // Delete the item from DB etc..
                                                                          setState(
                                                                              () {
                                                                            price =
                                                                                price - users[index].itemPrice;
                                                                            countSum =
                                                                                countSum - users[index].itemCount;
                                                                            totalPrice =
                                                                                totalPrice - users[index].itemPrice;
                                                                            cart.setInt('price',
                                                                                price);
                                                                            services.deleteUser(users[index].id);
                                                                            idCheck.remove(users[index].id);
                                                                            vendorIdCheck.remove(users[index].vendorId);
                                                                            checkitem.remove(users[index].menuItemId.toString());
                                                                            print(checkitem);
                                                                            cart.setStringList('addedtocart',
                                                                                checkitem);
                                                                          });

                                                                          Navigator.pop(
                                                                              context,
                                                                              () {
                                                                            setState(() {});
                                                                          });
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          }
                                                        }
                                                      },
                                                      child:
                                                          Icon(Icons.remove)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      "${users[index].itemCount}",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                    child: Icon(Icons.add),
                                                    onTap: () async {
                                                      final SharedPreferences
                                                          cart =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      if (idCheck.contains(
                                                          users[index].id)) {
                                                        setState(() {
                                                          services
                                                              .incrementItemCounter(
                                                                  users[index]
                                                                      .id,
                                                                  users[index]
                                                                      .itemCount);
                                                          price = price +
                                                              users[index]
                                                                  .itemPrice;

                                                          countSum++;
                                                          totalPrice =
                                                              totalPrice +
                                                                  users[index]
                                                                      .itemPrice;
                                                          cart.setInt(
                                                              'price', price);
                                                        });
                                                      } else {
                                                        setState(() {
                                                          services
                                                              .incrementItemCounter(
                                                                  users[index]
                                                                      .id,
                                                                  users[index]
                                                                      .itemCount);
                                                          price = price +
                                                              users[index]
                                                                  .itemPrice;
                                                          cart.setInt(
                                                              'price', price);
                                                        });
                                                      }
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
                              } else {
                                return SizedBox();
                              }
                            });
                      }
                    }),
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
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Row(
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
                              onTap: () {
                                if (dataForOffer['OffersAndCoupons'].isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "No offer avialable..");
                                } else {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => OnOfferBottomSheet(
                                            data:
                                                dataForOffer['OffersAndCoupons']
                                                    [0],
                                          ));
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
                                "₹$totalPrice.00",
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
                                "00.00",
                                textDirection: TextDirection.rtl,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(flex: 9, child: Text("Delivery Charges")),
                          Expanded(flex: 5, child: SizedBox()),
                          Expanded(
                              flex: 3,
                              child: Text(
                                "00.00",
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
                                "$totalPrice.00",
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
                      onTap: () {
                        if (userNameWithNumber == "Select Delivery Address") {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              elevation: 2,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => SelectAddress());
                        } else {
                          if (totalPrice != 0) {
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
    );
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
                  Text("₹$totalPrice.00",
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
                    Navigator.pop(context);
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
                    Navigator.pop(context, () {
                      setState(() {});
                    });
                  },
                )
              ],
            ));
  }

  var vendorId;
  @override
  void initState() {
    getList();
    getMenuDetails();

    vendorId = vendorIdCheck[0].toString();
    print(vendorId);
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
          paymentCheck();
        } else if (paymentMode == "Wallet") {
          paymentCheck();
        }
      } else {
        setState(() {
          placeValue = placePrecent / 100;
        });
      }
    });
    super.initState();
  }

  final services = UserServices();
  String jsonTags;
  getMenuDetails() async {
    int k = idCheck.length;
    for (int i = 0; i <= k - 1; i++) {
      print("ID:-$i");
      int data = idCheck[i];
      await services.sqliteIDquery(data).then((value) => fun(value));
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
    print(
        "*********************************   idcheck length********    ${idCheck.length}");
    int k = idCheck.length;
    print("*********************************   k length********    $k");
    for (int i = 0; i <= k - 1; i++) {
      print("*********************************   for loop stated********");
      print("*********************************   i  ********    $i");
      print("ID:-$i");
      final SharedPreferences cart = await SharedPreferences.getInstance();

      int data = idCheck[i];
      await services.sqliteIDquery(data).then((value) => func(value));

      int menuPriceRemove = data2[0]['itemPrice'];
      int menuQtyRemove = data2[0]['itemCount'];
      int vendorIdRemove = data2[0]['vendorId'];
      int menuIdRemove = data2[0]['menuItemId'];

      setState(() {
        countSum = 0;
        totalPrice = 0;
        price = price - (menuQtyRemove * menuPriceRemove);
        cart.setInt('price', price);
        services.deleteUser(data);
        vendorIdCheck.remove(vendorIdRemove);
        checkitem.remove(menuIdRemove.toString());
        print(checkitem);
        cart.setStringList('addedtocart', checkitem);
      });
    }
    setState(() {
      idCheck.clear();
    });
  }

  paymentCheck() async {
    print("*****************************************");
    final prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('userId');

    _authorization = prefs.getString('sessionToken');
    _refreshtoken = prefs.getString('refreshToken');
    Map data = {
      "menuId": menuidAndQty,
      "vendorId": "$vendorId",
      "userId": "$userid",
      "addressId": addressID,
      "orderPrice": "$totalPrice.00",
      "gst": "107.82",
      "discountPrice": "50",
      "offerId": "1",
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
    } else {
      Fluttertoast.showToast(msg: "Something went Wrong");
    }
  }

  func(value) {
    setState(() {
      data2 = value;
    });
  }

  Future<void> _checkout() async {
    var options = {
      'key': 'rzp_test_7iDSklI4oMeTUd',
      'amount': num.parse(totalPrice.toString()) * 100,
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
      "vendorId": "$vendorId",
      "userId": "$userid",
      "addressId": addressID,
      "orderPrice": "$totalPrice.00",
      "gst": "107.82",
      "discountPrice": "50",
      "offerId": "1",
      "paymentMode": "ONLINE",
      "razorpay_payment_id": "$responsepaymentid",
      "razo rpay_order_id": "$responseorderid",
      "razorpay_signature": "$responsesignature"
    };
    var requestBody = jsonEncode(data);

    var response =
        await http.post(APP_ROUTES + 'itemOrder', body: requestBody, headers: {
      "authorization": _authorization,
      "refreshtoken": _refreshtoken,
      "Content-Type": "application/json"
    });

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      removeDataFromCart();
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderConfirmResturent()));
      });
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
      showDialog(
          context: context,
          child: new AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            title: new Text(
              "Payment Failed",
              style: TextStyle(
                  color: Colors.red[700], fontWeight: FontWeight.bold),
            ),
            content: new Text(
              "Something Went Wrong",
            ),
          ));
    });
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
                      Text("PAY USING ( ₹$totalPrice)"),
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
                        Navigator.pop(context, () {
                          setState(() {});
                        });
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
