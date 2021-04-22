import 'dart:async';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/material.dart';

String paymentMode = "Online Mode";
String addAddress = " ";
String userNameWithNumber = "Select Delivery Address";
int addressID;
Timer circluatimer, placeTimer;
double placeValue = 0.0;
double placePrecent = 0.0;
double circluarValue = 0.0;
double circularPrecent = 0.0;
double latitude;
double longitude;
int addresstype;
List<int> idCheck = [];
// List<int> vendorIdCheck = [];
List<String> itemAdded = [];
var takeUser;
var emailid;
var photo;
var userName;
var location = "Fetching location...";
int loginstatus = 0;

class MenuData {
  int id;
  int qty;
  MenuData(this.id, this.qty);

  Map toJson() => {
        'id': id,
        'qty': qty,
      };
}

// class addto {
//   var foodImage;
//   String vegsymbol;
//   var starRating;
//   int quantity;
//   String title;
//   var addButton;
//   int foodPrice;
//   String subtitle;
//   var discountImage;
//   String discountText;
//   String ratingText;
//   String name;
//   int id;
//   int sum2 = 0;
//   int counter;
//   var postion;
//   var isSelected;
//   int sum1;

//   addto(
//       {this.foodImage,
//       this.vegsymbol,
//       this.sum1,
//       this.id,
//       this.sum2,
//       this.counter,
//       this.quantity,
//       this.isSelected,
//       this.starRating,
//       this.title,
//       this.addButton,
//       this.foodPrice,
//       this.subtitle,
//       this.ratingText,
//       this.name,
//       this.postion,
//       this.discountImage,
//       this.discountText});
// }

// List<addto> favourite = [];

// class ListofCategories {
//   var index0;
//   var foodImage;
//   int counter;
//   String vegsymbol;
//   var starRating;
//   String title;
//   bool isPressed;
//   var id;
//   int quantity;
//   var addButton;
//   int foodPrice;
//   String subtitle;
//   var discountImage;
//   String discountText;
//   String ratingText;
//   String name;

//   ListofCategories(
//       {this.index0,
//       this.counter,
//       this.quantity,
//       this.foodImage,
//       this.isPressed,
//       this.vegsymbol,
//       this.starRating,
//       this.title,
//       this.id,
//       this.addButton,
//       this.foodPrice,
//       this.subtitle,
//       this.ratingText,
//       this.name,
//       this.discountImage,
//       this.discountText});
// }

// List<ListofCategories> burgerlist = [
//   ListofCategories(
//     index0: 0,
//     id: 10,
//     isPressed: false,
//     counter: 0,
//     quantity: 1,
//     foodImage:
//         'https://media.gettyimages.com/photos/burger-with-french-fries-picture-id1211425123?k=6&m=1211425123&s=612x612&w=0&h=TTc0b9eNLNPk3uYgyIYlDTsb1aRJsO9z6qyEvN6jG2I=',
//     discountImage:
//         'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
//     discountText: '20 % | Coupon ',
//     foodPrice: 80,
//     title: 'Cheese Burger',
//     ratingText: '3.0',
//     subtitle: 'fastfood',
//     vegsymbol:
//         'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
//     starRating: SmoothStarRating(
//         allowHalfRating: false,
//         onRated: (v) {
//           Text("23");
//         },
//         starCount: 1,
//         rating: 3,
//         size: 20.0,
//         isReadOnly: false,
//         defaultIconData: Icons.star_border_outlined,
//         filledIconData: Icons.star,
//         halfFilledIconData: Icons.star_border,
//         color: Colors.red,
//         borderColor: Colors.red,
//         spacing: 0.0),
//   ),
//   ListofCategories(
//     index0: 1,
//     isPressed: false,
//     id: 105,
//     counter: 0,
//     quantity: 1,
//     foodImage:
//         'https://media.gettyimages.com/photos/crispy-chicken-burger-with-cheese-tomato-onions-and-lettuce-picture-id1265242728?k=6&m=1265242728&s=612x612&w=0&h=ZH3uKuHGNPHya-yiKmCmIleGy6jGPEtJes4VAywjH6g=',
//     discountImage:
//         'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
//     discountText: '20 % | Coupon ',
//     foodPrice: 180,
//     title: 'McChicken Burger',
//     ratingText: '4.0',
//     subtitle: 'fastfood',
//     vegsymbol:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/180px-Non_veg_symbol.svg.png',
//     starRating: SmoothStarRating(
//         allowHalfRating: false,
//         onRated: (v) {
//           Text("23");
//         },
//         starCount: 1,
//         rating: 4,
//         size: 20.0,
//         isReadOnly: true,
//         defaultIconData: Icons.star_border_outlined,
//         filledIconData: Icons.star,
//         halfFilledIconData: Icons.star_border,
//         color: Colors.red,
//         borderColor: Colors.red,
//         spacing: 0.0),
//   ),
//   ListofCategories(
//     index0: 2,
//     isPressed: false,
//     id: 105,
//     counter: 0,
//     quantity: 1,
//     foodImage:
//         'https://media.gettyimages.com/photos/crispy-chicken-burger-with-cheese-tomato-onions-and-lettuce-picture-id1265242728?k=6&m=1265242728&s=612x612&w=0&h=ZH3uKuHGNPHya-yiKmCmIleGy6jGPEtJes4VAywjH6g=',
//     discountImage:
//         'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
//     discountText: '20 % | Coupon ',
//     foodPrice: 180,
//     title: 'McVeggie',
//     ratingText: '4.0',
//     subtitle: 'fastfood',
//     vegsymbol:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/180px-Non_veg_symbol.svg.png',
//     starRating: SmoothStarRating(
//         allowHalfRating: false,
//         onRated: (v) {
//           Text("23");
//         },
//         starCount: 1,
//         rating: 4,
//         size: 20.0,
//         isReadOnly: true,
//         defaultIconData: Icons.star_border_outlined,
//         filledIconData: Icons.star,
//         halfFilledIconData: Icons.star_border,
//         color: Colors.red,
//         borderColor: Colors.red,
//         spacing: 0.0),
//   ),
//   ListofCategories(
//     index0: 3,
//     isPressed: false,
//     id: 105,
//     counter: 0,
//     quantity: 1,
//     foodImage:
//         'https://media.gettyimages.com/photos/crispy-chicken-burger-with-cheese-tomato-onions-and-lettuce-picture-id1265242728?k=6&m=1265242728&s=612x612&w=0&h=ZH3uKuHGNPHya-yiKmCmIleGy6jGPEtJes4VAywjH6g=',
//     discountImage:
//         'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
//     discountText: '20 % | Coupon ',
//     foodPrice: 180,
//     title: 'McVeggie Panner Grill',
//     ratingText: '4.0',
//     subtitle: 'fastfood',
//     vegsymbol:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/180px-Non_veg_symbol.svg.png',
//     starRating: SmoothStarRating(
//         allowHalfRating: false,
//         onRated: (v) {
//           Text("23");
//         },
//         starCount: 1,
//         rating: 4,
//         size: 20.0,
//         isReadOnly: true,
//         defaultIconData: Icons.star_border_outlined,
//         filledIconData: Icons.star,
//         halfFilledIconData: Icons.star_border,
//         color: Colors.red,
//         borderColor: Colors.red,
//         spacing: 0.0),
//   ),
//   ListofCategories(
//     index0: 4,
//     isPressed: false,
//     id: 105,
//     counter: 0,
//     quantity: 1,
//     foodImage:
//         'https://media.gettyimages.com/photos/crispy-chicken-burger-with-cheese-tomato-onions-and-lettuce-picture-id1265242728?k=6&m=1265242728&s=612x612&w=0&h=ZH3uKuHGNPHya-yiKmCmIleGy6jGPEtJes4VAywjH6g=',
//     discountImage:
//         'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
//     discountText: '20 % | Coupon ',
//     foodPrice: 180,
//     title: 'McVeggie',
//     ratingText: '4.0',
//     subtitle: 'fastfood',
//     vegsymbol:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/180px-Non_veg_symbol.svg.png',
//     starRating: SmoothStarRating(
//         allowHalfRating: false,
//         onRated: (v) {
//           Text("23");
//         },
//         starCount: 1,
//         rating: 4,
//         size: 20.0,
//         isReadOnly: true,
//         defaultIconData: Icons.star_border_outlined,
//         filledIconData: Icons.star,
//         halfFilledIconData: Icons.star_border,
//         color: Colors.red,
//         borderColor: Colors.red,
//         spacing: 0.0),
//   ),
//   ListofCategories(
//     index0: 5,
//     isPressed: false,
//     id: 106,
//     counter: 0,
//     quantity: 1,
//     foodImage:
//         'https://media.gettyimages.com/photos/crispy-chicken-burger-with-cheese-tomato-onions-and-lettuce-picture-id1265242728?k=6&m=1265242728&s=612x612&w=0&h=ZH3uKuHGNPHya-yiKmCmIleGy6jGPEtJes4VAywjH6g=',
//     discountImage:
//         'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
//     discountText: '20 % | Coupon ',
//     foodPrice: 180,
//     title: 'McEggSupreme ',
//     ratingText: '4.0',
//     subtitle: 'fastfood',
//     vegsymbol:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/180px-Non_veg_symbol.svg.png',
//     starRating: SmoothStarRating(
//         allowHalfRating: false,
//         onRated: (v) {
//           Text("23");
//         },
//         starCount: 1,
//         rating: 4,
//         size: 20.0,
//         isReadOnly: true,
//         defaultIconData: Icons.star_border_outlined,
//         filledIconData: Icons.star,
//         halfFilledIconData: Icons.star_border,
//         color: Colors.red,
//         borderColor: Colors.red,
//         spacing: 0.0),
//   )
// ];
