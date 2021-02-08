import 'package:feasturent_costomer_app/components/auth/Forgotpassword/otp.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ResetPassword extends StatelessWidget {
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
                                  builder: (context) => Otprecieve()));
                        },
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/images/password.png",
                        height: size.width * 0.3,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Reset Password",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ]),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          Container(
            child: Text(
              "Enter the new password",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //Password
          Container(
            margin: EdgeInsets.only(
                left: size.width * 0.05, right: size.width * 0.05),
            child: TextField(
              obscureText: true,
              // readOnly: _isOtpSend,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                ),
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                // errorText: _isPasswordValidate == true
                //     ? null
                //     : 'Please enter valid password'),
                //controller: _passwordController,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),

          // Confirm Password
          Container(
            margin: EdgeInsets.only(
                left: size.width * 0.05, right: size.width * 0.05),
            child: TextField(
              obscureText: true,
              // readOnly: _isOtpSend,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                ),
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock),
                // errorText: _isPasswordValidate == true
                //     ? null
                //     : 'Please enter valid password'),
                //controller: _passwordController,
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
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                "Reset",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              minWidth: 385,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              height: 60,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
