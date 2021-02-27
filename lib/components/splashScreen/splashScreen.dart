import 'package:feasturent_costomer_app/components/auth/login/authenticate.dart';
import 'package:feasturent_costomer_app/components/onBoarding/appOnBoarding.dart';
import 'package:feasturent_costomer_app/screens/home/home-screen.dart';
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
    Size size = MediaQuery.of(context).size;
    return new SplashScreen(
      seconds: 2,
      navigateAfterSeconds:
          _isOnboadingSeen ? HomeScreen() : OnboardingScreen(),
      
      image: new Image.asset('assets/images/feasturent_app_logo.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: size.height * 0.14,
      onClick: () => print("Feasturent"),
      loaderColor: Color(0xffFF1577),
    );
  }
}
