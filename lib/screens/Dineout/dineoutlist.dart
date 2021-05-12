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
      title: "Reserve Table",
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

  TimeList({this.time, this.isSelected, this.isSelected1});
}

List<TimeList> breaskfastList = [
  TimeList(isSelected1: true, isSelected: false, time: "9:00 AM"),
  TimeList(isSelected1: false, isSelected: false, time: "9:15 AM"),
  TimeList(isSelected1: false, isSelected: false, time: "9:30 AM"),
  TimeList(isSelected1: false, isSelected: false, time: "9:45 AM"),
  TimeList(isSelected1: false, isSelected: false, time: "10:00 AM"),
  TimeList(isSelected1: false, isSelected: false, time: "10:15 AM"),
  TimeList(isSelected1: false, isSelected: false, time: "10:30 AM"),
  TimeList(isSelected1: false, isSelected: false, time: "10:45 AM"),
  TimeList(isSelected1: false, isSelected: false, time: "11:00 AM"),
];

List<TimeList> lunchlist = [
  TimeList(isSelected1: true, isSelected: false, time: "12:00 PM"),
  TimeList(isSelected1: true, isSelected: true, time: "12:15 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "12:30 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "1:00 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "1:15 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "1:30 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "1:45 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "2:00 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "2:15 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "2:30 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "2:45 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "3:00 PM"),
];

List<TimeList> dinnerlist = [
  TimeList(isSelected1: true, isSelected: false, time: "7:00 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "7:15 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "7:30 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "7:45 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "8:00 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "8:15 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "8:30 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "8:45 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "9:00 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "9:15 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "9:30 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "9:45 PM"),
  TimeList(isSelected1: true, isSelected: false, time: "10:00 PM"),
];
