import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/components/bottom_nav_bar.dart';
// import 'package:feasturent_costomer_app/screens/home/components/homeAppBar.dart';
import 'package:feasturent_costomer_app/screens/home/components/body.dart';
import 'package:feasturent_costomer_app/components/appDrawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:feasturent_costomer_app/constants.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        title: RichText(
          text: TextSpan(
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: "Feas",
                style: TextStyle(color: ksecondaryColor),
              ),
              TextSpan(
                text: "Turent",
                style: TextStyle(color: kPrimaryColor),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/notification.svg"),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
      drawer: AppDrawer(),
      body: Body(),
    );
  }
}
