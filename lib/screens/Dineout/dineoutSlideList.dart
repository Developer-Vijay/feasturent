import 'package:feasturent_costomer_app/screens/home/components/category_item.dart';
import 'package:flutter/material.dart';

class DineoutList extends StatefulWidget {
  const DineoutList({
    Key key,
  }) : super(key: key);

  @override
  _DineoutListState createState() => _DineoutListState();
}

class _DineoutListState extends State<DineoutList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CategoryItem(
            title: "Filter",
            press: () {
              // Navigator.push(context,MaterialPageRoute(builder: (context)=>Filter()));
            },
          ),
          CategoryItem(
            title: "Chicken",
            press: () {},
          ),
          CategoryItem(
            title: "Beverages",
            press: () {},
          ),
          CategoryItem(
            title: "Snacks & Sides",
            press: () {},
          ),
          CategoryItem(
            title: "Deserts",
            press: () {},
          ),
        ],
      ),
    );
  }
}
