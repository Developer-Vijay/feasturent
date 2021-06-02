import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/Place_Order/repeat_orders.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/screens/home/home-screen.dart';
import 'package:feasturent_costomer_app/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:date_time_format/date_time_format.dart';

import '../../../constants.dart';
import '../../../main.dart';

var wholeorders;
var dineoutorders;
var resturentorders;
Timer placeTimer;

class MyOrdersResturent extends StatefulWidget {
  final checker;
  const MyOrdersResturent({Key key, this.checker}) : super(key: key);
  @override
  _MyOrdersResturentState createState() => _MyOrdersResturentState();
}

class _MyOrdersResturentState extends State<MyOrdersResturent> {
  @override
  void initState() {
    super.initState();
    refreshDataFunction();
  }

  refreshDataFunction() {
    placeTimer = Timer.periodic(Duration(seconds: 30), (_) {
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ^^^^^^^^^^^^^^^^^^^^^^^^  Refresh Page");
      setState(() {});
      return fetchOrders();
    });
  }

  // List<String> cancelreason = [];
  // DateTime time;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  var canceldata;

  Future refreshList() async {
    refreshKey.currentState.show();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      Fluttertoast.showToast(msg: "Page Refreshed");
    });
    return fetchOrders();
  }

  String _authorization = "";
  var userid;
  var ordersData;
  var datalength;
  var orderId;
  var timeised;
  // ignore: missing_return
  Future<List<dynamic>> fetchOrders() async {
    final prefs = await SharedPreferences.getInstance();
    var userid2 = prefs.getInt('userId');
    print(
        " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ hitting api order get $userid2");
    _authorization = prefs.getString('sessionToken');
    String _refreshtoken = prefs.getString('refreshToken');

    var result = await http
        .get(APP_ROUTES + 'userOrders' + '?key=BYUSER&id=$userid2', headers: {
      "Content-type": "application/json",
      "authorization": _authorization,
      "refreshtoken": _refreshtoken,
    });
    ordersData = json.decode(result.body)['data'];
    print(ordersData);
    datalength = ordersData.length;
    if (result.statusCode == 200) {
      wholeorders = ordersData;
      resturentorders = ordersData['userOrdersList'];
      dineoutorders = ordersData['userBookingList'];
      return resturentorders;
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
    }
  }

  @override
  void dispose() {
    placeTimer.cancel();
    super.dispose();
  }

  // void alertBox() {}

  // bool isDisabled = false;
  // void timercondition() {
  //   if (time.compareTo(currentTime) > currentTime.minute) {
  //     isDisabled = false;
  //   } else {
  //     isDisabled = true;
  //   }
  // }

  Future cancelOrder(index) async {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Center(child: Text("CANCELLATION")),
                titleTextStyle:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
                content: Container(
                  height: 240,
                  width: 200,
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: cancel.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            onChanged: (value) {
                              for (int i = 0; i <= cancel.length - 1; i++) {
                                setState(() {
                                  cancel[i].value = false;
                                });
                              }
                              setState(() {
                                cancel[index].value = value;
                                canceldata = cancel[index].title;
                              });
                            },
                            value: cancel[index].value,
                            title: Text(capitalize(cancel[index].title)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text("Done"),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      var userid = prefs.getInt('userId');
                      _authorization = prefs.getString('sessionToken');
                      _authorization = prefs.getString('sessionToken');
                      String _refreshtoken = prefs.getString('refreshToken');

                      print(
                          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  cancel order");
                      var response = await http.post(
                          APP_ROUTES +
                              'userOrders' +
                              '?key=BYID&id=${ordersData[index]['id']}',
                          headers: {
                            "authorization": _authorization,
                            "refreshtoken": _refreshtoken,
                          });
                      if (response.statusCode == 200) {
                        if (ordersData[index]['deliveryStatus'] == 'ACCEPTED') {
                          Fluttertoast.showToast(
                              msg:
                                  "Can't cancel order delivery boy assigned...");
                        } else {
                          var response = await http.post(
                              APP_ROUTES +
                                  'cancelOrder' +
                                  '?orderId=${ordersData[index]['id']}&userId=$userid&reason=$canceldata',
                              headers: {
                                "authorization": _authorization,
                                "refreshtoken": _refreshtoken,
                              });
                          if (response.statusCode == 200) {
                            Map socketData = {
                              'iconUrl': '',
                              'message':
                                  "Order ${ordersData[index]['id']} has been cancelled",
                              'theme': 'red',
                              'userName':
                                  '${ordersData[index]['VendorInfo']['user']['login']['userName']}'
                            };

                            socket.emit("pushNotification", socketData);

                            refreshList();
                            Navigator.pop(context);

                            Fluttertoast.showToast(msg: "ordercancelled");
                          } else if (response.statusCode == 401) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
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
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Order Cancellqation time is Finished");
                            Navigator.pop(context);

                            refreshList();
                          }
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Something went wrong. Can't cancel order");
                      }
                    },
                  )
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final textstyle1 =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w800);
    final textstyle2 = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    );
    Size size = MediaQuery.of(context).size;
    return Container(
      child: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: ListView(
          children: [
            FutureBuilder<List<dynamic>>(
                future: fetchOrders(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("data reci0");
                    if (snapshot.data.isEmpty) {
                      print("data null reci0");

                      return Center(
                        child: Column(
                          children: [
                            Container(
                                child: Image(
                              image: AssetImage(
                                "assets/images/noorder.JPG",
                              ),
                              height: size.height * 0.45,
                            )),
                            Text(
                              "No Orders Yet...",
                              style: TextStyle(
                                  fontSize: size.height * 0.035,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: size.height * 0.025,
                            ),
                            Text(
                              '''  Your MyOrders is empty.
              Place order first''',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: size.height * 0.1,
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              },
                              child: Text("Explore Now"),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: Colors.blue[600],
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        // ignore: missing_return
                        itemBuilder: (BuildContext context, index) {
                          print("data length orders $datalength");
                          DateTime currentTime = DateTime.now();

                          DateTime _timed =
                              DateTime.parse(snapshot.data[index]['createdAt']);
                          var data2 = _timed.toLocal();
                          var data4 = _timed.toLocal();
                          print("check........");
                          print(data2);
                          var data5 = data4.format("\d-\m\-\Y-\h:\i \A");
                          var data3 = data2.format("\h:\i \A");
                          print(currentTime.difference(data2));
                          print(data3);

                          int orderyear = int.parse(data4.format('Y'));
                          int ordermonth = int.parse(data4.format('m'));
                          int orderday = int.parse(data4.format('d'));
                          int orderhrs = int.parse(data4.format('H'));
                          int ordermins = int.parse(data4.format('i'));

                          int currentyear = int.parse(currentTime.format('Y'));
                          int currentmonth = int.parse(currentTime.format('m'));
                          int currentday = int.parse(currentTime.format('d'));
                          int currenthrs = int.parse(currentTime.format('H'));
                          int currentmins = int.parse(currentTime.format('i'));

                          print("order day = ${data4.format('d')}");
                          print("order months = ${data4.format('m')}");
                          print("order year = ${data4.format('Y')}");
                          print("order hrs = ${data4.format('H')}");
                          print("order mins = ${data4.format('i')}");

                          print(
                              "@@@@@@@@@@@@@@@@@@%%%%%%%%%%%%%%%%%%%%%%%%%@@@@@@@@@@@@@@@@");
                          print("current day = ${currentTime.format('d')}");
                          print("current months = ${currentTime.format('m')}");
                          print("current year = ${currentTime.format('Y')}");
                          print("current hrs = ${currentTime.format('H')}");
                          print("current mins = ${currentTime.format('i')}");
                          if (snapshot.data[index]['orderMenues'].isEmpty) {
                            return SizedBox();
                          } else if (snapshot
                              .data[index]['orderMenues'][0]['Menu'].isEmpty) {
                            return SizedBox();
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 12.0,
                                  top: 20,
                                  bottom: 10.0),
                              child: InkWell(
                                onTap: () async {
                                  placeTimer.cancel();

                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RepeatOrderPage(
                                                data: data5,
                                                itemData: snapshot.data[index],
                                              )));
                                  if (result) {
                                    setState(() {
                                      refreshDataFunction();
                                    });
                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 1,
                                              spreadRadius: 3,
                                              color: Colors.blue[50],
                                              offset: Offset(1, 3))
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: snapshot.data[index][
                                                                'orderMenues'][0]
                                                            [
                                                            'Menu']['image1'] !=
                                                        null
                                                    ? CachedNetworkImage(
                                                        imageUrl: S3_BASE_PATH +
                                                            snapshot.data[index]
                                                                        [
                                                                        'orderMenues']
                                                                    [0]['Menu']
                                                                ['image1'],
                                                        fit: BoxFit.fill,
                                                        height:
                                                            size.height * 0.1,
                                                        width:
                                                            size.width * 0.26,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      )
                                                    : Image.asset(
                                                        "assets/images/feasturenttemp.jpeg",
                                                        height:
                                                            size.height * 0.1,
                                                        width:
                                                            size.width * 0.26,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            Container(
                                              width: size.width * 0.5,
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child:
                                                  snapshot
                                                              .data[index][
                                                                  'orderMenues']
                                                              .length >=
                                                          2
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              capitalize(
                                                                  "${snapshot.data[index]['orderMenues'][0]['Menu']['title']} * ${snapshot.data[index]['orderMenues'][0]['quantity']}"),
                                                              style: textstyle1,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width:
                                                                      size.width *
                                                                          0.4,
                                                                  child: Text(
                                                                    capitalize(
                                                                        "${snapshot.data[index]['orderMenues'][1]['Menu']['title']} * ${snapshot.data[index]['orderMenues'][1]['quantity']}"),
                                                                    style:
                                                                        textstyle1,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                                snapshot.data[index]['orderMenues']
                                                                            .length >=
                                                                        3
                                                                    ? Text(
                                                                        " ....",
                                                                        style:
                                                                            textstyle1,
                                                                      )
                                                                    : SizedBox()
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      : Text(
                                                          capitalize(
                                                              "${snapshot.data[index]['orderMenues'][0]['Menu']['title']} * ${snapshot.data[index]['orderMenues'][0]['quantity']}"),
                                                          style: textstyle1,
                                                        ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12.0),
                                              child: Text(
                                                " ${(snapshot.data[index]['orderPrice'] + snapshot.data[index]['donation'] - snapshot.data[index]['discountPrice'])} ₹",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(
                                                "Order Id",
                                                style: textstyle2,
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Date",
                                                style: textstyle2,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(
                                                "${snapshot.data[index]['id']}",
                                                style: textstyle1,
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "$data5",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: snapshot.data[index]
                                                            ['orderStatus'] !=
                                                        "CANCELED"
                                                    ? StepProgressIndicator(
                                                        totalSteps: 4,
                                                        progressDirection:
                                                            TextDirection.ltr,
                                                        unselectedColor:
                                                            Colors.grey,
                                                        selectedColor:
                                                            Colors.green,
                                                        currentStep: snapshot
                                                                            .data[
                                                                        index][
                                                                    'orderStatus'] !=
                                                                "PENDING"
                                                            ? snapshot.data[index]
                                                                        [
                                                                        'orderStatus'] !=
                                                                    "ACCEPTED"
                                                                ? snapshot.data[index]
                                                                            [
                                                                            'orderStatus'] !=
                                                                        "PICKUP"
                                                                    ? 4
                                                                    : 3
                                                                : 2
                                                            : 1,
                                                        roundedEdges:
                                                            Radius.circular(20),
                                                        size: 13,
                                                      )
                                                    : Text(
                                                        "ORDER CANCELED",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                            Container(
                                                child: snapshot.data[index]
                                                            ['orderStatus'] !=
                                                        "CANCELED"
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: snapshot.data[
                                                                              index]
                                                                          [
                                                                          'orderStatus'] ==
                                                                      "PENDING"
                                                                  ? Text(
                                                                      "PENDING",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  : Text(
                                                                      "PENDING",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold))),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: snapshot.data[
                                                                              index]
                                                                          [
                                                                          'orderStatus'] ==
                                                                      "ACCEPTED"
                                                                  ? Text(
                                                                      "ACCEPTED",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color: Colors
                                                                              .red,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  : Text(
                                                                      "ACCEPTED",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold))),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: snapshot.data[
                                                                              index]
                                                                          [
                                                                          'orderStatus'] ==
                                                                      "PICKUP"
                                                                  ? Text(
                                                                      "PICKUP",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color: Colors
                                                                              .red,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  : Text(
                                                                      "PICKUP",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold))),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: snapshot.data[
                                                                              index]
                                                                          [
                                                                          'orderStatus'] ==
                                                                      "DELIVERED"
                                                                  ? Text(
                                                                      "DELIVERED",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color: Colors
                                                                              .green,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  : Text(
                                                                      "DELIVERED",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ))
                                                        ],
                                                      )
                                                    : SizedBox()),
                                            Container(
                                                child: snapshot.data[index]
                                                            ['orderStatus'] !=
                                                        "CANCELED"
                                                    ? Container(
                                                        child: orderyear !=
                                                                currentyear
                                                            ? SizedBox()
                                                            : ordermonth !=
                                                                    currentmonth
                                                                ? SizedBox()
                                                                : orderday !=
                                                                        currentday
                                                                    ? SizedBox()
                                                                    : orderhrs !=
                                                                            currenthrs
                                                                        ? SizedBox()
                                                                        : ordermins ==
                                                                                currentmins
                                                                            ? MaterialButton(
                                                                                child: Text("Cancel"),
                                                                                color: Colors.red,
                                                                                textColor: Colors.white,
                                                                                onPressed: () {
                                                                                  cancelOrder(index);
                                                                                },
                                                                              )
                                                                            : SizedBox())
                                                    : SizedBox()),
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            );
                          }
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Container(
                            child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("assets/images/Errorlogo.png"),
                        ),
                        Text(
                          "An Error Occured",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    )));
                  } else {
                    if (resturentorders != null) {
                      var snapshot = resturentorders;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.length,
                          // ignore: missing_return
                          itemBuilder: (BuildContext context, index) {
                            print("data length orders $datalength");
                            DateTime currentTime = DateTime.now();

                            DateTime _timed =
                                DateTime.parse(snapshot[index]['createdAt']);
                            var data2 = _timed.toLocal();
                            var data4 = _timed.toLocal();
                            print("check........");
                            print(data2);
                            var data5 = data4.format("\d-\m\-\Y-\h:\i \A");
                            var data3 = data2.format("\h:\i \A");

                            int orderyear = int.parse(data4.format('Y'));
                            int ordermonth = int.parse(data4.format('m'));
                            int orderday = int.parse(data4.format('d'));
                            int orderhrs = int.parse(data4.format('H'));
                            int ordermins = int.parse(data4.format('i'));

                            int currentyear =
                                int.parse(currentTime.format('Y'));
                            int currentmonth =
                                int.parse(currentTime.format('m'));
                            int currentday = int.parse(currentTime.format('d'));
                            int currenthrs = int.parse(currentTime.format('H'));
                            int currentmins =
                                int.parse(currentTime.format('i'));

                            print("order day = ${data4.format('d')}");
                            print("order months = ${data4.format('m')}");
                            print("order year = ${data4.format('Y')}");
                            print("order hrs = ${data4.format('H')}");
                            print("order mins = ${data4.format('i')}");

                            print(
                                "@@@@@@@@@@@@@@@@@@%%%%%%%%%%%%%%%%%%%%%%%%%@@@@@@@@@@@@@@@@");
                            print("current day = ${currentTime.format('d')}");
                            print(
                                "current months = ${currentTime.format('m')}");
                            print("current year = ${currentTime.format('Y')}");
                            print("current hrs = ${currentTime.format('H')}");
                            print("current mins = ${currentTime.format('i')}");

                            // print(currentTime.difference(data2));
                            print(data3);
                            if (snapshot[index]['orderMenues'].isEmpty) {
                              return SizedBox();
                            } else if (snapshot[index]['orderMenues'][0]['Menu']
                                .isEmpty) {
                              return SizedBox();
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0,
                                    right: 12.0,
                                    top: 20,
                                    bottom: 10.0),
                                child: InkWell(
                                  onTap: () async {
                                    placeTimer.cancel();

                                    final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RepeatOrderPage(
                                                  data: data5,
                                                  itemData: snapshot[index],
                                                )));
                                    if (result) {
                                      setState(() {
                                        refreshDataFunction();
                                      });
                                    }
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 1,
                                                spreadRadius: 3,
                                                color: Colors.blue[50],
                                                offset: Offset(1, 3))
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: snapshot[index][
                                                                      'orderMenues']
                                                                  [0]['Menu']
                                                              ['image1'] !=
                                                          null
                                                      ? CachedNetworkImage(
                                                          imageUrl: S3_BASE_PATH +
                                                              snapshot[index][
                                                                          'orderMenues']
                                                                      [
                                                                      0]['Menu']
                                                                  ['image1'],
                                                          fit: BoxFit.fill,
                                                          height:
                                                              size.height * 0.1,
                                                          width:
                                                              size.width * 0.26,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        )
                                                      : Image.asset(
                                                          "assets/images/feasturenttemp.jpeg",
                                                          height:
                                                              size.height * 0.1,
                                                          width:
                                                              size.width * 0.26,
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                              Container(
                                                width: size.width * 0.5,
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: snapshot[index]
                                                                ['orderMenues']
                                                            .length >=
                                                        2
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            capitalize(
                                                                "${snapshot[index]['orderMenues'][0]['Menu']['title']} * ${snapshot[index]['orderMenues'][0]['quantity']}"),
                                                            style: textstyle1,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width:
                                                                    size.width *
                                                                        0.4,
                                                                child: Text(
                                                                  capitalize(
                                                                      "${snapshot[index]['orderMenues'][1]['Menu']['title']} * ${snapshot[index]['orderMenues'][1]['quantity']}"),
                                                                  style:
                                                                      textstyle1,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              snapshot[index]['orderMenues']
                                                                          .length >=
                                                                      3
                                                                  ? Text(
                                                                      " ....",
                                                                      style:
                                                                          textstyle1,
                                                                    )
                                                                  : SizedBox()
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    : Text(
                                                        capitalize(
                                                            "${snapshot[index]['orderMenues'][0]['Menu']['title']} * ${snapshot[index]['orderMenues'][0]['quantity']}"),
                                                        style: textstyle1,
                                                      ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 12.0),
                                                child: Text(
                                                  " ${(snapshot[index]['orderPrice'] + snapshot[index]['donation'] - snapshot[index]['discountPrice'])} ₹",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textDirection:
                                                      TextDirection.rtl,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Text(
                                                  "Order Id",
                                                  style: textstyle2,
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Date",
                                                  style: textstyle2,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Text(
                                                  "${snapshot[index]['id']}",
                                                  style: textstyle1,
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "$data5",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: snapshot[index]
                                                              ['orderStatus'] !=
                                                          "CANCELED"
                                                      ? StepProgressIndicator(
                                                          totalSteps: 4,
                                                          progressDirection:
                                                              TextDirection.ltr,
                                                          unselectedColor:
                                                              Colors.grey,
                                                          selectedColor:
                                                              Colors.green,
                                                          currentStep: snapshot[
                                                                          index]
                                                                      [
                                                                      'orderStatus'] !=
                                                                  "PENDING"
                                                              ? snapshot[index][
                                                                          'orderStatus'] !=
                                                                      "ACCEPTED"
                                                                  ? snapshot[index]
                                                                              [
                                                                              'orderStatus'] !=
                                                                          "PICKUP"
                                                                      ? 4
                                                                      : 3
                                                                  : 2
                                                              : 1,
                                                          roundedEdges:
                                                              Radius.circular(
                                                                  20),
                                                          size: 13,
                                                        )
                                                      : Text(
                                                          "ORDER CANCELED",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                              Container(
                                                  child: snapshot[index]
                                                              ['orderStatus'] !=
                                                          "CANCELED"
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: snapshot[index]
                                                                            [
                                                                            'orderStatus'] ==
                                                                        "PENDING"
                                                                    ? Text(
                                                                        "PENDING",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .red,
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      )
                                                                    : Text(
                                                                        "PENDING",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold))),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: snapshot[index]
                                                                            [
                                                                            'orderStatus'] ==
                                                                        "ACCEPTED"
                                                                    ? Text(
                                                                        "ACCEPTED",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Colors.red,
                                                                            fontWeight: FontWeight.bold),
                                                                      )
                                                                    : Text(
                                                                        "ACCEPTED",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold))),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: snapshot[index]
                                                                            [
                                                                            'orderStatus'] ==
                                                                        "PICKUP"
                                                                    ? Text(
                                                                        "PICKUP",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Colors.red,
                                                                            fontWeight: FontWeight.bold),
                                                                      )
                                                                    : Text(
                                                                        "PICKUP",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold))),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: snapshot[index]
                                                                            [
                                                                            'orderStatus'] ==
                                                                        "DELIVERED"
                                                                    ? Text(
                                                                        "DELIVERED",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Colors.green,
                                                                            fontWeight: FontWeight.bold),
                                                                      )
                                                                    : Text(
                                                                        "DELIVERED",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ))
                                                          ],
                                                        )
                                                      : SizedBox()),
                                              Container(
                                                  child: snapshot[index]
                                                              ['orderStatus'] !=
                                                          "CANCELED"
                                                      ? Container(
                                                          child: orderyear !=
                                                                  currentyear
                                                              ? SizedBox()
                                                              : ordermonth !=
                                                                      currentmonth
                                                                  ? SizedBox()
                                                                  : orderday !=
                                                                          currentday
                                                                      ? SizedBox()
                                                                      : orderhrs !=
                                                                              currenthrs
                                                                          ? SizedBox()
                                                                          : ordermins == currentmins
                                                                              ? MaterialButton(
                                                                                  child: Text("Cancel"),
                                                                                  color: Colors.red,
                                                                                  textColor: Colors.white,
                                                                                  onPressed: () {
                                                                                    cancelOrder(index);
                                                                                  },
                                                                                )
                                                                              : SizedBox())
                                                      : SizedBox()),
                                            ],
                                          )
                                        ],
                                      )),
                                ),
                              );
                            }
                          });
                    } else {
                      return LoadingListPage();
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
