import 'package:flutter/material.dart';

class OfferForPlaceOrder extends StatefulWidget {
  final data;
  const OfferForPlaceOrder({Key key, this.data}) : super(key: key);
  @override
  _OfferForPlaceOrderState createState() => _OfferForPlaceOrderState();
}

class _OfferForPlaceOrderState extends State<OfferForPlaceOrder> {
  @override
  void initState() {
    super.initState();
    setState(() {
      offerData = widget.data;
    });
  }

  var offerData;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: size.height * 0.8,
      child: Column(
        children: [
          Text("data"),
          Text("data"),
          Text("data"),
        ],
      ),
    );
  }
}
