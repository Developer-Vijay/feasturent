import 'package:feasturent_costomer_app/components/auth/Forgotpassword/otp.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Forgot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForgotPassword(),
    );
  }
}

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        ClipPath(
          clipper: WaveClipperTwo(),
          child: Container(
            height: size.height * 0.6,
            width: size.width * 1,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Image.asset(
                    "assets/images/forgot (1).png",
                    height: size.height * 0.20,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  '''Enter the registerd mobile number 
                                    to recive an otp''',
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.only(
                      left: size.width * 0.05, right: size.width * 0.05),
                  child: TextField(
                    obscureText: false,
                    //readOnly: _isOtpSend,
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
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone),
                      counterText: "",
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Otprecieve()),
                    );
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  minWidth: size.width * 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  height: size.height * 0.07,
                  color: Colors.blue,
                ),
              ),
            
            ],
          ),
        )
      ],
    );
  }
}
