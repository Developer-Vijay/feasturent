import 'dart:async';
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
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:feasturent_costomer_app/components/appDrawer.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/searchBarFunction.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

const kGoogleApiKey = "AIzaSyCg54XwhQZYIkN7gpaj3wy9__mxvYQB6oE";

// to get places detail (lat/lng)
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _loginstatus = 0;
  int _customerUserId = 0;
  String _customerName;
  String _customerProfile;
  String _customerEmail;
  String _authorization = '';
  String _refreshtoken = '';

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
    OfferPageScreen(null),
    DineoutHomePage(),
    UserProfilePage()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
    getCurrentLocation();
    checkDate();
  }

  DateTime _currentDate;
  String getdate;
  var current;
  checkDate() async {
    SharedPreferences date = await SharedPreferences.getInstance();
    _currentDate = DateTime.now();
    getdate = DateFormat("dd-MM-yyyy").format(_currentDate);
    print(getdate);
    current = date.getString('date');
    if (current == getdate) {
      current = date.setString('date', getdate);
    } else {
      current = date.setString('date', getdate);

      return showDialog(
        context: context,
        barrierDismissible: false,
        child: _showOffers(),
      );
    }
  }

  Coordinates coordinates;
  String temp1;
  String locality = '';
  String area = '';
  String localArea = '';
  String state = '';
  var location = "Unable to load location";

  Future<void> getCurrentLocation() async {
    try {
      final geopostion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        latitude = geopostion.latitude;
        longitude = geopostion.longitude;

        coordinates = Coordinates(latitude, longitude);
        print(coordinates);
      });

      var temp = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      locality = temp.first.featureName;
      area = temp.first.subLocality;
      localArea = temp.first.subAdminArea;
      print(localArea);
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
    } catch (error) {
      print("loading failed");
    }
  }

  _showOffers() {
    return Center(
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
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/icons/feasturent.png"),
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: IconButton(
              icon: Icon(
                Icons.cancel_outlined,
                size: MediaQuery.of(context).size.height * 0.04,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
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
          _loginstatus = 1;
          _customerName = responseData['data'][0]['name'] +
              ' ' +
              responseData['data'][0]['lastName'];
          _customerEmail = responseData['data'][0]['email'];
          _customerProfile = responseData['data'][0]['profile'];
        });
      } else {
        print('User not Login');
        setState(() {
          _loginstatus = 0;
          _customerName = '';
          _customerEmail = '';
          _customerProfile = '';
        });
      }
    } catch (error) {
      print(error);
    }
  }

  _buildChangeTextApp() {
    if (_page == 0) {
      return Image.asset(
        "assets/images/feasturent_app_logo.png",
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

  Future<void> displayPrediction() async {
    var p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
    );
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      print(placeId);
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
      coordinates = Coordinates(lat, lng);

      var address =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      locality = address.first.featureName;
      area = address.first.subLocality;
      state = address.first.adminArea;
      setState(() {
        if (locality == null) {
          location = "$area , $state";
        } else if (area == null) {
          location = "$locality , $state";
        } else if (state == null) {
          location = "$locality , $area";
        } else if (state == locality) {
          location = "$area , $state";
        } else {
          location = "$locality , $area , $state";
        }
      });

      print(lat);
      print(lng);
      print(address.first.addressLine);
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
                    icon: SvgPicture.asset(
                      "assets/icons/menu.svg",
                      height: MediaQuery.of(context).size.height * 0.027,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    }),
                // SizedBox(
                //   height: 5,
                // ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildChangeTextApp(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "$location",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: () async {
                              displayPrediction();
                              print("change");
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Icon(
                                Icons.edit_outlined,
                                size:
                                    MediaQuery.of(context).size.height * 0.028,
                                color: Colors.grey,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/search.svg",
                height: MediaQuery.of(context).size.height * 0.027,
              ),
              onPressed: () {
                showSearch(context: context, delegate: Searchbar(), query: "");
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/notification.svg",
                height: MediaQuery.of(context).size.height * 0.027,
              ),
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
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: AppDrawer(
              cStatus: _loginstatus,
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
              Expanded(
                flex: 3,
                child: _buildAppBar(_page),
              ),
              Expanded(flex: 32, child: tabPages[_page]),
            ],
          ),
        ),
      ),
    );
  }
}
