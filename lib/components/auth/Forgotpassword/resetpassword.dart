import 'dart:convert';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

TextEditingController _newpasswordcontroller = TextEditingController();
TextEditingController _oldpasswordcontroller = TextEditingController();
TextEditingController _confirmpasswordcontroller = TextEditingController();

bool _isValidate = true;
var _oldpasswordvalidator;
var _confirmpasswordvalidator;
var _newpasswordvalidator;

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
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
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/images/resetpassword.png",
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

          Center(
            child: Container(
              child: Text(
                "Enter the new password",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(
                left: size.width * 0.05, right: size.width * 0.05),
            child: TextField(
              controller: _oldpasswordcontroller,
              obscureText: true,
              // readOnly: _isOtpSend,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                ),
                labelText: 'OldPassword',
                errorText: _oldpasswordvalidator,
                prefixIcon: Icon(Icons.lock),
              ),
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
              controller: _newpasswordcontroller,
              obscureText: true,
              // readOnly: _isOtpSend,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0),
                    ),
                  ),
                  labelText: 'New Password',
                  prefixIcon: Icon(Icons.lock),
                  errorText: _newpasswordvalidator),
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
              controller: _confirmpasswordcontroller,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                ),
                labelText: 'Confirm Password',
                errorText: _confirmpasswordvalidator,
                prefixIcon: Icon(Icons.lock),
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
                _changepass();
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

  Future<void> _changepass() async {
    //old password validation
    if (_oldpasswordcontroller.text.isEmpty) {
      setState(() {
        _oldpasswordvalidator = "Please enter your old password";
        _isValidate = true;
      });
    } else {
      setState(() {
        _oldpasswordvalidator = null;
        _isValidate = false;
      });
    }
    //new password validation
    if (_newpasswordcontroller.text.isEmpty) {
      setState(() {
        _newpasswordvalidator = "Please enter your new password";
        _isValidate = true;
      });
    } else {
      setState(() {
        _newpasswordvalidator = null;
        _isValidate = false;
      });
    }
    //confirm password validation
    if (_confirmpasswordcontroller.text.isEmpty) {
      setState(() {
        _confirmpasswordvalidator = "Please enter your confirm password";
        _isValidate = true;
      });
    } else if (_newpasswordcontroller.text != _confirmpasswordcontroller.text) {
      setState(() {
        _confirmpasswordvalidator = "Password Should be match";
        _isValidate = true;
      });
    } else {
      setState(() {
        _confirmpasswordvalidator = null;
        _isValidate = false;
      });
    }
    if (!_isValidate) {
      print("object");

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => new AlertDialog(
                  content: Row(
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text("Loading"),
                  )
                ],
              )));
      final prefs = await SharedPreferences.getInstance();
      var userId = prefs.getInt('userId');
      print(userId);
      var _authorization = prefs.getString('sessionToken');
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  change PAssword");
      String _refreshtoken = prefs.getString('refreshToken');

      final http.Response response =
          await http.post(AUTH_API + 'changePassword', body: {
        'oldPassword': _oldpasswordcontroller.text,
        'newPassword': _newpasswordcontroller.text,
        "userId": "$userId"
      }, headers: {
        "authorization": _authorization,
        "refreshtoken": _refreshtoken,
      });
      var responsedata = jsonDecode(response.body);
      print("hello");
      print(responsedata['message']);
      // print(responsedata['data']['user']['userType']);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: responsedata['message'].toString());
        Navigator.pop(context);
        Navigator.pop(context);
      } else if (response.statusCode == 401) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove(
          'name',
        );
        prefs.remove('sessionToken');
        prefs.remove('refreshToken');
        prefs.remove('userNumber');
        prefs.remove('userProfile');
        prefs.remove('customerName');
        prefs.remove('userId');
        prefs.remove('loginId');
        prefs.remove('userEmail');
        prefs.remove("loginBy");
        takeUser = false;
        emailid = null;
        photo = null;
        userName = null;

        prefs.setBool("_isAuthenticate", false);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        print("error");
        Fluttertoast.showToast(msg: responsedata['message'].toString());
        Navigator.pop(context);
      }
    }
  }
}
