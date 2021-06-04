import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/offerpage.dart';
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
import 'SearchFiles/test_search.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import 'components/ontap_offer.dart';

class HomeScreen extends StatefulWidget {
  final index;
  const HomeScreen({Key key, this.index}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tempoaryData = widget.index;
    });
    changePage();
    takeLocation();
    getSession();
    getCurrentLocation();
    fetchwelcomeBanner();
  }

  changePage() async {
    if (tempoaryData == null) {
      _page = 0;
    } else {
      _page = tempoaryData;
    }
  }

  var tempoaryData;
  var tempdata;

  var homeBanner;
  takeLocation() async {
    final SharedPreferences locationShared =
        await SharedPreferences.getInstance();
    location = locationShared.getString('tempLocation');
  }

  // ignore: missing_return
  Future<List<dynamic>> fetchwelcomeBanner() async {
    try {
      var result = await http
          .get(
            Uri.parse(APP_ROUTES + 'utilities' + '?key=BYFOR&for=welcomePopup')
            );
      print(_authorization);
      homeBanner = json.decode(result.body)['data'];
      if (result.statusCode == 200) {
        if (homeBanner != null) {
          if (homeBanner[0]['status'] == true) {
            if (homeBanner[0]['OffersAndCoupon'] != null) {
              checkDate(homeBanner);
            }
          }
        } else {
          print("data  avialable");
        }
      }
    } catch (error) {
      print(error);
    }
  }

  int _customerUserId = 0;
  String _customerName;
  String _customerProfile;
  String _customerEmail;
  String _authorization = '';
  String _refreshtoken = '';
  // ignore: unused_field
  var _latitude;
  // ignore: unused_field
  var _longitude;

  Future<bool> _onbackpressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Do you really want to exit"),
              actions: [
                TextButton(
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
                TextButton(
                  child: Text("Yes"),
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                )
              ],
            ));
  }

  int _page;
  List
  <Widget> 
  tabPages = [
    HomePageBody(),
    OfferPageScreen(),
    DineoutHomePage(),
    UserProfilePage()
  ];

  DateTime _currentDate;
  String getdate;
  var current;
  checkDate(homedata) async {
    SharedPreferences date = await SharedPreferences.getInstance();
    _currentDate = DateTime.now();
    getdate = DateFormat("dd-MM-yyyy").format(_currentDate);
    current = date.getString('date');
    if (current == getdate) {
      current = date.setString('date', getdate);
    } else {
      current = date.setString('date', getdate);
      var data = homedata;
      setState(() {});
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _showOffers(data),
      );
    }
  }

  Coordinates coordinates;
  String temp1;
  String locality = '';
  String area = '';
  String localArea = '';
  String state = '';
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
      state = temp.first.adminArea;
      setState(() async {
        if (locality == null) {
          location = "$area , $state";
        } else if (area == null) {
          location = "$locality , $state";
        } else if (state == null) {
          location = "$locality , $area";
        } else {
          location = "$locality , $area , $state";
        }
        final SharedPreferences locationShared =
            await SharedPreferences.getInstance();
        locationShared.setString('tempLocation', location);
      });
    } catch (error) {
      print(error);
    }
  }

  _showOffers(homebannerData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.55,
          width: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 20,
                top: MediaQuery.of(context).size.height * 0.095,
                child: Material(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.lightBlue[100],
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              S3_BASE_PATH +
                                  homebannerData[0]['OffersAndCoupon']['image'],
                            ),
                            fit: BoxFit.fill)),
                    height: MediaQuery.of(context).size.height * 0.48,
                    width: MediaQuery.of(context).size.height * 0.35,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnTapOffer(
                                      data: homebannerData[0],
                                    )));
                      },
                    ),
                  ),
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
    );
  }

  Future<void> getSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        userName = prefs.getString('name');
        _customerUserId = prefs.getInt('userId');
        _authorization = prefs.getString('sessionToken');
        _refreshtoken = prefs.getString('refreshToken');
        _latitude = prefs.setDouble('latitude', latitude);
        _longitude = prefs.setDouble('longitude', longitude);
      });

      print(takeUser);
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  get users form server");

      var response = await http.get(
      Uri.parse(USER_API + 'users?key=SINGLE&userId=' + _customerUserId.toString(),) ,   
          headers: {
            "authorization": _authorization,
            "refreshtoken": _refreshtoken,
            "Content-Type": "application/json"
          });
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(_authorization);
        print(_refreshtoken);

        setState(() {
          takeUser = true;

          loginstatus = 1;
          _customerName = responseData['data'][0]['name'] +
              ' ' +
              responseData['data'][0]['lastName'];
          _customerEmail = responseData['data'][0]['email'];
          _customerProfile = responseData['data'][0]['profile'];
          userName = _customerName;
          emailid = _customerEmail;
          photo = _customerProfile;
          print(_customerName);
        });
      } else {
        print('User not Login');
        setState(() {
          loginstatus = 0;
          _customerName = '';
          _customerEmail = '';
          _customerProfile = '';
          takeUser = false;
          userName = '';
          emailid = '';
          photo = '';
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
        height: MediaQuery.of(context).size.height * 0.05,
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
              // ignore: deprecated_member_use
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
          await places.getDetailsByPlaceId(p.placeId);

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
    }
  }

  _buildAppBar(_page) {
    if (_page == 3) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
      );
    } else {
      return AppBar(
        leading: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/menu.svg",
              height: MediaQuery.of(context).size.height * 0.027,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            }),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              height: MediaQuery.of(context).size.height * 0.027,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchField()));
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/notification.svg",
              height: MediaQuery.of(context).size.height * 0.027,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationSheet()));
            },
          ),
        ],
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChangeTextApp(),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "$location",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
                InkWell(
                    onTap: () async {
                      displayPrediction();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(
                        Icons.edit_outlined,
                        size: MediaQuery.of(context).size.height * 0.028,
                        color: Colors.grey,
                      ),
                    )),
              ],
            ),
          ],
        ),
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
                cStatus: loginstatus,
                cName: _customerName,
                cProfile: _customerProfile,
                cEmail: _customerEmail),
            bottomNavigationBar: CurvedNavigationBar(
              animationDuration: Duration(milliseconds: 200),
              index: _page,
              height: sized.height * 0.08,
              items: <Widget>[
                SvgPicture.asset(
                  "assets/icons/house.svg",
                  height: sized.height * 0.035,
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
                  "assets/icons/user.svg",
                  height: sized.height * 0.03,
                ),
              ],
              onTap: (index) {
                setState(() {
                  _page = index;
                });
              },
            ),
            appBar: _buildAppBar(_page),
            body:tabPages[_page]
             
              //  HomePageBody(),
                // OfferPageScreen(),
                // DineoutHomePage(),
                // UserProfilePage(),
            ),)
    );
            // IndexedStack(
              // index: _page,
            //   ListView(
                
            //   children: [
            //     HomePageBody(),
            //     OfferPageScreen(),
            //     DineoutHomePage(),
            //     UserProfilePage(),
            //   ],
            // // )
            //   )
            
    //   ),
    // );
  }
}
