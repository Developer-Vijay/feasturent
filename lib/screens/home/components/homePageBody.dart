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
      child: Column(
        children: [
          Expanded(
            flex: 18,
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: size.height * 0.1,
                              width: size.width * 0.5,
                              child: Image.asset(
                                "assets/images/feasturent_app_logo.png",
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text("Feasturent gives opportunity"),
                            Text("to Experience the "),
                            Text("great food"),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
