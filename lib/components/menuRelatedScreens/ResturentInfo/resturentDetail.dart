import 'package:feasturent_costomer_app/components/WishList/WishListDataBase/wishlist_service.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/ResturentInfo/review_resturent.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    datamenu = infodata;

    checkStatus();
    getcategory(infodata);
  }

  checkStatus() async {
    await wishListServices.data(datamenu['id']).then((value) => func(value));

    if (dataCheck1.isEmpty) {
      setState(() {
        isSelected = false;
      });
    } else {
      print(dataCheck1[0]);
      if (dataCheck1[0]['name'] != datamenu['name']) {
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
  var datamenu;
  final wishListServices = WishListService();

  int _page = 0;
  List tabPages = [
    DetailResturent(
      restaurantInfo: infodata,
    ),
    ResturentMenu(
      resturentMenu: infodata,
    ),
    ReturentReview(
      resturentRatingid: infodata['id'],
    ),
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
                }),
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
                          .data(datamenu['id'])
                          .then((value) => func(value));

                      if (dataCheck1.isEmpty) {
                        setState(() {
                          isSelected = true;
                        });
                        getItemandNavigateToFavourites(infodata);
                      } else {
                        print(dataCheck1[0]);
                        if (dataCheck1[0]['name'] != datamenu['name']) {
                          setState(() {
                            isSelected = true;
                            getItemandNavigateToFavourites(infodata);
                            Fluttertoast.showToast(
                                msg: "Item Added to favourites");
                          });
                        }
                      }
                    } else {
                      setState(() {
                        isSelected = true;
                        removeFromWishlist(infodata);
                        Fluttertoast.showToast(
                            msg: "Item remove from favourites");
                      });
                    }
                  }),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/icons/default restaurent.png'),
                ),
                label: 'Details',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu_rounded,
                ),
                label: 'Menu',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.rate_review_outlined,
                ),
                label: 'Review',
              ),
            ],
            currentIndex: _page,
            selectedItemColor: Colors.blue,
            selectedIconTheme: IconThemeData(color: Colors.blue),
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

  String avg;

  var category;
  getcategory(data) {
    if (data['cuisines'] != null) {
      int k = data['cuisines'].length;
      print(k);
      var categoryData = '';
      if (k != 0) {
        for (int j = 0; j <= k - 1; j++) {
          categoryData =
              '$categoryData ${data['cuisines'][j]['Category']['name']},';
        }
        category = categoryData;
      } else {
        categoryData = null;
      }
    } else {
      category = null;
    }

    if (data['avgCost'] != null) {
      avg = "${data['avgCost']} Cost for ${data['forPeople']}";
    } else {
      avg = null;
    }
  }

  removeFromWishlist(data) async {
    wishListServices.deleteUser(datamenu['id']);
    checkStatus();
  }

  getItemandNavigateToFavourites(data) async {
    String rating;

    setState(() {
      wishListServices.saveUser(0, 1, avg, data['user']['profile'],
          data['name'], datamenu['id'], rating, null, category);
    });
    checkStatus();
    print("data added");
  }
}
