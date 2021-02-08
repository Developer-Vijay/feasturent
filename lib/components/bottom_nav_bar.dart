import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/offerpage.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineouthome.dart';
import 'package:feasturent_costomer_app/screens/home/components/homePageBody.dart';

import 'package:feasturent_costomer_app/screens/profile/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Bottomnavbar extends StatefulWidget {
  @override
  _BottomnavbarState createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  Future<bool> _onbackpressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Do you really want to exit"),
              actions: [
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                )
              ],
            ));
  }

  int _page = 0;
  List<Widget> tabPages = [
    HomePageBody(),
    OfferPageScreen(),
    DineoutHomePage(),
    UserProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onbackpressed,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            animationDuration: Duration(milliseconds: 200),
            
            index: 0,
            height: 55,
            items: <Widget>[
              Icon(
                Icons.home_outlined,
                size: 30,
              ),
              SvgPicture.asset(
                "assets/icons/offer_bn_outline.svg",
                height: 30,
              ),
              SvgPicture.asset(
                "assets/icons/dineout_bn_outline.svg",
                height: 30,
              ),
              SvgPicture.asset("assets/icons/person.svg"),
            ],
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
          ),
          body: tabPages[_page],
        ),
      ),
    );
  }
}
