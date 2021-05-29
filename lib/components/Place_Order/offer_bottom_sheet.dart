import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/components/Place_Order/place_order.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class OfferForPlaceOrder extends StatefulWidget {
  final userid;
  final data;
  const OfferForPlaceOrder({Key key, this.data, this.userid}) : super(key: key);
  @override
  _OfferForPlaceOrderState createState() => _OfferForPlaceOrderState();
}

class _OfferForPlaceOrderState extends State<OfferForPlaceOrder> {
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      offerData = widget.data;
    });
  }

  int check = 1;
  var error;
  var offerData;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pop(context, 0);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                height: size.height * 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.height * 0.022,
                                  left: size.width * 0.03),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.pop(context, 0);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.height * 0.022,
                                  left: size.width * 0.03),
                              child: Text(
                                "Apply offers",
                                style: offerRecommendStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 2,
                      thickness: 2,
                    ),
                    Container(
                      height: size.height * 0.1,
                      child: Center(
                          child: Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: TextField(
                                  controller: controller,
                                  inputFormatters: [
                                    UpperCaseTextFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                      errorText: error,
                                      hintText: "Enter promo code",
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 5)),
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.only(right: 7),
                            child: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  controller.clear();
                                }),
                          ),
                          FlatButton(
                              color: Colors.green,
                              onPressed: () async {
                                if (controller.text.isEmpty) {
                                  setState(() {
                                    error = "please enter promocode";
                                  });
                                } else {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (_) => new AlertDialog(
                                              content: Row(
                                            children: [
                                              CircularProgressIndicator(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Text("Loading"),
                                              ),
                                            ],
                                          )));
                                  print(controller.text);
                                  print(widget.userid);
                                  final prefs =
                                      await SharedPreferences.getInstance();

                                  String _authorization =
                                      prefs.getString('sessionToken');
                                  String _refreshtoken =
                                      prefs.getString('refreshToken');
                                  var response = await http.get(
                                      APP_ROUTES +
                                          'checkApplyOffer' +
                                          '?userId=${widget.userid}&coupon=${controller.text}',
                                      headers: {
                                        "authorization": _authorization,
                                        "refreshtoken": _refreshtoken,
                                      });
                                  print(response.statusCode);
                                  if (response.statusCode == 200) {
                                    print("Promocode Apply");
                                    var responsData =
                                        jsonDecode(response.body)['data'];

                                    setState(() {
                                      error = null;
                                      offerInfo =
                                          "Promo code used ${controller.text}";
                                    });
                                    print(
                                        "offerId  === ${responsData[0]['id']}");
                                    Navigator.pop(context);
                                    Navigator.pop(
                                        context, responsData[0]['id']);
                                  } else {
                                    Navigator.pop(context);

                                    setState(() {
                                      error = "Invalid promo code";
                                    });
                                  }
                                }
                              },
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              )),
                          SizedBox(
                            width: 15,
                          )
                        ],
                      )),
                    ),
                    Divider(
                      height: 2,
                      thickness: 2,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 8, bottom: 10),
                      child: Text("Available offers for you",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black,
                          )),
                    ),
                    Expanded(
                      flex: 20,
                      child: Container(
                        color: Colors.blue[50],
                        child: ListView.builder(
                            padding: EdgeInsets.all(5),
                            itemCount: offerData.length,
                            itemBuilder: (context, index) {
                              var couponDetatil;

                              if (offerData[index]['discount'] == null) {
                                String symbol;
                                if (offerData[index]['couponDiscountType'] ==
                                    "PERCENT") {
                                  symbol = "%";
                                } else {
                                  symbol = "₹";
                                }

                                couponDetatil =
                                    "${offerData[index]['couponDiscount']}$symbol off";
                              } else {
                                String symbol;
                                if (offerData[index]['discountType'] ==
                                    "PERCENT") {
                                  symbol = "%";
                                } else {
                                  symbol = "₹";
                                }

                                couponDetatil =
                                    "${offerData[index]['discount']}$symbol off";
                              }

                              return Container(
                                color: Colors.blue[50],
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Card(
                                        elevation: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 6, top: 10),
                                                  padding: EdgeInsets.all(2),
                                                  child: Text(
                                                    capitalize(
                                                        "${offerData[index]['title']}"),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    offerInfo =
                                                        "$couponDetatil ${offerData[index]['title']}";
                                                    Navigator.pop(context,
                                                        offerData[index]['id']);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      "Apply",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            offerData[index]['coupon'] == null
                                                ? SizedBox()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: DottedBorder(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Text(
                                                        offerData[index]
                                                            ['coupon'],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 17),
                                                      ),
                                                    )),
                                                  ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Offer :$couponDetatil",
                                                style: offerSheetStyle,
                                              ),
                                            ),
                                            Container(
                                              width: size.width * 0.95,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: offerData[index][
                                                                'description'] !=
                                                            ''
                                                        ? Container(
                                                            width: size.width *
                                                                0.65,
                                                            child: Text(
                                                              "${offerData[index]['description']}...",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  offerCommonStyle,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (check == index) {
                                                        setState(() {
                                                          check = null;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          check = index;
                                                        });
                                                      }
                                                    },
                                                    child: check == index
                                                        ? Text(
                                                            "View less",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .blue),
                                                          )
                                                        : Text(
                                                            "View Detail",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            check == index
                                                ? Column(children: [
                                                    Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        margin: EdgeInsets.only(
                                                            left: size.width *
                                                                0.03),
                                                        child: Text(
                                                          "Terms and Conditions",
                                                          style:
                                                              offerRowHeadingStyle,
                                                        )),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.034,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8),
                                                          child: Icon(
                                                            Icons.check_circle,
                                                            color: Colors.blue,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            margin: EdgeInsets.only(
                                                                left:
                                                                    size.width *
                                                                        0.01),
                                                            child: Text(
                                                              " offer Valid ${offerData[index]['perUserValidity']} per user ",
                                                              style: TextStyle(
                                                                  color:
                                                                      kTextColor),
                                                            )),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8),
                                                          child: Icon(
                                                            Icons.check_circle,
                                                            color: Colors.blue,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            margin: EdgeInsets.only(
                                                                left:
                                                                    size.width *
                                                                        0.01),
                                                            child: Text(
                                                              " The maximum discount is upto 400",
                                                              style: TextStyle(
                                                                  color:
                                                                      kTextColor),
                                                            )),
                                                      ],
                                                    ),
                                                    offerData[index]
                                                                ['coupon'] ==
                                                            null
                                                        ? SizedBox()
                                                        : SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.02,
                                                          ),
                                                    offerData[index]
                                                                ['coupon'] ==
                                                            null
                                                        ? SizedBox()
                                                        : Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8),
                                                                child: Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 20,
                                                                ),
                                                              ),
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  margin: EdgeInsets.only(
                                                                      left: size
                                                                              .width *
                                                                          0.01),
                                                                  child: Text(
                                                                    "Coupon Code : ${offerData[index]['coupon']}",
                                                                    style: TextStyle(
                                                                        color:
                                                                            kTextColor),
                                                                  )),
                                                            ],
                                                          ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8),
                                                          child: Icon(
                                                            Icons.check_circle,
                                                            color: Colors.blue,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            margin: EdgeInsets.only(
                                                                left:
                                                                    size.width *
                                                                        0.01),
                                                            child: Text(
                                                              " offer valid on minimum card value",
                                                              style: TextStyle(
                                                                  color:
                                                                      kTextColor),
                                                            )),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8),
                                                          child: Icon(
                                                            Icons.check_circle,
                                                            color: Colors.blue,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            margin: EdgeInsets.only(
                                                                left:
                                                                    size.width *
                                                                        0.01),
                                                            child: Text(
                                                              " offer valid till ${offerData[index]['couponValidity']}",
                                                              style: TextStyle(
                                                                  color:
                                                                      kTextColor),
                                                            )),
                                                      ],
                                                    ),
                                                  ])
                                                : SizedBox(),
                                            SizedBox(
                                              height: size.height * 0.02,
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 2.5,
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
