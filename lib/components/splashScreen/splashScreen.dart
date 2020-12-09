import 'package:feasturent_costomer_app/components/auth/login/authenticate.dart';
import 'package:feasturent_costomer_app/components/onBoarding/appOnBoarding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenApp extends StatefulWidget {
  @override
  _SplashScreenAppState createState() => _SplashScreenAppState();
}

class _SplashScreenAppState extends State<SplashScreenApp> {
  bool _isOnboadingSeen = false;

  @override
  void initState() {
    super.initState();
    getSession();
  }

  getSession() async {
    //Local Session
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        prefs.getBool('isOnboadingSeen')
            ? _isOnboadingSeen = true
            : _isOnboadingSeen = false;
      } catch (error) {
        print(error);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 2,
      navigateAfterSeconds:
          _isOnboadingSeen ? UserAuthenticate(context) : OnboardingScreen(),
      title: new Text(
        'Feasturent',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            color: Color(0xff2549F3)),
      ),
      image: new Image.asset('assets/icons/feasturent.png'),
      // backgroundGradient: new LinearGradient(colors: [Colors.cyan, Colors.blue], begin: Alignment.topLeft, end: Alignment.bottomRight),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("Feasturent"),
      loaderColor: Color(0xffFF1577),
    );
  }
}
