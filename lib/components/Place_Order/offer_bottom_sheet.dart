import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class OfferForPlaceOrder extends StatefulWidget {
  final data;
  const OfferForPlaceOrder({Key key, this.data}) : super(key: key);
  @override
  _OfferForPlaceOrderState createState() => _OfferForPlaceOrderState();
}

class _OfferForPlaceOrderState extends State<OfferForPlaceOrder> {
  @override
  void initState() {
    super.initState();
    setState(() {
      offerData = widget.data;
    });
  }

  var offerData;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, 0);
      },
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          height: size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: size.height * 0.022, left: size.width * 0.03),
                        child: Text(
                          "Available offers",
                          style: offerRecommendStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.height * 0.022, left: size.width * 0.03),
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context, 0);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 2,
                thickness: 2,
              ),
              Expanded(
                flex: 18,
                child: ListView.builder(
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
                        if (offerData[index]['discountType'] == "PERCENT") {
                          symbol = "%";
                        } else {
                          symbol = "₹";
                        }

                        couponDetatil =
                            "${offerData[index]['discount']}$symbol off";
                      }

                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 6, top: 10),
                                  padding: EdgeInsets.all(2),
                                  child: Text(
                                    "${offerData[index]['title']}",
                                    style: offerSheetStyle,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(
                                        context, offerData[index]['id']);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      "Apply",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Offer :$couponDetatil",
                                style: offerSheetStyle,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: offerData[index]['description'] != null
                                    ? Text(
                                        offerData[index]['description'],
                                        style: offerCommonStyle,
                                      )
                                    : SizedBox()),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin:
                                    EdgeInsets.only(left: size.width * 0.03),
                                child: Text(
                                  "Terms and Conditions",
                                  style: offerRowHeadingStyle,
                                )),
                            SizedBox(
                              height: size.height * 0.034,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                        left: size.width * 0.01),
                                    child: Text(
                                      " offer Valid ${offerData[index]['perUserValidity']} per user ",
                                      style: TextStyle(color: kTextColor),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                        left: size.width * 0.01),
                                    child: Text(
                                      " The maximum discount is upto 400",
                                      style: TextStyle(color: kTextColor),
                                    )),
                              ],
                            ),
                            offerData[index]['coupon'] == null
                                ? SizedBox()
                                : SizedBox(
                                    height: size.height * 0.02,
                                  ),
                            offerData[index]['coupon'] == null
                                ? SizedBox()
                                : Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                      ),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.01),
                                          child: Text(
                                            "Coupon Code : ${offerData[index]['coupon']}",
                                            style: TextStyle(color: kTextColor),
                                          )),
                                    ],
                                  ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                        left: size.width * 0.01),
                                    child: Text(
                                      " offer valid on minimum card value",
                                      style: TextStyle(color: kTextColor),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                        left: size.width * 0.01),
                                    child: Text(
                                      " offer valid till ${offerData[index]['couponValidity']}",
                                      style: TextStyle(color: kTextColor),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          )),
    );
  }
}
