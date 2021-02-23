import 'package:feasturent_costomer_app/components/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Colors Code
const kPrimaryColor = Color(0xFF3498E5);
const ksecondaryColor = Color(0xFFB5BFD0);
const kTextColor = Color(0xFF50505D);
const kSecondaryTextColor = Color(0xFFFFCA27);
const kTextLightColor = Color(0xFF3498E5);

const kBackgroundColor = Color(0xFFE4F0FA);

//Api's
const API_BASE_URL = 'http://18.223.208.214/api/';
const AUTH_API = API_BASE_URL + 'auth/';
const USER_API = API_BASE_URL + 'users/';
const COMMON_API = API_BASE_URL + 'common/';
const ADMIN_API = API_BASE_URL + 'admin/';
const VENDOR_API = API_BASE_URL + 'vendor/';

//Base path
const S3_BASE_PATH = 'https://festurent.s3.amazonaws.com/';

//Status

const SUCCESSSTATUS = 'SUCCESS';
const ERRORSTATUS = 'ERROR';
const FAILDSTATUS = 'FAILD';

//Profile Design

const kSpacingUnit = 10;

const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);

final kTitleTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
  fontWeight: FontWeight.w600,
);

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
  fontSize: 14,
  color: Colors.black,
);

// Wallet Design

final walletProfileName =
    TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold);

final walletIconStyle = TextStyle(fontSize: 12, color: Colors.blueGrey);

class Addresses {
  String fullnameHolder;
  String phonenumberHolder;
  String pincodeHolder;
  String cityholder;
  String housenoholder;
  String stateholder;
  String roadholder;
  String landmarkholder;

  Addresses(
      {this.fullnameHolder,
      this.phonenumberHolder,
      this.cityholder,
      this.landmarkholder,
      this.stateholder,
      this.roadholder,
      this.housenoholder,
      this.pincodeHolder});
}

List<Addresses> temp = [];

class Productmodel {
  final foodtitle;
  final titleprice;
  Productmodel({this.foodtitle, this.titleprice});
}

List<Productmodel> add1 = [];
List<Productmodel> addon = [
  Productmodel(foodtitle: "Regular", titleprice: "₹ 0"),
  Productmodel(foodtitle: "Wheat", titleprice: "₹ 10"),
  Productmodel(foodtitle: "Barbeque Mayonese", titleprice: "₹ 10"),
  Productmodel(foodtitle: "Cheese", titleprice: "₹ 17"),
];

class Review {
  final icon;

  final text;

  Review({this.icon, this.text});
}

List<Review> policy = [
  Review(
      icon: Icon(Icons.paste_outlined),
      text: "Review Your order and address details to avoid\n cancellation"),
  Review(
      icon: Icon(
        Icons.timer,
        color: Colors.blue,
      ),
      text:
          "if you choose to cancel you can do it within 60 \n seconds after placing the order"),
  Review(
      icon: Icon(
        Icons.monetization_on_outlined,
        color: Colors.blue,
      ),
      text: "Review Your order and address details to avoid\n cancellation"),
  Review(
      icon: Icon(
        Icons.clean_hands,
        color: Colors.blue,
      ),
      text: "Review Your order and address details to avoid\n cancellation"),
  Review(
      icon: Icon(
        Icons.wash,
        color: Colors.blue,
      ),
      text: "Review Your order and address details to avoid\n cancellation"),
  Review(
      icon: Icon(Icons.paste_outlined),
      text: "Review Your order and address details to avoid\n cancellation"),
];

class SearchList {
  String title;
  String subtitle;

  SearchList({
    this.title,
    this.subtitle,
  });
}

List<SearchList> searchedlist = [
  SearchList(title: "Chole Bhature", subtitle: "Pandi ji Paratha Wala"),
  SearchList(title: "Rajma Chawal", subtitle: "Dhaba da Shaba"),
  SearchList(title: "Noodles", subtitle: "Foodie Cafe"),
  SearchList(title: "Soup", subtitle: "Samrat Restaurant")
];

class FilterList {
  var name;
  int pagecount;
  FilterList({this.name, this.pagecount});
}

List<FilterList> filtered = [
  FilterList(name: "Quick Filters", pagecount: 0),
  FilterList(name: "Cuisines", pagecount: 1),
  FilterList(name: "Tags", pagecount: 2),
  FilterList(name: "Features", pagecount: 3),
  FilterList(name: "Dineout Passport", pagecount: 4),
  FilterList(name: "Sort By", pagecount: 5),
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

class MenuList {
  var title;
  int number;
  MenuList({this.title, this.number});
}

List<MenuList> menu = [
  MenuList(title: "Recomended", number: 0),
  MenuList(title: "Tandoori", number: 1),
  MenuList(title: "Bread", number: 2),
  MenuList(title: "Snacks and Beverages", number: 3),
  MenuList(title: "Gravy", number: 4),
  MenuList(title: "Chinese", number: 5),
  MenuList(title: "Recomended", number: 6),
  MenuList(title: "Recomended", number: 7),
  MenuList(title: "Recomended", number: 8),
  MenuList(title: "Recomended", number: 9),
  MenuList(title: "Recomended", number: 10),
  MenuList(title: "Recomended", number: 11),
];
