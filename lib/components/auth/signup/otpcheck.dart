import 'dart:async';

import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/components/auth/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OtpChecker(),
    );
  }
}

class OtpChecker extends StatefulWidget {
  @override
  _OtpCheckerState createState() => _OtpCheckerState();
}

class _OtpCheckerState extends State<OtpChecker> {
  int _counter = 60;
  Timer _timer;

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

  bool tncValue = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
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
                        margin: EdgeInsets.only(left: 20, bottom: 30),
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
                                  builder: (context) => SignupPage()),
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
                    style: TextStyle(fontSize: 30, color: Colors.white),
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
             mobile number''',
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
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),

      SizedBox(
        height: 30,
      ),
      Container(
        width: size.width * 0.8,
        height: size.height * 0.06,
        child: OTPTextField(
            fieldWidth: 40,
            onCompleted: (pin) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            length: 5,
            width: MediaQuery.of(context).size.width,
            style: TextStyle(fontSize: 24),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.box),
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
      // Container(
      //   margin: EdgeInsets.only(left: 7, right: 7),
      //   child: MaterialButton(
      //     onPressed: () {
      //       _startTimer();
      //       // Navigator.push(
      //       //   context,
      //       //   MaterialPageRoute(builder: (context) => LoginPage()),
      //       // );
      //     },
      //     child: Text(
      //       "Submit",
      //       style: TextStyle(fontSize: 20, color: Colors.white),
      //     ),
      //     minWidth: 385,
      //     shape:
      //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      //     height: 60,
      //     color: Colors.blue,
      //   ),
      // )
    ]);
  }
}
