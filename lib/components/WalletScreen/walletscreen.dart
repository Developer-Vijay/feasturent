import 'package:feasturent_costomer_app/components/appDrawer.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletDesign extends StatefulWidget {
  @override
  _WalletDesignState createState() => _WalletDesignState();
}

class _WalletDesignState extends State<WalletDesign> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var mediaheight40 = size.height * 0.04;
    var mediawidth25 = size.width * 0.06;

    var mediaheight25 = size.height * 0.034;

    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => AppDrawer()),
                  );
                },
              )),
          Expanded(
            flex: 18,
            child: ListView(
              children: [
                Container(
                  height: size.height * 0.50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: mediaheight40,
                          left: mediawidth25,
                          right: size.width * 0.811,
                        ),
                        child: Text(
                          "Wallet",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(left: mediawidth25),
                              child: Text(
                                "Nicolas Adams",
                                style: walletProfileName,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: mediaheight40),
                              child: CircleAvatar(
                                radius: 28,
                                child: Image.asset(
                                  "assets/images/avatar.png",
                                  height: size.height * 0.8,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: mediaheight25,
                      ),
                      Container(
                        height: size.height * 0.17,
                        width: size.width * 0.92,
                        decoration: BoxDecoration(
                            color: Colors.blue[800],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue[800].withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ]),
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(
                                    top: size.height * 0.038,
                                    left: size.width * 0.08),
                                child: Text(
                                  "Total Balance",
                                  style: TextStyle(fontSize: 18),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                margin:
                                    EdgeInsets.only(left: size.width * 0.09),
                                child: Text(
                                  "₹ 3,50,000",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                )),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.06,
                                    top: size.height * 0.026),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue[100],
                                  radius: 22,
                                  child: IconButton(
                                    icon: Icon(Icons.file_download),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.06,
                                    top: size.height * 0.01),
                                child: Text("Sent", style: walletIconStyle),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Column(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(top: size.height * 0.026),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue[100],
                                  radius: 22,
                                  child: IconButton(
                                    icon: Icon(Icons.request_quote),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.01,
                                    top: size.height * 0.01),
                                child: Text("Request", style: walletIconStyle),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Column(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(top: size.height * 0.03),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue[100],
                                  radius: 22,
                                  child: IconButton(
                                    icon: Icon(Icons.money),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.01,
                                    top: size.width * 0.01),
                                child: Text("Loan", style: walletIconStyle),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.007,
                                    top: size.height * 0.03,
                                    right: size.width * 0.04),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue[100],
                                  radius: 22,
                                  child: IconButton(
                                    icon: Icon(Icons.wallet_membership),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.006,
                                    top: size.height * 0.01,
                                    right: size.width * 0.04),
                                child: Text("Topup", style: walletIconStyle),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[350].withOpacity(0.5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: size.width * 0.044,
                                top: size.height * 0.02),
                            child: Text(
                              "Recent Transactions",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          Container(
                              margin: EdgeInsets.only(
                                  top: size.height * 0.024,
                                  right: size.width * 0.044),
                              child: Row(
                                children: [
                                  Text(
                                    "View all",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red[300],
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 13,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.004,
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.18,
                            height: size.height * 0.037,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white54,
                                      spreadRadius: 2,
                                      offset: Offset(0, 3),
                                      blurRadius: 6)
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.only(
                                left: size.width * 0.044,
                                top: size.height * 0.026),
                            child: Center(
                                child: Text(
                              "All",
                              style: TextStyle(
                                  color: Colors.blue[800],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Container(
                            width: size.width * 0.3,
                            height: size.height * 0.04,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white54,
                                      spreadRadius: 2,
                                      offset: Offset(0, 3),
                                      blurRadius: 6)
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.only(
                                left: size.width * 0.044,
                                top: size.height * 0.026),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Icon(
                                      Icons.monetization_on,
                                      size: 20,
                                      color: Colors.grey,
                                    )),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Income",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.3,
                            height: size.height * 0.043,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white54,
                                      spreadRadius: 2,
                                      offset: Offset(0, 3),
                                      blurRadius: 6)
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.only(
                                left: size.width * 0.044,
                                top: size.height * 0.026),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Icon(
                                      Icons.upload_sharp,
                                      size: 20,
                                      color: Colors.grey,
                                    )),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Outcome",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: mediaheight40,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: size.width * 0.044),
                            height: size.height * 0.064,
                            width: size.width * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(12)),
                            child: Icon(
                              Icons.shopping_bag_sharp,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: size.width * 0.044),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    "Salarly",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Freeslab Company",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              alignment: Alignment.topRight,
                              child: Column(
                                children: [
                                  Text(
                                    "2,00000.00 ₹ +",
                                    style: TextStyle(
                                        color: Colors.green[400],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 41.0),
                                    child: Text(
                                      "01 Nov",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            height: size.height * 0.064,
                            width: size.width * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12)),
                            child: Icon(
                              Icons.monetization_on,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Paypal",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Paymnet from John",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              alignment: Alignment.topRight,
                              child: Column(
                                children: [
                                  Text(
                                    "3,0000.00 ₹ +",
                                    style: TextStyle(
                                        color: Colors.green[400],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40.0),
                                    child: Text(
                                      "01 Nov",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            height: size.height * 0.064,
                            width: size.width * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12)),
                            child: Icon(
                              Icons.car_repair,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Car Repair",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Hyndai Car Service",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              alignment: Alignment.topRight,
                              child: Column(
                                children: [
                                  Text(
                                    "3,000.00 ₹ -",
                                    style: TextStyle(
                                        color: Colors.red[400],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Text(
                                      "01 Nov",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 21),
                            height: size.height * 0.064,
                            width: size.width * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12)),
                            child: Icon(
                              Icons.shopping_bag_sharp,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Grocery",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Max Bazar Grocery",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              alignment: Alignment.topRight,
                              child: Column(
                                children: [
                                  Text(
                                    "1,0000000.00 ₹ -",
                                    style: TextStyle(
                                        color: Colors.red[400],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 80.0),
                                    child: Text(
                                      "01 Nov",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
