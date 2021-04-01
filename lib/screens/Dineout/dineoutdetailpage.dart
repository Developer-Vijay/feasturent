import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineoutRatingTab.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineout_about_tab.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineout_offer_tab.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineout_overview.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/dineoutgalleryImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../constants.dart';
import 'DIneoutTabs/dineout_menu_tab.dart';

class DineoutDetailPage extends StatefulWidget {
  final data;
  const DineoutDetailPage({this.data});
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
    Tab(
      child: Text("Rating"),
    ),
    Tab(
      child: Text("About"),
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

  var image =
      "https://media.gettyimages.com/photos/waiter-serves-beers-at-a-bar-on-the-eve-of-the-mandatory-closure-of-picture-id1228945616?k=6&m=1228945616&s=612x612&w=0&h=d-qVLDUFwS5hZzJuXKGosaY6O0TYEL09T9EXAVyjLJ4=";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: DefaultTabController(
            length: 5,
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
                                      data: widget.data['dineoutImages'],
                                    )));
                      },
                      child: widget.data['dineoutImages'].isNotEmpty
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
                                      widget.data['dineoutImages'][index]
                                          ['image'],
                                  fit: BoxFit.cover,
                                );
                              },
                              itemCount: widget.data['dineoutImages'].length,
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
                    labelColor: widget.data['dineoutImages'].isNotEmpty
                        ? Colors.white
                        : Colors.black,
                    controller: _controller,
                    tabs: list),
                title: Text('${widget.data['name']}'),
              ),
              SliverFillRemaining(
                  child: TabBarView(
                controller: _controller,
                children: [
                  PortfolioGallerySubPage(
                    data: widget.data,
                  ),
                  DineoutOfferTabPage(
                    data: widget.data,
                  ),
                  MenuDart(
                    data: widget.data,
                  ),
                  RatingBarTab(),
                  About(
                    data: widget.data,
                  ),
                ],
              )),
            ]))));
  }
}
