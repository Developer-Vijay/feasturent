import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/screens/home/slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';

import '../customize_menu.dart';
import '../resturentCateMenues.dart';

class ResturentMenu extends StatefulWidget {
  final resturentMenu;
  const ResturentMenu({Key key, this.resturentMenu}) : super(key: key);
  @override
  _ResturentMenuState createState() => _ResturentMenuState();
}

class _ResturentMenuState extends State<ResturentMenu> {
  final services = UserServices();
  @override
  void initState() {
    super.initState();
    getList();
    restaurantDataCopy = widget.resturentMenu;
    fetchRestaurantStatus();
  }

  callingLoader() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => new AlertDialog(
                content: Row(
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text("Loading"),
                ),
              ],
            )));
  }

  bool status = true;

  Future fetchRestaurantStatus() async {
    if (restaurantDataCopy['user']['Setting'] == null) {
      setState(() {
        status = false;
      });
      WidgetsBinding.instance.addPostFrameCallback(
          // ignore: deprecated_member_use
          (_) => _scaffoldKey.currentState.showSnackBar(restaurantSnackBar));
    } else {
      setState(() {
        status = restaurantDataCopy['user']['Setting']['isActive'];
      });
      if (status == false) {
        WidgetsBinding.instance.addPostFrameCallback(
            // ignore: deprecated_member_use
            (_) => _scaffoldKey.currentState.showSnackBar(restaurantSnackBar));
      } else {
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ");
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final restaurantSnackBar = SnackBar(
      padding: EdgeInsets.symmetric(horizontal: 20),
      duration: Duration(minutes: 100),
      backgroundColor: Colors.white,
      content: Container(
        height: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.restaurant, color: Colors.blue),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Restaurant is now closed",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text("Restaurant is no longer taking order",
                        style: TextStyle(color: kPrimaryColor)),
                  ],
                )
              ],
            ),
          ],
        ),
      ));
  String snackBarData = "Items in cart";

  List<String> checkdata = [];
  getList() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      checkdata = cart.getStringList('addedtocart');
      baritemCount = cart.getInt('TotalCount');
      pricebar = cart.getInt('TotalPrice');
    });
    print(checkdata);
  }

  int baritemCount = 0;
  int pricebar = 0;
  var restaurantDataCopy;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: restaurantDataCopy['VendorCategories'].length == 0
          ? Container()
          : Container(
              margin: EdgeInsets.only(
                  bottom: baritemCount == 0
                      ? size.height * 0.03
                      : size.height * 0.07),
              child: MaterialButton(
                onPressed: () {},
                child: PopupMenuButton(
                    child: Container(
                        height: size.height * 0.06,
                        width: size.width * 0.12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                    offset: Offset(0, -size.height * 0.3),
                    elevation: 0,
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    itemBuilder: (context) {
                      return <PopupMenuEntry<Widget>>[
                        PopupMenuItem<Widget>(
                          enabled: true,
                          child: Container(
                            decoration: ShapeDecoration(
                                color: Colors.grey[100],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Scrollbar(
                              child: ListView.builder(
                                itemCount:
                                    restaurantDataCopy['VendorCategories']
                                        .length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VendorCategoryPage(
                                              vendorId: restaurantDataCopy[
                                                          'VendorCategories']
                                                      [index]['id']
                                                  .toString(),
                                              menudata: restaurantDataCopy,
                                            ),
                                          ));
                                      if (result) {
                                        setState(() {});
                                        getList();
                                      }
                                    },
                                    child: ListTile(
                                      enabled: true,
                                      title: Text(
                                        capitalize(restaurantDataCopy[
                                                'VendorCategories'][index]
                                            ['title']),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: size.height * 0.02,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            height: size.height * 0.26,
                            width: size.width * 0.6,
                          ),
                        ),
                      ];
                    }),
              ),
            ),
      body: Column(
        children: [
          Expanded(
            flex: 23,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: restaurantDataCopy['Menus'].length,
              itemBuilder: (context, index) {
                int tpye = 0;
                double rating = 1.0;
                int ratingLength = 1;
                if (restaurantDataCopy['Menus'][index]['ReviewAndRatings']
                    .isNotEmpty) {
                  int k = restaurantDataCopy['Menus'][index]['ReviewAndRatings']
                      .length;
                  ratingLength = k;
                  for (int i = 0; i <= k - 1; i++) {
                    rating = rating +
                        double.parse(restaurantDataCopy['Menus'][index]
                            ['ReviewAndRatings'][i]['id'].toString());
                  }
                  rating = rating / k;
                  if (rating >= 5) {
                    rating = 5.0;
                  }
                }

                return InkWell(
                  onTap: () async {
                    bool status;
                    var menuD;
                    if (restaurantDataCopy['user']['Setting'] == null) {
                      setState(() {
                        status = false;
                        menuD = restaurantDataCopy['Menus'][index];
                      });
                    } else {
                      setState(() {
                        status =
                            restaurantDataCopy['user']['Setting']['isActive'];
                        menuD = restaurantDataCopy['Menus'][index];
                      });
                    }

                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FoodSlider(
                                  menuData: menuD,
                                  menuStatus: status,
                                  restaurentName: restaurantDataCopy['name'],
                                  rating: rating,
                                  ratinglength: ratingLength,
                                )));

                    if (result) {
                      setState(() {});
                      getList();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2,
                                  color: Colors.blue[50],
                                  offset: Offset(1, 3),
                                  spreadRadius: 2)
                            ]),
                        margin: EdgeInsets.only(
                          left: size.width * 0.02,
                          right: size.width * 0.02,
                        ),
                        height: size.height * 0.14,
                        child: Row(children: [
                          Expanded(
                              flex: 0,
                              child: Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.topCenter,
                                    height: size.height * 0.2,
                                    width: size.width * 0.3,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.01,
                                          right: size.width * 0.014,
                                          top: size.height * 0.008),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: restaurantDataCopy['Menus']
                                                    [index]['image1'] !=
                                                null
                                            ? CachedNetworkImage(
                                                imageUrl: S3_BASE_PATH +
                                                    restaurantDataCopy['Menus']
                                                        [index]['image1'],
                                                height: size.height * 0.1,
                                                width: size.width * 0.26,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                  "assets/images/feasturenttemp.jpeg",
                                                  height: size.height * 0.1,
                                                  width: size.width * 0.26,
                                                  fit: BoxFit.cover,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              )
                                            : Image.asset(
                                                "assets/images/feasturenttemp.jpeg",
                                                height: size.height * 0.1,
                                                width: size.width * 0.26,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: size.height * 0.09,
                                    bottom: size.height * 0.02,
                                    left: size.width * 0.06,
                                    right: size.width * 0.06,
                                    child: Container(
                                      child: MaterialButton(
                                        onPressed: () async {
                                          if (status == true) {
                                            final SharedPreferences cart =
                                                await SharedPreferences
                                                    .getInstance();

                                            int vendorId =
                                                cart.getInt('VendorId');
                                            if (restaurantDataCopy['Menus']
                                                    [index]['isNonVeg'] ==
                                                false) {
                                              if (restaurantDataCopy['Menus']
                                                      [index]['isEgg'] ==
                                                  false) {
                                                tpye = 1;
                                              } else {
                                                tpye = 2;
                                              }
                                            } else {
                                              tpye = 3;
                                            }

                                            await services
                                                .data(
                                                    restaurantDataCopy['Menus']
                                                        [index]['id'])
                                                .then((value) => fun(value));

                                            if (vendorId == 0 ||
                                                vendorId ==
                                                    restaurantDataCopy['Menus']
                                                        [index]['vendorId']) {
                                              callingLoader();

                                              if (data1.isEmpty) {
                                                if (restaurantDataCopy['Menus']
                                                        [index]['AddonMenus']
                                                    .isEmpty) {
                                                  await addButtonFunction(
                                                      tpye,
                                                      index,
                                                      restaurantDataCopy[
                                                              'Menus'][index]
                                                          ['totalPrice'],
                                                      restaurantDataCopy[
                                                                      'Menus']
                                                                  [index]
                                                              ['gstAmount']
                                                          .toInt(),
                                                      0,
                                                      null,
                                                      restaurantDataCopy[
                                                              'Menus'][index]
                                                          ['title'],
                                                      rating);
                                                } else {
                                                  tempAddOns = null;
                                                  final result =
                                                      await showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          isDismissible: false,
                                                          enableDrag: false,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          context: context,
                                                          builder: (context) =>
                                                              CustomizeMenu(
                                                                menuData:
                                                                    restaurantDataCopy[
                                                                            'Menus']
                                                                        [index],
                                                              ));

                                                  if (result != null) {
                                                    if (result > 0) {
                                                      int totalprice = 0;
                                                      int totalgst = 0;
                                                      String title;
                                                      int k = restaurantDataCopy[
                                                                      'Menus']
                                                                  [index]
                                                              ['AddonMenus']
                                                          .length;
                                                      for (int i = 0;
                                                          i <= k - 1;
                                                          i++) {
                                                        if (restaurantDataCopy[
                                                                            'Menus']
                                                                        [index][
                                                                    'AddonMenus']
                                                                [i]['id'] ==
                                                            result) {
                                                          setState(() {
                                                            title =
                                                                "${restaurantDataCopy['Menus'][index]['AddonMenus'][i]['title']} ${restaurantDataCopy['Menus'][index]['title']}";

                                                            totalprice = restaurantDataCopy['Menus']
                                                                            [index]
                                                                        [
                                                                        'AddonMenus'][i]
                                                                    ['amount'] +
                                                                restaurantDataCopy['Menus']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'AddonMenus'][i]
                                                                    [
                                                                    'gstAmount'];
                                                            totalgst = restaurantDataCopy['Menus']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'AddonMenus'][i]
                                                                    [
                                                                    'gstAmount']
                                                                .toInt();
                                                          });
                                                        }
                                                      }
                                                      await addButtonFunction(
                                                          tpye,
                                                          index,
                                                          totalprice,
                                                          totalgst,
                                                          result,
                                                          tempAddOns,
                                                          title,
                                                          rating);
                                                    } else if (result == 0) {
                                                      await addButtonFunction(
                                                          tpye,
                                                          index,
                                                          restaurantDataCopy[
                                                                      'Menus']
                                                                  [index]
                                                              ['totalPrice'],
                                                          restaurantDataCopy[
                                                                          'Menus']
                                                                      [index]
                                                                  ['gstAmount']
                                                              .toInt(),
                                                          0,
                                                          tempAddOns,
                                                          restaurantDataCopy[
                                                                  'Menus']
                                                              [index]['title'],
                                                          rating);
                                                    }
                                                  }
                                                }
                                              } else {
                                                if (data1[0]['itemName'] !=
                                                    restaurantDataCopy['Menus']
                                                        [index]['title']) {
                                                  if (restaurantDataCopy[
                                                              'Menus'][index]
                                                          ['AddonMenus']
                                                      .isEmpty) {
                                                    await addButtonFunction(
                                                        tpye,
                                                        index,
                                                        restaurantDataCopy[
                                                                'Menus'][index]
                                                            ['totalPrice'],
                                                        restaurantDataCopy[
                                                                        'Menus']
                                                                    [index]
                                                                ['gstAmount']
                                                            .toInt(),
                                                        0,
                                                        null,
                                                        restaurantDataCopy[
                                                                'Menus'][index]
                                                            ['title'],
                                                        rating);
                                                  } else {
                                                    tempAddOns = null;
                                                    final result =
                                                        await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            isDismissible:
                                                                false,
                                                            enableDrag: false,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder: (context) =>
                                                                CustomizeMenu(
                                                                  menuData:
                                                                      restaurantDataCopy[
                                                                              'Menus']
                                                                          [
                                                                          index],
                                                                ));

                                                    if (result != null) {
                                                      if (result > 0) {
                                                        int totalprice = 0;
                                                        int totalgst = 0;
                                                        String title;
                                                        int k = restaurantDataCopy[
                                                                        'Menus']
                                                                    [index]
                                                                ['AddonMenus']
                                                            .length;
                                                        for (int i = 0;
                                                            i <= k - 1;
                                                            i++) {
                                                          if (restaurantDataCopy[
                                                                              'Menus']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'AddonMenus']
                                                                  [i]['id'] ==
                                                              result) {
                                                            setState(() {
                                                              title =
                                                                  "${restaurantDataCopy['Menus'][index]['AddonMenus'][i]['title']} ${restaurantDataCopy['Menus'][index]['title']}";
                                                              totalprice = restaurantDataCopy['Menus']
                                                                              [index]
                                                                          ['AddonMenus'][i]
                                                                      [
                                                                      'amount'] +
                                                                  restaurantDataCopy['Menus']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'AddonMenus'][i]
                                                                      [
                                                                      'gstAmount'];
                                                              totalgst = restaurantDataCopy['Menus']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'AddonMenus'][i]
                                                                      [
                                                                      'gstAmount']
                                                                  .toInt();
                                                            });
                                                          }
                                                        }
                                                        await addButtonFunction(
                                                            tpye,
                                                            index,
                                                            totalprice,
                                                            totalgst,
                                                            result,
                                                            tempAddOns,
                                                            title,
                                                            rating);
                                                      } else if (result == 0) {
                                                        await addButtonFunction(
                                                            tpye,
                                                            index,
                                                            restaurantDataCopy[
                                                                        'Menus']
                                                                    [index]
                                                                ['totalPrice'],
                                                            restaurantDataCopy[
                                                                            'Menus']
                                                                        [index][
                                                                    'gstAmount']
                                                                .toInt(),
                                                            0,
                                                            tempAddOns,
                                                            restaurantDataCopy[
                                                                        'Menus']
                                                                    [index]
                                                                ['title'],
                                                            rating);
                                                      }
                                                    }
                                                  }
                                                } else {
                                                  setState(() {
                                                    snackBarData =
                                                        "${restaurantDataCopy['Menus'][index]['title']} is already added to cart";
                                                  });
                                                  print("match");
                                                }
                                              }
                                              Navigator.pop(context);
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                        content: Text(
                                                            "Do you want to order food from different resturent"),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: Text(
                                                              "No",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: Text(
                                                              "Yes",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              callingLoader();
                                                              removeCartForNewData();
                                                              setState(() {});
                                                              getList();
                                                              Navigator.pop(
                                                                  context);
                                                              Navigator.pop(
                                                                  context);
                                                              if (restaurantDataCopy[
                                                                              'Menus']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'AddonMenus']
                                                                  .isEmpty) {
                                                                await addButtonFunction(
                                                                    tpye,
                                                                    index,
                                                                    restaurantDataCopy['Menus']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'totalPrice'],
                                                                    restaurantDataCopy['Menus']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'gstAmount'],
                                                                    0,
                                                                    null,
                                                                    restaurantDataCopy['Menus']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'title'],
                                                                    rating);
                                                              } else {
                                                                tempAddOns =
                                                                    null;
                                                                final result =
                                                                    await showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        isDismissible:
                                                                            false,
                                                                        enableDrag:
                                                                            false,
                                                                        backgroundColor:
                                                                            Colors
                                                                                .transparent,
                                                                        context:
                                                                            context,
                                                                        builder: (context) =>
                                                                            CustomizeMenu(
                                                                              menuData: restaurantDataCopy['Menus'][index],
                                                                            ));

                                                                if (result !=
                                                                    null) {
                                                                  if (result >
                                                                      0) {
                                                                    int totalprice =
                                                                        0;
                                                                    int totalgst =
                                                                        0;
                                                                    String
                                                                        title;
                                                                    int k = restaurantDataCopy['Menus'][index]
                                                                            [
                                                                            'AddonMenus']
                                                                        .length;
                                                                    for (int i =
                                                                            0;
                                                                        i <=
                                                                            k - 1;
                                                                        i++) {
                                                                      if (restaurantDataCopy['Menus'][index]['AddonMenus'][i]
                                                                              [
                                                                              'id'] ==
                                                                          result) {
                                                                        setState(
                                                                            () {
                                                                          title =
                                                                              "${restaurantDataCopy['Menus'][index]['AddonMenus'][i]['title']} ${restaurantDataCopy['Menus'][index]['title']}";

                                                                          totalprice =
                                                                              restaurantDataCopy['Menus'][index]['AddonMenus'][i]['amount'] + restaurantDataCopy['Menus'][index]['AddonMenus'][i]['gstAmount'].toInt();
                                                                          totalgst = restaurantDataCopy['Menus'][index]['AddonMenus'][i]['gstAmount']
                                                                              .toInt()
                                                                              .toInt();
                                                                        });
                                                                      }
                                                                    }
                                                                    await addButtonFunction(
                                                                        tpye,
                                                                        index,
                                                                        totalprice,
                                                                        totalgst,
                                                                        result,
                                                                        tempAddOns,
                                                                        title,
                                                                        rating);
                                                                  } else if (result ==
                                                                      0) {
                                                                    await addButtonFunction(
                                                                        tpye,
                                                                        index,
                                                                        restaurantDataCopy['Menus'][index]
                                                                            [
                                                                            'totalPrice'],
                                                                        restaurantDataCopy['Menus'][index]
                                                                            [
                                                                            'gstAmount'],
                                                                        0,
                                                                        tempAddOns,
                                                                        restaurantDataCopy['Menus'][index]
                                                                            [
                                                                            'title'],
                                                                        rating);
                                                                  }
                                                                }
                                                              }
                                                            },
                                                          ),
                                                        ]);
                                                  });
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Not taking orders now");
                                          }
                                        },
                                        color: checkdata.contains(
                                                restaurantDataCopy['Menus']
                                                        [index]['id']
                                                    .toString())
                                            ? Colors.blue
                                            : Colors.white,
                                        minWidth: size.width * 0.16,
                                        height: size.height * 0.033,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14)),
                                        textColor: Colors.white,
                                        child: checkdata.contains(
                                                restaurantDataCopy['Menus']
                                                        [index]['id']
                                                    .toString())
                                            ? Text(
                                                "Added",
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.015,
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                "Add",
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.015,
                                                    color: Colors.blueGrey),
                                              ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 6,
                              child: Container(
                                height: size.height * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: size.height * 0.01),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: size.width * 0.5,
                                            child: Text(
                                              capitalize(
                                                  restaurantDataCopy['Menus']
                                                      [index]['title']),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize:
                                                      size.height * 0.019),
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12),
                                              child: restaurantDataCopy['Menus']
                                                          [index]['isNonVeg'] ==
                                                      false
                                                  ? restaurantDataCopy['Menus']
                                                                  [index]
                                                              ['isEgg'] ==
                                                          false
                                                      ? Container(
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                                            height:
                                                                size.height *
                                                                    0.016,
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                          ),
                                                        )
                                                      : Container(
                                                          child: Image.asset(
                                                          "assets/images/eggeterian.png",
                                                          height: size.height *
                                                              0.016,
                                                        ))
                                                  : CachedNetworkImage(
                                                      imageUrl:
                                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
                                                      height:
                                                          size.height * 0.016,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.005),
                                    SizedBox(
                                      height: size.height * 0.002,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Text("⭐"),
                                          ),
                                          Text(
                                            "${rating.toStringAsFixed(1)}",
                                            style: TextStyle(
                                                fontSize: size.height * 0.014,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: size.width * 0.1),
                                            child: Text(
                                              "₹${restaurantDataCopy['Menus'][index]['totalPrice']}",
                                              style: TextStyle(
                                                  fontSize: size.height * 0.018,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.003,
                                    ),
                                    Container(
                                      child: Container(
                                          child:
                                              restaurantDataCopy['Menus'][index]
                                                              ['MenuOffers']
                                                          .length !=
                                                      0
                                                  ? Row(
                                                      children: [
                                                        Image.asset(
                                                          "assets/icons/discount_icon.jpg",
                                                          height: size.height *
                                                              0.02,
                                                        ),
                                                        SizedBox(
                                                          width: size.width *
                                                              0.006,
                                                        ),
                                                        Container(
                                                          child: restaurantDataCopy['Menus']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'MenuOffers']
                                                                      .length >=
                                                                  2
                                                              ? Row(
                                                                  children: [
                                                                    restaurantDataCopy['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon'] ==
                                                                            null
                                                                        ? SizedBox()
                                                                        : Text(
                                                                            " ${restaurantDataCopy['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon']}, ",
                                                                            style:
                                                                                TextStyle(fontSize: size.height * 0.015, color: kTextColor),
                                                                          ),
                                                                    restaurantDataCopy['Menus'][index]['MenuOffers'][1]['OffersAndCoupon']['coupon'] ==
                                                                            null
                                                                        ? SizedBox()
                                                                        : Text(
                                                                            " ${restaurantDataCopy['Menus'][index]['MenuOffers'][1]['OffersAndCoupon']['coupon']}",
                                                                            style:
                                                                                TextStyle(fontSize: size.height * 0.015, color: kTextColor),
                                                                          ),
                                                                  ],
                                                                )
                                                              : restaurantDataCopy['Menus']
                                                                              [
                                                                              index]['MenuOffers'][0]['OffersAndCoupon']
                                                                          [
                                                                          'coupon'] ==
                                                                      null
                                                                  ? SizedBox()
                                                                  : Text(
                                                                      " ${restaurantDataCopy['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon']}",
                                                                      style: TextStyle(
                                                                          fontSize: size.height *
                                                                              0.015,
                                                                          color:
                                                                              kTextColor),
                                                                    ),
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox()),
                                    ),
                                  ],
                                ),
                              )),
                          restaurantDataCopy['Menus'][index]['AddonMenus']
                                  .isEmpty
                              ? SizedBox()
                              : RotatedBox(
                                  quarterTurns: -1,
                                  child: Text(
                                    "Customize",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: size.height * 0.015),
                                  )),
                        ])),
                  ),
                );
              },
            ),
          ),
          baritemCount == 0
              ? SizedBox()
              : Expanded(
                  flex: 3,
                  child: Container(
                    height: size.height * 1,
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        border: Border.all(color: Colors.blueAccent),
                        // color: Colors.grey[200],
                      ),
                      height: size.height * 0.01,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: size.width * 1,
                      child: Row(
                        children: [
                          Container(
                            width: size.width * 0.4,
                            child: Text(
                              "$baritemCount Items | ₹ $pricebar",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          Spacer(),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            color: Colors.blue,
                            // minWidth: size.width * 0.4,
                            // height: size.height * 0.03,
                            textColor: Colors.white,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.blue[50],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "View Cart",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartScreen()));
                              if (result) {
                                setState(() {});
                                getList();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ))
        ],
      ),
    );
  }

  addButtonFunction(
      tpye, index, price, gst, variantId, addonsData, title, rating) async {
    if (status == true) {
      final SharedPreferences cart = await SharedPreferences.getInstance();

      int totalprice = cart.getInt('TotalPrice');
      int gsttotal = cart.getInt('TotalGst');
      int totalcount = cart.getInt('TotalCount');
      int vendorId = cart.getInt('VendorId');
      if (restaurantDataCopy['Menus'][index]['isNonVeg'] == false) {
        if (restaurantDataCopy['Menus'][index]['isEgg'] == false) {
          tpye = 1;
        } else {
          tpye = 2;
        }
      } else {
        tpye = 3;
      }

      await services
          .data(restaurantDataCopy['Menus'][index]['id'])
          .then((value) => fun(value));

      if (vendorId == 0 ||
          vendorId == restaurantDataCopy['Menus'][index]['vendorId']) {
        callingLoader();

        if (data1.isEmpty) {
          setState(() {
            itemAddToCart(
                index, tpye, price, gst, variantId, addonsData, title, rating);
            checkdata.add(restaurantDataCopy['Menus'][index]['id'].toString());

            totalcount = totalcount + 1;
            gsttotal = gsttotal + gst;
            totalprice = totalprice + price;

            vendorId = restaurantDataCopy['Menus'][index]['vendorId'];
            cart.setInt('VendorId', vendorId);
            cart.setInt('TotalPrice', totalprice);
            cart.setInt('TotalGst', gsttotal);
            cart.setInt('TotalCount', totalcount);

            cart.setStringList('addedtocart', checkdata);
            snackBarData =
                "${restaurantDataCopy['Menus'][index]['title']} is added to cart";
          });
        } else {
          if (data1[0]['itemName'] !=
              restaurantDataCopy['Menus'][index]['title']) {
            setState(() {
              itemAddToCart(index, tpye, price, gst, variantId, addonsData,
                  title, rating);
              checkdata
                  .add(restaurantDataCopy['Menus'][index]['id'].toString());

              totalcount = totalcount + 1;
              gsttotal = gsttotal + gst;
              totalprice = totalprice + price;

              vendorId = restaurantDataCopy['Menus'][index]['vendorId'];
              cart.setInt('VendorId', vendorId);
              cart.setInt('TotalPrice', totalprice);
              cart.setInt('TotalGst', gsttotal);
              cart.setInt('TotalCount', totalcount);

              cart.setStringList('addedtocart', checkdata);
              snackBarData =
                  "${restaurantDataCopy['Menus'][index]['title']} is added to cart";
            });
          } else {
            setState(() {
              snackBarData =
                  "${restaurantDataCopy['Menus'][index]['title']} is already added to cart";
            });
            print("match");
          }
        }
        Navigator.pop(context);
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  content: Text(
                      "Do you want to order food from different resturent"),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        callingLoader();
                        removeCartForNewData();
                        setState(() {});
                        getList();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        await addButtonFunction(tpye, index, price, gst,
                            variantId, addonsData, title, rating);
                      },
                    ),
                  ]);
            });
      }
    } else {
      Fluttertoast.showToast(msg: "Not taking orders now");
    }
  }

  itemAddToCart(
      index, tpye, price, gst, variantId, addons, name, rating) async {
    setState(() {
      services.saveUser(
          price,
          1,
          restaurantDataCopy['Menus'][index]['vendorId'],
          restaurantDataCopy['Menus'][index]['id'],
          restaurantDataCopy['Menus'][index]['image1'],
          name,
          "Add".toString(),
          tpye,
          0,
          restaurantDataCopy['name'],
          gst,
          variantId,
          addons,
          rating.toString());
    });
    getList();
  }

  fun(value) {
    setState(() {
      data1 = value;
    });
  }
}
