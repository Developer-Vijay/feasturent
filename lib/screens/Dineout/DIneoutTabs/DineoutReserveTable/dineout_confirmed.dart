import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:feasturent_costomer_app/screens/home/home-screen.dart';

class DineoutConfirmed extends StatefulWidget {
  var dateconfirm;
  var timeconfirm;
  var guest;
  var wholedata;
  var maleguest1;
  var childguest;
  var name;
  var adult;

  var femaleguest1;

  DineoutConfirmed(
      {this.dateconfirm,
      this.guest,
      this.name,
      this.timeconfirm,
      this.wholedata,
      this.adult,
      this.maleguest1,
      this.childguest,
      this.femaleguest1});

  @override
  _DineoutConfirmedState createState() => _DineoutConfirmedState();
}

class _DineoutConfirmedState extends State<DineoutConfirmed> {
  var date;
  var timeis;
  var guest;
  var wholedat;
  var nameis;
  var maleguest;
  var femaleguests;
  var childguests;
  @override
  void initState() {
    super.initState();
    date = widget.dateconfirm;
    timeis = widget.timeconfirm;
    guest = widget.guest;
    nameis = widget.name;
    maleguest = widget.maleguest1;
    childguests = widget.childguest;
    femaleguests = widget.femaleguest1;
  }

  Future<bool> _onbackpressed() {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            index: 2,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onbackpressed,
      child: Scaffold(
          appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        index: 2,
                      ),
                    ));
              },
            ),
            title: Text("Booking Summary"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Table Status - Confirmed",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.green[400],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.2,
                  ),
                  CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      child: Icon(
                        Icons.check,
                        size: 16,
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 12),
                alignment: Alignment.topLeft,
                child: Text("Your Reservation is Confirmed Happy Dinning"),
              ),
              Divider(),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Date & Time"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$date and $timeis",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Guests"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$maleguest Male , $femaleguests Female and $childguests Child",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Name"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$nameis",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Need Help ?",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Call The Restaurant",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("6789012345"),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(child: Icon(Icons.call)),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              Center(
                child: MaterialButton(
                  onPressed: () {
                    Fluttertoast.showToast(msg: "Api needed to be integrate");
                  },
                  child: Text("Cancel"),
                  color: Colors.red[700],
                  textColor: Colors.white,
                  minWidth: size.width * 0.9,
                  height: size.height * 0.06,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          )),
    );
  }
}
