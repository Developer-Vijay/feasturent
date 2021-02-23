import 'dart:async';
import 'dart:convert';

import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/components/auth/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../constants.dart';
import '../../../messageWrapper.dart';

class OtpChecker extends StatefulWidget {
  final String phone;
  OtpChecker(this.phone);
  @override
  _OtpCheckerState createState() => _OtpCheckerState();
}

class _OtpCheckerState extends State<OtpChecker> {
  int _counter = 60;
  Timer _timer;
  bool _isOtpSend = false;
  bool tncValue = false;
  bool _isOtpValidate = true;

  int _registeredUserId;
  bool _isProcessing = false;
  bool _isValidate = false;
  TextEditingController _otpController = new TextEditingController();

  void _startTimer() {
    _counter = 10;
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  ClipPath(
                    clipper: WaveClipperTwo(),
                    child: Container(
                        height: 400,
                        width: 600,
                        color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, bottom: 30),
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignupPage()),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.3,
                              //height: 20,
                              child: Image.asset("assets/images/password.png"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(bottom: 50),
                              child: Text(
                                "OTP Sent",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Text(
                      '''Otp has been sent to the 
                        ${widget.phone} mobile number''',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  // Timer Function
                  SizedBox(
                    width: 20,
                  ),

                  (_counter > 60)
                      ? Text("")
                      : Text(
                          "",
                          style: TextStyle(color: Colors.green),
                        ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 180),
                    child: Text(
                      '$_counter',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    obscureText: false,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                    ],
                    maxLength: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                      ),
                      labelText: 'Otp',
                      counterText: "",
                    ),
                    controller: _otpController,
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    //alignment: Alignment.topLeft,
                    child: FlatButton(
                      child: Text(
                        "again send the otp",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        _startTimer();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 7, right: 7),
                    child: MaterialButton(
                      onPressed: () {
                        _verifyOtp();

                        print("hello");
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      minWidth: 385,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      height: 60,
                      color: Colors.blue,
                    ),
                  )
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyOtp() async {
    var response = await http.post(AUTH_API + 'verifyOtp', body: {
      'otp': _otpController.text,
      'userId': _registeredUserId.toString(),
    });
    print(_otpController.text);
    print(response.body);
 var responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
       _stoastMessage(responseData['message']);
      Fluttertoast.showToast(msg: "Otp Verified");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      Fluttertoast.showToast(msg: "Invalid Otp");
    }
  }
}

Future<void> _stoastMessage(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);
}
