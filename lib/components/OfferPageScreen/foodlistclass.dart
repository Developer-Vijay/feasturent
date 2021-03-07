import 'dart:async';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/material.dart';

String paymentMode = "Online Mode";
int sumtotal = 0;
int countSum = 0;
int totalPrice = 0;
String addAddress = " ";
String userNameWithNumber = "Select Delivery Address";
Timer circluatimer, placeTimer;
double placeValue = 0.0;
double placePrecent = 0.0;
double circluarValue = 0.0;
double circularPrecent = 0.0;
double latitude;
double longitude;
int addresstype;

class ListofFood {
  String timing;
  String distance;
  String serviceType;
  String address;
  String resturentDetails;
  var index0;
  var foodImage;
  int counter;
  String vegsymbol;
  var starRating;
  String title;
  var id;
  int quantity;
  var addButton;
  int foodPrice;
  String subtitle;
  var discountImage;
  String discountText;
  String ratingText;

  ListofFood(
      {this.index0,
      this.counter,
      this.quantity,
      this.foodImage,
      this.vegsymbol,
      this.starRating,
      this.title,
      this.id,
      this.addButton,
      this.foodPrice,
      this.subtitle,
      this.ratingText,
      this.discountImage,
      this.discountText,
      this.timing,
      this.address,
      this.distance,
      this.resturentDetails,
      this.serviceType});
}

class addto {
  var foodImage;
  String vegsymbol;
  var starRating;
  int quantity;
  String title;
  var addButton;
  int foodPrice;
  String subtitle;
  var discountImage;
  String discountText;
  String ratingText;
  String name;
  int id;
  int sum2 = 0;
  int counter;
  var postion;
  var isSelected;
  int sum1;

  addto(
      {this.foodImage,
      this.vegsymbol,
      this.sum1,
      this.id,
      this.sum2,
      this.counter,
      this.quantity,
      this.isSelected,
      this.starRating,
      this.title,
      this.addButton,
      this.foodPrice,
      this.subtitle,
      this.ratingText,
      this.name,
      this.postion,
      this.discountImage,
      this.discountText});
}

List<addto> add2 = [];
List<addto> favourite = [];

List<ListofFood> tandorilist = [
  ListofFood(
    index0: 0,
    id: 101,
    quantity: 1,
    counter: 0,
    foodImage:
        'https://media.gettyimages.com/photos/tandoori-chicken-picture-id1220188103?k=6&m=1220188103&s=612x612&w=0&h=8N-AzLoUkzsc7VpKyIpSpeQJjkG2WrdFx4PfmywthzA=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '40 % | Use Code SW100',
    foodPrice: 400,
    title: 'Tandoori Chicken',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
  ListofFood(
    index0: 0,
    id: 101,
    quantity: 1,
    counter: 0,
    foodImage:
        'https://media.gettyimages.com/photos/indian-tandoori-chicken-wrap-and-lamb-kebab-on-food-truck-picture-id616455114?k=6&m=616455114&s=612x612&w=0&h=lIWDEeJMpbGVn9Vmjd0MWgOyFKgsZ79MTsNT7PqlOXY=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '40 % | Use Code SW100',
    foodPrice: 100,
    title: 'Chicken Shawerma',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
  ListofFood(
    index0: 0,
    id: 101,
    quantity: 1,
    counter: 0,
    foodImage:
        'https://media.gettyimages.com/photos/paneer-tikka-picture-id636150236?k=6&m=636150236&s=612x612&w=0&h=xpdtqdpVR24FkRp_QOwMRVwKJXICPITUDE8YJJGezeI=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '40 % | Use Code SW100',
    foodPrice: 100,
    title: 'Paneer Tikka',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
];

List<ListofFood> foodlist = [
  ListofFood(
    timing: "10AM - 10PM",
    distance: "1.5Km",
    serviceType: "Delivery",
    address: "MIE Part - B Haryana",
    resturentDetails:
        "Restaurants in New Delhi,  South Delhi restaurants, Sweet Shop in Kalkaji, Quick Bites in Delhi NCR,  Quick Bites in South Delhi, Special in Delhi NCR,",
    index0: 0,
    id: 101,
    quantity: 1,
    counter: 0,
    foodImage:
        'https://lh3.googleusercontent.com/Ab4tWrbsxF_t4bEHFBwvIT_A99PQSOacsQLuo1DLzF85Dq-TA7c2jrk95OCR564LIJTLk16OFQIo0nph63H6-Kpcxg=w128',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: ' 40 % | SW12345678',
    foodPrice: 100,
    title: 'Aggarwal Sweets',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
// Another List
  ListofFood(
    timing: "10AM - 10PM",
    distance: "1.5Km",
    serviceType: "Delivery",
    address: "MIE Part - B Haryana",
    resturentDetails:
        "Restaurants in New Delhi,  South Delhi restaurants, Sweet Shop in Delhi NCR, Sweet Shop near me, Sweet Shop in South Delhi, Sweet Shop in Kalkaji, Quick Bites in Delhi NCR, Quick Bites near me, Quick Bites in South Delhi, Quick Bites in Kalkaji, Order food online in Kalkaji, Order food online in Delhi NCR, Order food online in South Delhi, New Year Parties in Delhi NCR, Christmas' Special in Delhi NCR,",
    index0: 0,
    id: 101,
    quantity: 1,
    counter: 0,
    foodImage:
        'https://content3.jdmagicbox.com/comp/chandigarh/e1/0172px172.x172.101018083946.t1e1/catalogue/bikaner-sweets-sector-34c-chandigarh-sweet-shops-restaurants-ynk79.jpg',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: ' 40 % | SW12345678',
    foodPrice: 100,
    title: 'Bikaner wale',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
// Another List
  ListofFood(
    timing: "10AM - 10PM",
    distance: "1.5Km",
    serviceType: "Delivery",
    address: "MIE Part - B Haryana",
    resturentDetails:
        "Restaurants in New Delhi,  South Delhi restaurants, Sweet Shop in Delhi NCR, Sweet Shop near me, Sweet Shop in South Delhi, Sweet Shop in Kalkaji, Quick Bites in Delhi NCR, Quick Bites near me, Quick Bites in South Delhi, Quick Bites in Kalkaji, Order food online in Kalkaji, Order food online in Delhi NCR, Order food online in South Delhi, New Year Parties in Delhi NCR, Christmas' Special in Delhi NCR,",
    index0: 0,
    id: 101,
    quantity: 1,
    counter: 0,
    foodImage:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-TbuisC6gIOZoGgh1V_ffufCn9v-4R9X9xw&usqp=CAU',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: ' 40 % | SW12345678',
    foodPrice: 100,
    title: 'Gupta ji Chole Bhature',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
// Another List
  ListofFood(
    timing: "10AM - 10PM",
    distance: "1.5Km",
    serviceType: "Delivery",
    address: "MIE Part - B Haryana",
    resturentDetails:
        "Restaurants in New Delhi,  South Delhi restaurants, Sweet Shop in Delhi NCR, Sweet Shop near me, Sweet Shop in South Delhi, Sweet Shop in Kalkaji, Quick Bites in Delhi NCR, Quick Bites near me, Quick Bites in South Delhi, Quick Bites in Kalkaji, Order food online in Kalkaji, Order food online in Delhi NCR, Order food online in South Delhi, New Year Parties in Delhi NCR, Christmas' Special in Delhi NCR,",
    index0: 0,
    id: 101,
    quantity: 1,
    counter: 0,
    foodImage:
        'https://b.zmtcdn.com/data/reviews_photos/31c/22b8ae9a061f46eafb42b3d9ae50e31c_1585038222.jpg',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: ' 40 % | SW12345678',
    foodPrice: 100,
    title: 'Swagg Tikka',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
// Another List
  ListofFood(
    timing: "10AM - 10PM",
    distance: "1.5Km",
    serviceType: "Delivery",
    address: "MIE Part - B Haryana",
    resturentDetails:
        "Restaurants in New Delhi,  South Delhi restaurants, Sweet Shop in Delhi NCR, Sweet Shop near me, Sweet Shop in South Delhi, Sweet Shop in Kalkaji, Quick Bites in Delhi NCR, Quick Bites near me, Quick Bites in South Delhi, Quick Bites in Kalkaji, Order food online in Kalkaji, Order food online in Delhi NCR, Order food online in South Delhi, New Year Parties in Delhi NCR, Christmas' Special in Delhi NCR,",
    index0: 0,
    id: 101,
    quantity: 1,
    counter: 0,
    foodImage:
        'https://b.zmtcdn.com/data/pictures/5/6075/bea5c5b100e1b745769e13d6feca3187.jpg?fit=around|300:273&crop=300:273;*,*',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: ' 40 % | SW12345678',
    foodPrice: 100,
    title: 'Sita Ram Diwan',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
// Another List
  ListofFood(
    timing: "10AM - 10PM",
    distance: "1.5Km",
    serviceType: "Delivery",
    address: "MIE Part - B Haryana",
    resturentDetails:
        "Restaurants in New Delhi,  South Delhi restaurants, Sweet Shop in Delhi NCR, Sweet Shop near me, Sweet Shop in South Delhi, Sweet Shop in Kalkaji, Quick Bites in Delhi NCR, Quick Bites near me, Quick Bites in South Delhi, Quick Bites in Kalkaji, Order food online in Kalkaji, Order food online in Delhi NCR, Order food online in South Delhi, New Year Parties in Delhi NCR, Christmas' Special in Delhi NCR,",
    index0: 0,
    id: 101,
    quantity: 1,
    counter: 0,
    foodImage:
        'https://media.gettyimages.com/photos/view-of-papri-chat-on-november-10-2015-in-kolkata-india-picture-id542764412?k=6&m=542764412&s=612x612&w=0&h=6IEwFhfeYFwdt8H8hdgzePPRyusFHnu25xYFxfRXvNU=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: ' 40 % | SW12345678',
    foodPrice: 100,
    title: 'Pandit Ji Paranthe Wale',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
// Another List
  ListofFood(
    timing: "10AM - 10PM",
    distance: "1.5Km",
    serviceType: "Delivery",
    address: "MIE Part - B Haryana",
    resturentDetails:
        "Restaurants in New Delhi,  South Delhi restaurants, Sweet Shop in Delhi NCR, Sweet Shop near me, Sweet Shop in South Delhi, Sweet Shop in Kalkaji, Quick Bites in Delhi NCR, Quick Bites near me, Quick Bites in South Delhi, Quick Bites in Kalkaji, Order food online in Kalkaji, Order food online in Delhi NCR, Order food online in South Delhi, New Year Parties in Delhi NCR, Christmas' Special in Delhi NCR,",
    index0: 0,
    id: 101,
    quantity: 1,
    counter: 0,
    foodImage:
        'https://media.gettyimages.com/photos/view-of-papri-chat-on-november-10-2015-in-kolkata-india-picture-id542764412?k=6&m=542764412&s=612x612&w=0&h=6IEwFhfeYFwdt8H8hdgzePPRyusFHnu25xYFxfRXvNU=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: ' 40 % | SW12345678',
    foodPrice: 100,
    title: 'Burger King',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
// Another List
  ListofFood(
    timing: "10AM - 10PM",
    distance: "1.5Km",
    serviceType: "Delivery",
    address: "MIE Part - B Haryana",
    resturentDetails:
        "Restaurants in New Delhi,  South Delhi restaurants, Sweet Shop in Delhi NCR, Sweet Shop near me, Sweet Shop in South Delhi, Sweet Shop in Kalkaji, Quick Bites in Delhi NCR, Quick Bites near me, Quick Bites in South Delhi, Quick Bites in Kalkaji, Order food online in Kalkaji, Order food online in Delhi NCR, Order food online in South Delhi, New Year Parties in Delhi NCR, Christmas' Special in Delhi NCR,",
    index0: 0,
    id: 101,
    quantity: 1,
    counter: 0,
    foodImage:
        'https://media.gettyimages.com/photos/view-of-papri-chat-on-november-10-2015-in-kolkata-india-picture-id542764412?k=6&m=542764412&s=612x612&w=0&h=6IEwFhfeYFwdt8H8hdgzePPRyusFHnu25xYFxfRXvNU=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: ' 40 % | SW12345678',
    foodPrice: 100,
    title: 'Gupta Chart',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
// Another List
  ListofFood(
    timing: "10AM - 10PM",
    distance: "1.5Km",
    serviceType: "Delivery",
    address: "MIE Part - B Haryana",
    resturentDetails:
        "Restaurants in New Delhi,  South Delhi restaurants, Sweet Shop in Delhi NCR, Sweet Shop near me, Sweet Shop in South Delhi, Sweet Shop in Kalkaji, Quick Bites in Delhi NCR, Quick Bites near me, Quick Bites in South Delhi, Quick Bites in Kalkaji, Order food online in Kalkaji, Order food online in Delhi NCR, Order food online in South Delhi, New Year Parties in Delhi NCR, Christmas' Special in Delhi NCR,",
    index0: 1,
    id: 102,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/spring-salad-shot-from-above-on-rustic-wood-table-picture-id505685702?k=6&m=505685702&s=612x612&w=0&h=dw2v57OlDMM8xUBbg2EHGaWP4zWX9iKLXS6mS2qPaB4=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % |   ',
    foodPrice: 120,
    title: 'Salad',
    ratingText: '3.0',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
];

class InsideListofFood {
  var addedStatus;
  int index0;
  var foodImage;
  int counter;
  String vegsymbol;
  var starRating;
  String title;
  int id;
  int quantity;
  var addButton;
  int foodPrice;
  String subtitle;
  var discountImage;
  String discountText;
  String ratingText;
  String name;

  InsideListofFood(
      {this.index0,
      this.addedStatus,
      this.counter,
      this.quantity,
      this.foodImage,
      this.vegsymbol,
      this.starRating,
      this.title,
      this.id,
      this.addButton,
      this.foodPrice,
      this.subtitle,
      this.ratingText,
      this.name,
      this.discountImage,
      this.discountText});
}

List<InsideListofFood> insideOfferPage = [
  InsideListofFood(
    addedStatus: "Add",
    index0: 0,
    id: 100,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/pav-bhaji-picture-id151138134?k=6&m=151138134&s=612x612&w=0&h=BszlTiZj4a5FUYrBqsd58n5JMf1T7BZh91G5F8ZEbW4=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Coupon ',
    foodPrice: 120,
    title: 'Pav Bhaji',
    ratingText: '3.0',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
  InsideListofFood(
    addedStatus: "Add",
    index0: 1,
    id: 101,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/bhalla-papdi-chaat-picture-id487677839?k=6&m=487677839&s=612x612&w=0&h=2_DI2CmOlpAVPiXaN5Vn7FFFdeta-nVMpnxbzWwmnn4=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Coupon ',
    foodPrice: 120,
    title: 'Bhale Papdi',
    ratingText: '3.0',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
  InsideListofFood(
    addedStatus: "Add",
    index0: 2,
    id: 102,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://b.zmtcdn.com/data/dish_photos/e9a/9707b419e40552ec9c11e17d13644e9a.jpg?fit=around|130:130&crop=130:130;*,*',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Coupon ',
    foodPrice: 120,
    title: 'Mozzarella Sandwich',
    ratingText: '3.0',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
  InsideListofFood(
    addedStatus: "Add",
    index0: 3,
    id: 103,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://b.zmtcdn.com/data/dish_photos/ca4/6b0118ef0938e7ba5f8151bb51feeca4.jpg?fit=around|130:130&crop=130:130;*,*',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Coupon ',
    foodPrice: 120,
    title: 'Farmhouse Pizza',
    ratingText: '3.0',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
  InsideListofFood(
    addedStatus: "Add",
    index0: 4,
    id: 104,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/pani-puri-picture-id1140993688?k=6&m=1140993688&s=612x612&w=0&h=uHU55pv3ECgx9yQtwHUwOKS5DgNk3S_cS9DCILvLqU4=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Coupon ',
    foodPrice: 120,
    title: 'Pani Puri',
    ratingText: '3.0',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
  InsideListofFood(
    addedStatus: "Add",
    index0: 5,
    id: 105,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/closeup-of-raj-kachori-served-on-table-picture-id654743911?k=6&m=654743911&s=612x612&w=0&h=820dRXGQay-CYK6suM1clNiE-sZeyDQdLQmaqyUIY98=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Coupon ',
    foodPrice: 100,
    title: 'Raj Kachori',
    ratingText: '3.0',
    subtitle: 'NorthIndian',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  )
];

class ListofCategories {
  var index0;
  var foodImage;
  int counter;
  String vegsymbol;
  var starRating;
  String title;
  bool isPressed;
  var id;
  int quantity;
  var addButton;
  int foodPrice;
  String subtitle;
  var discountImage;
  String discountText;
  String ratingText;
  String name;

  ListofCategories(
      {this.index0,
      this.counter,
      this.quantity,
      this.foodImage,
      this.isPressed,
      this.vegsymbol,
      this.starRating,
      this.title,
      this.id,
      this.addButton,
      this.foodPrice,
      this.subtitle,
      this.ratingText,
      this.name,
      this.discountImage,
      this.discountText});
}

List<ListofCategories> burgerlist = [
  ListofCategories(
    index0: 0,
    id: 10,
    isPressed: false,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/burger-with-french-fries-picture-id1211425123?k=6&m=1211425123&s=612x612&w=0&h=TTc0b9eNLNPk3uYgyIYlDTsb1aRJsO9z6qyEvN6jG2I=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Coupon ',
    foodPrice: 80,
    title: 'Cheese Burger',
    ratingText: '3.0',
    subtitle: 'fastfood',
    vegsymbol:
        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 3,
        size: 20.0,
        isReadOnly: false,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
  ListofCategories(
    index0: 1,
    isPressed: false,
    id: 105,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/crispy-chicken-burger-with-cheese-tomato-onions-and-lettuce-picture-id1265242728?k=6&m=1265242728&s=612x612&w=0&h=ZH3uKuHGNPHya-yiKmCmIleGy6jGPEtJes4VAywjH6g=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Coupon ',
    foodPrice: 180,
    title: 'McChicken Burger',
    ratingText: '4.0',
    subtitle: 'fastfood',
    vegsymbol:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/180px-Non_veg_symbol.svg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 4,
        size: 20.0,
        isReadOnly: true,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
  ListofCategories(
    index0: 2,
    isPressed: false,
    id: 105,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/crispy-chicken-burger-with-cheese-tomato-onions-and-lettuce-picture-id1265242728?k=6&m=1265242728&s=612x612&w=0&h=ZH3uKuHGNPHya-yiKmCmIleGy6jGPEtJes4VAywjH6g=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Coupon ',
    foodPrice: 180,
    title: 'McVeggie',
    ratingText: '4.0',
    subtitle: 'fastfood',
    vegsymbol:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/180px-Non_veg_symbol.svg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 4,
        size: 20.0,
        isReadOnly: true,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
  ListofCategories(
    index0: 3,
    isPressed: false,
    id: 105,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/crispy-chicken-burger-with-cheese-tomato-onions-and-lettuce-picture-id1265242728?k=6&m=1265242728&s=612x612&w=0&h=ZH3uKuHGNPHya-yiKmCmIleGy6jGPEtJes4VAywjH6g=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Coupon ',
    foodPrice: 180,
    title: 'McVeggie Panner Grill',
    ratingText: '4.0',
    subtitle: 'fastfood',
    vegsymbol:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/180px-Non_veg_symbol.svg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 4,
        size: 20.0,
        isReadOnly: true,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
  ListofCategories(
    index0: 4,
    isPressed: false,
    id: 105,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/crispy-chicken-burger-with-cheese-tomato-onions-and-lettuce-picture-id1265242728?k=6&m=1265242728&s=612x612&w=0&h=ZH3uKuHGNPHya-yiKmCmIleGy6jGPEtJes4VAywjH6g=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Coupon ',
    foodPrice: 180,
    title: 'McVeggie',
    ratingText: '4.0',
    subtitle: 'fastfood',
    vegsymbol:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/180px-Non_veg_symbol.svg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 4,
        size: 20.0,
        isReadOnly: true,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  ),
  ListofCategories(
    index0: 5,
    isPressed: false,
    id: 106,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/crispy-chicken-burger-with-cheese-tomato-onions-and-lettuce-picture-id1265242728?k=6&m=1265242728&s=612x612&w=0&h=ZH3uKuHGNPHya-yiKmCmIleGy6jGPEtJes4VAywjH6g=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Coupon ',
    foodPrice: 180,
    title: 'McEggSupreme ',
    ratingText: '4.0',
    subtitle: 'fastfood',
    vegsymbol:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/180px-Non_veg_symbol.svg.png',
    starRating: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          Text("23");
        },
        starCount: 1,
        rating: 4,
        size: 20.0,
        isReadOnly: true,
        defaultIconData: Icons.star_border_outlined,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_border,
        color: Colors.red,
        borderColor: Colors.red,
        spacing: 0.0),
  )
];
