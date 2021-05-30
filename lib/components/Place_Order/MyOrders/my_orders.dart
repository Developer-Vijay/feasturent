import 'package:feasturent_costomer_app/screens/home/home-screen.dart';
import 'package:flutter/material.dart';
import 'my_order_dineout.dart';
import 'my_orders_resturent.dart';

class MyOrders extends StatefulWidget {
  final checker;
  const MyOrders({Key key, this.checker}) : super(key: key);
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    wholeorders = null;
    dineoutorders = null;
    resturentorders = null;
  }

  // ignore: missing_return
  Future<bool> _backfunction() {
    placeTimer.cancel();

    if (widget.checker == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    placeTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backfunction,
      child: SafeArea(
          child: DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: AppBar(
            title: Text(
              "My Orders",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            backgroundColor: Colors.blue,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                iconSize: 24,
                color: Colors.white,
                onPressed: () {
                  _backfunction();
                }),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [Tab(text: "Resturent"), Tab(text: "DineOut")],
            ),
          ),
          body: TabBarView(children: [
            MyOrdersResturent(),
            MyOrdersDineout(),
          ]),
        ),
      )),
    );
  }
}
