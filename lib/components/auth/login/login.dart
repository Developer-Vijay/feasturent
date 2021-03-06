import 'dart:convert';
import 'package:feasturent_costomer_app/components/auth/Forgotpassword/forgotpassword.dart';
import 'package:feasturent_costomer_app/components/auth/login/authenticate.dart';
import 'package:feasturent_costomer_app/components/auth/login/loginWithGoolge.dart';
import 'package:feasturent_costomer_app/components/auth/signup/otpcheck.dart';
import 'package:feasturent_costomer_app/components/auth/signup/signup.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/home-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isValidate = true;
  bool _obscureText = true;
  // ignore: unused_field
  bool _isProcessing = false;
  bool _isUserNameValidate = true;
  bool _isPasswordValidate = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<bool> backbutton() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Don't want to login"),
              actions: [
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                )
              ],
            ));
  }

  //Controllers
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: backbutton,
      child: Scaffold(
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
                  Text('Login',
                      style: GoogleFonts.pacifico(
                          textStyle: TextStyle(
                              color: kPrimaryColor,
                              letterSpacing: .5,
                              fontSize: size.height * 0.05))),
                  SizedBox(height: 10),
                  //Login Form
                  Container(
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 0),
                    child: Column(
                      children: [
                        TextField(
                          autofocus: true,
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                              ),
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Username',
                              errorText: _isUserNameValidate == false
                                  ? 'Please enter your username'
                                  : null),
                          controller: _userNameController,
                        ),
                        SizedBox(height: 15),
                        //Password
                        TextField(
                          autofocus: true,
                          obscureText: _obscureText,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                              ),
                              labelText: 'Password',
                              suffixIcon: InkWell(
                                  onTap: _toggle,
                                  child: new Icon(
                                    (_obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    size: 17,
                                  )),
                              prefixIcon: Icon(Icons.lock_outline),
                              errorText: _isPasswordValidate == false
                                  ? 'Please enter your password'
                                  : null),
                          controller: _passwordController,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Forget Password
                      Container(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Forgot()),
                            );
                          },
                          child: Text(
                            "Forget Password ?",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.blue[900]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Login Button
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: RaisedButton(
                      padding: EdgeInsets.all(5),
                      onPressed: () {
                        _loginUser();
                      },
                      child: Text('Login',
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
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          height: 2.0,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.0),
                        child: Text("OR",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 20.0),
                          height: 2.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  //Login With Social
                  Container(
                    width: size.width * 1,
                    margin: const EdgeInsets.symmetric(horizontal: 100),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Login With Google
                        IconButton(
                          icon: SvgPicture.asset('assets/icons/google.svg'),
                          tooltip: 'Login With Goolge',
                          iconSize: 40,
                          onPressed: () {
                            setState(() => {
                                  signInWithGoogle()
                                      .whenComplete(() => {_signUpBySocial()})
                                });
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        //Login With FaceBook
                        IconButton(
                          icon: SvgPicture.asset('assets/icons/facebook.svg'),
                          tooltip: 'Login With Facebook',
                          iconSize: 40,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Not yet account",
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
                                  builder: (context) => SignupPage()));
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.blue[900]),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

//Login user
  Future<void> _loginUser() async {
    //localStorage
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _isProcessing = true;
    });
    //Username validation
    if (_userNameController.text.isEmpty) {
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

    //Password Validation
    if (_passwordController.text.isEmpty) {
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

    if (_isValidate) {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (_) => new AlertDialog(
                  content: Row(
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text("Loading"),
                  ),
                ],
              )));
      print("before hit server");
      var response = await http.post(AUTH_API + 'login', body: {
        'userName': _userNameController.text,
        'password': _passwordController.text,
      });
      print(" hit server");
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(responseData['data']);
        if (responseData['data']['user']['userType'] == 'USER') {
          _stoastMessage('LOGIN SUCCESSFUL', SUCCESSSTATUS);

          prefs.setString('sessionToken', responseData['data']['sessionToken']);
          prefs.setString("refreshToken", responseData['data']['refreshToken']);
          prefs.setString("userNumber", responseData['data']['user']['phone']);
          prefs.setString("userProfile", responseData['data']['profile']);
          prefs.setInt("userId", responseData['data']['user']['userId']);
          prefs.setInt("loginId", responseData['data']['user']['loginId']);
          prefs.setString("userEmail", responseData['data']['user']['email']);
          prefs.setString("loginBy", "userName");

          prefs.setBool("_isAuthenticate", true);
          prefs.setString('name', _userNameController.text);
          UserAuthenticate(context);
          setState(() {
            _isProcessing = false;
          });
        } else {
          Fluttertoast.showToast(
              msg: "User not found",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP_RIGHT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() {
            _isProcessing = false;
            Navigator.pop(context);
          });
        }
      } else if (responseData['message'] ==
          "Your mobile number is not verified") {
        setState(() {
          _isProcessing = false;
          Navigator.pop(context);
        });
        _stoastMessage("Verify your phone number", ERRORSTATUS);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpChecker(
                    phone: "        ",
                    resgUserId: responseData['userId'].toString(),
                  )),
        );
      } else {
        _stoastMessage(responseData['message'], ERRORSTATUS);
        setState(() {
          _isProcessing = false;
          Navigator.pop(context);
        });
      }
    } else {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  //Signup By social media
  Future<void> _signUpBySocial() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    //localStorage
    final prefs = await SharedPreferences.getInstance();
    var response = await http.post(USER_API + 'signupBysocial', body: {
      'phone': user.phoneNumber == null ? '' : user.phoneNumber,
      'email': user.email,
      'profile': user.photoUrl,
      'displayName': user.displayName,
    });
    var responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _stoastMessage('LOGIN SUCCESSFUL', SUCCESSSTATUS);
      prefs.setString('sessionToken', responseData['data']['sessionToken']);
      prefs.setString("refreshToken", responseData['data']['refreshToken']);
      prefs.setString("userNumber", responseData['data']['user']['phone']);
      prefs.setString("userProfile", user.photoUrl);
      prefs.setString("customerName", user.displayName);
      prefs.setInt("userId", responseData['data']['user']['userId']);
      prefs.setInt("loginId", responseData['data']['user']['loginId']);
      prefs.setString("userEmail", responseData['data']['user']['email']);
      prefs.setString("loginBy", "google");
      prefs.setBool("_isAuthenticate", true);
      UserAuthenticate(context);
    } else {
      _stoastMessage('LOGIN FAILD!', ERRORSTATUS);
    }
  }

  //Toast Message

  // ignore: missing_return
  Future<void> _stoastMessage(message, status) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: status == 'ERROR' ? Colors.red : Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
