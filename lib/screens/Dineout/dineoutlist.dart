import 'package:flutter/material.dart';

class Dineoutlist{
  var title;
  var subtitle;
  var icon;

  Dineoutlist({this.icon,this.subtitle,this.title});
}
List<Dineoutlist> dineoutlist=[
  Dineoutlist(icon: Icon(Icons.local_offer,color: Colors.red[800],),title: "up to 50% off",subtitle: ""),
  Dineoutlist(icon: Icon(Icons.attach_money,color: Colors.green[700],),title: "Paybill",subtitle: "Save Extra 10% using PromoCash"),
   Dineoutlist(icon: Icon(Icons.table_chart,color: Colors.brown,),title: "Reserve Table",subtitle: ""),
    Dineoutlist(icon:Icon(Icons.people)
    ,title: "Stories",subtitle: ""),


];

class PopularList{
  var name;
  var image;

  PopularList({this.image,this.name});
}

List<PopularList> popular=[
  PopularList(image: "https://media.gettyimages.com/photos/elegant-shopping-mall-picture-id182408547?s=2048x2048",name: "V3S mall"),
  PopularList(image: "https://media.gettyimages.com/photos/cafebar-in-moscow-picture-id1158221681?s=2048x2048",name: "The Great Indian Place"),
   PopularList(image: "https://media.gettyimages.com/photos/cafebar-in-moscow-picture-id1158221681?s=2048x2048",name: "M3s"),
     PopularList(image: "https://media.gettyimages.com/photos/cafebar-in-moscow-picture-id1158221681?s=2048x2048",name: "M3s"),
];