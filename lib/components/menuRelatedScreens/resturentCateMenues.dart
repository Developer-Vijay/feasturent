import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/screens/home/slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'customize_menu.dart';
import 'foodlistclass.dart';

class VendorCategoryPage extends StatefulWidget {
  final menudata;
  final vendorId;
  const VendorCategoryPage({Key key, this.menudata, this.vendorId})
      : super(key: key);
  @override
  _VendorCategoryPageState createState() => _VendorCategoryPageState();
}

class _VendorCategoryPageState extends State<VendorCategoryPage> {
  @override
  void initState() {
    super.initState();
    getList();
    setState(() {
      menuData = widget.menudata;
      vendorID = widget.vendorId;
    });
    print(menuData);
    calculatedata();
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

  calculatedata() {
    int k = menuData['Menus'].length;
    for (int i = 0; i <= k - 1; i++) {
      if (menuData['Menus'][i]['vendorCategoryId'] != vendorID) {
        counter = counter + 1;
      } else {
        setState(() {
          checker = true;
        });
      }
    }
    if (counter == k) {
      setState(() {
        checker = true;
        datachecker = true;
      });
    }
  }

  bool checker = false;
  bool datachecker = false;
  bool status = true;

  Future fetchRestaurantStatus() async {
    if (menuData['user']['Setting'] == null) {
      setState(() {
        status = false;
      });
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => _scaffoldKey.currentState.showSnackBar(restaurantSnackBar));
    } else {
      setState(() {
        status = menuData['user']['Setting']['isActive'];
      });
      if (status == false) {
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => _scaffoldKey.currentState.showSnackBar(restaurantSnackBar));
      } else {
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ");
      }
    }

    // if (timeData.compareTo(resturantStatus[0]['user']['Setting']['storeTimeStart']) != 1)
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
    });
    print(checkdata);
  }

  final services = UserServices();
  int counter = 0;
  var menuData;
  var vendorID;
  @override
  Widget build(BuildContext context) {
    print(vendorID);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pop(context, true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          title: Text(
            menuData['name'],
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: checker == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : datachecker == true
                ? Center(
                    child: Text("No menue available..."),
                  )
                : Column(
                    children: [
                      Expanded(
                        flex: 18,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            itemCount: menuData['Menus'].length,
                            itemBuilder: (context, index) {
                              if (menuData['Menus'][index]
                                      ['vendorCategoryId'] ==
                                  vendorID) {
                                int tpye = 0;
                                double rating = 1.0;
                                int ratingLength = 1;
                                if (menuData['Menus'][index]['ReviewAndRatings']
                                    .isNotEmpty) {
                                  int k = menuData['Menus'][index]
                                          ['ReviewAndRatings']
                                      .length;
                                  ratingLength = k;
                                  for (int i = 0; i <= k - 1; i++) {
                                    if (rating <=
                                        double.parse(menuData['Menus'][index]
                                                ['ReviewAndRatings'][i]
                                            ['rating'])) {
                                      rating = double.parse(menuData['Menus']
                                              [index]['ReviewAndRatings'][i]
                                          ['rating']);
                                    }
                                  }
                                }
                                return InkWell(
                                  onTap: () async {
                                    var menuD;
                                    setState(() {
                                      menuD = menuData['Menus'][index];
                                    });
                                    final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FoodSlider(
                                                menuData: menuD,
                                                menuStatus: status,
                                                restaurentName:
                                                    menuData['name'],
                                                rating: rating,
                                                ratinglength: ratingLength)));
                                    if (result) {
                                      setState(() {});
                                      getList();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 14),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                    alignment:
                                                        Alignment.topCenter,
                                                    height: size.height * 0.2,
                                                    width: size.width * 0.3,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left:
                                                              size.width * 0.01,
                                                          right: size.width *
                                                              0.014,
                                                          top: size.height *
                                                              0.008),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: menuData['Menus']
                                                                        [index][
                                                                    'image1'] !=
                                                                null
                                                            ? CachedNetworkImage(
                                                                imageUrl: S3_BASE_PATH +
                                                                    menuData['Menus']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'image1'],
                                                                height:
                                                                    size.height *
                                                                        0.1,
                                                                width:
                                                                    size.width *
                                                                        0.26,
                                                                fit: BoxFit
                                                                    .cover,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                              )
                                                            : Image.asset(
                                                                "assets/images/feasturenttemp.jpeg",
                                                                height:
                                                                    size.height *
                                                                        0.1,
                                                                width:
                                                                    size.width *
                                                                        0.26,
                                                                fit: BoxFit
                                                                    .cover,
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
                                                            final SharedPreferences
                                                                cart =
                                                                await SharedPreferences
                                                                    .getInstance();

                                                            int totalprice =
                                                                cart.getInt(
                                                                    'TotalPrice');
                                                            int gsttotal =
                                                                cart.getInt(
                                                                    'TotalGst');
                                                            int totalcount =
                                                                cart.getInt(
                                                                    'TotalCount');
                                                            int vendorId =
                                                                cart.getInt(
                                                                    'VendorId');
                                                            if (menuData['Menus']
                                                                        [index][
                                                                    'isNonVeg'] ==
                                                                false) {
                                                              if (menuData['Menus']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'isEgg'] ==
                                                                  false) {
                                                                tpye = 1;
                                                              } else {
                                                                tpye = 2;
                                                              }
                                                            } else {
                                                              tpye = 3;
                                                            }

                                                            await services
                                                                .data(menuData[
                                                                            'Menus']
                                                                        [index]
                                                                    ['id'])
                                                                .then((value) =>
                                                                    fun(value));

                                                            if (vendorId == 0 ||
                                                                vendorId ==
                                                                    menuData['Menus']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'vendorId']) {
                                                              callingLoader();
                                                              if (data1
                                                                  .isEmpty) {
                                                                if (menuData['Menus']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'AddonMenus']
                                                                    .isEmpty) {
                                                                  await addButtonFunction(
                                                                      tpye,
                                                                      index,
                                                                      menuData['Menus']
                                                                              [index]
                                                                          [
                                                                          'totalPrice'],
                                                                      menuData['Menus']
                                                                              [index]
                                                                          [
                                                                          'gstAmount'],
                                                                      0,
                                                                      null,
                                                                      menuData['Menus']
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
                                                                          backgroundColor: Colors
                                                                              .transparent,
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
                                                                              CustomizeMenu(
                                                                                menuData: menuData['Menus'][index],
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
                                                                      int k = menuData['Menus'][index]
                                                                              [
                                                                              'AddonMenus']
                                                                          .length;
                                                                      for (int i =
                                                                              0;
                                                                          i <=
                                                                              k - 1;
                                                                          i++) {
                                                                        if (menuData['Menus'][index]['AddonMenus'][i]['id'] ==
                                                                            result) {
                                                                          setState(
                                                                              () {
                                                                            title =
                                                                                "${menuData['Menus'][index]['AddonMenus'][i]['title']} ${menuData['Menus'][index]['title']}";

                                                                            totalprice =
                                                                                menuData['Menus'][index]['AddonMenus'][i]['amount'] + menuData['Menus'][index]['AddonMenus'][i]['gstAmount'];
                                                                            totalgst =
                                                                                menuData['Menus'][index]['AddonMenus'][i]['gstAmount'];
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
                                                                          menuData['Menus'][index]
                                                                              [
                                                                              'totalPrice'],
                                                                          menuData['Menus'][index]
                                                                              [
                                                                              'gstAmount'],
                                                                          0,
                                                                          tempAddOns,
                                                                          menuData['Menus'][index]
                                                                              [
                                                                              'title'],
                                                                          rating);
                                                                    }
                                                                  }
                                                                }
                                                              } else {
                                                                if (data1[0][
                                                                        'itemName'] !=
                                                                    menuData['Menus']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'title']) {
                                                                  if (menuData['Menus']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'AddonMenus']
                                                                      .isEmpty) {
                                                                    await addButtonFunction(
                                                                        tpye,
                                                                        index,
                                                                        menuData['Menus'][index]
                                                                            [
                                                                            'totalPrice'],
                                                                        menuData['Menus'][index]
                                                                            [
                                                                            'gstAmount'],
                                                                        0,
                                                                        null,
                                                                        menuData['Menus'][index]
                                                                            [
                                                                            'title'],
                                                                        rating);
                                                                  } else {
                                                                    tempAddOns =
                                                                        null;
                                                                    final result = await showModalBottomSheet(
                                                                        isScrollControlled: true,
                                                                        isDismissible: false,
                                                                        enableDrag: false,
                                                                        backgroundColor: Colors.transparent,
                                                                        context: context,
                                                                        builder: (context) => CustomizeMenu(
                                                                              menuData: menuData['Menus'][index],
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
                                                                        int k =
                                                                            menuData['Menus'][index]['AddonMenus'].length;
                                                                        for (int i =
                                                                                0;
                                                                            i <=
                                                                                k - 1;
                                                                            i++) {
                                                                          if (menuData['Menus'][index]['AddonMenus'][i]['id'] ==
                                                                              result) {
                                                                            setState(() {
                                                                              title = "${menuData['Menus'][index]['AddonMenus'][i]['title']} ${menuData['Menus'][index]['title']}";

                                                                              totalprice = menuData['Menus'][index]['AddonMenus'][i]['amount'] + menuData['Menus'][index]['AddonMenus'][i]['gstAmount'];
                                                                              totalgst = menuData['Menus'][index]['AddonMenus'][i]['gstAmount'];
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
                                                                            menuData['Menus'][index]['totalPrice'],
                                                                            menuData['Menus'][index]['gstAmount'],
                                                                            0,
                                                                            tempAddOns,
                                                                            menuData['Menus'][index]['title'],
                                                                            rating);
                                                                      }
                                                                    }
                                                                  }
                                                                } else {
                                                                  setState(() {
                                                                    snackBarData =
                                                                        "${menuData['Menus'][index]['title']} is already added to cart";
                                                                  });
                                                                  print(
                                                                      "match");
                                                                }
                                                              }
                                                              Navigator.pop(
                                                                  context);
                                                            } else {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                        content:
                                                                            Text(
                                                                                "Do you want to order food from different resturent"),
                                                                        actions: <
                                                                            Widget>[
                                                                          FlatButton(
                                                                            child:
                                                                                Text(
                                                                              "No",
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                          ),
                                                                          FlatButton(
                                                                            child:
                                                                                Text(
                                                                              "Yes",
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              callingLoader();
                                                                              removeCartForNewData();
                                                                              setState(() {});
                                                                              getList();
                                                                              Navigator.pop(context);
                                                                              Navigator.pop(context);
                                                                              if (menuData['Menus'][index]['AddonMenus'].isEmpty) {
                                                                                await addButtonFunction(tpye, index, menuData['Menus'][index]['totalPrice'], menuData['Menus'][index]['gstAmount'], 0, null, menuData['Menus'][index]['title'], rating);
                                                                              } else {
                                                                                tempAddOns = null;
                                                                                final result = await showModalBottomSheet(
                                                                                    isScrollControlled: true,
                                                                                    isDismissible: false,
                                                                                    enableDrag: false,
                                                                                    backgroundColor: Colors.transparent,
                                                                                    context: context,
                                                                                    builder: (context) => CustomizeMenu(
                                                                                          menuData: menuData['Menus'][index],
                                                                                        ));

                                                                                if (result != null) {
                                                                                  if (result > 0) {
                                                                                    int totalprice = 0;
                                                                                    int totalgst = 0;
                                                                                    String title;
                                                                                    int k = menuData['Menus'][index]['AddonMenus'].length;
                                                                                    for (int i = 0; i <= k - 1; i++) {
                                                                                      if (menuData['Menus'][index]['AddonMenus'][i]['id'] == result) {
                                                                                        setState(() {
                                                                                          title = "${menuData['Menus'][index]['AddonMenus'][i]['title']} ${menuData['Menus'][index]['title']}";

                                                                                          totalprice = menuData['Menus'][index]['AddonMenus'][i]['amount'] + menuData['Menus'][index]['AddonMenus'][i]['gstAmount'];
                                                                                          totalgst = menuData['Menus'][index]['AddonMenus'][i]['gstAmount'];
                                                                                        });
                                                                                      }
                                                                                    }
                                                                                    await addButtonFunction(tpye, index, totalprice, totalgst, result, tempAddOns, title, rating);
                                                                                  } else if (result == 0) {
                                                                                    await addButtonFunction(tpye, index, menuData['Menus'][index]['totalPrice'], menuData['Menus'][index]['gstAmount'], 0, null, menuData['Menus'][index]['title'], rating);
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
                                                                msg:
                                                                    "Not taking orders now");
                                                          }

                                                          // await addButtonFunction(tpye, index);
                                                        },
                                                        color: Colors.white,
                                                        minWidth:
                                                            size.width * 0.16,
                                                        height:
                                                            size.height * 0.033,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14)),
                                                        textColor: Colors.white,
                                                        child: checkdata.contains(
                                                                menuData['Menus']
                                                                            [
                                                                            index]
                                                                        ['id']
                                                                    .toString())
                                                            ? Text(
                                                                "Added",
                                                                style: TextStyle(
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.015,
                                                                    color: Colors
                                                                        .blueGrey),
                                                              )
                                                            : Text(
                                                                "Add",
                                                                style: TextStyle(
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.015,
                                                                    color: Colors
                                                                        .blueGrey),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: size.height *
                                                              0.01),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: size.width *
                                                                0.5,
                                                            child: Text(
                                                              capitalize(
                                                                  menuData['Menus']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'title']),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: size
                                                                          .height *
                                                                      0.019),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          12),
                                                              child: menuData['Menus']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'isNonVeg'] ==
                                                                      false
                                                                  ? menuData['Menus'][index]
                                                                              [
                                                                              'isEgg'] ==
                                                                          false
                                                                      ? Container(
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl:
                                                                                'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                                                            height:
                                                                                size.height * 0.016,
                                                                            errorWidget: (context, url, error) =>
                                                                                Icon(Icons.error),
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          child:
                                                                              Image.asset(
                                                                          "assets/images/eggeterian.png",
                                                                          height:
                                                                              size.height * 0.016,
                                                                        ))
                                                                  : CachedNetworkImage(
                                                                      imageUrl:
                                                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
                                                                      height: size
                                                                              .height *
                                                                          0.016,
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Icon(Icons
                                                                              .error),
                                                                    ))
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: size.height *
                                                            0.005),
                                                    // Container(
                                                    //   child: Row(
                                                    //     children: [
                                                    //       Container(
                                                    //         child: menuData['Menus']
                                                    //                             [index]
                                                    //                         ['Category']
                                                    //                     ['iconImage'] ==
                                                    //                 "null"
                                                    //             ? Image.asset(
                                                    //                 "assets/icons/discount_icon.jpg",
                                                    //                 height: size.height *
                                                    //                     0.02,
                                                    //               )
                                                    //             : SizedBox(),
                                                    //       ),
                                                    //       SizedBox(
                                                    //         width: size.width * 0.006,
                                                    //       ),
                                                    //       Text(
                                                    //         menuData['Menus'][index]
                                                    //             ['Category']['name'],
                                                    //         style: TextStyle(
                                                    //             fontSize:
                                                    //                 size.height * 0.014,
                                                    //             fontWeight:
                                                    //                 FontWeight.bold),
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.002,
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            child: Text("⭐"),
                                                          ),
                                                          Text(
                                                            "$rating",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.014,
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                right:
                                                                    size.width *
                                                                        0.1),
                                                            child: Text(
                                                              "₹${menuData['Menus'][index]['totalPrice']}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.height *
                                                                          0.018,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.003,
                                                    ),
                                                    Container(
                                                      child: Container(
                                                          child: menuData['Menus']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'MenuOffers']
                                                                      .length !=
                                                                  0
                                                              ? Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      "assets/icons/discount_icon.jpg",
                                                                      height: size
                                                                              .height *
                                                                          0.02,
                                                                    ),
                                                                    SizedBox(
                                                                      width: size
                                                                              .width *
                                                                          0.006,
                                                                    ),
                                                                    Container(
                                                                      child: menuData['Menus'][index]['MenuOffers'].length >=
                                                                              2
                                                                          ? Row(
                                                                              children: [
                                                                                menuData['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon'] == null
                                                                                    ? SizedBox()
                                                                                    : Text(
                                                                                        " ${menuData['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon']}, ",
                                                                                        style: TextStyle(fontSize: size.height * 0.015, color: kTextColor),
                                                                                      ),
                                                                                menuData['Menus'][index]['MenuOffers'][1]['OffersAndCoupon']['coupon'] == null
                                                                                    ? SizedBox()
                                                                                    : Text(
                                                                                        " ${menuData['Menus'][index]['MenuOffers'][1]['OffersAndCoupon']['coupon']}",
                                                                                        style: TextStyle(fontSize: size.height * 0.015, color: kTextColor),
                                                                                      ),
                                                                              ],
                                                                            )
                                                                          : menuData['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon'] == null
                                                                              ? SizedBox()
                                                                              : Text(
                                                                                  " ${menuData['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon']}",
                                                                                  style: TextStyle(fontSize: size.height * 0.015, color: kTextColor),
                                                                                ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : SizedBox()),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          menuData['Menus'][index]['AddonMenus']
                                                  .isEmpty
                                              ? SizedBox()
                                              : RotatedBox(
                                                  quarterTurns: -1,
                                                  child: Text(
                                                    "Customize",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54,
                                                        fontSize: size.height *
                                                            0.015),
                                                  )),
                                        ])),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            },
                          ),

                          // ListView.builder(
                          //   padding: EdgeInsets.symmetric(horizontal: 10),
                          //   shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          //   itemCount: tandorilist.length,
                          //   itemBuilder: (context, index) {
                          //     return InkWell(
                          //       onTap: () {
                          //         var menuD;
                          //         setState(() {
                          //           menuD = menuData[index];
                          //         });
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) => FoodSlider(
                          //                       menuData: menuD,
                          //                     )));
                          //       },
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(bottom: 14),
                          //         child: Container(
                          //             decoration: BoxDecoration(
                          //                 borderRadius: BorderRadius.circular(10),
                          //                 color: Colors.white,
                          //                 boxShadow: [
                          //                   BoxShadow(
                          //                       blurRadius: 2,
                          //                       color: Colors.blue[50],
                          //                       offset: Offset(1, 3),
                          //                       spreadRadius: 2)
                          //                 ]),
                          //             margin: EdgeInsets.only(
                          //               left: size.width * 0.02,
                          //               right: size.width * 0.02,
                          //             ),
                          //             height: size.height * 0.136,
                          //             child: Row(children: [
                          //               Expanded(
                          //                   flex: 0,
                          //                   child: Container(
                          //                     alignment: Alignment.topCenter,
                          //                     height: size.height * 0.22,
                          //                     child: Stack(
                          //                       children: [
                          //                         Container(
                          //                           margin: EdgeInsets.only(
                          //                               left: size.width * 0.01,
                          //                               right: size.width * 0.01,
                          //                               top: size.height * 0.005),
                          //                           child: ClipRRect(
                          //                             borderRadius: BorderRadius.circular(10),
                          //                             child: CachedNetworkImage(
                          //                               imageUrl: tandorilist[index].foodImage,
                          //                               height: size.height * 0.1,
                          //                               width: size.width * 0.26,
                          //                               fit: BoxFit.fill,
                          //                             ),
                          //                           ),
                          //                         ),
                          //                         // For Add Button
                          //                         Align(
                          //                             widthFactor: size.width * 0.00368,
                          //                             alignment: Alignment.bottomCenter,
                          //                             heightFactor: size.height * 0.003,
                          //                             child: Container(
                          //                               child: MaterialButton(
                          //                                 onPressed: () {
                          //                                   setState(() {
                          //                                     _index1 = tandorilist[index].index0;
                          //                                   });

                          //                                   getItemandNavigateToCart(_index1);
                          //                                 },
                          //                                 color: Colors.white,
                          //                                 minWidth: size.width * 0.16,
                          //                                 height: size.height * 0.033,
                          //                                 shape: RoundedRectangleBorder(
                          //                                     borderRadius:
                          //                                         BorderRadius.circular(14)),
                          //                                 textColor: Colors.white,
                          //                                 child: Row(
                          //                                   children: [
                          //                                     Icon(
                          //                                       Icons.add,
                          //                                       size: size.height * 0.02,
                          //                                       color: Colors.blueGrey,
                          //                                     ),
                          //                                     Text(
                          //                                       "ADD",
                          //                                       style: TextStyle(
                          //                                           fontSize: size.height * 0.013,
                          //                                           color: Colors.blueGrey),
                          //                                     ),
                          //                                   ],
                          //                                 ),
                          //                               ),
                          //                             ))
                          //                       ],
                          //                     ),
                          //                   )),
                          //               Expanded(
                          //                   flex: 6,
                          //                   child: Container(
                          //                     height: size.height * 0.2,
                          //                     child: Column(
                          //                       crossAxisAlignment: CrossAxisAlignment.start,
                          //                       mainAxisSize: MainAxisSize.max,
                          //                       children: [
                          //                         Container(
                          //                           margin: EdgeInsets.only(
                          //                             top: size.height * 0.008,
                          //                           ),
                          //                           child: Row(
                          //                             children: [
                          //                               Text(
                          //                                 tandorilist[index].title,
                          //                                 style: TextStyle(
                          //                                     fontWeight: FontWeight.bold,
                          //                                     color: Colors.black,
                          //                                     fontSize: size.height * 0.018),
                          //                               ),
                          //                               Spacer(),
                          //                               Padding(
                          //                                 padding:
                          //                                     const EdgeInsets.only(right: 12),
                          //                                 child: CachedNetworkImage(
                          //                                   imageUrl:
                          //                                       tandorilist[index].vegsymbol,
                          //                                   height: size.height * 0.02,
                          //                                 ),
                          //                               )
                          //                             ],
                          //                           ),
                          //                         ),
                          //                         SizedBox(height: 4),
                          //                         Text(
                          //                           tandorilist[index].subtitle,
                          //                           style: TextStyle(
                          //                               fontSize: size.height * 0.016,
                          //                               fontWeight: FontWeight.bold),
                          //                         ),
                          //                         SizedBox(
                          //                           height: size.height * 0.006,
                          //                         ),
                          //                         Container(
                          //                           child: Row(
                          //                             children: [
                          //                               Container(
                          //                                 child: tandorilist[index].starRating,
                          //                               ),
                          //                               Text(
                          //                                 "3.0",
                          //                                 style: TextStyle(
                          //                                     fontSize: size.height * 0.016,
                          //                                     color: Colors.red,
                          //                                     fontWeight: FontWeight.bold),
                          //                               ),
                          //                               Spacer(),
                          //                               Container(
                          //                                 margin: EdgeInsets.only(
                          //                                     right: size.width * 0.1),
                          //                                 child: Text(
                          //                                   "₹${tandorilist[index].foodPrice}",
                          //                                   style: TextStyle(
                          //                                       fontSize: size.height * 0.016,
                          //                                       color: Colors.black,
                          //                                       fontWeight: FontWeight.bold),
                          //                                 ),
                          //                               ),
                          //                             ],
                          //                           ),
                          //                         ),
                          //                         SizedBox(
                          //                           height: 5,
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ))
                          //             ])),
                          //       ),
                          //     );
                          //   },
                          // ),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                            height: size.height * 1,
                            color: Colors.white,
                            child: Container(
                              height: size.height * 0.01,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: size.width * 1,
                              color: Colors.lightBlueAccent[200],
                              child: Row(
                                children: [
                                  Container(
                                    width: size.width * 0.65,
                                    child: Text(
                                      snackBarData,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Spacer(),
                                  FlatButton(
                                    textColor: Colors.redAccent,
                                    child: Text("View Cart"),
                                    onPressed: () async {
                                      final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CartScreen()));
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
      ),
    );
  }

  addButtonFunction(
      tpye, index, price, gst, variantId, addOnData, title, rating) async {
    if (status == true) {
      final SharedPreferences cart = await SharedPreferences.getInstance();

      int totalprice = cart.getInt('TotalPrice');
      int gsttotal = cart.getInt('TotalGst');
      int totalcount = cart.getInt('TotalCount');
      int vendorId = cart.getInt('VendorId');
      if (menuData['Menus'][index]['isNonVeg'] == false) {
        if (menuData['Menus'][index]['isEgg'] == false) {
          tpye = 1;
        } else {
          tpye = 2;
        }
      } else {
        tpye = 3;
      }

      await services
          .data(menuData['Menus'][index]['id'])
          .then((value) => fun(value));

      if (vendorId == 0 || vendorId == menuData['Menus'][index]['vendorId']) {
        callingLoader();
        if (data1.isEmpty) {
          setState(() {
            itemAddToCart(
                index, tpye, price, gst, variantId, addOnData, title, rating);
            checkdata.add(menuData['Menus'][index]['id'].toString());
            totalcount = totalcount + 1;
            gsttotal = gsttotal + gst;
            totalprice = totalprice + price;
            vendorId = menuData['Menus'][index]['vendorId'];
            cart.setInt('VendorId', vendorId);
            cart.setInt('TotalPrice', totalprice);
            cart.setInt('TotalGst', gsttotal);
            cart.setInt('TotalCount', totalcount);

            cart.setStringList('addedtocart', checkdata);
            snackBarData =
                "${menuData['Menus'][index]['title']} is added to cart";
          });

          // Scaffold.of(context)
          //     .showSnackBar(snackBar);
        } else {
          if (data1[0]['itemName'] != menuData['Menus'][index]['title']) {
            setState(() {
              itemAddToCart(
                  index, tpye, price, gst, variantId, addOnData, title, rating);
              checkdata.add(menuData['Menus'][index]['id'].toString());
              totalcount = totalcount + 1;
              gsttotal = gsttotal + gst;
              totalprice = totalprice + price;
              vendorId = menuData['Menus'][index]['vendorId'];
              cart.setInt('VendorId', vendorId);
              cart.setInt('TotalPrice', totalprice);
              cart.setInt('TotalGst', gsttotal);
              cart.setInt('TotalCount', totalcount);

              cart.setStringList('addedtocart', checkdata);
              snackBarData =
                  "${menuData['Menus'][index]['title']} is added to cart";
            });
          } else {
            setState(() {
              snackBarData =
                  "${menuData['Menus'][index]['title']} is already added to cart";
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
                    FlatButton(
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
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
                            variantId, addOnData, title, rating);
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
          menuData['Menus'][index]['vendorId'],
          menuData['Menus'][index]['id'],
          menuData['Menus'][index]['image1'],
          name,
          "Add".toString(),
          tpye,
          0,
          menuData['name'],
          gst,
          variantId,
          addons,
          rating.toString());
    });
  }

  fun(value) {
    setState(() {
      data1 = value;
    });
  }
}
