import 'dart:convert';
import 'package:feasturent_costomer_app/components/Bottomsheet/addRatingBottom.dart';
import 'package:feasturent_costomer_app/notificationsfiles.dart';
import 'package:http/http.dart' as http;
import 'package:feasturent_costomer_app/components/Place_Order/order_confirm.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    setState(() {
      itemData1 = widget.itemData;
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse responsed) async {
    var responsepaymentid = responsed.paymentId;
    var responseorderid = responsed.orderId;
    var responsesignature = responsed.signature;
    var orderprice;
    orderprice = itemData1['orderMenues'][0]['Menu']['price'];
    final prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('userId');
    _authorization = prefs.getString('sessionToken');
    _refreshtoken = prefs.getString('refreshToken');
    var response = await http.post(APP_ROUTES + 'itemOrder', body: {
      "menuId": "1",
      "vendorId": "1",
      "userId": "$userid",
      "orderPrice": "${itemData1['orderMenues'][0]['Menu']['price']}",
      "discountPrice": "00",
      "offerId": "1",
      "razorpay_payment_id": "$responsepaymentid",
      "razorpay_order_id": "$responseorderid",
      "razorpay_signature": "$responsesignature",
      "paymentMode": "Online"
    }, headers: {
      "authorization": _authorization,
      "refreshToken": _refreshtoken
    });

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderConfirmResturent()));
        notifications.scheduleNotification("Rezorpay",
            "Payment of  ₹ ${orderprice.toString()} is Successfully Paid");
      });
    } else {
      Fluttertoast.showToast(msg: responseData['message']);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      Navigator.pop(context, RepeatOrderPage());
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

  Future<void> _checkout() async {
    final prefs = await SharedPreferences.getInstance();
    var phone = prefs.getString('userNumber');
    var email = prefs.getString('userEmail');
    var name = prefs.getString('name');
    var options = {
      'key': 'rzp_test_7iDSklI4oMeTUd',
      'amount': num.parse(
              itemData1['orderMenues'][0]['Menu']['totalPrice'].toString()) *
          100,
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
          title: Text("Order Details"),
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
                      Divider(
                        color: Colors.black45,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                        itemCount: itemData1['orderMenues'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          DateTime _timed =
                              DateTime.parse(itemData1['createdAt']);
                          var data1 = _timed.toLocal();
                          return Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${itemData1['orderMenues'][index]['Menu']['title']}",
                                            style: item,
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${itemData1['orderMenues'][index]['Menu']['price']} ₹",
                                            style: itemPrice,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.black45,
                                      thickness: 1,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            "Quantity",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0, top: 8),
                                          child: Text(
                                            "${itemData1['orderMenues'][index]['quantity']} ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            "gst",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0, top: 8),
                                          child: Text(
                                            "${itemData1['orderMenues'][index]['Menu']['gstAmount'].toString()} ₹",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            "Total",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0, top: 8),
                                          child: Text(
                                            " ${itemData1['orderMenues'][index]['quantity']} ₹ ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black45,
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          );
                        },
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
                                "${itemData1['orderPrice']} ₹",
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
                          "order Number",
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
                                                checkout();
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

  void checkout() async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Repeat Orders"),
              actions: [
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () {
                    _checkout();
                  },
                ),
                FlatButton(
                  child: Text("No"),
                  onPressed: () {},
                )
              ],
            ));
  }
}
