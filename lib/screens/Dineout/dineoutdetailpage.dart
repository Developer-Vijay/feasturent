import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/DineoutMenuTab.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/Dineoutsub_page.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineoutRatingTab.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineout_offer_tab.dart';
import 'package:feasturent_costomer_app/screens/details/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DineoutDetailPage extends StatefulWidget {
  @override
  _DineoutDetailPageState createState() => _DineoutDetailPageState();
}

class _DineoutDetailPageState extends State<DineoutDetailPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(
      child: Text("OverView"),
    ),
    Tab(
      child: Text("Offers"),
    ),
    Tab(
      child: Text("Menu"),
    ),
    Tab(
      child: Text("Rating"),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  final _textstyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
  List barimages = [
    "https://media.gettyimages.com/photos/wooden-table-in-front-of-abstract-blurred-restaurant-lights-of-bar-picture-id1250327071?k=6&m=1250327071&s=612x612&w=0&h=z_gcxwIlFxPxrPh3XX3maljIx7Nqg4Ct2hA6LKjgYqM=",
    "https://media.gettyimages.com/photos/waiter-serves-beers-at-a-bar-on-the-eve-of-the-mandatory-closure-of-picture-id1228945616?k=6&m=1228945616&s=612x612&w=0&h=d-qVLDUFwS5hZzJuXKGosaY6O0TYEL09T9EXAVyjLJ4="
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: DefaultTabController(
            length: 4,
            child: Scaffold(
                body: CustomScrollView(slivers: [
              SliverAppBar(
                floating: false,
                forceElevated: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                  )
                ],
                toolbarHeight: 40,
                expandedHeight: size.height * 0.4,
                flexibleSpace: FlexibleSpaceBar(
                  background: Swiper(
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: barimages[index],
                        fit: BoxFit.fill,
                      );
                    },
                    itemCount: barimages.length,
                  ),
                ),
                bottom: TabBar(
                    onTap: (index) {}, controller: _controller, tabs: list),
                title: Text('Bar'),
              ),
              SliverFillRemaining(
                  child: TabBarView(
                controller: _controller,
                children: [
                  PortfolioGallerySubPage(),
                  DineoutOfferTabPage(),
                  MenuDart(),
                  RatingBarTab(),
                ],
              )),
            ]))));
  }
}
