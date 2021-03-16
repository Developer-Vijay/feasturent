import 'package:flutter/material.dart';

class Dineoutlist {
  var title;
  var subtitle;
  var icon;
  int number;

  Dineoutlist({this.icon, this.subtitle, this.title, this.number});
}

List<Dineoutlist> dineoutlist = [
  Dineoutlist(
      icon: Icon(
        Icons.local_offer,
        color: Colors.red[800],
      ),
      title: "up to 50% off",
      subtitle: "",
      number: 1),
  Dineoutlist(
      icon: Icon(
        Icons.attach_money,
        color: Colors.green[700],
      ),
      title: "Paybill",
      subtitle: "Save Extra 10% using PromoCash",
      number: 2),
  Dineoutlist(
      icon: Icon(
        Icons.table_chart,
        color: Colors.brown,
      ),
      title: "Reserve Table",
      subtitle: "",
      number: 3),
  Dineoutlist(
      icon: Icon(
        Icons.people,
      ),
      title: "Stories",
      subtitle: "",
      number: 4),
];

class PopularList {
  var name;
  var image;

  PopularList({this.image, this.name});
}

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

  TimeList({this.time, this.isSelected, this.isSelected1});
}

List<TimeList> breaskfastList = [
  TimeList(isSelected1: true, isSelected: false, time: "9:00"),
  TimeList(isSelected1: false, isSelected: false, time: "9:15"),
  TimeList(isSelected1: false, isSelected: false, time: "9:30"),
  TimeList(isSelected1: false, isSelected: false, time: "9:45"),
  TimeList(isSelected1: false, isSelected: false, time: "10:00"),
  TimeList(isSelected1: false, isSelected: false, time: "10:15"),
  TimeList(isSelected1: false, isSelected: false, time: "10:30"),
  TimeList(isSelected1: false, isSelected: false, time: "10:45"),
  TimeList(isSelected1: false, isSelected: false, time: "11:00"),
];

List<TimeList> lunchlist = [
  TimeList(isSelected1: true, isSelected: false, time: "12:00"),
  TimeList(isSelected1: true, isSelected: false, time: "12:15"),
  TimeList(isSelected1: true, isSelected: false, time: "12:30"),
  TimeList(isSelected1: true, isSelected: false, time: "1:00"),
  TimeList(isSelected1: true, isSelected: false, time: "1:15"),
  TimeList(isSelected1: true, isSelected: false, time: "1:30"),
  TimeList(isSelected1: true, isSelected: false, time: "1:45"),
  TimeList(isSelected1: true, isSelected: false, time: "2:00"),
  TimeList(isSelected1: true, isSelected: false, time: "2:15"),
  TimeList(isSelected1: true, isSelected: false, time: "2:30"),
  TimeList(isSelected1: true, isSelected: false, time: "2:45"),
  TimeList(isSelected1: true, isSelected: false, time: "3:00:"),
];

List<TimeList> dinnerlist = [
  TimeList(isSelected1: true, isSelected: false, time: "7:00"),
  TimeList(isSelected1: true, isSelected: false, time: "7:15"),
  TimeList(isSelected1: true, isSelected: false, time: "7:30"),
  TimeList(isSelected1: true, isSelected: false, time: "7:45"),
  TimeList(isSelected1: true, isSelected: false, time: "8:00"),
  TimeList(isSelected1: true, isSelected: false, time: "8:15"),
  TimeList(isSelected1: true, isSelected: false, time: "8:30"),
  TimeList(isSelected1: true, isSelected: false, time: "8:45"),
  TimeList(isSelected1: true, isSelected: false, time: "9:00"),
  TimeList(isSelected1: true, isSelected: false, time: "9:15"),
  TimeList(isSelected1: true, isSelected: false, time: "9:30"),
  TimeList(isSelected1: true, isSelected: false, time: "9:45"),
  TimeList(isSelected1: true, isSelected: false, time: "10:00"),
];
