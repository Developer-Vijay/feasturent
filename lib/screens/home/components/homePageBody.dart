import 'package:feasturent_costomer_app/screens/home/components/allResturent.dart';
import 'package:feasturent_costomer_app/screens/home/components/popular.dart';
import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/screens/home/components/category_list.dart';
import 'package:feasturent_costomer_app/screens/home/components/discount_card.dart';
import 'package:feasturent_costomer_app/screens/home/components/item_list.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  void initState() {
    super.initState();
  }

  ScrollController _scrollController = ScrollController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState.show();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      Fluttertoast.showToast(msg: "Page Refreshed");
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: RefreshIndicator(
      key: refreshKey,
      onRefresh: refreshList,
      child: ListView(
        controller: _scrollController,
        children: [
          DiscountCard(),
          CategoryList(),
          CategoriesList(),
          PopularList(),
          AllResturent(),
          Container(
            color: Colors.grey[50],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: size.height * 0.06,
                    backgroundImage: AssetImage("assets/icons/feasturent.png"),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
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
      ),
    ));
  }
}
