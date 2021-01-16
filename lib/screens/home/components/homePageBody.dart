import 'package:feasturent_costomer_app/screens/home/components/homeAppBar.dart';
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
    return 
    Column(
      children: [Expanded(flex: 2,child:  HomeAppBar1(),),
        Expanded(flex: 18,
          child: ListView(
            
            children:[ 
             
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[

                
                DiscountCard(),
                CategoryList(),
                CategoriesList(),
                PopularList(),
               
                
              ],
            ),
          ]),
        ),
      ],
    );
  }
}
