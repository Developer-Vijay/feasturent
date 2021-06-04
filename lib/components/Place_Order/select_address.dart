import 'dart:convert';
import 'package:feasturent_costomer_app/components/AddressBook/addAddress.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

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
        await http.delete(
          Uri.parse(USER_API + 'deleteOrderAdress/$addressid')
          , headers: {
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
      Uri.parse( USER_API + 'getOrderAddress' + '?key=BYUSERID&id=$userid')
       ,
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

  // ignore: missing_return
  Future<List<dynamic>> getAddress() async {
    final prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userId');
    _authorization = prefs.getString('sessionToken');
    String _refreshtoken = prefs.getString('refreshToken');

    print(userid);
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  getorderaddress");
    var response = await http.get(
      Uri.parse(  USER_API + 'getOrderAddress' + '?key=BYUSERID&id=$userid')
      ,
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

  int selectedRadio = -1;
  int addrId;
  var addrUser;
  var addaddr;

  changeValue(int val, data) {
    setState(() {
      selectedRadio = val;
      addrId = data['id'];
      addrUser = "${data['name']}, ${data['phone']}";

      addaddr = "${data['address']}";
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pop(context, true);
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            height: size.height * 1,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context, true);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Select an address",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.024),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
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
                                              builder: (context) =>
                                                  AddAdress()));
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
                                                  fontSize:
                                                      size.height * 0.0225),
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
                        flex: 6,
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
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 18.0,
                                                              right: 8),
                                                      child: Radio(
                                                        value: index,
                                                        groupValue:
                                                            selectedRadio,
                                                        activeColor:
                                                            Colors.blue,
                                                        onChanged: (val) {
                                                          changeValue(
                                                              val,
                                                              snapshot
                                                                  .data[index]);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Address",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blueGrey),
                                                            ),
                                                            Spacer(),
                                                            PopupMenuButton(
                                                              onSelected:
                                                                  (value) {
                                                                if (value ==
                                                                    1) {
                                                                  setState(() {
                                                                    deleteAddress(
                                                                        index,
                                                                        snapshot
                                                                            .data[index]['id']
                                                                            .toString());
                                                                  });
                                                                }
                                                              },
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context) =>
                                                                      [
                                                                PopupMenuItem(
                                                                  child: Text(
                                                                      "Remove"),
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
                                                              snapshot.data[
                                                                      index]
                                                                  ['name'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          20),
                                                              child: Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          7),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .lightBlue,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              7)),
                                                                  child: Text(
                                                                    snapshot.data[
                                                                            index]
                                                                        [
                                                                        'addressFor'],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: size.height *
                                                              0.02,
                                                        ),
                                                        Text(
                                                          "${snapshot.data[index]['address']}",
                                                          style: textstyle,
                                                        ),
                                                        SizedBox(
                                                          height: size.height *
                                                              0.005,
                                                        ),
                                                        Text(
                                                            "${snapshot.data[index]['phone']}",
                                                            style: textstyle),
                                                        SizedBox(
                                                          height: size.height *
                                                              0.02,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ));
                                      });
                                } else if (snapshot.hasError) {
                                  return Image.asset(
                                      "assets/images/ErrorLogo.png");
                                } else {
                                  return Container(
                                    margin: EdgeInsets.only(left: 18, top: 20),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.grey[100],
                                      enabled: true,
                                      child: ListView.builder(
                                        itemBuilder: (_, __) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: double.infinity,
                                                height: size.height * 0.02,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: size.height * 0.02,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: size.height * 0.02,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: size.height * 0.02,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                              ),
                                              Container(
                                                width: 40.0,
                                                height: size.height * 0.02,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        itemCount: 6,
                                      ),
                                    ),
                                  );
                                }
                              }),
                        )),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: MaterialButton(
                            onPressed: () {
                              if (addaddr == null) {
                                Fluttertoast.showToast(
                                    msg: "Please select any address");
                              } else {
                                setState(() {
                                  addressID = addrId;
                                  userNameWithNumber = addrUser;

                                  addAddress = addaddr;
                                });
                                Navigator.pop(context, true);
                              }
                            },
                            child: Text("Deliver to this Address"),
                            color: Colors.blue,
                            minWidth: size.width * 0.8,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        )

                        // InkWell(
                        //   onTap: () {
                        //     if (addaddr == null) {
                        //       Fluttertoast.showToast(
                        //           msg: "Please select any address");
                        //     } else {
                        //       setState(() {
                        //         addressID = addrId;
                        //         userNameWithNumber = addrUser;

                        //         addAddress = addaddr;
                        //       });
                        //       Navigator.pop(context, true);
                        //     }
                        //   },
                        //   child: Container(
                        //     height: 25,
                        //     margin: const EdgeInsets.all(10.0),
                        //     decoration: BoxDecoration(
                        //         color: Colors.blue,
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(15))),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(10.0),
                        //       child: Center(
                        //         child: Text(
                        //           "Deliver to this Address",
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: size.height * 0.024),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
