import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/SettingsPage/settings.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/components/WishList/wishlist.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/Place_Order/my_orders.dart';
import 'package:feasturent_costomer_app/components/WalletScreen/walletscreen.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
    getWalletDetaile();
    setState(() {
      datastatus = widget.cStatus;
    });
  }

  int datastatus;
  var walletdetails;
  Future getWalletDetaile() async {
    final prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('userId');
    String _authorization = prefs.getString('sessionToken');
    var result = await http.get(
        'http://18.223.208.214/api/payment/userWalletAndTransaction/$userid',
        headers: {
          "Content-type": "application/json",
          "authorization": _authorization,
        });
    walletdetails = json.decode(result.body)['data'];
    print(walletdetails);

    return walletdetails;
  }

  bool isenabled = false;
  loginCheckForData() {
    if (widget.cStatus == 1) {
      return Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 4),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xffF8F9FE),
                child: ClipOval(
                    child: widget.cProfile == null
                        ? Image.asset("assets/images/loginuser.png")
                        : CachedNetworkImage(
                            imageUrl: widget.cProfile,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/feasturenttemp.jpeg",
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

  @override
  Widget build(BuildContext context) {
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
              child: loginCheckForData()),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
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
                  title: Text('MyOrders'),
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
            title: Text('Wishlist'),
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
            title: Text('Cart'),
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
            title: Text('Wallet'),
            dense: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WalletDesign(
                          status: datastatus,
                        )),
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
            title: Text('Settings'),
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
            title: Text('Help & Support'),
            dense: true,
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            dense: true,
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
            dense: true,
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          widget.cStatus == 1
              ? ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
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
