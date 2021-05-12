import 'dart:convert';
import 'package:feasturent_costomer_app/components/AddressBook/addAddress.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  Future<dynamic> myfuture;
  @override
  void initState() {
    super.initState();
    setState(() {
      myfuture = _getdata();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<void> refreshList() async {
    refreshKey.currentState.show();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      myfuture = getAddress(context);
    });
    return null;
  }

  final textstyle = TextStyle(color: Colors.black, fontSize: 16);

  String _authorization = '';
  var userid;
  var userid2;
  var addressid;
  var addressdata;

  Future deleteAddress(index, String id, context) async {
    final prefs = await SharedPreferences.getInstance();
    addressid = ordersData[index]['id'];

    userid2 = prefs.getInt('userId');
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  deletOrderAddress");
    String _refreshtoken = prefs.getString('refreshToken');

    _authorization = prefs.getString('sessionToken');
    var response =
        await http.delete(USER_API + 'deleteOrderAdress/$addressid', headers: {
      "Content-type": "application/json",
      "authorization": _authorization,
      "refreshtoken": _refreshtoken,
    });
    if (response.statusCode == 200) {
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
      Fluttertoast.showToast(msg: "Unable to delete");
    }
  }

  _getdata() async {
    return await getAddress(context);
  }

  Future<dynamic> getAddress(context) async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  getOrderAddress");

    final prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userId');
    String _refreshtoken = prefs.getString('refreshToken');

    _authorization = prefs.getString('sessionToken');
    var response = await http.get(
        USER_API + 'getOrderAddress' + '?key=BYUSERID&id=$userid',
        headers: {
          "Content-type": "application/json",
          "authorization": _authorization,
          "refreshtoken": _refreshtoken,
        });
    setState(() {
      ordersData = json.decode(response.body)['data'];
    });
    total = ordersData.length;
    if (response.statusCode == 200) {
      return ordersData;
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

  var ordersData;
  var total = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_sharp),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: size.width * 0.02,
                              top: size.height * 0.012),
                          child: Text(
                            "My Addresses",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: total < 10
                      ? FlatButton(
                          onPressed: () {},
                          child: InkWell(
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
                              margin: EdgeInsets.only(left: 5, right: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Add a new address",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
                Expanded(
                    flex: 18,
                    child: RefreshIndicator(
                      key: refreshKey,
                      onRefresh: refreshList,
                      child: FutureBuilder<dynamic>(
                          future: myfuture,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              if (ordersData.length >= 10) {
                                total = 10;
                              } else if (ordersData.length <= 10) {
                                total = ordersData.length;
                              }
                              return ListView.builder(
                                  itemCount: total,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          top: 10,
                                          right: 15,
                                          bottom: 20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 2,
                                                  offset: Offset(1, 3),
                                                  spreadRadius: 3,
                                                  color: Colors.blue[50])
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
                                                      if (value == 0) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AddAdress(
                                                                          fullName:
                                                                              snapshot.data[index]['name'],
                                                                          phoneNumber:
                                                                              snapshot.data[index]['phone'],
                                                                          pincode:
                                                                              snapshot.data[index]['pinCode'],
                                                                          houseno:
                                                                              snapshot.data[index]['address'],
                                                                          roadname:
                                                                              snapshot.data[index]['addressFor'],
                                                                          city: snapshot.data[index]
                                                                              [
                                                                              'city'],
                                                                          state:
                                                                              snapshot.data[index]['state'],
                                                                          landmark:
                                                                              snapshot.data[index]['landMark'],
                                                                        )));
                                                      } else if (value == 1) {
                                                        setState(() {
                                                          deleteAddress(
                                                              index,
                                                              snapshot
                                                                  .data[index]
                                                                      ['id']
                                                                  .toString(),
                                                              context);
                                                          myfuture = getAddress(
                                                              context);
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
                                                  SizedBox(
                                                    width: 10,
                                                  ),
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
                                                                        7)),
                                                        child: Text(
                                                          snapshot.data[index]
                                                              ['addressFor'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              Text(
                                                "${snapshot.data[index]['address']}",
                                                style: textstyle,
                                              ),
                                              SizedBox(
                                                height: size.height * 0.005,
                                              ),
                                              Text(
                                                  "${snapshot.data[index]['phone']}",
                                                  style: textstyle),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            } else if (snapshot.hasError) {
                              return Text("Error");
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
                    ))
              ]),
        ),
      ),
    );
  }
}
