import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/profile/components/profileItemList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kLightTheme,
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: ProfileScreen(),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // bool finalUser = true;
  // int temp;
  // var email;
  // var photo;
  var name;
  @override
  void initState() {
    super.initState();
    setState(() {
      getsession();
    });
  }

  getsession() async {}

  Widget _buildloginCheck(size) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: kSpacingUnit.w * 5,
            ),
            Container(
              height: kSpacingUnit.w * 10,
              width: kSpacingUnit.w * 10,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xffF8F9FE),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: photo == null
                        ? Image.asset("assets/images/loginuser.png")
                        : CachedNetworkImage(
                            imageUrl: S3_BASE_PATH + photo,
                            fit: BoxFit.fill,
                            width: size.width * 0.33,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/loginuser.png",
                              fit: BoxFit.cover,
                            ),
                          )),
              ),
              //CachedNetworkImageProvider('$photo')),
            ),
            SizedBox(height: kSpacingUnit.w * 2),
            Container(
                child: userName == null
                    ? Text(
                        "UserName",
                        style: kTitleTextStyle,
                      )
                    : Text("$userName")),
            SizedBox(height: kSpacingUnit.w * 2),
            Container(
                child: emailid == null
                    ? Text(
                        "Email Id",
                        style: kTitleTextStyle,
                      )
                    : Text("$emailid")),
            SizedBox(height: kSpacingUnit.w * 2),
          ],
        ),
        ProfileListItem(
            icon: LineAwesomeIcons.user_shield,
            text: 'Edit Profile',
            index: 0,
            hasNavigation: true),
        ProfileListItem(
          icon: LineAwesomeIcons.address_card,
          text: 'Addresses',
          index: 1,
          hasNavigation: true,
        ),
        ProfileListItem(
          icon: LineAwesomeIcons.history,
          text: 'Change Password',
          index: 2,
        ),
        ProfileListItem(
          icon: LineAwesomeIcons.question_circle,
          text: 'Wallet',
          index: 3,
        ),
        ProfileListItem(
          icon: LineAwesomeIcons.cog,
          text: 'Settings',
          index: 4,
        ),
        ProfileListItem(
          icon: LineAwesomeIcons.user_plus,
          text: 'Invite a Friend',
          index: 5,
        ),
        ProfileListItem(
          icon: LineAwesomeIcons.alternate_sign_out,
          text: 'Logout',
          index: 6,
          hasNavigation: true,
        ),
      ],
    );
  }

  Widget _buildElseCheck() {
    return Column(
      children: [
        Container(
          height: kSpacingUnit.w * 15,
          width: kSpacingUnit.w * 22,
          child: Image.asset(
            "assets/images/feasturent_app_logo.png",
            fit: BoxFit.contain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            "ACCOUNT",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 15),
            child: Text(
              "Login/Create Account",
              style: TextStyle(fontSize: 10),
            )),
        SizedBox(
          height: 15,
        ),
        MaterialButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: Text("Login"),
          color: Colors.blue,
          textColor: Colors.white,
          minWidth: 345,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          height: 50,
        ),
        SizedBox(
          height: 20,
        ),
        ProfileListItem(
          icon: LineAwesomeIcons.cog,
          text: 'Settings',
          hasNavigation: true,
          index: 4,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                    child: Container(
                        child: takeUser == true
                            ? _buildloginCheck(size)
                            : _buildElseCheck()))
              ],
            ),
          );
        },
      ),
    );
  }
}
