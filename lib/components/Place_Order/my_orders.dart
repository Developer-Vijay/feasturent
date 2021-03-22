import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/Place_Order/repeat_orders.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class MyOrders extends StatefulWidget {
  final menuid;
  String foodname;

  MyOrders({
    Key key,
    this.menuid,
    this.foodname,
  }) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  // AsyncMemoizer _memoizer;
  Future myFuture;

  @override
  void initState() {
    super.initState();
  }

  ScrollController _scrollController = ScrollController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future cancelOrder() async {
     final prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('userId');

    _authorization = prefs.getString('sessionToken');
   
    var response = await http.post(APP_ROUTES + 'cancelOrder' + '?orderId=orderId&userId=userId&reason=No reason' );
    
  }

  Future<Null> refreshList() async {
    refreshKey.currentState.show();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      Fluttertoast.showToast(msg: "Page Refreshed");
    });
    return null;
  }

  String _authorization = "";
  bool _progressController = true;
  var userid;

  var ordersData;
  var datalength;
  Future<List<dynamic>> fetchOrders() async {
    final prefs = await SharedPreferences.getInstance();
    var userid2 = prefs.getInt('userId');
    _authorization = prefs.getString('sessionToken');

    var result = await http
        .get(COMMON_API + 'orders' + '?key=BYUSER&id=$userid2', headers: {
      "Content-type": "application/json",
      "authorization": _authorization,
    });
    ordersData = json.decode(result.body)['data'];
    datalength = ordersData.length;
    print(datalength);
    return ordersData;
  }

  @override
  Widget build(BuildContext context) {
    final textstyle1 =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w800);
    final textstyle2 = TextStyle(fontWeight: FontWeight.w800);
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
                                                " ${snapshot.data[index]['orderMenues'][0]['Menu']['orderPrice']} ₹",
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "Total Items",
                                            style: textstyle2,
                                          ),
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
                                                "${snapshot.data[index]['orderMenues'].length}",
                                                style: textstyle1,
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  "${snapshot.data[index]['createdAt']}"),
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
                                              child: StepProgressIndicator(
                                                totalSteps: 2,
                                                progressDirection:
                                                    TextDirection.ltr,
                                                unselectedColor: snapshot
                                                                .data[index]
                                                            ['orderStatus'] ==
                                                        "PENDING"
                                                    ? Colors.grey
                                                    : Colors.green,
                                                selectedColor: snapshot
                                                                .data[index]
                                                            ['orderStatus'] ==
                                                        "PENDING"
                                                    ? Colors.green
                                                    : Colors.grey,
                                                currentStep: 1,
                                                roundedEdges:
                                                    Radius.circular(20),
                                                size: 13,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: snapshot.data[index][
                                                                'orderStatus'] ==
                                                            "PENDING"
                                                        ? Text(
                                                            "PENDING",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : Text("PENDING",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                Spacer(),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: snapshot.data[index][
                                                                'orderStatus'] ==
                                                            "COMPLETED"
                                                        ? Text(
                                                            "COMPLETED",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : Text(
                                                            "COMPLETED",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ))
                                              ],
                                            ),
                                            Container(
                                              child: MaterialButton(
                                                color: Colors.red[500],
                                                textColor: Colors.white,
                                                child: Text("Cancel"),
                                                onPressed: () {},
                                              ),
                                            )
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
