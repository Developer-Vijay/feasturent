import 'package:feasturent_costomer_app/SettingsPage/settings.dart';
import 'package:feasturent_costomer_app/components/AddressBook/newAddressPage.dart';
import 'package:feasturent_costomer_app/components/WalletScreen/walletscreen.dart';
import 'package:feasturent_costomer_app/components/auth/Forgotpassword/forgotpassword.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final index;
  final bool hasNavigation;
  const ProfileListItem(
      {Key key, this.icon, this.text, this.hasNavigation = true, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (index == 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EditProfile()));
        } else if (index == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddressList()));
        } else if (index == 2) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Forgot()));
        } else if (index == 3) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WalletDesign()));
        } else if (index == 4) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SettingsScreen()));
        } else if (index == 6) {
          return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Do you really want to logout"),
                    actions: [
                      FlatButton(
                        child: Text("Yes"),
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove(
                            'name',
                          );
                          prefs.remove('sessionToken');
                          prefs.remove('refreshToken');
                          prefs.remove('userNumber');
                          prefs.remove('userProfile');
                          prefs.remove('customerName');
                          prefs.remove('userId');
                          prefs.remove('loginId');
                          prefs.remove('userEmail');
                          prefs.remove("loginBy");

                          prefs.setBool("_isAuthenticate", false);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                      ),
                      FlatButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ));
        }
      },
      child: Container(
        height: kSpacingUnit.w * 5.5,
        margin: EdgeInsets.symmetric(
          horizontal: kSpacingUnit.w * 4,
        ).copyWith(
          bottom: kSpacingUnit.w * 2,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: kSpacingUnit.w * 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.icon,
              size: kSpacingUnit.w * 2.5,
            ),
            SizedBox(width: kSpacingUnit.w * 1.5),
            Text(
              this.text,
              style: kTitleTextStyle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            if (this.hasNavigation)
              Icon(
                LineAwesomeIcons.angle_right,
                size: kSpacingUnit.w * 2.5,
              ),
          ],
        ),
      ),
    );
  }
}
