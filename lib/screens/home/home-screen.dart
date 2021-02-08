import 'dart:convert';

import 'package:feasturent_costomer_app/screens/home/components/category_list.dart';
import 'package:feasturent_costomer_app/screens/home/components/discount_card.dart';
import 'package:feasturent_costomer_app/screens/home/components/homeAppBar.dart';
import 'package:feasturent_costomer_app/screens/home/components/homePageBody.dart';
import 'package:feasturent_costomer_app/screens/home/components/item_list.dart';
import 'package:feasturent_costomer_app/screens/home/components/popular.dart';

import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/components/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;

import 'package:feasturent_costomer_app/components/appDrawer.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _customerUserId = 0;
  String _customerName = '';
  String _customerProfile = '';
  String _customerEmail = '';
  String _authorization = '';
  String _refreshtoken = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
  }

  Future<void> getSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _customerUserId = prefs.getInt('userId');
      _authorization = prefs.getString('sessionToken');
      _refreshtoken = prefs.getString('refreshToken');
      var response = await http.get(
          USER_API + 'users?key=SINGLE&userId=' + _customerUserId.toString(),
          headers: {
            "authorization": _authorization,
            "refreshtoken": _refreshtoken,
            "Content-Type": "application/json"
          });
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(responseData['data'][0]['profile']);
        setState(() {
          _customerName = responseData['data'][0]['name'] +
              ' ' +
              responseData['data'][0]['lastName'];
          _customerEmail = responseData['data'][0]['email'];
          _customerProfile = responseData['data'][0]['profile'];
        });
      } else {
        print('ERROR');
      }
    } catch (error) {
      print(error);
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
    
      bottomNavigationBar: Bottomnavbar(),
      drawer: AppDrawer(
          cName: _customerName,
          cProfile: _customerProfile,
          cEmail: _customerEmail),
          body: HomePageBody(),
     
    );
  }
}
