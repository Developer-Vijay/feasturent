import 'package:feasturent_costomer_app/screens/home/components/quick_filter_resturent.dart';
import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/screens/home/components/category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1 categorylist");
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CategoryItem(
            title: "Combo Meal",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuickFilterResturent(
                            quickyName: "Combo Meal",
                          )));
            },
          ),
          CategoryItem(
            title: "Chicken",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuickFilterResturent(
                            quickyName: "Chicken",
                          )));
            },
          ),
          CategoryItem(
            title: "Beverages",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuickFilterResturent(
                            quickyName: "Beverage",
                          )));
            },
          ),
          CategoryItem(
            title: "Snacks & Sides",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuickFilterResturent(
                            quickyName: "Snacks Sides",
                          )));
            },
          ),
          CategoryItem(
            title: "Deserts",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuickFilterResturent(
                            quickyName: "Desert",
                          )));
            },
          ),
        ],
      ),
    );
  }
}
