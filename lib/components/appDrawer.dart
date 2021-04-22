import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/SettingsPage/settings.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/components/WishList/wishlist.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/Place_Order/my_orders.dart';
import 'package:feasturent_costomer_app/components/WalletScreen/walletscreen.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatefulWidget {
  final int cStatus;
  final String cName;
  final String cProfile;
  final String cEmail;
  const AppDrawer(
      {Key key, this.cStatus, this.cName, this.cProfile, this.cEmail})
      : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
  }

  bool isenabled = false;
  loginCheckForData(size) {
    if (widget.cStatus == 1) {
      return Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 4),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xffF8F9FE),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: widget.cProfile == null
                        ? Image.asset("assets/images/loginuser.png")
                        : CachedNetworkImage(
                            imageUrl: S3_BASE_PATH + widget.cProfile,
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
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.003,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 2),
              child: Column(
                children: [
                  Text(
                    widget.cName != null ? widget.cName : ' ',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        color: Colors.white),
                  ),
                  Text(widget.cEmail != null ? widget.cEmail : ' ',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 4),
                height: MediaQuery.of(context).size.height * 0.125,
                child: Image.asset("assets/images/feasturent_app_logo.png")),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
                padding: EdgeInsets.only(bottom: 0),
                child: InkWell(
                  child: Text("Login",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ))
          ],
        ),
      );
    }
  }

  _launchURL() async {
    const url = 'http:/feasturent.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              padding: EdgeInsets.only(bottom: 5, top: 3),
              decoration: BoxDecoration(
                color: Color(0xFF3498E5),
              ),
              child: loginCheckForData(size)),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            dense: true,
            selected: true,
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          widget.cStatus == 1
              ? ListTile(
                  leading: Icon(Icons.article),
                  title: Text(
                    'MyOrders',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  dense: true,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyOrders()));
                    // Update the state of the app.
                    // ...
                  },
                )
              : SizedBox(),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
              'Wishlist',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            dense: true,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Wishlist()));
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text(
              'Cart',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            dense: true,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text(
              'Wallet',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            dense: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletDesign()),
              );
              // Update the state of the app.
              // ...
            },
          ),
          Divider(
            color: Colors.blue,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            dense: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.help_center),
            title: Text(
              'Term & Condition',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            dense: true,
            onTap: () {
              _launchURL();
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text(
              'Privacy Policy',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            dense: true,
            onTap: () {
              _launchURL();
            },
          ),
          widget.cStatus == 1
              ? ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    'Logout',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  dense: true,
                  onTap: () async {
                    return showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Do you really want to logout"),
                              actions: [
                                FlatButton(
                                  child: Text("Yes"),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    Navigator.pop(context);

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
                                    takeUser = false;
                                    emailid = null;
                                    photo = null;
                                    userName = null;

                                    prefs.setBool("_isAuthenticate", false);
                                    setState(() {
                                      loginstatus = 0;
                                    });
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

                    // Update the state of the app.
                    // ...
                  },
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
