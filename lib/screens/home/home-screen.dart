import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/offerpage.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineouthome.dart';
import 'package:feasturent_costomer_app/screens/home/components/homePageBody.dart';
import 'package:feasturent_costomer_app/screens/home/components/notificationPage.dart';
import 'package:feasturent_costomer_app/screens/profile/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:feasturent_costomer_app/components/appDrawer.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/searchBarFunction.dart';

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
  double add1;
  double add2;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
    getCurrentLocation();
  }

  Coordinates coordinates;
  String temp1;
  String locality = '';
  String area = '';
  String state = '';
  var location = "Unable to load your location";

  getCurrentLocation() async {
    final geopostion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      add1 = geopostion.latitude;
      add2 = geopostion.longitude;
      print(add1);
      print(add2);
      coordinates = Coordinates(add1, add2);
      print(coordinates);
    });
    var temp = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    locality = temp.first.featureName;
    area = temp.first.subLocality;
    state = temp.first.adminArea;
    setState(() {
      if (locality == null) {
        location = "$area , $state";
      } else if (area == null) {
        location = "$locality , $state";
      } else if (state == null) {
        location = "$locality , $area";
      } else {
        location = "$locality , $area , $state";
      }
    });

    // Fluttertoast.showToast(msg: "$location");
    showDialog(
      context: context,
      barrierDismissible: false,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.height * 0.35,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.1,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.48,
                      width: MediaQuery.of(context).size.height * 0.35,
                      color: Colors.lightBlue,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: MediaQuery.of(context).size.height * 0.1,
                    // right: MediaQuery.of(context).size.height * 0.7,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage("assets/icons/feasturent.png"),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.cancel_outlined,
              size: 40,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
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

  _buildChangeTextApp() {
    if (_page == 0) {
      return RichText(
        text: TextSpan(
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: "Feas",
              style: TextStyle(
                color: ksecondaryColor,
                fontSize: MediaQuery.of(context).size.height * 0.028,
              ),
            ),
            TextSpan(
              text: "Turent",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: MediaQuery.of(context).size.height * 0.028,
              ),
            ),
          ],
        ),
      );
    } else if (_page == 1) {
      return Text(
        "Offers",
        style: TextStyle(
            color: kPrimaryColor,
            fontSize: MediaQuery.of(context).size.height * 0.028,
            fontWeight: FontWeight.bold),
      );
    } else if (_page == 2) {
      return RichText(
        text: TextSpan(
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: "Dine",
              style: TextStyle(
                color: ksecondaryColor,
                fontSize: MediaQuery.of(context).size.height * 0.028,
              ),
            ),
            TextSpan(
              text: "Out",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: MediaQuery.of(context).size.height * 0.028,
              ),
            ),
          ],
        ),
      );
    }
  }

  _buildAppBar(_page) {
    if (_page == 3) {
      return SizedBox();
    } else {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                IconButton(
                    icon: SvgPicture.asset("assets/icons/menu.svg"),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    }),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildChangeTextApp(),
                  Text(
                    "$location",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: SvgPicture.asset("assets/icons/search.svg"),
              onPressed: () {
                showSearch(context: context, delegate: Searchbar(), query: "");
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: SvgPicture.asset("assets/icons/notification.svg"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationSheet()));
              },
            ),
          ),
        ],
      );
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: _onbackpressed,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(
            cName: _customerName,
            cProfile: _customerProfile,
            cEmail: _customerEmail),
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 200),
          index: 0,
          height: sized.height * 0.08,
          items: <Widget>[
            Icon(
              Icons.home_outlined,
              size: sized.height * 0.035,
            ),
            SvgPicture.asset(
              "assets/icons/offer_bn_outline.svg",
              height: sized.height * 0.035,
            ),
            SvgPicture.asset(
              "assets/icons/dineout_bn_outline.svg",
              height: sized.height * 0.035,
            ),
            SvgPicture.asset(
              "assets/icons/person.svg",
              height: sized.height * 0.03,
            ),
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 2,
              child: _buildAppBar(_page),
            ),
            Expanded(flex: 17, child: tabPages[_page]),
          ],
        ),
      ),
    );
  }
}
