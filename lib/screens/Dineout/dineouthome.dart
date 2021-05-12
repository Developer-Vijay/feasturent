import 'package:feasturent_costomer_app/screens/Dineout/dineoutSlideList.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutSweeper.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutcollection.dart';
import 'package:feasturent_costomer_app/screens/Dineout/featured_dineout.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'best_offer_dineout.dart';
import 'dineoutPopular.dart';
import 'recommended_for_you.dart';

class DineoutHomePage extends StatefulWidget {
  @override
  _DineoutHomePageState createState() => _DineoutHomePageState();
}

class _DineoutHomePageState extends State<DineoutHomePage> {
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
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: refreshList,
          child: Column(
            children: [
              Expanded(
                flex: 18,
                child: ListView(shrinkWrap: true, children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Swipper(),
                      DineoutList(),
                      RecommendedForU(),
                      PopularDininingLists(),
                      FeaturedDineout(),
                      BestOfferDineout(),
                      Collections(),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
