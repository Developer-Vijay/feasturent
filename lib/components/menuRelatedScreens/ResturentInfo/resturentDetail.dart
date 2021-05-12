import 'package:feasturent_costomer_app/components/menuRelatedScreens/ResturentInfo/review_resturent.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'detail_Resturent.dart';
import 'menu_Resturent.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/resturent_menues.dart';

class ResturentDetail extends StatefulWidget {
  final restaurantDataInfo;
  const ResturentDetail({Key key, this.restaurantDataInfo}) : super(key: key);
  @override
  _ResturentDetailState createState() => _ResturentDetailState();
}

class _ResturentDetailState extends State<ResturentDetail> {
  @override
  void initState() {
    super.initState();
  }

  int _page = 0;
  List tabPages = [
    DetailResturent(
      restaurantInfo: infodata,
    ),
    ResturentMenu(
      resturentMenu: infodata,
    ),
    ReturentReview(),
  ];
  appbarText() {
    if (_page == 0) {
      return Text(
        "Resturent Details",
        style: TextStyle(
            color: kTextColor, fontWeight: FontWeight.bold, fontSize: 15),
      );
    } else if (_page == 1) {
      return Text(
        "Menu",
        style: TextStyle(
            color: kTextColor, fontWeight: FontWeight.bold, fontSize: 15),
      );
    } else if (_page == 2) {
      return Text(
        "Review",
        style: TextStyle(
            color: kTextColor, fontWeight: FontWeight.bold, fontSize: 15),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pop(context, true);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              title: appbarText(),
              shadowColor: Colors.white,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: size.height * 0.03,
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context, true);
                  })),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(
                    AssetImage('assets/icons/default restaurent.png')),
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
      ),
    );
  }
}
