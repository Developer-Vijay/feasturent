import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:feasturent_costomer_app/components/Place_Order/order_confirm.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class RepeatOrderPage extends StatefulWidget {
  final itemData;
  const RepeatOrderPage({Key key, this.itemData}) : super(key: key);

  @override
  _RepeatOrderPageState createState() => _RepeatOrderPageState();
}

class _RepeatOrderPageState extends State<RepeatOrderPage> {
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
    final prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('userId');
    _authorization = prefs.getString('sessionToken');
    _refreshtoken = prefs.getString('refreshToken');
    var response = await http.post(APP_ROUTES + 'itemOrder', body: {
      "menuId": "1",
      "vendorId": "1",
      "userId": "$userid",
      "price": "${itemData1['orderMenues'][0]['Menu']['price']}",
      "discountPrice": "00",
      "offerId": "1",
      "razorpay_payment_id": "$responsepaymentid",
      "razorpay_order_id": "$responseorderid",
      "razorpay_signature": "$responsesignature",
      "paymentMode": "Online"
    }, headers: {
      "authorization": _authorization,
      "refreshtoken": _refreshtoken
    });

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderConfirmResturent()));
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
    var options = {
      'key': 'rzp_test_7iDSklI4oMeTUd',
      'amount': num.parse(
              itemData1['orderMenues'][0]['Menu']['totalPrice'].toString()) *
          100,
      'name': "Vijay",
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
    final orderHeading = TextStyle(fontWeight: FontWeight.w600);
    final item = TextStyle(color: Colors.black, fontWeight: FontWeight.w600);
    final itemPrice =
        TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
    return Scaffold(
        appBar: AppBar(
          actions: [
            FlatButton(
              child: Text(
                "Support",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            )
          ],
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
                      Divider(),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${itemData1['orderMenues'][0]['Menu']['title']}",
                                style: item,
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${itemData1['orderMenues'][0]['Menu']['price']} ₹",
                                style: itemPrice,
                                textDirection: TextDirection.rtl,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Item Name2",
                                style: item,
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Item Quantity Price",
                                style: itemPrice,
                                textDirection: TextDirection.rtl,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Item Total",
                                    style: item,
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${itemData1['orderMenues'][0]['Menu']['price']} ₹",
                                    style: itemPrice,
                                    textDirection: TextDirection.rtl,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "gst",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 8.0, top: 8),
                                  child: Text(
                                    "${itemData1['orderMenues'][0]['Menu']['gstAmount'].toString()} ₹",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Deleivery Charge",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 8.0, top: 8),
                                  child: Text(
                                    "0 ₹",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Grand Total",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${itemData1['orderMenues'][0]['Menu']['totalPrice']} ₹",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                          "${itemData1['orderId'].toString()}",
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
                          "Date",
                          style: orderHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "${itemData1['orderDate'].toString()}",
                          style: orderdetails,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Phone Number",
                          style: orderHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "${itemData1['customerPhone'].toString()}",
                          style: orderdetails,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Deliver to",
                          style: orderHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Address",
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
              child: Expanded(
                flex: 1,
                child: MaterialButton(
                  height: size.height * 0.07,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    children: [
                      Text(
                        "Repeat Order",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  textColor: Colors.white,
                  minWidth: size.width * 0.9,
                  color: Colors.blue,
                  onPressed: () {
                    checkout();
                  },
                ),
              ),
            )
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
