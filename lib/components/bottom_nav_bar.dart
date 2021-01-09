import 'package:feasturent_costomer_app/screens/home/home-screen.dart';
import 'package:feasturent_costomer_app/screens/profile/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 75,
      width: double.infinity,
      // double.infinity means it cove the available width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -7),
            blurRadius: 33,
            color: Color(0xFF6DAED9).withOpacity(0.11),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            tooltip: 'Home',
            icon: SvgPicture.asset("assets/icons/home.svg"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Dineout',
            icon: SvgPicture.asset("assets/icons/dineout_bn_outline.svg"),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'Offers',
            icon: SvgPicture.asset("assets/icons/offer_bn_outline.svg"),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'Profile',
            icon: SvgPicture.asset("assets/icons/person.svg"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return UserProfilePage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
