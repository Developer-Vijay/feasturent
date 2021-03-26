import 'dart:convert';
import 'package:feasturent_costomer_app/components/AddressBook/addAddress.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<void> refreshList() async {
    refreshKey.currentState.show();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      myfuture = getAddress();
    });
    return null;
  }

  final textstyle = TextStyle(color: Colors.black, fontSize: 16);

  String _authorization = '';
  var userid;
  var userid2;
  var addressid;
  var addressdata;

  Future deleteAddress(index, String id) async {
    final prefs = await SharedPreferences.getInstance();
    addressid = ordersData[index]['id'];

    userid2 = prefs.getInt('userId');

    _authorization = prefs.getString('sessionToken');
    var response =
        await http.delete(USER_API + 'deleteOrderAdress/$addressid', headers: {
      "Content-type": "application/json",
      "authorization": _authorization,
    });
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body);
      print(response.body);

      return response.body;
    } else {
      Fluttertoast.showToast(msg: "Unable to delete");
    }
  }

  _getdata() async {
    return await getAddress();
  }

  Future<dynamic> getAddress() async {
    final prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userId');
    _authorization = prefs.getString('sessionToken');
    var response = await http.get(
        USER_API + 'getOrderAddress' + '?key=BYUSERID&id=$userid',
        headers: {
          "Content-type": "application/json",
          "authorization": _authorization,
        });
    ordersData = json.decode(response.body)['data'];
    total = ordersData.length;
    return ordersData;
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddAdress()));
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
                                                                  .toString());
                                                          myfuture =
                                                              getAddress();
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
                                                height: 3,
                                              ),
                                              Text(
                                                snapshot.data[index]['pinCode'],
                                                style: textstyle,
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                snapshot.data[index]['city'],
                                                style: textstyle,
                                              ),
                                              Text(
                                                snapshot.data[index]['state'],
                                                style: textstyle,
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                snapshot.data[index]
                                                    ['addressFor'],
                                                style: textstyle,
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                snapshot.data[index]
                                                    ['landMark'],
                                                style: textstyle,
                                              )
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
                                margin: EdgeInsets.only(left: 18),
                                child:
                                    Center(child: CircularProgressIndicator()),
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
