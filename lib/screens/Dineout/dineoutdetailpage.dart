import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/ShimmerEffects/dineout_effect.dart';
import 'package:feasturent_costomer_app/components/WishList/WishListDataBase/wishlist_service.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineout_about_tab.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineout_offer_tab.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineout_overview.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineoutgalleryImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  // ignore: unused_field
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
    Tab(
      child: Text("About"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.dineID != null) {
      print(widget.dineID);
      fetchData(widget.dineID);
    } else {
      setState(() {
        dataChecker = true;

        data = widget.data;
      });
      checkStatus();

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

  String avg;
  checkStatus() async {
    await wishListServices.data(data['id']).then((value) => func(value));
    if (data['avgCost'] != null) {
      avg = "${data['avgCost']} Cost for ${data['forPeople']}";
    } else {
      avg = null;
    }
    if (dataCheck1.isEmpty) {
      setState(() {
        isSelected = false;
      });
    } else {
      print(dataCheck1[0]);
      if (dataCheck1[0]['name'] != data['name']) {
        setState(() {
          isSelected = false;
        });
      } else {
        setState(() {
          isSelected = true;
        });
      }
    }
  }

  func(value) {
    if (mounted) {
      setState(() {
        dataCheck1 = value;
      });
    }
  }

  bool isSelected = false;
  // var datamenu;
  final wishListServices = WishListService();

  bool dataChecker = false;
  bool dataValidator = false;
  // ignore: missing_return
  fetchData(id) async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  get dineout search");

    var result = await http.get(
      Uri.parse(APP_ROUTES + 'dineout?key=BYID&id=$id')
      ,
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
      checkStatus();
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
  var image =
      "https://media.gettyimages.com/photos/waiter-serves-beers-at-a-bar-on-the-eve-of-the-mandatory-closure-of-picture-id1228945616?k=6&m=1228945616&s=612x612&w=0&h=d-qVLDUFwS5hZzJuXKGosaY6O0TYEL09T9EXAVyjLJ4=";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: dataChecker == false
            ? Scaffold(
                body:DineoutEffect()
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
                        pinned: true,
                        floating: false,
                        forceElevated: true,
                        toolbarHeight: 40,
                        expandedHeight: size.height * 0.4,
                        actions: [
                          IconButton(
                              icon: isSelected == false
                                  ? Icon(Icons.bookmark_border_outlined)
                                  : Icon(Icons.bookmark_outlined),
                              iconSize: size.height * 0.03,
                              color: Colors.blue,
                              onPressed: () async {
                                if (isSelected == false) {
                                  await wishListServices
                                      .data(data['id'])
                                      .then((value) => func(value));

                                  if (dataCheck1.isEmpty) {
                                    setState(() {
                                      isSelected = true;
                                    });
                                    getItemandNavigateToFavourites(data);
                                  } else {
                                    print(dataCheck1[0]);
                                    if (dataCheck1[0]['name'] != data['name']) {
                                      setState(() {
                                        isSelected = true;
                                        getItemandNavigateToFavourites(data);
                                        Fluttertoast.showToast(
                                            msg: "Item Added to favourites");
                                      });
                                    }
                                  }
                                } else {
                                  setState(() {
                                    isSelected = true;
                                    removeFromWishlist(data);
                                    Fluttertoast.showToast(
                                        msg: "Item remove from favourites");
                                  });
                                }
                              }),
                        ],
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
                                      autoplay: true,
                                      autoplayDelay: 2000,
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
                                      "assets/images/defaultdineout.jpg",
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
                          About(
                            data: data,
                          ),
                        ],
                      )),
                    ]))));
  }

  removeFromWishlist(data) async {
    wishListServices.deleteUser(data['id']);
    checkStatus();
  }

  getItemandNavigateToFavourites(data) async {
    String rating;

    setState(() {
      wishListServices.saveUser(1, 0, null, data['user']['profile'],
          data['name'], data['id'], rating, data['Address']['city'], null);
    });
    checkStatus();

    print("data added");
  }
}
