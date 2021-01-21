import 'package:feasturent_costomer_app/components/auth/Forgotpassword/forgotpassword.dart';
import 'package:feasturent_costomer_app/components/auth/Forgotpassword/otp.dart';
import 'package:feasturent_costomer_app/components/auth/Forgotpassword/resetpassword.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';


import 'package:feasturent_costomer_app/components/splashScreen/splashScreen.dart';
import 'package:feasturent_costomer_app/screens/home/components/item_card.dart';
import 'package:feasturent_costomer_app/screens/home/components/popularItem.dart';
import 'package:feasturent_costomer_app/screens/home/slider.dart';
import 'package:feasturent_costomer_app/screens/profile/cake.dart';
import 'package:feasturent_costomer_app/screens/profile/components/rating.dart';
import 'package:feasturent_costomer_app/screens/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/home-screen.dart';

// void main() => runApp(MyApp());

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      //Add Route to the main Page.
      routes: {
        '/homePage': (context) => HomeScreen(),
        '/loginPage': (context) => LoginPage()
      },
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          body1: TextStyle(color: ksecondaryColor),
          body2: TextStyle(color: ksecondaryColor),
        ),
      ),
     
       home: SplashScreenApp(),
      //  home:RatingPage(),
    );
  }
}
