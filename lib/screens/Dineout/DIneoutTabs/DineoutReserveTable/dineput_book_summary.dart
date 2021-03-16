import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/DineoutReserveTable/dineout_confirmed.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DineoutBookingSummary extends StatefulWidget {
  var date;
  var time;
  var malecount;
  var femalecount;
  DineoutBookingSummary(
      {this.date, this.time, this.malecount, this.femalecount});
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
  var _email;

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
  var femaleguests;
  @override
  void initState() {
    super.initState();
    timeis = widget.time;
    dateis = widget.date;
    maleguest = widget.malecount;
    femaleguests = widget.femalecount;
    getuserdata();
  }

  Future getuserdata() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('customerName');
    usermobilenumber = prefs.getString('userNumber');
    useremailid = prefs.getString('userEmail');

    _emailController.text = useremailid;
    _nameController.text = username;
    _emailController.text = useremailid;
  }

  @override
  Widget build(BuildContext context) {
    email = _emailController.text;
    name = _nameController.text;
    phone = _phoneController.text;
    specialrequest = _specialRequestController.text;
    
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Cafe Name"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.014,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Booking Summary",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12, top: 12, bottom: 12),
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
                        spreadRadius: 2,
                        color: Colors.blue[50],
                        offset: Offset(1, 3))
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextField(
                      controller: _nameController,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(labelText: "Name",errorText: _nameValidate),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextField(
                      controller: _phoneController,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: "Mobile No.",errorText: _phoneValidate),
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
          MaterialButton(
            onPressed: () {
              data();
            },
            child: Text("Continue to Reserve"),
            color: Colors.blue,
            textColor: Colors.white,
            minWidth: size.width * 0.9,
            height: size.height * 0.06,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
    } else {
      _phoneValidate = null;
      _isValidate = true;
    }

    if (_isValidate == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DineoutConfirmed(
                    dateconfirm: dateis,
                    timeconfirm: timeis,
                    wholedata: email,
                    name: name,
                    maleguest1: maleguest,
                    femaleguest1: femaleguests,
                  )));
    }
  }
}
