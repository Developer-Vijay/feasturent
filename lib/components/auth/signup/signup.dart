import 'dart:convert';
import 'package:feasturent_costomer_app/components/auth/signup/otpcheck.dart';
import 'package:feasturent_costomer_app/components/common/validator.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/messageWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool tncValue = false;
  bool _isOtpSend = false;
  int registeredUserId;

  bool _isProcessing = false;
  var _isEmailValidate;
  var _isUserNameValidate;
  var _isPhoneValidate;
  var _isPasswordValidate;
  bool _isValidate = true;
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //Controllers
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(children: [
        Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: size.height * 0.1),
                Image.asset(
                  'assets/images/feasturent_app_logo.png',
                  height: size.height * 0.15,
                  width: size.width * 0.6,
                ),
                Text('Signup',
                    style: GoogleFonts.pacifico(
                        textStyle: TextStyle(
                            color: kPrimaryColor,
                            letterSpacing: .5,
                            fontSize: 40))),
                SizedBox(height: 10),
                //Login Form
                Container(
                  padding:
                      EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
                  child: Column(
                    children: [
                      //Username
                      TextField(
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        readOnly: _isOtpSend,
                        maxLength: 12,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                            ),
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person),
                            counterText: "",
                            errorText: _isUserNameValidate),
                        controller: _userNameController,
                      ),
                      SizedBox(height: 15),
                      //Phone Number
                      TextField(
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        readOnly: _isOtpSend,
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
                            errorText: _isPhoneValidate),
                        controller: _phoneNumberController,
                      ),
                      SizedBox(height: 15),
                      //Email Address
                      TextField(
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        readOnly: _isOtpSend,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                            ),
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email),
                            errorText: _isEmailValidate),
                        controller: _emailController,
                      ),
                      SizedBox(height: 15),
                      //Password
                      TextField(
                        obscureText: _obscureText,
                        readOnly: _isOtpSend,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                            ),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: InkWell(
                                onTap: _toggle,
                                child: new Icon(
                                  (_obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  size: 17,
                                )),
                            errorText: _isPasswordValidate),
                        controller: _passwordController,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      //Checkbox for accept T&C
                      Checkbox(
                        value: this.tncValue,
                        onChanged: (bool value) {
                          setState(() {
                            this.tncValue = value;
                          });
                        },
                      ),
                      //Term & Condition
                      FlatButton(
                        onPressed: () {
                          _launchURL();
                        },
                        child: Text(
                          "Accept our term & condition",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ),
                //Login Button
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: RaisedButton(
                    padding: EdgeInsets.all(5),
                    onPressed: () {
                      _signupBymobile();
                    },
                    child: Text('Signup',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Have an account",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, color: Colors.black),
                    ),
                    FlatButton(
                      padding: EdgeInsets.zero,
                      minWidth: 60,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.blue[700],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  //Signup request api
  Future<void> _signupBymobile() async {
    setState(() {
      _isProcessing = true;
    });
    //Email Validate
    if (_emailController.text.isEmpty &&
        isEmail(_emailController.text) &&
        _emailController.text.length < 7) {
      setState(() {
        _isEmailValidate = "Email id cannot be Empty";
        _isValidate = false;
      });
    } else {
      setState(() {
        _isEmailValidate = null;
        _isValidate = true;
      });
    }
    //Phone Validate
    if (_phoneNumberController.text.isEmpty) {
      setState(() {
        _isPhoneValidate = "Mobile number Cant be empty ";
        _isValidate = false;
      });
    } else if (_phoneNumberController.text.length < 10) {
      _isPhoneValidate = "Mobile number should be of 10 digit ";
      _isValidate = false;
    } else {
      setState(() {
        _isPhoneValidate = null;
        _isValidate = true;
      });
    }
    //Username Validation
    if ((_userNameController.text.isEmpty)) {
      setState(() {
        _isUserNameValidate = "Username cannot be empty ";
        _isValidate = false;
      });
    } else if ((_userNameController.text.length) <= 3) {
      setState(() {
        _isUserNameValidate = "Username cannot be of three words ";
        _isValidate = false;
      });
    } else if (_userNameController.text.contains(" ")) {
      setState(() {
        _isUserNameValidate = "Username cannot contain the Space";
        _isValidate = false;
      });
    } else {
      setState(() {
        _isUserNameValidate = null;
        _isValidate = true;
      });
    }
    //Phone Validation
    if (_passwordController.text.isEmpty) {
      setState(() {
        _isPasswordValidate = "Password cannot be empty";
        _isValidate = false;
      });
    } else if (_passwordController.text.length < 8) {
      setState(() {
        _isPasswordValidate = "Password Must be of 8 digits";
        _isValidate = false;
      });
    } else if (!RegExp(
            r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
        .hasMatch(_passwordController.text)) {
      setState(() {
        _isPasswordValidate =
            "password must contain a Capiatl word , special character , number ";
        _isValidate = false;
      });
    } else {
      setState(() {
        _isPasswordValidate = null;
        _isValidate = true;
      });
    }

    if (tncValue == true && _isValidate) {
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  signup");

      var response = await http.post(USER_API + 'signup', body: {
        'userName': _userNameController.text,
        'password': _passwordController.text,
        'phone': _phoneNumberController.text,
        'email': _emailController.text
      });
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _stoastMessage(VerifyAcount);
        setState(() {
          _isOtpSend = true;
          registeredUserId = responseData['data']['userId'];
          _isProcessing = false;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpChecker(
                      phone: _phoneNumberController.text,
                      resgUserId: registeredUserId.toString(),
                    )),
          );
        });
      } else {
        _stoastMessage(responseData['message']);
        setState(() {
          _isProcessing = false;
        });
      }
    } else {
      setState(() {
        _isProcessing = false;
      });
      _stoastMessage(AcceptTnC);
    }
  }

  //Toast Message
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

  _launchURL() async {
    const url = 'http:/feasturent.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

//Verify otp
  _openPopup(context) {
    Alert(
        context: context,
        title: "Verify Account",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Username',
              ),
            ),
            TextField(
              obscureText: true,
              readOnly: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Verify",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
