import 'package:feasturent_costomer_app/screens/Dineout/dineoutSlideList.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutSweeper.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutappbar.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutcollection.dart';
import 'package:flutter/material.dart';

import 'dineoutPopular.dart';

class DineoutHomePage extends StatefulWidget {
  @override
  _DineoutHomePageState createState() => _DineoutHomePageState();
}

class _DineoutHomePageState extends State<DineoutHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Expanded(
            //   flex: 2,
            //   child: DineoutHomeAppBar1(),
            // ),
            Expanded(
              flex: 18,
              child: ListView(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Swipper(),
                    DineoutList(),
                    SizedBox(
                      height: 12,
                    ),
                    PopularDininingLists(),
                    SizedBox(
                      height: 12,
                    ),
                    Collections(),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
