import 'package:flutter/material.dart';

class MyOrdersDineout extends StatefulWidget {
  @override
  _MyOrdersDineoutState createState() => _MyOrdersDineoutState();
}

class _MyOrdersDineoutState extends State<MyOrdersDineout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Not Have Any booking....",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
