import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/components/WishList/wishlist.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/Place_Order/MyOrders/my_orders.dart';
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

  bool home = true;
  bool myorder = false;
  bool wishlist = false;
  bool cart = false;
  bool setting = false;
  bool wallet = false;
  bool term = false;
  bool policy = false;
  bool logout = false;

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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: home == true ? Colors.blue : Colors.black87),
            ),
            dense: true,
            selected: home,
            onTap: () {
              setState(() {
                home = true;
                myorder = false;
                wishlist = false;
                cart = false;
                setting = false;
                wallet = false;
                term = false;
                policy = false;
                logout = false;
              });
              Navigator.pop(context);
              // Update the state of the app.
              // ...
            },
          ),
          widget.cStatus == 1
              ? ListTile(
                  leading: Icon(Icons.article),
                  title: Text(
                    'My Orders',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: myorder == true ? Colors.blue : Colors.black87),
                  ),
                  dense: true,
                  selected: myorder,
                  onTap: () {
                    setState(() {
                      home = false;
                      myorder = true;
                      wishlist = false;
                      cart = false;
                      setting = false;
                      wallet = false;
                      term = false;
                      policy = false;
                      logout = false;
                    });
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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: wishlist == true ? Colors.blue : Colors.black87),
            ),
            selected: wishlist,
            dense: true,
            onTap: () {
              setState(() {
                home = false;
                myorder = false;
                wishlist = true;
                cart = false;
                setting = false;
                wallet = false;
                term = false;
                policy = false;
                logout = false;
              });
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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: cart == true ? Colors.blue : Colors.black87),
            ),
            selected: cart,
            dense: true,
            onTap: () {
              setState(() {
                home = false;
                myorder = false;
                wishlist = false;
                cart = true;
                setting = false;
                wallet = false;
                term = false;
                policy = false;
                logout = false;
              });
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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: wallet == true ? Colors.blue : Colors.black87),
            ),
            selected: wallet,
            dense: true,
            onTap: () {
              setState(() {
                home = false;
                myorder = false;
                wishlist = false;
                cart = false;
                setting = false;
                wallet = true;
                term = false;
                policy = false;
                logout = false;
              });
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
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text(
          //     'Settings',
          //     style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 15,
          //         color: setting == true ? Colors.blue : Colors.black87),
          //   ),
          //   selected: setting,
          //   dense: true,
          //   onTap: () {
          //     setState(() {
          //       home = false;
          //       myorder = false;
          //       wishlist = false;
          //       cart = false;
          //       setting = true;
          //       wallet = false;
          //       term = false;
          //       policy = false;
          //       logout = false;
          //     });
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => SettingsScreen()),
          //     );
          //     // Update the state of the app.
          //     // ...
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.help_center),
            title: Text(
              'Term & Condition',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: term == true ? Colors.blue : Colors.black87),
            ),
            dense: true,
            selected: term,
            onTap: () {
              setState(() {
                home = false;
                myorder = false;
                wishlist = false;
                cart = false;
                setting = false;
                wallet = false;
                term = true;
                policy = false;
                logout = false;
              });
              _launchURL();
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text(
              'Privacy Policy',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: policy == true ? Colors.blue : Colors.black87),
            ),
            selected: policy,
            dense: true,
            onTap: () {
              setState(() {
                home = false;
                myorder = false;
                wishlist = false;
                cart = false;
                setting = false;
                wallet = false;
                term = false;
                policy = true;
                logout = false;
              });
              _launchURL();
            },
          ),
          widget.cStatus == 1
              ? ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: logout == true ? Colors.blue : Colors.black87),
                  ),
                  selected: logout,
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
                                    setState(() {
                                      home = false;
                                      myorder = false;
                                      wishlist = false;
                                      cart = false;
                                      setting = false;
                                      wallet = false;
                                      term = false;
                                      policy = false;
                                      logout = true;
                                    });
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
