import 'package:feasturent_costomer_app/screens/home/components/allResturent.dart';
import 'package:feasturent_costomer_app/screens/home/components/popular.dart';
import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/screens/home/components/category_list.dart';
import 'package:feasturent_costomer_app/screens/home/components/discount_card.dart';
import 'package:feasturent_costomer_app/screens/home/components/item_list.dart';

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        DiscountCard(),
        CategoryList(),
        CategoriesList(),
        PopularList(),
        AllResturent(),
        Container(
          // height: 150,
          // width: 200,
          color: Colors.grey[50],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/icons/feasturent.png"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '''
  Feasturent give opportunity 
  to Experience the 
  great food
                     ''',
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
