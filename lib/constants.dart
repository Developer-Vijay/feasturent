import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_webservice/places.dart';

//Colors Code
const kPrimaryColor = Color(0xFF3498E5);
const ksecondaryColor = Color(0xFFB5BFD0);
const kTextColor = Color(0xFF50505D);
const kSecondaryTextColor = Color(0xFFFFCA27);
const kTextLightColor = Color(0xFF3498E5);
int registerdUserId;
const kBackgroundColor = Color(0xFFE4F0FA);

//Api's
const API_BASE_URL = 'http://18.223.208.214/api/';
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

var barimages = [
  "https://media.gettyimages.com/photos/wooden-table-in-front-of-abstract-blurred-restaurant-lights-of-bar-picture-id1250327071?k=6&m=1250327071&s=612x612&w=0&h=z_gcxwIlFxPxrPh3XX3maljIx7Nqg4Ct2hA6LKjgYqM=",
  "https://media.gettyimages.com/photos/waiter-serves-beers-at-a-bar-on-the-eve-of-the-mandatory-closure-of-picture-id1228945616?k=6&m=1228945616&s=612x612&w=0&h=d-qVLDUFwS5hZzJuXKGosaY6O0TYEL09T9EXAVyjLJ4="
];

final imageList = [
  "https://media.gettyimages.com/photos/nightclub-picture-id157532720?k=6&m=157532720&s=612x612&w=0&h=oan-SIIOcol4NRhRWpJ_Vd2k6FzFE24Ub4zmK4SjNzM=",
  "https://media.gettyimages.com/photos/interior-of-empty-bar-at-night-picture-id826837298?k=6&m=826837298&s=612x612&w=0&h=-hIbnJFk265RDKqfykcNmKXlge91c0ynk3hDAGvjESI=",
  "https://media.gettyimages.com/photos/empty-nightclub-dance-floor-picture-id1053940970?k=6&m=1053940970&s=612x612&w=0&h=2VsbM5AKs7sLlklQ7m0iN6lTg_7ulDB4jZfdrG5t36M=",
  "https://media.gettyimages.com/photos/bartender-making-cocktails-at-retro-bar-for-mature-couple-picture-id991839156?k=6&m=991839156&s=612x612&w=0&h=nXyZjg1b9XlVeNQUJp3wy3WkiAirt0ZkocsPmBrQe00=",
];

class PopularOnFeasturent {
  String categoryName = '';
  String categoryImage;
  PopularOnFeasturent({
    this.categoryName,
    this.categoryImage,
  });
}

List<PopularOnFeasturent> popularonfeast = [
  PopularOnFeasturent(
      categoryImage:
          "https://image.shutterstock.com/z/stock-photo-chole-bhature-or-chick-pea-curry-and-fried-puri-served-in-terracotta-crockery-over-white-1072270610.jpg",
      categoryName: "Chole Bhature"),
  PopularOnFeasturent(
      categoryImage:
          "https://image.shutterstock.com/z/stock-photo-traditional-dumpling-vegetarian-momos-food-from-nepal-served-with-tomato-chutney-over-moody-plate-1719536887.jpg",
      categoryName: "Specail Momos"),
  PopularOnFeasturent(
      categoryImage:
          "https://image.shutterstock.com/image-photo/arabian-spicy-food-concept-homemade-600w-1199926645.jpg",
      categoryName: "Tandoori Chicken"),
  PopularOnFeasturent(
      categoryImage:
          "https://image.shutterstock.com/z/stock-photo-big-cheeseburger-with-lots-of-cheese-stock-photo-side-view-of-a-cheeseburger-on-a-black-brick-wall-1680415567.jpg",
      categoryName: "Cheese Burger"),
  PopularOnFeasturent(
      categoryImage:
          "https://image.shutterstock.com/z/stock-photo-chicken-kabsa-homemade-arabian-biryani-overhead-view-1048188121.jpg",
      categoryName: "Chicken Biryani"),
  PopularOnFeasturent(
      categoryImage:
          "https://image.shutterstock.com/z/stock-photo-palak-paneer-curry-made-up-of-spinach-and-cottage-cheese-popular-indian-healthy-lunch-dinner-food-620862170.jpg",
      categoryName: "Palak Paneer"),
  PopularOnFeasturent(
      categoryImage:
          "https://image.shutterstock.com/z/stock-photo-masala-dosa-indian-savory-crepes-with-potato-filling-top-down-view-783911236.jpg",
      categoryName: "Masala Dosa"),
];
