import 'dart:convert';
import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/Place_Order/repeat_orders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';

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
  AsyncMemoizer _memoizer;

  @override
  void initState() {
    super.initState();

    _memoizer = AsyncMemoizer();
    fetchOrders();
  }

  String _authorization = "";
  bool _progressController = true;
 

  var ordersData;
  Future<List<dynamic>> fetchOrders() async {
    // return _memoizer.runOnce(() async {
    final prefs = await SharedPreferences.getInstance();

    _authorization = prefs.getString('sessionToken');
    var result = await http.get(COMMON_API + 'orders' + '?key=ALL', headers: {
      "Content-type": "application/json",
      "authorization": _authorization,
    });
    var ordersData = json.decode(result.body)['data'];

    return ordersData;
  }
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final textstyle1 =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w600);
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
          child: FutureBuilder<List<dynamic>>(
              future: fetchOrders(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  print("HEY");
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 20, bottom: 10.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        color: Colors.grey[300],
                                        offset: Offset(0, 3))
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://media.gettyimages.com/photos/closeup-of-pizza-on-table-picture-id995467932?k=6&m=995467932&s=612x612&w=0&h=cjArdsWiJtWrIvJlUWIM7sdEwyf8MSI_0oG-87xf5IM=",
                                            fit: BoxFit.contain,
                                            height: size.height * 0.08,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          "${snapshot.data[index]['menuTitle']}",
                                          style: textstyle1,
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        child: Text(
                                          " ${snapshot.data[index]['totalPrice']} ₹",
                                          style: textstyle1,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "Items",
                                      style: textstyle2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "1",
                                          style: textstyle1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("Orders on"),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${snapshot.data[index]['orderDate']}",
                                          style: textstyle1,
                                        ),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.replay_outlined,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RepeatOrderPage(
                                                          itemData: snapshot
                                                              .data[index],
                                                        )));
                                          },
                                          child: Text(
                                            "Repeat Orders",
                                            style: textstyle2,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(
                      child: Container(
                    child: Text("Error"),
                  ));
                } else {
                  print("No");

                  return Container(
                    margin: EdgeInsets.only(left: 18),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              }),
        ));
  }
}
