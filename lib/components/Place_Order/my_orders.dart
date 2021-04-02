import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/Bottomsheet/addRatingBottom.dart';
import 'package:feasturent_costomer_app/components/Place_Order/repeat_orders.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:date_time_format/date_time_format.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  // AsyncMemoizer _memoizer;
  Future myFuture;

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  List<String> cancelreason = [];
  DateTime time;
  DateTime currentTime = DateTime.now();

  ScrollController _scrollController = ScrollController();
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
  bool _progressController = true;
  var userid;
  var ordersData;
  var datalength;
  var orderId;
  var timeised;
  Future<List<dynamic>> fetchOrders() async {
    final prefs = await SharedPreferences.getInstance();
    var userid2 = prefs.getInt('userId');
    _authorization = prefs.getString('sessionToken');

    var result = await http
        .get(APP_ROUTES + 'userOrders' + '?key=BYUSER&id=$userid2', headers: {
      "Content-type": "application/json",
      "authorization": _authorization,
    });
    ordersData = json.decode(result.body)['data'];
    datalength = ordersData.length;
    // refresh();

    return ordersData;
  }

  Timer placeTimer;

  refresh() {
    placeTimer = Timer.periodic(Duration(seconds: 30), (_) {
      placeTimer.cancel();
      print("refreshed");
      if (mounted) {
        setState(() {});
        refresh();
      }
    });
  }

  @override
  void dispose() {
    refresh();
    placeTimer.cancel();
    super.dispose();
  }

  void alertBox() {}

  bool isDisabled = false;
  void timercondition() {
    if (time.compareTo(currentTime) > currentTime.minute) {
      isDisabled = false;
    } else {
      isDisabled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(time);
    var current = currentTime.format("\h\i");
    // print("${currentTime.hour}:${currentTime.minute}");
    final textstyle1 =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w800);
    final textstyle2 = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Orders",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            iconSize: 24,
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          child: RefreshIndicator(
            key: refreshKey,
            onRefresh: refreshList,
            child: FutureBuilder<List<dynamic>>(
                future: fetchOrders(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: datalength,
                        // ignore: missing_return
                        itemBuilder: (BuildContext context, index) {
                          Future cancelOrder() async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        title:
                                            Center(child: Text("CANCELLATION")),
                                        titleTextStyle: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w700),
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
                                                      for (int i = 0;
                                                          i <=
                                                              cancel.length - 1;
                                                          i++) {
                                                        setState(() {
                                                          cancel[i].value =
                                                              false;
                                                        });
                                                      }
                                                      setState(() {
                                                        cancel[index].value =
                                                            value;
                                                        canceldata =
                                                            cancel[index].title;
                                                      });
                                                    },
                                                    value: cancel[index].value,
                                                    title: Text(
                                                        cancel[index].title),
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
                                              final prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              var userid =
                                                  prefs.getInt('userId');
                                              _authorization = prefs
                                                  .getString('sessionToken');
                                              _authorization = prefs
                                                  .getString('sessionToken');

                                              var response = await http.post(
                                                  APP_ROUTES +
                                                      'cancelOrder' +
                                                      '?orderId=${ordersData[index]['id']}&userId=$userid&reason=$canceldata',
                                                  headers: {
                                                    "authorization":
                                                        _authorization
                                                  });
                                              if (response.statusCode == 200) {
                                                Fluttertoast.showToast(
                                                    msg: "ordercancelled");
                                                Navigator.pop(context);
                                                refreshList();
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Order Cancellqation time is Finished");
                                                Navigator.pop(context);

                                                refreshList();
                                              }
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                });
                          }

                          DateTime _timed =
                              DateTime.parse(snapshot.data[index]['createdAt']);
                          var data2 = _timed.toLocal();
                          var data4 = _timed.toLocal();
                          print("check........");
                          print(data2);
                          var data5 = data4.format("\d-\m\-\Y-\h:\i \A");
                          var data3 = data2.format("\h:\i \A");
                          // DateTime _timeis=DateTime.parse(data3);
                          // print(_timeis);
                          var data = _timed.format("\h:\i \a");
                          print(currentTime.difference(data2));
                          print("///////////");
                          print(data3);
                          // print(_timed);
                          // print(data);
                          if (snapshot.data[index]['orderMenues'].isEmpty) {
                            return SizedBox();
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 12.0,
                                  top: 20,
                                  bottom: 10.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RepeatOrderPage(
                                                data: data5,
                                                itemData: snapshot.data[index],
                                              )));
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
                                                        fit: BoxFit.contain,
                                                        height:
                                                            size.height * 0.08,
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
                                            Padding(
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
                                                              "${snapshot.data[index]['orderMenues'][0]['Menu']['title']} * ${snapshot.data[index]['orderMenues'][0]['quantity']}",
                                                              style: textstyle1,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "${snapshot.data[index]['orderMenues'][1]['Menu']['title']} * ${snapshot.data[index]['orderMenues'][1]['quantity']}",
                                                                  style:
                                                                      textstyle1,
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
                                                          "${snapshot.data[index]['orderMenues'][0]['Menu']['title']} * ${snapshot.data[index]['orderMenues'][0]['quantity']}",
                                                          style: textstyle1,
                                                        ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12.0),
                                              child: Text(
                                                " ${snapshot.data[index]['orderPrice']} ₹",
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
                                                          // Spacer(),
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
                                                          // Spacer(),

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
                                                                      "COMPLETED"
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
                                                        // remove not symbol from here Afteer Testing it
                                                        child: currentTime
                                                                    .minute ==
                                                                data2.minute
                                                            ? MaterialButton(
                                                                child: Text(
                                                                    "Cancel"),
                                                                color:
                                                                    Colors.red,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                onPressed: () {
                                                                  cancelOrder();
                                                                },
                                                              )
                                                            : SizedBox())
                                                    : SizedBox()),
                                            Container(
                                                child: snapshot.data[index]
                                                            ['orderStatus'] ==
                                                        "COMPLETED"
                                                    ? MaterialButton(
                                                        textColor: Colors.grey,
                                                        color:
                                                            Colors.amber[600],
                                                        child: Text("Review"),
                                                        onPressed: () {
                                                          showModalBottomSheet(
                                                              enableDrag: true,
                                                              isScrollControlled:
                                                                  true,
                                                              context: context,
                                                              builder: (context) =>
                                                                  Container(
                                                                      height:
                                                                          size.height *
                                                                              0.8,
                                                                      child:
                                                                          AddRatingPage(
                                                                        data: snapshot
                                                                            .data[index],
                                                                      )));
                                                        },
                                                      )
                                                    : SizedBox())
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
                  } else if (snapshot.hasData == null) {
                    return Center(
                        child: Container(
                            child: Image(
                                image: AssetImage(
                                    "assets/images/NoImage.png.jpeg"))));
                  } else {
                    return Container(
                      margin: EdgeInsets.only(left: 18),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                }),
          ),
        ));
  }
}
