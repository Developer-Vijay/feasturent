import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineout_about_tab.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineout_offer_tab.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineout_overview.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineoutgalleryImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../constants.dart';
import 'DIneoutTabs/dineout_menu_tab.dart';

import 'package:http/http.dart ' as http;
import 'dart:convert';

class DineoutDetailPage extends StatefulWidget {
  final dineID;
  final data;
  const DineoutDetailPage({this.data, this.dineID});
  @override
  _DineoutDetailPageState createState() => _DineoutDetailPageState();
}

class _DineoutDetailPageState extends State<DineoutDetailPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(
      child: Text(
        "OverView",
      ),
    ),
    Tab(
      child: Text("Offers"),
    ),
    Tab(
      child: Text("Menu"),
    ),
    // Tab(
    //   child: Text("Rating"),
    // ),
    Tab(
      child: Text("About"),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.dineID != null) {
      print(widget.dineID);
      fetchData(widget.dineID);
    } else {
      setState(() {
        dataChecker = true;

        data = widget.data;
      });
      // Create TabController for getting the index of current tab
      _controller = TabController(length: list.length, vsync: this);

      _controller.addListener(() {
        setState(() {
          _selectedIndex = _controller.index;
        });
        print("Selected Index: " + _controller.index.toString());
      });
    }
  }

  bool dataChecker = false;
  bool dataValidator = false;
  // ignore: missing_return
  fetchData(id) async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  get dineout search");

    var result = await http.get(
      APP_ROUTES + 'dineout?key=BYID&id=$id',
    );
    var restaurantData = json.decode(result.body)['data'];
    print("this is data");
    print(restaurantData);

    if (restaurantData.isEmpty || restaurantData == null) {
      setState(() {
        dataChecker = true;

        dataValidator = true;
      });
    } else {
      setState(() {
        dataChecker = true;

        data = restaurantData[0];
      });
      // Create TabController for getting the index of current tab
      _controller = TabController(length: list.length, vsync: this);

      _controller.addListener(() {
        setState(() {
          _selectedIndex = _controller.index;
        });
        print("Selected Index: " + _controller.index.toString());
      });
    }
  }

  var data;
  final _textstyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  var image =
      "https://media.gettyimages.com/photos/waiter-serves-beers-at-a-bar-on-the-eve-of-the-mandatory-closure-of-picture-id1228945616?k=6&m=1228945616&s=612x612&w=0&h=d-qVLDUFwS5hZzJuXKGosaY6O0TYEL09T9EXAVyjLJ4=";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: dataChecker == false
            ? Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : dataValidator == true
                ? Scaffold(
                    body: Center(
                      child: Text("Something went wrong please try later..."),
                    ),
                  )
                : DefaultTabController(
                    length: 4,
                    child: Scaffold(
                        body: CustomScrollView(slivers: [
                      SliverAppBar(
                        floating: false,
                        forceElevated: true,
                        // pinned: true,
                        actions: [
                          IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () {},
                          )
                        ],
                        toolbarHeight: 40,
                        expandedHeight: size.height * 0.4,
                        flexibleSpace: FlexibleSpaceBar(
                          background: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DineoutGallery(
                                              data: data['dineoutImages'],
                                            )));
                              },
                              child: data['dineoutImages'].isNotEmpty
                                  ? Swiper(
                                      itemBuilder: (context, index) {
                                        return CachedNetworkImage(
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.black,
                                              semanticsLabel: "Loading",
                                            ),
                                          ),
                                          imageUrl: S3_BASE_PATH +
                                              data['dineoutImages'][index]
                                                  ['image'],
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      itemCount: data['dineoutImages'].length,
                                    )
                                  : Image.asset(
                                      "assets/images/NoImage.png.jpeg",
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        bottom: TabBar(
                            labelPadding: EdgeInsets.all(2),
                            indicatorWeight: 3.0,
                            onTap: (index) {},
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            labelColor: data['dineoutImages'].isNotEmpty
                                ? Colors.white
                                : Colors.black,
                            controller: _controller,
                            tabs: list),
                        title: Text(capitalize('${data['name']}')),
                      ),
                      SliverFillRemaining(
                          child: TabBarView(
                        controller: _controller,
                        children: [
                          PortfolioGallerySubPage(
                            data: data,
                          ),
                          DineoutOfferTabPage(
                            data: data,
                          ),
                          MenuDart(
                            data: data,
                          ),
                          // RatingBarTab(),
                          About(
                            data: data,
                          ),
                        ],
                      )),
                    ]))));
  }
}
