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