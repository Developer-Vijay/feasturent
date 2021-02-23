import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/ResturentInfo/review_resturent.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'detail_Resturent.dart';
import 'menu_Resturent.dart';

class ResturentDetail extends StatefulWidget {
  @override
  _ResturentDetailState createState() => _ResturentDetailState();
}

class _ResturentDetailState extends State<ResturentDetail> {
  int _page = 0;
  List<Widget> tabPages = [
    DetailResturent(),
    ResturentMenu(),
    ReturentReview(),
  ];
  appbarText() {
    if (_page == 0) {
      return Text(
        "Resturent Details",
      );
    } else if (_page == 1) {
      return Text(
        "Menu",
      );
    } else if (_page == 2) {
      return Text(
        "Review",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ListofFood resturentNameIndex =
        ModalRoute.of(context).settings.arguments;
    print(resturentNameIndex.index0);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: appbarText()),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.details_outlined),
              label: 'Details',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_rounded),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.rate_review_outlined),
              label: 'Review',
            ),
          ],
          currentIndex: _page,
          selectedItemColor: Colors.amber[800],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: tabPages[_page],
      ),
    );
  }
}
