import 'package:feasturent_costomer_app/components/auth/Forgotpassword/forgotpassword.dart';
import 'package:feasturent_costomer_app/components/auth/Forgotpassword/resetpassword.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Otprecieve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: WaveClipperOne(),
            child: Container(
              height: size.height * 0.5,
              width: size.width * 1,
              color: Colors.blue,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Forgot()));
                        },
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      // width: size.width * 0.3,
                      // height: size.height * 0.4,
                      child: Image.asset(
                        "assets/images/password.png",
                        height: size.height * 0.2,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "OTP Sent",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ]),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text(
              '''Otp has been Sent to the 
                  Mobile Number''',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(
                left: size.width * 0.05, right: size.width * 0.05),
            child: TextField(
              obscureText: false,
              //readOnly: _isOtpSend,
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
                labelText: 'OTP',
                prefixIcon: Icon(Icons.lock_sharp),
                counterText: "",
                // errorText: _isPhoneValidate == true
                //     ? null
                //     : 'Please enter valid phone number'),
                //controller: _phoneNumberController,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(
                left: size.width * 0.05, right: size.width * 0.05),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPassword()),
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
          FlatButton(
            child: Text("resend otp"),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
