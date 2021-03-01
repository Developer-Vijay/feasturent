import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  var ordersData;
  Future<List<dynamic>> fetchOrders() async {
    var result = await http
        .get(APP_ROUTES + 'orders ' + 'Key=BYUSER&id=userId', headers: {
      "authorization":
          " eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6ImNhcmwiLCJpYXQiOjE2MTQ1MTAxNjcsImV4cCI6MTYxNDU1NjgwMH0._nt3PcQa9Owxm1q8LOii9nqIt9nFgJKAGeOHAWza6X8",
      "Content-type": "application/json"
    });
    ordersData = json.decode(result.body)['data'];

    return ordersData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: 150,
      child: FutureBuilder<List<dynamic>>(
          future: fetchOrders(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              print("HEY");
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: snapshot.data[index]['id'],
                      title: snapshot.data[index]['image1'],
                      subtitle: snapshot.data[index]['name'],
                      // menuId: snapshot.data[index]['id'],
                      // menuIcon: snapshot.data[index]['image1'],
                      // title: snapshot.data[index]['title'],
                      // shopName: "Feasturent",
                      // price: snapshot.data[index]['price'],
                      // press: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return DetailsScreen();
                      //     },
                      //   ),
                      // );
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(
                  child: Container(
                child: Text("Error"),
              ));
            } else {
              print("No");
              Fluttertoast.showToast(
                  msg: "Sorry You Have Not Placed ANy Order Yet ");
              return Container(
                margin: EdgeInsets.only(left: 18),
                child: Center(child: Text('Adam')),
              );
            }
          }),
    ));
  }
}
