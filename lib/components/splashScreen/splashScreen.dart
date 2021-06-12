import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:feasturent_costomer_app/components/onBoarding/appOnBoarding.dart';
import 'package:feasturent_costomer_app/screens/home/home-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    try {
      InternetAddress.lookup('google.com').then((result) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          // internet conn available
          new Timer(new Duration(seconds: 3), () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    _isOnboadingSeen ? HomeScreen() : OnboardingScreen()));
          });
        } else {
          // no conn
          _showdialog();
        }
      }).catchError((error) {
        // no conn
        _showdialog();
      });
    } on SocketException catch (_) {
      // no internet
      _showdialog();
    }
    ConnectivityResult previous;

    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connresult) {
      if (connresult == ConnectivityResult.none) {
      } else if (previous == ConnectivityResult.none) {
        // internet conn
        new Timer(new Duration(seconds: 3), () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  _isOnboadingSeen ? HomeScreen() : OnboardingScreen()));
        });
      }

      previous = connresult;
    });
  }

  void _showdialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ERROR'),
        content: Text("No Internet Detected."),
        actions: <Widget>[
          FlatButton(
            // method to exit application programitacally
            onPressed: () =>
                SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            child: Text("Exit"),
          ),
        ],
      ),
    );
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
    // ignore: missing_required_param
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/feasturent_app_logo.png'),
            SizedBox(
              height: size.height * 0.4,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFF1577)),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
