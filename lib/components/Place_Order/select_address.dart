import 'dart:convert';
import 'package:feasturent_costomer_app/components/Place_Order/add_address.dart';
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
  var ordersData;
  var total = 0;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> refreshList() async {
    refreshKey.currentState.show();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      getAddress();
    });
    return null;
  }

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

  Future<List<dynamic>> getAddress() async {
    final prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userId');
    _authorization = prefs.getString('sessionToken');
    var response = await http
        .get(USER_API + 'getOrderAddress' + '?key=BYUSER&id$userid', headers: {
      "Content-type": "application/json",
      "authorization": _authorization,
    });
    ordersData = json.decode(response.body)['data'];
    total = ordersData.length;
    return ordersData;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
                        Navigator.pop(context, () {
                          setState(() {});
                        });
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
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddAdresses()));
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
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (ordersData.length >= 10) {
                          total = 10;
                        } else if (ordersData.length <= 10) {
                          total = ordersData.length;
                        }
                        return ListView.builder(
                            itemCount: total,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    if (snapshot.data[index]['addressFor'] ==
                                        "HOME") {
                                      setState(() {
                                        addresstype = 0;
                                      });
                                    } else {
                                      setState(() {
                                        addresstype = 1;
                                      });
                                    }
                                    setState(() {
                                      userNameWithNumber =
                                          "${snapshot.data[index]['name']}, ${snapshot.data[index]['phone']}";

                                      addAddress =
                                          "${snapshot.data[index]['landMark']}";
                                    });
                                    Navigator.pop(context, () {
                                      setState(() {});
                                    });
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
                                                            snapshot.data[index]
                                                                    ['id']
                                                                .toString());

                                                        getAddress();
                                                      });
                                                    }
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context) =>
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
                                                  snapshot.data[index]['name'],
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
                                                        const EdgeInsets.all(7),
                                                    decoration: BoxDecoration(
                                                        color: Colors.lightBlue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: snapshot.data[index][
                                                                'addressFor'] ==
                                                            null
                                                        ? Text(
                                                            "Home",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        : Text(
                                                            "office",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                  ),
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
                                              snapshot.data[index]['landMark'],
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
    );
  }
}
