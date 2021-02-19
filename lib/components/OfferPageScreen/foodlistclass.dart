import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/material.dart';

class ListofFood {
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
  String name;

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
      this.name,
      this.discountImage,
      this.discountText});
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
  var id;
  int counter;
  var postion;
  var isSelected;

  addto(
      {this.foodImage,
      this.vegsymbol,
      this.id,
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

List<ListofFood> foodlist = [
  ListofFood(
    index0: 0,
    id: 101,
    quantity: 1,
    counter: 0,
    foodImage:
        'https://media.gettyimages.com/photos/view-of-papri-chat-on-november-10-2015-in-kolkata-india-picture-id542764412?k=6&m=542764412&s=612x612&w=0&h=6IEwFhfeYFwdt8H8hdgzePPRyusFHnu25xYFxfRXvNU=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '40 % | Use Code SW100',
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
    index0: 1,
    id: 102,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/spring-salad-shot-from-above-on-rustic-wood-table-picture-id505685702?k=6&m=505685702&s=612x612&w=0&h=dw2v57OlDMM8xUBbg2EHGaWP4zWX9iKLXS6mS2qPaB4=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Use Code ',
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
  String name;

  InsideListofFood(
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
      this.name,
      this.discountImage,
      this.discountText});
}

List<InsideListofFood> addtocart = [];

List<InsideListofFood> insideOfferPage = [
  InsideListofFood(
    index0: 0,
    id: 102,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/aloo-tikki-chaat-picture-id159801149?k=6&m=159801149&s=612x612&w=0&h=96ZMbIqHXuhaJepXw_xfls7wxs8CgqKOUHkbKFdgwqE=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Use Code ',
    foodPrice: 120,
    title: 'Aloo Tikki',
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
    index0: 1,
    id: 102,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/pani-puri-picture-id1140993688?k=6&m=1140993688&s=612x612&w=0&h=uHU55pv3ECgx9yQtwHUwOKS5DgNk3S_cS9DCILvLqU4=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Use Code ',
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
    index0: 2,
    id: 102,
    counter: 0,
    quantity: 1,
    foodImage:
        'https://media.gettyimages.com/photos/closeup-of-raj-kachori-served-on-table-picture-id654743911?k=6&m=654743911&s=612x612&w=0&h=820dRXGQay-CYK6suM1clNiE-sZeyDQdLQmaqyUIY98=',
    discountImage:
        'https://st2.depositphotos.com/1435425/6338/v/950/depositphotos_63384005-stock-illustration-special-offer-icon-design.jpg',
    discountText: '20 % | Use Code ',
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
    discountText: '20 % | Use Code ',
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
    discountText: '20 % | Use Code ',
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
    discountText: '20 % | Use Code ',
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
    discountText: '20 % | Use Code ',
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
    discountText: '20 % | Use Code ',
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
    discountText: '20 % | Use Code ',
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
