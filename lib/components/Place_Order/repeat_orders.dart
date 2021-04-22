import 'dart:async';
import 'dart:convert';
import 'package:feasturent_costomer_app/components/Bottomsheet/addRatingBottom.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/Place_Order/place_order.dart';
import 'package:feasturent_costomer_app/components/Place_Order/select_address.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/notificationsfiles.dart';
import 'package:http/http.dart' as http;
import 'package:feasturent_costomer_app/components/Place_Order/order_confirm.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';

class RepeatOrderPage extends StatefulWidget {
  final itemData;
  final data;
  const RepeatOrderPage({Key key, this.itemData, this.data}) : super(key: key);

  @override
  _RepeatOrderPageState createState() => _RepeatOrderPageState();
}

class _RepeatOrderPageState extends State<RepeatOrderPage> {
  Notifications notifications = Notifications();
  Razorpay _razorpay;
  String _authorization = '';
  String _refreshtoken = '';
  @override
  void initState() {
    super.initState();
    // _razorpay = Razorpay();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    setState(() {
      itemData1 = widget.itemData;
    });
  }

  // void _handlePaymentSuccess(PaymentSuccessResponse responsed) async {
  //   var responsepaymentid = responsed.paymentId;
  //   var responseorderid = responsed.orderId;
  //   var responsesignature = responsed.signature;
  //   var orderprice;
  //   orderprice = itemData1['orderMenues'][0]['Menu']['price'];
  //   final prefs = await SharedPreferences.getInstance();
  //   var userid = prefs.getInt('userId');
  //   _authorization = prefs.getString('sessionToken');
  //   _refreshtoken = prefs.getString('refreshToken');
  //   var response = await http.post(APP_ROUTES + 'itemOrder', body: {
  //     "menuId": "1",
  //     "vendorId": "1",
  //     "userId": "$userid",
  //     "orderPrice": "${itemData1['orderMenues'][0]['Menu']['price']}",
  //     "discountPrice": "00",
  //     "offerId": "1",
  //     "razorpay_payment_id": "$responsepaymentid",
  //     "razorpay_order_id": "$responseorderid",
  //     "razorpay_signature": "$responsesignature",
  //     "paymentMode": "Online"
  //   }, headers: {
  //     "authorization": _authorization,
  //     "refreshToken": _refreshtoken
  //   });

  //   var responseData = jsonDecode(response.body);

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => OrderConfirmResturent()));
  //       notifications.scheduleNotification("Rezorpay",
  //           "Payment of  ₹ ${orderprice.toString()} is Successfully Paid");
  //     });
  //   } else {
  //     Fluttertoast.showToast(msg: responseData['message']);
  //   }
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   setState(() {
  //     Navigator.pop(context, RepeatOrderPage());
  //     showDialog(
  //         context: context,
  //         child: new AlertDialog(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  //           title: new Text(
  //             "Payment Failed",
  //             style: TextStyle(
  //                 color: Colors.red[700], fontWeight: FontWeight.bold),
  //           ),
  //           content: new Text(
  //             "Something Went Wrong",
  //           ),
  //         ));
  //   });
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   Fluttertoast.showToast(
  //       msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => OrderConfirmResturent()));
  // }

  var itemData1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orderdetails =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w400);
    final orderHeading =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w600);
    final item = TextStyle(color: Colors.black, fontWeight: FontWeight.w600);
    final itemPrice =
        TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
    return Scaffold(
        appBar: AppBar(
          title: Text("Order Summary"),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 15,
              child: ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text(
                                "Your Order",
                                style: TextStyle(color: Colors.black),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                        itemCount: itemData1['orderMenues'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // DateTime _timed =
                          //     DateTime.parse(itemData1['createdAt']);
                          // var data1 = _timed.toLocal();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                color: Colors.black38,
                                thickness: 0.8,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${itemData1['orderMenues'][index]['Menu']['title']}",
                                        style: item,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                color: Colors.grey[400]),
                                            padding: EdgeInsets.only(
                                                top: 2,
                                                left: 2,
                                                right: 5,
                                                bottom: 2),
                                            margin: EdgeInsets.only(top: 8),
                                            child: Text(
                                              "${itemData1['orderMenues'][index]['quantity']} ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ),
                                          Text(" * ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.grey[400],
                                                  fontWeight: FontWeight.w600)),
                                          Text(
                                              "₹ ${itemData1['orderMenues'][index]['Menu']['price']}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey[400],
                                                  fontWeight: FontWeight.w600)),
                                          Spacer(),
                                          Text(
                                              "₹ ${(itemData1['orderMenues'][index]['Menu']['price'] * itemData1['orderMenues'][index]['quantity'])}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "GST added",
                                            style: item,
                                          ),
                                          Spacer(),
                                          Text(
                                              "₹ ${(itemData1['orderMenues'][index]['Menu']['gstAmount'] * itemData1['orderMenues'][index]['quantity'])}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      )
                                    ]),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          );
                        },
                      ),
                      Divider(
                        color: Colors.black38,
                        thickness: 0.8,
                      ),
                      itemData1['donation'] == 0
                          ? SizedBox()
                          : Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Donation",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${itemData1['donation']} ₹ +",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  )
                                ],
                              ),
                            ),
                      itemData1['discountPrice'] == 0
                          ? SizedBox()
                          : Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Discount Price",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${itemData1['discountPrice']} ₹ -",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  )
                                ],
                              ),
                            ),
                      Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Grand Total",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${(itemData1['orderPrice'] - itemData1['discountPrice'] + itemData1['donation'])} ₹",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textDirection: TextDirection.rtl,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Order Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Order Number",
                          style: orderHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "${itemData1['id'].toString()}",
                          style: orderdetails,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Resturent Name",
                          style: orderHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Not available",
                          style: orderdetails,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Payment",
                          style: orderHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "${itemData1['paymentMode'].toString()}",
                          style: orderdetails,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Date and Time",
                          style: orderHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "${widget.data}",
                          style: orderdetails,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Delivered to",
                          style: orderHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          itemData1['OrderAddress']['address'],
                          style: orderdetails,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: itemData1['orderStatus'] != "PENDING"
                    ? Container(
                        child: itemData1['orderStatus'] != "CANCELED"
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: itemData1['orderStatus'] ==
                                              "DELIVERED"
                                          ? OutlineButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14)),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Repeat Order",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              textColor: Colors.blue,
                                              borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 2),
                                              onPressed: () {
                                                if (itemData1[
                                                        'discountPrice'] !=
                                                    0) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Discount will not add in total amount");
                                                }
                                                showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) =>
                                                        BottomRepeatSheet(
                                                          data: itemData1,
                                                        ));
                                              },
                                            )
                                          : SizedBox()),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        child: itemData1['orderStatus'] ==
                                                "DELIVERED"
                                            ? OutlineButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                textColor: Colors.blue,
                                                borderSide: BorderSide(
                                                    color: Colors.amber,
                                                    width: 2),
                                                child: Text("Give Rating"),
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      enableDrag: true,
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (context) => Container(
                                                          height:
                                                              size.height * 0.8,
                                                          child: AddRatingPage(
                                                              data:
                                                                  itemData1)));
                                                },
                                              )
                                            : SizedBox()),
                                  )
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(
                                    "Order is Cancelled",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            "IN PROGRESS",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ))
          ],
        ));
  }
}

class BottomRepeatSheet extends StatefulWidget {
  final data;
  const BottomRepeatSheet({Key key, this.data}) : super(key: key);
  @override
  _BottomRepeatSheetState createState() => _BottomRepeatSheetState();
}

class _BottomRepeatSheetState extends State<BottomRepeatSheet> {
  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  var data;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      height: size.height * 0.15,
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
                    null == null
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
                        : null == true
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
              onTap: () async {
                if (userNameWithNumber == "Select Delivery Address") {
                  final result = await showModalBottomSheet(
                      isScrollControlled: true,
                      elevation: 2,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => SelectAddress());
                  if (result) {
                    setState(() {});
                  }
                } else {
                  showModalBottomSheet(
                      enableDrag: false,
                      isDismissible: false,
                      isScrollControlled: false,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => RepeatOrderCheck(
                            dataPart: data,
                          ));
                }
              },
              child: checkAddress(size))
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
                  Text("₹${(data['orderPrice'] + data['donation'])}.00",
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

class RepeatOrderCheck extends StatefulWidget {
  final dataPart;
  const RepeatOrderCheck({Key key, this.dataPart}) : super(key: key);
  @override
  _RepeatOrderCheckState createState() => _RepeatOrderCheckState();
}

class _RepeatOrderCheckState extends State<RepeatOrderCheck> {
  Razorpay _razorpay;
  String _authorization = '';
  String _refreshtoken = '';

  var emailid;
  var userid;
  var usernamed;
  var phonenumber;

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

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

  var itemData1;

  @override
  void initState() {
    itemData1 = widget.dataPart;
    getMenuDetails();

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

  String jsonTags;
  getMenuDetails() async {
    int k = itemData1['orderMenues'].length;
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ $k");
    for (int i = 0; i <= k - 1; i++) {
      print("ID:-$i");
      // int data = idCheck[i];
      // await services.sqliteIDquery(data).then((value) => fun(value));
      String menuName = itemData1['orderMenues'][i]['Menu']['title'];

      int menuID = itemData1['orderMenues'][i]['Menu']['id'];
      int menuQty = itemData1['orderMenues'][i]['quantity'];
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

  List<MenuData> menuidAndQty = [];

  walletPayment() async {
    print("*****************************************");
    final prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('userId');

    _authorization = prefs.getString('sessionToken');
    _refreshtoken = prefs.getString('refreshToken');
    Map data = {
      "menuId": menuidAndQty,
      "vendorId": "${itemData1['vendorId']}",
      "userId": "$userid",
      "addressId": addressID,
      "orderPrice": "${itemData1['orderPrice']}.00",
      "gst": "${itemData1['gst']}",
      "discountPrice": "0",
      "offerId": "0",
      "donation": "${itemData1['donation']}",
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
      "vendorId": "${itemData1['vendorId']}",
      "userId": "$userid",
      "addressId": addressID,
      "orderPrice": "${itemData1['orderPrice']}.00",
      "gst": "${itemData1['gst']}",
      "discountPrice": "0",
      "offerId": "0",
      "donation": "${itemData1['donation']}",
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

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
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

  Future<void> _checkout() async {
    final prefs = await SharedPreferences.getInstance();
    var phone = prefs.getString('userNumber');
    var email = prefs.getString('userEmail');
    var name = prefs.getString('name');
    var price = (itemData1['orderPrice'] + itemData1['donation']);
    var options = {
      'key': 'rzp_test_7iDSklI4oMeTUd',
      'amount': num.parse(price.toString()) * 100,
      'name': "$name",
      'description': 'Tasty',
      'prefill': {'contact': "$phone", 'email': "$email"}
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
      "vendorId": "${itemData1['vendorId']}",
      "userId": "$userid",
      "addressId": addressID,
      "orderPrice": "${itemData1['orderPrice']}.00",
      "gst": "${itemData1['gst']}",
      "discountPrice": "0",
      "offerId": "0",
      "donation": "${itemData1['donation']}",
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

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
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
                          "PAY USING ( ₹${(itemData1['orderPrice'] + itemData1['donation'])}.00)"),
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
