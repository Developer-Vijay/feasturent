import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/Cart.dart/AddOnDataBase/addon_service.dart';
import 'components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:async/async.dart';

// Memorizer
final AsyncMemoizer discountmemoizer = AsyncMemoizer();
final AsyncMemoizer categorymemoizer = AsyncMemoizer();
final AsyncMemoizer allresturentmemoizer = AsyncMemoizer();
final AsyncMemoizer popularMenumemoizer = AsyncMemoizer();
final AsyncMemoizer homeslidermemoizer = AsyncMemoizer();
final AsyncMemoizer offerbannermemoizer = AsyncMemoizer();
final AsyncMemoizer offerslidermemoizer = AsyncMemoizer();
final AsyncMemoizer dineoutbannermemoizer = AsyncMemoizer();
final AsyncMemoizer popluardineoutmemoizer = AsyncMemoizer();
final AsyncMemoizer collectionmemoizer = AsyncMemoizer();
final AsyncMemoizer feturememoizer = AsyncMemoizer();
//  final AsyncMemoizer memoizer = AsyncMemoizer();

// capitalize text function
String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

//Colors Code
const kPrimaryColor = Color(0xFF3498E5);
const ksecondaryColor = Color(0xFFB5BFD0);
const kTextColor = Color(0xFF50505D);
const kSecondaryTextColor = Color(0xFFFFCA27);
const kTextLightColor = Color(0xFF3498E5);
int registerdUserId;
const kBackgroundColor = Color(0xFFE4F0FA);

//Api's
const API_BASE_URL = 'https://feasturent.in/api/';
const AUTH_API = API_BASE_URL + 'auth/';
const USER_API = API_BASE_URL + 'users/';
const COMMON_API = API_BASE_URL + 'common/';
const ADMIN_API = API_BASE_URL + 'admin/';
const VENDOR_API = API_BASE_URL + 'vendor/';
const APP_ROUTES = API_BASE_URL + 'appRoutes/';
const PAYMENT_API = API_BASE_URL + 'payment/';

//Base path
const S3_BASE_PATH = 'https://festurent.s3.amazonaws.com/';

//Socket server url
const SOCKET_URL = 'http://192.168.1.35:4000/';

//Status

const SUCCESSSTATUS = 'SUCCESS';
const ERRORSTATUS = 'ERROR';
const FAILDSTATUS = 'FAILD';

// Google map Key
const kGoogleApiKey = "AIzaSyCg54XwhQZYIkN7gpaj3wy9__mxvYQB6oE";

// to get places detail (lat/lng)
GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

//Profile Design
var locality;
var area;
var localArea;
var state;

Coordinates coordinates;
const kSpacingUnit = 10;

const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);

final kTitleTextStyle = TextStyle(
    fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
    fontWeight: FontWeight.w600,
    color: Colors.black);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.3),
  fontWeight: FontWeight.w100,
);

final kButtonTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SFProText',
  primaryColor: kLightPrimaryColor,
  canvasColor: kLightPrimaryColor,
  backgroundColor: kLightSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
        color: kDarkSecondaryColor,
      ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kDarkSecondaryColor,
        displayColor: kDarkSecondaryColor,
      ),
);

// offer List Design

const OffTextColor = Colors.grey;

final offerCommonStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 12,
  color: OffTextColor,
);

final offerRowHeadingStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

final offerRecommendStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: Colors.black,
);

final offerSheetStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15,
  color: Colors.black,
);

// Wallet Design

final walletProfileName =
    TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold);

final walletIconStyle = TextStyle(fontSize: 12, color: Colors.blueGrey);

class FilterList {
  var name;
  int pagecount;
  FilterList({this.name, this.pagecount});
}

List<FilterList> filtered = [
  FilterList(name: "Sort", pagecount: 0),
  FilterList(name: "Cuisines", pagecount: 1),
  FilterList(name: "Offer & more", pagecount: 2),
  // FilterList(name: "Features", pagecount: 3),
  // FilterList(name: "Dineout Passport", pagecount: 4),
  // FilterList(name: "Sort By", pagecount: 5),
  // FilterList(name: "Sort ", pagecount: 5),
  // FilterList(name: " By", pagecount: 5),
];

class ShortList {
  var name;
  int index;
  ShortList({this.name, this.index});
}

int selectedRadio = -1;

List<ShortList> sorted = [
  ShortList(name: "Relevance", index: 0),
  ShortList(name: "Cost For Two", index: 1),
  ShortList(name: "Delivery Time", index: 2),
  ShortList(name: "Rating", index: 3),
];

class CusisinesList {
  var name;
  bool index;
  CusisinesList({this.name, this.index});
}

List<CusisinesList> cusisinesList = [
  CusisinesList(name: "American", index: false),
  CusisinesList(name: "Bakery", index: false),
  CusisinesList(name: "Beverages", index: false),
  CusisinesList(name: "Chaat", index: false),
  CusisinesList(name: "Chinese", index: false),
  CusisinesList(name: "Continental", index: false),
  CusisinesList(name: "Desserts", index: false),
  CusisinesList(name: "Fast Food", index: false),
  CusisinesList(name: "Italian", index: false),
  CusisinesList(name: "Mughlai", index: false),
  CusisinesList(name: "North Indian", index: false),
];

class OfferMore {
  var name;
  bool index;
  OfferMore({this.name, this.index});
}

List<OfferMore> offerMore = [
  OfferMore(name: "Pure Veg", index: false),
  OfferMore(name: "Non-Veg", index: false),
];

class SettingsList {
  var title;
  var subtitle;
  var icon;
  int number;

  SettingsList({this.title, this.subtitle, this.icon, this.number});
}

List<SettingsList> settingpanel = [
  SettingsList(
      number: 0,
      title: "Add a Place",
      subtitle: "In Case we're missing Something",
      icon: Icon(Icons.place)),
  SettingsList(
      number: 1,
      title: "Places you've added",
      subtitle: "See all the places you've added so far",
      icon: Icon(Icons.stay_primary_landscape_outlined)),
  SettingsList(
    number: 2,
    title: "Settings",
    subtitle: "Define what ALerts You want to see",
    icon: Icon(Icons.settings),
  ),
  SettingsList(
      number: 3,
      title: "Notifications Settings",
      subtitle: "Change your email or delete your account",
      icon: Icon(Icons.notifications))
];

class CancelOrderList {
  bool value = false;
  var title;

  CancelOrderList({this.value, this.title});
}

List<CancelOrderList> cancel = [
  CancelOrderList(title: "By Mistake", value: false),
  CancelOrderList(title: "OverPriced", value: false),
  CancelOrderList(title: "Mood Changed", value: false),
  CancelOrderList(title: "Hygiene issue", value: false),
];
var donateAmount = 0;

class DonateList {
  bool value = false;
  int amount;

  DonateList({this.value, this.amount});
}

int offerid = 0;
double discount = 0;
List color = [
  Color(0xFFf1635c),
  Color(0xFF392d7a),
  Color(0xFF51ba64),
  Color(0xFF6e588a),
  Color(0xFF660143),
  Color(0xFF015196),
  Color(0xFFfcdc4c),
];

List colors = [
  Color(0xFFF9C0BD),
  Color(0xFF9C96BC),
  Color(0xFFA8DCB1),
  Color(0xFFB6ABC4),
  Color(0xFFB382A2),
  Color(0xFF80A8CA),
  Color(0xFFFDEDA5),
];

// function for clear cart for add menu from different resturent
final services = UserServices();
final addOnservices = AddOnService();

removeCartForNewData() async {
  int gsttotal1;
  int totalprice1;
  int totalcount1;
  int vendorId1;
  List<String> checkitem = [];
  List<String> addOncheckitem = [];

  final SharedPreferences cart = await SharedPreferences.getInstance();
  checkitem = cart.getStringList('addedtocart');
  addOncheckitem = cart.getStringList('addontocart');

  int l = addOncheckitem.length;
  for (int i = 0; i <= l - 1; i++) {
    var datatemp = int.parse(addOncheckitem[i]);

    addOnservices.deleteUser(datatemp);
  }

  int k = checkitem.length;
  for (int i = 0; i <= k - 1; i++) {
    int data = int.parse(checkitem[i]);

    services.deleteUser(data);
  }

  gsttotal1 = 0;
  totalcount1 = 0;
  totalprice1 = 0;
  discount = 0;
  offerid = 0;
  vendorId1 = 0;
  cart.setInt('VendorId', vendorId1);

  cart.setInt('TotalPrice', totalprice1);
  cart.setInt('TotalGst', gsttotal1);
  cart.setInt('TotalCount', totalcount1);

  checkitem.clear();
  addOncheckitem.clear();

  print(checkitem);
  cart.setStringList('addontocart', addOncheckitem);

  cart.setStringList('addedtocart', checkitem);
}

removeAddOnWithMenu(addOnIds) async {
  if (addOnIds != null) {
    var ids = json.decode(addOnIds);

    if (ids.isNotEmpty) {
      List tempIds = [];
      List addonlist = [];
      final SharedPreferences cart = await SharedPreferences.getInstance();
      addonlist = cart.getStringList('addontocart');

      int totalprice = cart.getInt('TotalPrice');
      int gsttotal = cart.getInt('TotalGst');
      int totalcount = cart.getInt('TotalCount');
      int k = ids.length;
      for (int i = 0; i <= k - 1; i++) {
        var id = ids[i];

        var data = id.toInt();
        await addOnservices.data(data).then((value) => fun(value));
        totalcount = totalcount - data3New[0]['addonCount'];
        gsttotal = gsttotal - data3New[0]['addongst'];
        totalprice = totalprice - data3New[0]['addonPrice'];
        tempIds.add(data);
      }
      int l = tempIds.length;
      cart.setInt('TotalPrice', totalprice);
      cart.setInt('TotalGst', gsttotal);
      cart.setInt('TotalCount', totalcount);
      for (int z = 0; z <= l - 1; z++) {
        int tempid = tempIds[z];
        addonlist.remove(tempid.toString());

        addOnservices.deleteUser(tempid);
      }
      cart.setStringList('addontocart', addonlist);
    } else {
      print("addons list is empty from constants");
    }
  } else {
    print("addons list is null from constants");
  }
  print("this is addon is from constants $addOnIds");
}

fun(value) {
  data3New = value;
}

class ChangeJson {
  int id;
  int vendorId;
  String title;
  String description;
  int price;
  int gst;
  int gstAmount;
  int totalPrice;
  int deliveryTime;
  bool isNonVeg;
  bool isEgg;
  bool isCombo;
  String image1;
  String image2;
  String image3;
  List addonMenus;
  List menuoffer;

  ChangeJson(
      this.id,
      this.vendorId,
      this.title,
      this.description,
      this.price,
      this.gst,
      this.gstAmount,
      this.totalPrice,
      this.deliveryTime,
      this.isNonVeg,
      this.isEgg,
      this.isCombo,
      this.image1,
      this.image2,
      this.image3,
      this.addonMenus,
      this.menuoffer);

  Map toJson() => {
        'id': id,
        'vendorId': vendorId,
        'title': title,
        'description': description,
        'price': price,
        'gst': gst,
        'gstAmount': gstAmount,
        'totalPrice': totalPrice,
        'deliveryTime': deliveryTime,
        'isNonVeg': isNonVeg,
        'isEgg': isEgg,
        'isCombo': isCombo,
        'image1': image1,
        'image2': image2,
        'image3': image3,
        'AddonMenus': addonMenus,
        'MenuOffers': menuoffer
      };
}

class AddonMenus {
  int id;
  int menuId;
  String type;
  String title;
  int amount;
  int gst;
  int gstAmount;

  AddonMenus(
    this.id,
    this.menuId,
    this.type,
    this.title,
    this.amount,
    this.gst,
    this.gstAmount,
  );
  Map toJson() => {
        'id': id,
        'menuId': menuId,
        'type': type,
        'title': title,
        'amount': amount,
        'gst': gst,
        'gstAmount': gstAmount
      };
}
