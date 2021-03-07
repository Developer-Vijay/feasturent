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
import '../../../constants.dart';

class OtpChecker extends StatefulWidget {
  final String phone;
  final String email;
  final String username;
  final String passwords;
  
  const OtpChecker({key:Key,this.email,this.passwords,this.phone,this.username});
  @override
  _OtpCheckerState createState() => _OtpCheckerState();
}

class _OtpCheckerState extends State<OtpChecker> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  int _counter = 60;
  bool tncValue = false;

  TextEditingController _otpController = new TextEditingController();
  //Verify user otp
  Future<void> _verifyOtp() async {
    print("approved");
    var response = await http.post(AUTH_API + 'verifyOtp', body: {
      'otp': _otpController.text,
      'userId': registeredUserId.toString()
    });
    var responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _stoastMessage(responseData['message']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    } else {
      _stoastMessage(responseData['message']);
    }
  }

  // Future<void> resendtheotp() async {
  //   var response = await http.post(
  //     USER_API + 'signup',body: {
        
  //         'userName': username,
       
  //       'phone': phone,
  //       'email': email
  //     }
  //   );
  //   var responseData = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     setState(() {
  //        registeredUserId = responseData['data']['userId'];
  //       Fluttertoast.showToast(msg: "Otp Resended");
  //       print("Status");
  //     });
  //   }else{
  //     print("error");
  //   }
  // }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
  }

  @override
  void dispose() {
    super.dispose();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Column(children: [
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                    height: size.height * 0.5,
                    width: size.width * 1,
                    color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.05,
                                    bottom: size.height * 0.02),
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: size.height * 0.04,
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
                          child: Image.asset("assets/images/password.png"),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(bottom: size.height * 0.07),
                          child: Text(
                            "OTP Sent",
                            style: TextStyle(
                                fontSize: size.height * 0.04,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: size.height * 0.02,
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
                width: size.width * 0.02,
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
                height: size.height * 0.001,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: false,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
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
              ),

              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.01),
                //alignment: Alignment.topLeft,
                child: FlatButton(
                  child: _counter == 0
                      ? Text(
                          " resend the otp",
                          style: TextStyle(fontSize: size.height * 0.02),
                        )
                      : Container(),
                  onPressed: () {
                    
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.03, right: size.width * 0.03),
                child: MaterialButton(
                  onPressed: () {
                    _verifyOtp();
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  minWidth: size.width * 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  height: size.height * 0.07,
                  color: Colors.blue,
                ),
              )
            ]),
          ],
        ),
      ),
    );
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
}
