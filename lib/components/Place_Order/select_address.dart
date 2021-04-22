import 'dart:convert';
import 'package:feasturent_costomer_app/components/AddressBook/addAddress.dart';
import 'package:feasturent_costomer_app/components/Place_Order/add_address.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectAddress extends StatefulWidget {
  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  final textstyle = TextStyle(color: Colors.black, fontSize: 16);
  var userid;
  var userid2;
  var addressid;
  var addressdata;
  String _authorization;
  int ordersData;
  // var total = 0;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> refreshList() async {
    refreshKey.currentState.show();
    callingLoader();
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      getAddress();
    });
    Navigator.pop(context);
    return null;
  }

  callingLoader() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
                content: Row(
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text("Loading"),
                ),
              ],
            )));
  }

  @override
  void initState() {
    getAddresslength();
    super.initState();
  }

  Future deleteAddress(index, String id) async {
    final prefs = await SharedPreferences.getInstance();
    addressid = id;

    userid2 = prefs.getInt('userId');
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  delete orderaddress");
    _authorization = prefs.getString('sessionToken');
    String _refreshtoken = prefs.getString('refreshToken');

    var response =
        await http.delete(USER_API + 'deleteOrderAdress/$addressid', headers: {
      "Content-type": "application/json",
      "authorization": _authorization,
      "refreshtoken": _refreshtoken,
    });
    if (response.statusCode == 200) {
      refreshList();
      Fluttertoast.showToast(msg: "Address deleted sucessfully");
      print(response.body);

      return response.body;
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
      var data = json.decode(response.body)['data'];

      print(data);
      Fluttertoast.showToast(msg: "Unable to delete");
    }
  }

  getAddresslength() async {
    final prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userId');
    _authorization = prefs.getString('sessionToken');
    String _refreshtoken = prefs.getString('refreshToken');

    print(userid);
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  getorderaddress");
    var response = await http.get(
        USER_API + 'getOrderAddress' + '?key=BYUSERID&id=$userid',
        headers: {
          "Content-type": "application/json",
          "authorization": _authorization,
          "refreshtoken": _refreshtoken,
        });
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'];
      if (mounted) {
        ordersData = data.length;

        setState(() {});
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        print(ordersData);
      } else {
        print("donr");
      }
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
    }
  }

  Future<List<dynamic>> getAddress() async {
    final prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userId');
    _authorization = prefs.getString('sessionToken');
    String _refreshtoken = prefs.getString('refreshToken');

    print(userid);
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  getorderaddress");
    var response = await http.get(
        USER_API + 'getOrderAddress' + '?key=BYUSERID&id=$userid',
        headers: {
          "Content-type": "application/json",
          "authorization": _authorization,
          "refreshtoken": _refreshtoken,
        });
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'];
      if (mounted) {
        ordersData = data.length;

        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        print(ordersData);
      } else {
        print("donr");
      }
      return data;
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
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pop(context, true);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        height: size.height * 0.75,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 160),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    alignment: Alignment.center,
                    height: 8,
                    width: size.width * 0.1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        "Select an address",
                        style: TextStyle(
                            color: Colors.black, fontSize: size.height * 0.024),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Icon(
                          Icons.clear,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 7,
                  color: Colors.grey,
                ),
                ordersData == null
                    ? SizedBox()
                    : ordersData >= 10
                        ? SizedBox()
                        : Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddAdress()));
                                  if (result) {
                                    setState(() {
                                      refreshList();
                                    });
                                  }
                                },
                                child: Container(
                                  height: size.height * 0.06,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Colors.red,
                                          size: size.height * 0.025,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Add Address",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: size.height * 0.0225),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 7,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                Row(
                  children: [
                    Container(
                      height: size.height * 0.06,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Saved Addresses",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size.height * 0.0225),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                    child: RefreshIndicator(
                  key: refreshKey,
                  onRefresh: refreshList,
                  child: FutureBuilder<List<dynamic>>(
                      future: getAddress(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        addressID = snapshot.data[index]['id'];
                                        userNameWithNumber =
                                            "${snapshot.data[index]['name']}, ${snapshot.data[index]['phone']}";

                                        addAddress =
                                            "${snapshot.data[index]['address']}";
                                      });
                                      Navigator.pop(context, true);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 2,
                                                  color: Colors.grey[500])
                                            ]),
                                        width: size.width,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Address",
                                                    style: TextStyle(
                                                        color: Colors.blueGrey),
                                                  ),
                                                  Spacer(),
                                                  PopupMenuButton(
                                                    onSelected: (value) {
                                                      if (value == 1) {
                                                        setState(() {
                                                          deleteAddress(
                                                              index,
                                                              snapshot
                                                                  .data[index]
                                                                      ['id']
                                                                  .toString());

                                                          // refreshList();
                                                        });
                                                      }
                                                    },
                                                    itemBuilder: (BuildContext
                                                            context) =>
                                                        [
                                                      PopupMenuItem(
                                                        child: Text("Remove"),
                                                        enabled: true,
                                                        value: 1,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    snapshot.data[index]
                                                        ['name'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                      "${snapshot.data[index]['phone']}",
                                                      style: textstyle),
                                                  Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(7),
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .lightBlue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Text(
                                                          snapshot.data[index]
                                                              ['addressFor'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.001,
                                              ),
                                              Text(
                                                snapshot.data[index]['pinCode'],
                                                style: textstyle,
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.001),
                                              Text(
                                                snapshot.data[index]['city'],
                                                style: textstyle,
                                              ),
                                              Text(
                                                snapshot.data[index]['state'],
                                                style: textstyle,
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.001),
                                              Text(
                                                "${snapshot.data[index]['address']}",
                                                style: textstyle,
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.001),
                                              Text(
                                                "${snapshot.data[index]['landMark']}",
                                                style: textstyle,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              });
                        } else if (snapshot.hasError) {
                          return Image.asset("assets/images/ErrorLogo.png");
                        } else {
                          return Container(
                            margin: EdgeInsets.only(left: 18),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      }),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
