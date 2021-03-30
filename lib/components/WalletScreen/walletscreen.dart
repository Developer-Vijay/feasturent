import 'dart:convert';

import 'package:feasturent_costomer_app/components/appDrawer.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WalletDesign extends StatefulWidget {
  var walletdata;
  final status;
  WalletDesign({this.walletdata, this.status});
  @override
  _WalletDesignState createState() => _WalletDesignState();
}

var wallet;

class _WalletDesignState extends State<WalletDesign> {
  @override
  void initState() {
    super.initState();
    // setState(() {
    //   wallet = widget.walletdata;
    // });
  }

  Future<List<dynamic>> getWalletDetaile() async {
    final prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('userId');
    String _authorization = prefs.getString('sessionToken');
    print("***************************************");
    print(_authorization);
    var result = await http.get(
        'http://18.223.208.214/api/payment/userWalletAndTransaction/$userid',
        headers: {
          "Content-type": "application/json",
          "authorization": _authorization,
        });
    var walletdetails = json.decode(result.body)['data'];
    print(walletdetails);

    return walletdetails;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var mediaheight40 = size.height * 0.04;
    var mediawidth25 = size.width * 0.06;

    var mediaheight25 = size.height * 0.034;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Wallet"),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 18,
                  child: widget.status == 1
                      ? FutureBuilder<List<dynamic>>(
                          future: getWalletDetaile(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(
                                  "################################################################################");
                              print(snapshot.data);
                              return ListView(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
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
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: mediawidth25),
                                                child: Text(
                                                  "${snapshot.data[0]['name']}",
                                                  style: walletProfileName,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: mediaheight40),
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.blue[800]
                                                      .withOpacity(0.5),
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
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  )),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.only(
                                                      left: size.width * 0.09),
                                                  child: Text(
                                                    "₹ ${snapshot.data[0]['Wallets'][0]['balance']}",
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: size.width * 0.06,
                                                      top: size.height * 0.026),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue[100],
                                                    radius: 22,
                                                    child: IconButton(
                                                      icon: Icon(
                                                          Icons.file_download),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: size.width * 0.06,
                                                      top: size.height * 0.01),
                                                  child: Text("Sent",
                                                      style: walletIconStyle),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: size.width * 0.01,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: size.height * 0.026),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue[100],
                                                    radius: 22,
                                                    child: IconButton(
                                                      icon: Icon(
                                                          Icons.request_quote),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: size.width * 0.01,
                                                      top: size.height * 0.01),
                                                  child: Text("Request",
                                                      style: walletIconStyle),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: size.width * 0.01,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: size.height * 0.03),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue[100],
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
                                                  child: Text("Loan",
                                                      style: walletIconStyle),
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
                                                    backgroundColor:
                                                        Colors.blue[100],
                                                    radius: 22,
                                                    child: IconButton(
                                                      icon: Icon(Icons
                                                          .wallet_membership),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: size.width * 0.006,
                                                      top: size.height * 0.01,
                                                      right: size.width * 0.04),
                                                  child: Text("Topup",
                                                      style: walletIconStyle),
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
                                    child: Row(
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
                                                      fontWeight:
                                                          FontWeight.w800),
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
                                  ),

                                  Container(
                                    color: Colors.grey[350].withOpacity(0.5),
                                    child: Row(
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.044,
                                              top: size.height * 0.026),
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 20),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.044,
                                              top: size.height * 0.026),
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 20),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: mediaheight40,
                                    color: Colors.grey[350].withOpacity(0.5),
                                  ),

                                  // recent
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        snapshot.data[0]['Payments'].length,
                                    itemBuilder: (context, index1) {
                                      return Container(
                                        color:
                                            Colors.grey[350].withOpacity(0.5),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: size.width * 0.044),
                                                  height: size.height * 0.064,
                                                  width: size.width * 0.12,
                                                  decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Icon(
                                                    Icons.shopping_bag_sharp,
                                                    color: Colors.white,
                                                    size: 22,
                                                  ),
                                                ),
                                                Container(
                                                  width: size.width * 0.78,
                                                  padding: EdgeInsets.only(
                                                      left: size.width * 0.044),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            child: Text(
                                                              "${snapshot.data[0]['Payments'][index1]['PaymentTransactions'][0]['transactionFor']}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            "${snapshot.data[0]['Payments'][index1]['PaymentTransactions'][0]['transactionAmount']} ₹ -",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red[400],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.005,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${snapshot.data[0]['Payments'][index1]['PaymentTransactions'][0]['transactionType']}",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Spacer(),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 41.0),
                                                            child: Text(
                                                              "${snapshot.data[0]['Payments'][index1]['PaymentTransactions'][0]['createdAt']}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * 0.03,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                ],
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          })
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("You need to login first..."),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: Text("Login"),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                color: Colors.blue[600],
                              ),
                            ],
                          ),
                        ))
            ],
          )),
    );
  }
}
