import 'dart:convert';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/DineoutReserveTable/dineout_confirmed.dart';
import 'package:feasturent_costomer_app/screens/home/components/notificationPage.dart';
import 'package:feasturent_costomer_app/screens/home/home-screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../notificationsfiles.dart';

class DineoutBookingSummary extends StatefulWidget {
  var date;
  var time;
  var malecount;
  var childcount;
  var femalecount;
  var totalguest;
  var senddate;
  var adult;
  var data;
  DineoutBookingSummary(
      {this.date,
      this.time,
      this.malecount,
      this.adult,
      this.femalecount,
      this.totalguest,
      this.senddate,
      this.data,
      this.childcount});
  @override
  _DineoutBookingSummaryState createState() => _DineoutBookingSummaryState();
}

class _DineoutBookingSummaryState extends State<DineoutBookingSummary> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _specialRequestController = TextEditingController();

  var _nameValidate;
  var _phoneValidate;

  bool _isValidate = false;
  var name;
  var filledname;
  var phone;
  var username;
  var usermobilenumber;
  var useremailid;
  var email;
  var specialrequest;
  var timeis;
  var dateis;
  var maleguest;
  var guests;
  var totaladults;
  var childguest;
  var sendateis;
  var femaleguests;
  @override
  void initState() {
    super.initState();
    timeis = widget.time;
    dateis = widget.date;
    sendateis = widget.senddate;
    totaladults = widget.adult;
    maleguest = widget.malecount;
    femaleguests = widget.femalecount;
    childguest = widget.childcount;
    guests = widget.totalguest;
    print(totaladults);
    print(dateis);
    getuserdata();
  }

  Future getuserdata() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('name');
    usermobilenumber = prefs.getString('userNumber');
    useremailid = prefs.getString('userEmail');

    _emailController.text = useremailid;
    _nameController.text = username;
    _phoneController.text = usermobilenumber;
  }

  NotificationSheet _notificationSheet = NotificationSheet();

  @override
  Widget build(BuildContext context) {
    email = _emailController.text;
    name = _nameController.text;
    phone = _phoneController.text;
    specialrequest = _specialRequestController.text;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.data['name']),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: size.height * 0.014,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 14,
              bottom: 8,
            ),
            child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Booking Summary",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              height: size.height * 0.07,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      "$dateis",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "$timeis",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Contact Info",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text("Email or Mobile Number"),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 4,
                        color: Colors.blue[100],
                        offset: Offset(3, 3))
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextField(
                      controller: _nameController,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                          labelText: "Name", errorText: _nameValidate),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextField(
                      maxLength: 10,
                      controller: _phoneController,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Mobile No.", errorText: _phoneValidate),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                      decoration:
                          InputDecoration(labelText: "Email(optional)."),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextField(
                      controller: _specialRequestController,
                      style: TextStyle(color: Colors.black),
                      decoration:
                          InputDecoration(labelText: "Special Request(if any)"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.13,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 12,
            ),
            child: MaterialButton(
              onPressed: () {
                data();
              },
              child: Text("Continue to Reserve"),
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: size.width * 0.7,
              height: size.height * 0.06,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          )
        ],
      ),
    );
  }

  Future data() async {
    if (_nameController.text.isEmpty) {
      setState(() {
        _nameValidate = "Please Enter the Details";
        _isValidate = false;
      });
    } else {
      _nameValidate = null;
      _isValidate = true;
    }

    if (_phoneController.text.isEmpty) {
      setState(() {
        _phoneValidate = "Please Enter the Mobile Number";
        _isValidate = false;
      });
    } else if (_phoneController.text.length != 10) {
      setState(() {
        _phoneValidate = "Mobile Number should be 10 digits";
        _isValidate = false;
      });
    } else {
      _phoneValidate = null;
      _isValidate = true;
    }

    if (_isValidate == true) {
      Map data = {
        "vendorId": "${widget.data['id']}",
        "member": "$guests",
        "child": "$childguest",
        "adult": "$totaladults",
        "bookingDate": "$sendateis",
        "specialRequest": _specialRequestController.text,
        "customerPhone": _phoneController.text,
        "customerName": _nameController.text,
        "customerEmail": _emailController.text,
        "tableTiming": "$timeis",
        "status": true
      };
      var bookbody = json.encode(data);
      print(bookbody);
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  book table");

      var response =
          await http.post(APP_ROUTES + 'bookTable', body: bookbody, headers: {
        "Content-Type": "application/json",
      });
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        response.body;
        Fluttertoast.showToast(msg: responseData['message']);
        Center(child: CircularProgressIndicator());
        setState(() {
          CircularProgressIndicator();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DineoutConfirmed(
                        dateconfirm: dateis,
                        timeconfirm: timeis,
                        wholedata: email,
                        name: _nameController.text,
                        childguest: childguest,
                        maleguest1: maleguest,
                        femaleguest1: femaleguests,
                      )));
        });
        Notifications().scheduleNotification(
            "Dear ${_nameController.text}", "Your Table is Booked For $guests");
      } else {
        Fluttertoast.showToast(msg: responseData['message']);
      }
    } else {
      Fluttertoast.showToast(msg: "out of the validate");
    }
  }
}
