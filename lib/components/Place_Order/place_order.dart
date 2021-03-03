import 'dart:async';
import 'dart:convert';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/screens/home/components/homePageBody.dart';
import 'package:feasturent_costomer_app/screens/home/home-screen.dart';
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
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // padding: EdgeInsets.only(top: 7, left: 7, right: 7),
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
                Navigator.pop(context);
              },
              child: Icon(
                Icons.clear,
              ),
            ),
          ),
          Container(
            height: size.height * 0.06,
            // color: Colors.red,
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
                  Expanded(flex: 3, child: Text("Delivery at- ")),
                  Expanded(
                    flex: 9,
                    child: Text(
                      "$addAddress",
                      overflow: TextOverflow.ellipsis,
                    ),
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
                  Text("50 mins. No line tracking"),
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
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: add2.length,
                    // ignore: missing_return
                    itemBuilder: (context, index) {
                      if (add2[index].isSelected == true) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      color: Colors.blue[50],
                                      offset: Offset(1, 4),
                                      spreadRadius: 2)
                                ]),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: size.width * 0.69,
                                        height: size.height * 0.128,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 0,
                                              child: Container(
                                                  alignment: Alignment.topLeft,
                                                  height: size.height * 0.2,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 4,
                                                        right: 4,
                                                        top: 4),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl: add2[index]
                                                            .foodImage,
                                                        height:
                                                            size.height * 0.09,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            Expanded(
                                                child: Container(
                                              margin: EdgeInsets.only(
                                                  left: size.width * 0.01),
                                              height: size.height * 0.2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: 6,
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          add2[index].title,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                        ),
                                                        Spacer(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 12),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                add2[index]
                                                                    .vegsymbol,
                                                            height:
                                                                size.height *
                                                                    0.013,
                                                          ),
                                                        )
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
                                                          child: add2[index]
                                                              .starRating,
                                                        ),
                                                        Text(
                                                          "3.0",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 50,
                                                        ),
                                                        Text(
                                                          "₹ ${add2[index].foodPrice}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                  padding: EdgeInsets.only(right: 0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 2,
                                          spreadRadius: 2,
                                          color: Colors.grey[300],
                                          offset: Offset(0, 3))
                                    ],
                                  ),
                                  margin:
                                      EdgeInsets.only(right: size.width * 0.0),
                                  child: ButtonBar(
                                    buttonPadding: EdgeInsets.all(3),
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            if (add2[index].counter > 1) {
                                              setState(() {
                                                countSum--;
                                                add2[index].counter--;
                                                sumtotal = sumtotal -
                                                    add2[index].foodPrice;
                                                totalPrice = totalPrice -
                                                    add2[index].foodPrice;
                                              });

                                              print("Decrease");
                                            } else if (add2[index].counter ==
                                                1) {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          "Are you sure you want to delete ${add2[index].title}?"),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        FlatButton(
                                                          child: Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          onPressed: () {
                                                            // TODO: Delete the item from DB etc..
                                                            setState(() {
                                                              countSum = countSum -
                                                                  add2[index]
                                                                      .counter;
                                                              totalPrice =
                                                                  totalPrice -
                                                                      add2[index]
                                                                          .foodPrice;

                                                              insideOfferPage[
                                                                          index]
                                                                      .addedStatus =
                                                                  "Add";
                                                              sumtotal = sumtotal -
                                                                  add2[index]
                                                                      .foodPrice;
                                                              add2.removeAt(
                                                                  index);

                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            }
                                          },
                                          child: Icon(Icons.remove)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("${add2[index].counter}",
                                          style:
                                              TextStyle(color: Colors.black)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        child: Icon(Icons.add),
                                        onTap: () {
                                          if (add2[index].isSelected == true) {
                                            setState(() {
                                              countSum++;

                                              add2[index].counter++;

                                              sumtotal = sumtotal +
                                                  add2[index].foodPrice;
                                              totalPrice = totalPrice +
                                                  add2[index].foodPrice;
                                            });
                                          } else {
                                            setState(() {
                                              add2[index].counter++;

                                              sumtotal = sumtotal +
                                                  add2[index].foodPrice;
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
                        );
                      } else {
                        return SizedBox();
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
                            ),
                            Text("Select a promo code"),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg: "checking the best offers");
                              },
                              child: Text(
                                "View offers",
                                style: TextStyle(color: Colors.red),
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
                                    fontSize: size.height * 0.0275),
                              )),
                          Expanded(flex: 5, child: SizedBox()),
                          Expanded(
                              flex: 3,
                              child: Text(
                                "$totalPrice.00",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.0275),
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
                            PopupMenuButton(
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
                              ],
                            ),
                          ],
                        ),
                        Text(paymentMode),
                      ],
                    ),
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        print("Order placed ");
                        if (userNameWithNumber == "Select Delivery Address") {
                          showModalBottomSheet(
                              isScrollControlled: true,
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
          height: size.height * 0.1,
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
                    placeTimer.cancel();
                    placePrecent = 0;
                    placeValue = 0;
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    placeTimer = Timer.periodic(Duration(milliseconds: 100), (_) {
      print('Percent Update');
      setState(() {
        placePrecent++;
      });
      if (placePrecent >= 100) {
        placeTimer.cancel();
        placePrecent = 0;
        placeValue = 1;

        print(add2.length);
        int k = add2.length - 1;
        print(add2);

        for (int i = 0; i <= k; i++) {
          print(i);
          print("new item ${add2[i].title}");
          print(add2[i].isSelected);

          if (add2[i].isSelected == true) {
            print("remove from cart ${add2[i].title}");
          } else {
            print("item not selected  ${add2[i].title}");
          }
        }
        // API hit will be from here
        if (paymentMode == "Online Mode") {
          _checkout();
        } else if (paymentMode == "Cash On Delivery")
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OrderConfirmResturent()));
      } else {
        setState(() {
          placeValue = placePrecent / 100;
        });
      }
    });

    super.initState();
  }

  Future<void> _checkout() async {
    var options = {
      'key': 'rzp_test_7iDSklI4oMeTUd',
      'amount': num.parse(totalPrice.toString()) * 100,
      'name': 'Adams',
      'description': 'Tasty',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "Congrats payment Succesffully Paid");
    final prefs = await SharedPreferences.getInstance();
    _authorization = prefs.getString('sessionToken');
    _refreshtoken = prefs.getString('refreshToken');
    print(_authorization);
    var response = await http.post(APP_ROUTES + 'itemOrder', body: {
      "menuId": "1",
      "vendorId": "1",
      "userId": "1",
      "price": "300",
      "discountPrice": "40",
      "offerId": "1",
      "paymentMode": "CASH"
    }, headers: {
      "authorization": _authorization,
      "refreshtoken": _refreshtoken
    });

    var responseData = jsonDecode(response.body);

    print(responseData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("succes");
      print(responseData);
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        showDialog(
            context: context,
            child: new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
              title: new Text(
                "Payment Successfull",
                style: TextStyle(
                    color: Colors.green[700], fontWeight: FontWeight.w600),
              ),
              content: new Text(
                "Order has been  Placed Successfully",
              ),
            ));
        // add2.clear();
      });
    } else {
      print("error");
      print(responseData);
      Fluttertoast.showToast(msg: "Something went Wrong");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
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
                        fontSize: size.height * 0.025,
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
                      Text("PAY USING"),
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
                  width: 255,
                  child: LiquidLinearProgressIndicator(
                    value: placeValue,
                    valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                    backgroundColor: Colors.grey[200],
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
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
