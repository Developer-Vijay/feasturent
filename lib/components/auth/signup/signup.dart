import 'dart:convert';
import 'package:feasturent_costomer_app/components/auth/signup/otpcheck.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/messageWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
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

  // ignore: unused_field
  bool _isProcessing = false;
  // var _isEmailValidate;
  // var _isUserNameValidate;
  // var _isPhoneValidate;
  // var _isPasswordValidate;
  // bool _isValidate = true;
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final _formKey = GlobalKey<FormState>();

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
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 0),
                    child: Column(
                      children: [
                        //Username
                        TextFormField(
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
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Username cannot be empty ';
                            } else if (text.contains(" ")) {
                              return 'Username cannot contain the Space';
                            } else if (text.length <= 3) {
                              return "Username cannot be of three words ";
                            }
                            return null;
                          },
                          controller: _userNameController,
                        ),
                        SizedBox(height: 15),
                        //Phone Number
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          readOnly: _isOtpSend,
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
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone),
                            counterText: "",
                          ),
                          controller: _phoneNumberController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Mobile number Cant be empty  ';
                            } else if (text.length != 10) {
                              return "Mobile number should be of 10 digit ";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        //Email Address
                        TextFormField(
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
                          ),
                          controller: _emailController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Email id cannot be Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        //Password
                        TextFormField(
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
                          ),
                          controller: _passwordController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Password cannot be empty';
                            } else if (text.length < 8) {
                              return "Password Must be of 8 digits";
                            } else if (!RegExp(
                                    r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                                .hasMatch(text)) {
                              return "password must contain a Capiatl word , special character , number ";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      //Checkbox for accept T&C
                      Checkbox(
                        value: tncValue,
                        onChanged: (bool value) {
                          setState(() {
                            tncValue = value;
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
    print(_emailController.text);

    print(_passwordController.text);
    final isValid = _formKey.currentState.validate();

    setState(() {
      _isProcessing = true;
    });

    if (tncValue == true) {
      if (isValid == true) {
        print(" here isValida ### $isValid");
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
        print("isValida ### $isValid");
      }
    } else {
      setState(() {
        _isProcessing = false;
      });
      _stoastMessage(AcceptTnC);
    }
  }

  //Toast Message
  // ignore: missing_return
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
}
