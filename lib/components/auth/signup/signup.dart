import 'dart:convert';
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
  int _registeredUserId;
  bool _isProcessing = false;
  bool _isEmailValidate = true;
  bool _isUserNameValidate = true;
  bool _isPhoneValidate = true;
  bool _isPasswordValidate = true;
  bool _isValidate = true;

  //Controllers
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _otpController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Signin'),
      //   elevation: 0,
      // ),
      body: Container(
        // padding: EdgeInsets.only(top:60),
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              Image.asset(
                'assets/icons/feasturent.png',
                height: 170,
                width: 170,
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
                          counterText: "",
                          errorText: _isUserNameValidate == true
                              ? null
                              : 'Please enter valid username'),
                      controller: _userNameController,
                    ),
                    SizedBox(height: 15),
                    //Phone Number
                    TextField(
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
                          counterText: "",
                          errorText: _isPhoneValidate == true
                              ? null
                              : 'Please enter valid phone number'),
                      controller: _phoneNumberController,
                    ),
                    SizedBox(height: 15),
                    //Email Address
                    TextField(
                      obscureText: false,
                      readOnly: _isOtpSend,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Email Address',
                          errorText: _isEmailValidate == true
                              ? null
                              : 'Please enter valid email address'),
                      controller: _emailController,
                    ),
                    SizedBox(height: 15),
                    //Password
                    TextField(
                      obscureText: true,
                      readOnly: _isOtpSend,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Password',
                          errorText: _isPasswordValidate == true
                              ? null
                              : 'Please enter valid password'),
                      controller: _passwordController,
                    ),
                    SizedBox(height: 15),
                    //Otp
                    _isOtpSend == true
                        ? TextField(
                            obscureText: false,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.,]')),
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
                          )
                        : Container(),
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
                    _isOtpSend == false ? _signupBymobile() : _verifyOtp();
                  },
                  child: _isOtpSend == false
                      ? Text('Signup',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold))
                      : Text('Verify',
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
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  "Have an account, Login",
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ),
      ),
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
        _isEmailValidate = false;
        _isValidate = false;
      });
    } else {
      setState(() {
        _isEmailValidate = true;
        _isValidate = true;
      });
    }
    //Phone Validate
    if (_phoneNumberController.text.isEmpty &&
        _phoneNumberController.text.length < 10) {
      setState(() {
        _isPhoneValidate = false;
        _isValidate = false;
      });
    } else {
      setState(() {
        _isPhoneValidate = true;
        _isValidate = true;
      });
    }
    //Username Validation
    if ((_userNameController.text.isEmpty) &&
        (_userNameController.text.length) <= 3) {
      setState(() {
        _isUserNameValidate = false;
        _isValidate = false;
      });
    } else {
      setState(() {
        _isUserNameValidate = true;
        _isValidate = true;
      });
    }
    //Phone Validation
    if (_passwordController.text.isEmpty &&
        _passwordController.text.length < 3) {
      setState(() {
        _isPasswordValidate = false;
        _isValidate = false;
      });
    } else {
      setState(() {
        _isPasswordValidate = true;
        _isValidate = true;
      });
    }

    if (tncValue == true && _isValidate) {
      var response = await http.post(USER_API + 'signup', body: {
        'userName': _userNameController.text,
        'password': _passwordController.text,
        'phone': _phoneNumberController.text,
        'email': _emailController.text
      });
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(responseData['data']['userId']);
        _stoastMessage(VerifyAcount);
        setState(() {
          _isOtpSend = true;
          _registeredUserId = responseData['data']['userId'];
          _isProcessing = false;
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

  //Verify user otp
  Future<void> _verifyOtp() async {
    if (tncValue == true) {
      var response = await http.post(AUTH_API + 'verifyOtp', body: {
        'otp': _otpController.text,
        'userId': _registeredUserId.toString()
      });
      print(response.body);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _stoastMessage(responseData['message']);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        _stoastMessage(responseData['message']);
      }
    } else {
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
