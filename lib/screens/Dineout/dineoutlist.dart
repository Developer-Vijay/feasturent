import 'package:flutter/material.dart';

class Dineoutlist {
  var title;
  var subtitle;
  var icon;
  int number;
  int phoneNumber;

  Dineoutlist(
      {this.icon, this.subtitle, this.title, this.number, this.phoneNumber});
}

List<Dineoutlist> dineoutlist = [
  Dineoutlist(
      icon: Image.asset('assets/icons/RESERVE TABLE.png'),
      title: "Book a Table",
      subtitle: "",
      phoneNumber: 0,
      number: 3),
];

class PopularList {
  var name;
  var image;

  PopularList({this.image, this.name});
}

DateTime time = DateTime.now();
List<PopularList> popular = [
  PopularList(
      image:
          "https://media.gettyimages.com/photos/elegant-shopping-mall-picture-id182408547?s=2048x2048",
      name: "V3S mall"),
  PopularList(
      image:
          "https://media.gettyimages.com/photos/cafebar-in-moscow-picture-id1158221681?s=2048x2048",
      name: "The Great Indian Place"),
  PopularList(
      image:
          "https://media.gettyimages.com/photos/cafebar-in-moscow-picture-id1158221681?s=2048x2048",
      name: "M3s"),
  PopularList(
      image:
          "https://media.gettyimages.com/photos/cafebar-in-moscow-picture-id1158221681?s=2048x2048",
      name: "M3s"),
];

class TimeList {
  bool isSelected = false;
  bool isSelected1 = false;
  var time;
  var hour;
  var format;

  TimeList(
      {this.time, this.isSelected, this.isSelected1, this.format, this.hour});
}
