import 'dart:async';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
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
    circluatimer = Timer.periodic(Duration(milliseconds: 100), (_) {
      setState(() {
        circularPrecent++;
      });
      if (circularPrecent >= 100) {
        circularPrecent = 0;
        circluarValue = 1;
        circluatimer.cancel();
      } else {
        setState(() {
          circluarValue = circularPrecent / 100;
        });
      }
    });

    super.initState();
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
                  "Waiting for Resturent Response",
                  style: TextStyle(
                      fontSize: size.height * 0.035, color: Colors.lightBlue),
                )),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: Container(
                    height: size.height * 0.5,
                    width: size.width * 0.7,
                    child: CircularProgressIndicator(
                      semanticsLabel: "helo",
                      strokeWidth: 15,
                      value: circluarValue,
                    ),
                  ),
                ),
              ),
              Expanded(flex: 4, child: SizedBox()),
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
