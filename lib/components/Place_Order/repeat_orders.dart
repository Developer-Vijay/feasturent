import 'package:flutter/material.dart';

class RepeatOrderPage extends StatefulWidget {

  final itemData;
   const RepeatOrderPage({
    Key key,
    this.itemData
  }) : super(key: key);

  @override
  _RepeatOrderPageState createState() => _RepeatOrderPageState();
}

class _RepeatOrderPageState extends State<RepeatOrderPage> {
  @override
  void initState(){
    super.initState();
    setState(() {
          itemData1=widget.itemData;
        });
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
                              MaterialButton(
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  onPressed: () {},
                                  child: Text(
                                    "Mark as Favourite",
                                    style: TextStyle(fontSize: 12),
                                  )),
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
                                "${itemData1['menuTitle']}",
                                style: item,
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                               "${itemData1['price'].toString()} ₹",
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
                                    "Data",
                                    style: orderHeading,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Taxes",
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
                                    "${itemData1['gst'].toString()} ₹",
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
                                "${itemData1['totalPrice'].toString()} ₹",
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
                      Text(
                        "View Cart on Next Step",
                        style: TextStyle(fontSize: 10, color: Colors.red[600]),
                      )
                    ],
                  ),
                  textColor: Colors.white,
                  minWidth: size.width * 0.9,
                  color: Colors.blue,
                  onPressed: () {},
                ),
              ),
            )
          ],
        ));
  }
}
