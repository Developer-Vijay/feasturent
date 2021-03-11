import 'dart:async';
import 'package:feasturent_costomer_app/screens/home/home-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderConfirmResturent extends StatefulWidget {
  @override
  _OrderConfirmResturentState createState() => _OrderConfirmResturentState();
}

class _OrderConfirmResturentState extends State<OrderConfirmResturent> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 4);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onBack,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                    child: Text(
                  "Order Placed Successfully",
                  style: TextStyle(
                      fontSize: size.height * 0.035, color: Colors.lightBlue),
                )),
              ),
              Expanded(
                  flex: 5,
                  child: Center(
                      child: CircleAvatar(
                          maxRadius: 120,
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 120,
                          )))),
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    child: Container(
                      margin: EdgeInsets.only(left: 40, right: 40),
                      child: Text(
                        'You will be Redirected to the Home Screen Shortly',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onBack() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Check your order status in MyOrder"),
              actions: [
                FlatButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                )
              ],
            ));
  }
}
