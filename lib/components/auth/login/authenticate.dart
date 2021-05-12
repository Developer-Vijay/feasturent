import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/screens/home/home-screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
Future<void> UserAuthenticate(context) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('_isAuthenticate')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ),
    );
  } else {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ),
    );
  }
}
