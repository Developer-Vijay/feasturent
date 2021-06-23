import 'dart:convert';
import 'package:feasturent_costomer_app/ShimmerEffects/offer_restaurant_effect.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
import 'dart:async';

import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class WalletDesign extends StatefulWidget {
  var walletdata;

  WalletDesign({
    this.walletdata,
  });
  @override
  _WalletDesignState createState() => _WalletDesignState();
}

var wallet;

class _WalletDesignState extends State<WalletDesign> {
  @override
  void initState() {
    super.initState();
    getSession();
  }

  bool status = false;
  Future<void> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      status = prefs.getBool("_isAuthenticate");
    });
  }

  // ignore: missing_return
  Future<List<dynamic>> getWalletDetaile() async {
    final prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('userId');
    String _authorization = prefs.getString('sessionToken');
    String _refreshtoken = prefs.getString('refreshToken');

    print("***************************************");
    print(_authorization);
    var result = await http.get(
        Uri.parse(PAYMENT_API + 'userWalletAndTransaction/$userid'),
        headers: {
          "Content-type": "application/json",
          "authorization": _authorization,
          "refreshtoken": _refreshtoken,
        });
    if (result.statusCode == 200) {
      var walletdetails = json.decode(result.body)['data'];
      print(walletdetails);

      return walletdetails;
    } else if (result.statusCode == 401) {
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
      print("error %%%%%%%%%%%%%%%%%% ");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                  child: status == true
                      ? FutureBuilder<List<dynamic>>(
                          future: getWalletDetaile(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(
                                  "################################################################################");
                              print(snapshot.data);

                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    height: size.height * 0.3715,
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
                                                  child: snapshot
                                                          .data[0]['Wallets']
                                                          .isEmpty
                                                      ? Text(
                                                          "₹ 00",
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )
                                                      : Text(
                                                          "₹ ${snapshot.data[0]['Wallets'][0]['balance']}",
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Spacer(),
                                            Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: size.height * 0.026),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue[100],
                                                    radius: 22,
                                                    child: InkWell(
                                                      child: Image.asset(
                                                        "assets/icons/send.png",
                                                        height: 25,
                                                        color: Colors.blue[900],
                                                      ),
                                                      onTap: () {},
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: size.height * 0.01),
                                                  child: Text("Send",
                                                      style: walletIconStyle),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: size.height * 0.026),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue[100],
                                                    radius: 22,
                                                    child: InkWell(
                                                      child: Image.asset(
                                                        "assets/icons/debit.png",
                                                        height: 25,
                                                        color: Colors.blue[900],
                                                      ),
                                                      onTap: () {},
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: size.height * 0.01),
                                                  child: Text("Debit",
                                                      style: walletIconStyle),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: size.height * 0.03),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue[100],
                                                    radius: 22,
                                                    child: InkWell(
                                                      child: Image.asset(
                                                        "assets/icons/credit.png",
                                                        height: 25,
                                                        color: Colors.blue[900],
                                                      ),
                                                      onTap: () {},
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: size.width * 0.01),
                                                  child: Text("Credit",
                                                      style: walletIconStyle),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
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
                                      ],
                                    ),
                                  ),

                                  Container(
                                    height: size.height * 0.02,
                                    color: Colors.grey[350].withOpacity(0.5),
                                  ),

                                  // recent
                                  Container(
                                    color: Colors.grey[350].withOpacity(0.5),
                                    height: size.height * 0.43,
                                    child: ListView.builder(
                                      itemCount:
                                          snapshot.data[0]['Payments'].length,
                                      itemBuilder: (context, index1) {
                                        var data2;
                                        DateTime _timed = DateTime.parse(
                                            snapshot.data[0]['Payments'][index1]
                                                    ['PaymentTransactions'][0]
                                                ['createdAt']);
                                        data2 = _timed.toLocal();
                                        data2 = DateFormat("HH:mm dd-MM-yyyy")
                                            .format(data2);

                                        return Container(
                                          color:
                                              Colors.grey[350].withOpacity(0.5),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left:
                                                            size.width * 0.044),
                                                    height: size.height * 0.064,
                                                    width: size.width * 0.12,
                                                    decoration: BoxDecoration(
                                                        color: Colors.orange,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: Icon(
                                                      Icons.shopping_bag_sharp,
                                                      color: Colors.white,
                                                      size: 22,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: size.width * 0.78,
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            size.width * 0.044),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              child: Text(
                                                                "${snapshot.data[0]['Payments'][index1]['PaymentTransactions'][0]['transactionFor']}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            Text(
                                                              "- ₹ ${snapshot.data[0]['Payments'][index1]['PaymentTransactions'][0]['transactionAmount']}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red[400],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: size.height *
                                                              0.005,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "${snapshot.data[0]['Payments'][index1]['PaymentTransactions'][0]['transactionType']}",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Spacer(),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          41.0),
                                                              child: Text(
                                                                "$data2",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        10,
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
                                    ),
                                  )
                                ],
                              );
                            } else {
                              
                              return Container(
                                margin: EdgeInsets.only(left: 5, top: 20),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[100],
                                  enabled: true,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4.0),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8.0),
                                          width: double.infinity,
                                          height: size.height * 0.2,
                                          color: Colors.white,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 7.0),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: size.height * 0.1,
                                          color: Colors.white,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15.0),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: size.height * 0.05,
                                          color: Colors.white,
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 3,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.0),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height:
                                                          size.height * 0.02,
                                                      color: Colors.white,
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.0),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height:
                                                          size.height * 0.02,
                                                      color: Colors.white,
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.0),
                                                    ),
                                                    Container(
                                                      width: 40.0,
                                                      height:
                                                          size.height * 0.02,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                ),
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
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ))
            ],
          )),
    );
  }
}
