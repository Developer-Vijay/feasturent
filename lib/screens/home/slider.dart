import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/ShimmerEffects/menu_effect.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/customize_menu.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:feasturent_costomer_app/components/WishList/WishListDataBase/wishlist_service.dart';
import 'package:http/http.dart ' as http;
import 'dart:convert';

class FoodSlider extends StatefulWidget {
  final dishID;

  final rating;
  final ratinglength;
  final menuData;
  final menuStatus;
  final restaurentName;
  const FoodSlider(
      {Key key,
      this.dishID,
      this.menuData,
      this.menuStatus,
      this.restaurentName,
      this.rating,
      this.ratinglength})
      : super(key: key);
  @override
  _FoodSliderState createState() => _FoodSliderState();
}

class _FoodSliderState extends State<FoodSlider> {
  bool isSelected = false;

  var ratingfetched;
  int selectedRadioTile;

  var pad = 34;

  void initState() {
    super.initState();
    if (widget.dishID != null) {
      fetchData(widget.dishID);
    } else {
      setState(() {
        getList();
        ratingfetched = widget.rating;
        datamenu = widget.menuData;
        selectedRadioTile = 0;
        print("this is slider page data");
        print(datamenu);
        checkStatus();
        dataChecker = true;
      });
    }
  }

  fetchData(id) async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  get menu APi hit 111111111111111^^^^^^^^^^^^*****************!!!!!!!!!!@@@@@@@^^^^^^^^^^112222222222222233333333333388888888888 ");

    var result = await http.get(
      Uri.parse(
        APP_ROUTES +
            'getMenues' +
            '?key=BYID&id=$id' +
            '&latitude=' +
            latitude.toString() +
            '&longitude=' +
            longitude.toString(),
      ),
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
      convertFunction(restaurantData[0]);
    }
  }

  convertFunction(menuD) {
    List<ChangeJson> dataList = [];
    List addonList = menuD['variant'];
    addonList.addAll(menuD['addon']);
    print("this is list");
    List<AddonMenus> createListAddon = [];

    if (addonList.isNotEmpty) {
      int k = addonList.length;
      for (int i = 0; i <= k - 1; i++) {
        createListAddon.add(AddonMenus(
            addonList[i]['id'],
            menuD['menuId'],
            addonList[i]['type'],
            addonList[i]['title'],
            addonList[i]['amount'],
            addonList[i]['gst'],
            addonList[i]['gstAmount'].toInt()));
      }
    }
    print("this is without encode list");
    print(createListAddon);

    print("this is  encode list");
    var dataencoded = jsonEncode(createListAddon);
    print(dataencoded);
    print("this is  dencode list");
    var datadecode = jsonDecode(dataencoded);
    print(datadecode);

    dataList.add(ChangeJson(
        menuD['menuId'],
        menuD['vendorId'],
        menuD['title'],
        menuD['description'],
        menuD['itemPrice'],
        menuD['gst'],
        menuD['gstAmount'],
        menuD['totalPrice'],
        menuD['deliveryTime'],
        menuD['isNonVeg'],
        menuD['isEgg'],
        menuD['isCombo'],
        menuD['menuImage1'],
        menuD['menuImage2'],
        menuD['menuImage3'],
        datadecode, []));
    print("this is data list open #####");
    var dataNew = jsonEncode(dataList[0]);
    var finaldata = jsonDecode(dataNew);
    print(finaldata);
    print("this is data list close #####");
    if (mounted) {
      setState(() {
        getList();
        ratingfetched = widget.rating;
        datamenu = finaldata;
        selectedRadioTile = 0;
        print("this is slider page data");
        print(datamenu);
        checkStatus();
        dataChecker = true;
      });
    }
  }

  bool dataChecker = false;
  bool dataValidator = false;
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

  checkStatus() async {
    await wishListServices.data(datamenu['id']).then((value) => func(value));

    if (dataCheck1.isEmpty) {
      setState(() {
        isSelected = false;
      });
    } else {
      print(dataCheck1[0]);
      if (dataCheck1[0]['itemName'] != datamenu['title']) {
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

  String snackBarData = "Item in cart";
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
  final services = UserServices();
  final wishListServices = WishListService();

  var datamenu;
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
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
          child: dataChecker == false
              ? Scaffold(
                  body: Center(
                    child: MenuEffect(),
                  ),
                )
              : dataValidator == true
                  ? Scaffold(
                      body: Center(
                      child: Container(
                        child: Image.asset(
                          "assets/images/serverError.png",
                          height: 200,
                          width: 300,
                        ),
                      ),
                    ))
                  : Scaffold(
                      body: Column(
                        children: [
                          Expanded(
                            flex: 25,
                            child: Container(
                                height: size.height * 1,
                                child: Stack(children: [
                                  Container(
                                    height: size.height * 0.45,
                                    width: size.width * 1,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: size.width * 1,
                                          child: datamenu['image1'] != null
                                              ? datamenu['image2'] != null
                                                  ? datamenu['image3'] != null
                                                      ? Swiper(
                                                          autoplay: true,
                                                          autoplayDelay: 2000,
                                                          itemCount: 3,
                                                          itemBuilder:
                                                              (context, index) {
                                                            int tempindex =
                                                                index + 1;
                                                            print(
                                                                'temp image$tempindex');
                                                            return Container(
                                                              child: datamenu[
                                                                          'image$tempindex'] !=
                                                                      null
                                                                  ? CachedNetworkImage(
                                                                      imageUrl:
                                                                          S3_BASE_PATH +
                                                                              datamenu['image$tempindex'],
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      placeholder: (context,
                                                                              url) =>
                                                                          Image
                                                                              .asset(
                                                                        "assets/images/feasturenttemp.jpeg",
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Icon(Icons
                                                                              .error),
                                                                    )
                                                                  : Image.asset(
                                                                      "assets/images/feasturenttemp.jpeg",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                            );
                                                          })
                                                      : Swiper(
                                                          autoplay: true,
                                                          autoplayDelay: 2000,
                                                          itemCount: 2,
                                                          itemBuilder:
                                                              (context, index) {
                                                            int tempindex =
                                                                index + 1;
                                                            return Container(
                                                              child: datamenu[
                                                                          'image$tempindex'] !=
                                                                      null
                                                                  ? CachedNetworkImage(
                                                                      imageUrl:
                                                                          S3_BASE_PATH +
                                                                              datamenu['image$tempindex'],
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      placeholder: (context,
                                                                              url) =>
                                                                          Image
                                                                              .asset(
                                                                        "assets/images/feasturenttemp.jpeg",
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Icon(Icons
                                                                              .error),
                                                                    )
                                                                  : Image.asset(
                                                                      "assets/images/feasturenttemp.jpeg",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                            );
                                                          })
                                                  : CachedNetworkImage(
                                                      imageUrl: S3_BASE_PATH +
                                                          datamenu['image1'],
                                                      fit: BoxFit.fill,
                                                      placeholder:
                                                          (context, url) =>
                                                              Image.asset(
                                                        "assets/images/feasturenttemp.jpeg",
                                                        fit: BoxFit.cover,
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    )
                                              : Image.asset(
                                                  "assets/images/feasturenttemp.jpeg",
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: IconButton(
                                            icon: Icon(Icons.arrow_back),
                                            color: Colors.white,
                                            iconSize: 25,
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                        ),
                                        // Align(
                                        //     alignment: Alignment.topRight,
                                        //     child: Padding(
                                        //       padding:
                                        //           const EdgeInsets.all(8.0),
                                        //       child: CircleAvatar(
                                        //         backgroundColor:
                                        //             Colors.red[200],
                                        //         child: IconButton(
                                        //           icon: isSelected
                                        //               ? Icon(Icons
                                        //                   .bookmark_outlined)
                                        //               : Icon(Icons
                                        //                   .bookmark_border_outlined),
                                        //           color: (isSelected)
                                        //               ? Colors.blue
                                        //               : Colors.white,
                                        //           onPressed: () async {
                                        //             var type;
                                        //             if (datamenu['isNonVeg'] ==
                                        //                 false) {
                                        //               if (datamenu['isEgg'] ==
                                        //                   false) {
                                        //                 type = 1;
                                        //               } else {
                                        //                 type = 2;
                                        //               }
                                        //             } else {
                                        //               type = 3;
                                        //             }

                                        //             if (isSelected == false) {
                                        //               await wishListServices
                                        //                   .data(datamenu['id'])
                                        //                   .then((value) =>
                                        //                       func(value));

                                        //               if (dataCheck1.isEmpty) {
                                        //                 setState(() {
                                        //                   isSelected = true;
                                        //                 });
                                        //                 getItemandNavigateToFavourites(
                                        //                     type);
                                        //               } else {
                                        //                 print(dataCheck1[0]);
                                        //                 if (dataCheck1[0]
                                        //                         ['itemName'] !=
                                        //                     datamenu['title']) {
                                        //                   setState(() {
                                        //                     isSelected = true;
                                        //                     getItemandNavigateToFavourites(
                                        //                         type);
                                        //                     Fluttertoast.showToast(
                                        //                         msg:
                                        //                             "Item Added to favourites");
                                        //                   });
                                        //                 }
                                        //               }
                                        //             }
                                        //           },
                                        //         ),
                                        //       ),
                                        //     ))
                                      ],
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: size.height * 00.6,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40),
                                                topRight: Radius.circular(40))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 34, top: 20),
                                                  child: Icon(
                                                    Icons.restaurant,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  ),
                                                ),
                                                Spacer(),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 24, top: 24),
                                                    child: datamenu[
                                                                'isNonVeg'] ==
                                                            false
                                                        ? datamenu['isEgg'] ==
                                                                false
                                                            ? Container(
                                                                child:
                                                                    CachedNetworkImage(
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                  imageUrl:
                                                                      'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                                                  height:
                                                                      size.height *
                                                                          0.016,
                                                                ),
                                                              )
                                                            : Container(
                                                                child:
                                                                    Image.asset(
                                                                "assets/images/eggeterian.png",
                                                                height:
                                                                    size.height *
                                                                        0.016,
                                                              ))
                                                        : CachedNetworkImage(
                                                            imageUrl:
                                                                'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
                                                            height:
                                                                size.height *
                                                                    0.016,
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                          )),
                                              ],
                                            )),

                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30, right: 30),
                                              child: Row(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Container(
                                                    child: Container(
                                                      width: size.width * 0.75,
                                                      child: Text(
                                                        capitalize(
                                                            datamenu['title']),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                            Row(children: [
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       left: 30, top: 2),
                                              //   child: Text("Resturent Name: ",
                                              //       overflow:
                                              //           TextOverflow.ellipsis,
                                              //       style: TextStyle(
                                              //         color: Colors.black,
                                              //         fontWeight:
                                              //             FontWeight.w400,
                                              //       )),
                                              // ),
                                              // Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30),
                                                child: Container(
                                                  width: size.width * 0.5,
                                                  child: Text(
                                                    widget.restaurentName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              )
                                            ]),
                                            // Price
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30, top: 2),
                                                  child: SmoothStarRating(
                                                      allowHalfRating: false,
                                                      onRated: (v) {
                                                        Text(widget
                                                            .ratinglength);
                                                      },
                                                      starCount: 5,
                                                      rating: ratingfetched,
                                                      size: 23.0,
                                                      isReadOnly: true,
                                                      defaultIconData: Icons
                                                          .star_border_outlined,
                                                      filledIconData:
                                                          Icons.star,
                                                      halfFilledIconData:
                                                          Icons.star_border,
                                                      color: Colors.amber,
                                                      borderColor: Colors.amber,
                                                      spacing: 0.0),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: widget.ratinglength ==
                                                          1
                                                      ? Text(
                                                          "${widget.ratinglength} View")
                                                      : Text(
                                                          "${widget.ratinglength} Views"),
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 30.0),
                                                  child: Text(
                                                    "₹ ${datamenu['totalPrice']}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 25, left: 25),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Deliver in : ",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${datamenu['deliveryTime']}mins",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 25,
                                                    right: 25,
                                                    left: 25),
                                                child: Container(
                                                  height: size.height * 0.27,
                                                  child: Text(
                                                    " ${datamenu['description']}",
                                                    maxLines: 10,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        wordSpacing: 2,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Container(
                                              alignment: Alignment.bottomCenter,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              margin: EdgeInsets.only(
                                                  left: size.width * 0.11,
                                                  right: size.width * 0.11),
                                              child: MaterialButton(
                                                onPressed: () async {
                                                  if (widget.menuStatus ==
                                                      true) {
                                                    // ignore: unused_local_variable
                                                    int tpye = 0;

                                                    final SharedPreferences
                                                        cart =
                                                        await SharedPreferences
                                                            .getInstance();

                                                    int vendorId =
                                                        cart.getInt('VendorId');
                                                    if (datamenu['isNonVeg'] ==
                                                        false) {
                                                      if (datamenu['isEgg'] ==
                                                          false) {
                                                        tpye = 1;
                                                      } else {
                                                        tpye = 2;
                                                      }
                                                    } else {
                                                      tpye = 3;
                                                    }

                                                    await services
                                                        .data(datamenu['id'])
                                                        .then((value) =>
                                                            fun(value));
                                                    if (vendorId == 0 ||
                                                        vendorId ==
                                                            datamenu[
                                                                'vendorId']) {
                                                      callingLoader();
                                                      if (data1.isEmpty) {
                                                        if (datamenu[
                                                                'AddonMenus']
                                                            .isEmpty) {
                                                          await addButtonFunction(
                                                              datamenu[
                                                                  'totalPrice'],
                                                              datamenu[
                                                                      'gstAmount']
                                                                  .toInt(),
                                                              0,
                                                              null,
                                                              datamenu['title'],
                                                              ratingfetched);
                                                        } else {
                                                          tempAddOns = null;
                                                          print(
                                                              "this is addonlist length ${datamenu['AddonMenus'].length}");
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
                                                                  builder:
                                                                      (context) =>
                                                                          CustomizeMenu(
                                                                            menuData:
                                                                                datamenu,
                                                                          ));

                                                          if (result != null) {
                                                            if (result > 0) {
                                                              int totalprice =
                                                                  0;
                                                              int totalgst = 0;
                                                              String title;
                                                              int k = datamenu[
                                                                      'AddonMenus']
                                                                  .length;
                                                              for (int i = 0;
                                                                  i <= k - 1;
                                                                  i++) {
                                                                if (datamenu['AddonMenus']
                                                                            [i][
                                                                        'id'] ==
                                                                    result) {
                                                                  setState(() {
                                                                    title =
                                                                        "${datamenu['AddonMenus'][i]['title']} ${datamenu['title']}";
                                                                    totalprice = datamenu['AddonMenus'][i]
                                                                            [
                                                                            'amount'] +
                                                                        datamenu['AddonMenus'][i]['gstAmount']
                                                                            .toInt();
                                                                    totalgst = datamenu['AddonMenus'][i]
                                                                            [
                                                                            'gstAmount']
                                                                        .toInt();
                                                                  });
                                                                }
                                                              }
                                                              await addButtonFunction(
                                                                  totalprice,
                                                                  totalgst,
                                                                  result,
                                                                  tempAddOns,
                                                                  title,
                                                                  ratingfetched);
                                                            } else if (result ==
                                                                0) {
                                                              await addButtonFunction(
                                                                  datamenu[
                                                                      'totalPrice'],
                                                                  datamenu[
                                                                          'gstAmount']
                                                                      .toInt(),
                                                                  0,
                                                                  tempAddOns,
                                                                  datamenu[
                                                                      'title'],
                                                                  ratingfetched);
                                                            }
                                                          }
                                                        }
                                                      } else {
                                                        if (data1[0]
                                                                ['itemName'] !=
                                                            datamenu['title']) {
                                                          if (datamenu[
                                                                  'AddonMenus']
                                                              .isEmpty) {
                                                            await addButtonFunction(
                                                                datamenu[
                                                                    'totalPrice'],
                                                                datamenu[
                                                                        'gstAmount']
                                                                    .toInt(),
                                                                0,
                                                                null,
                                                                datamenu[
                                                                    'title'],
                                                                ratingfetched);
                                                          } else {
                                                            tempAddOns = null;
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
                                                                    builder:
                                                                        (context) =>
                                                                            CustomizeMenu(
                                                                              menuData: datamenu,
                                                                            ));

                                                            if (result !=
                                                                null) {
                                                              if (result > 0) {
                                                                int totalprice =
                                                                    0;
                                                                int totalgst =
                                                                    0;
                                                                String title;
                                                                int k = datamenu[
                                                                        'AddonMenus']
                                                                    .length;
                                                                for (int i = 0;
                                                                    i <= k - 1;
                                                                    i++) {
                                                                  if (datamenu['AddonMenus']
                                                                              [
                                                                              i]
                                                                          [
                                                                          'id'] ==
                                                                      result) {
                                                                    setState(
                                                                        () {
                                                                      title =
                                                                          "${datamenu['AddonMenus'][i]['title']} ${datamenu['title']}";

                                                                      totalprice = datamenu['AddonMenus'][i]
                                                                              [
                                                                              'amount'] +
                                                                          datamenu['AddonMenus'][i]['gstAmount']
                                                                              .toInt();
                                                                      totalgst =
                                                                          datamenu['AddonMenus'][i]['gstAmount']
                                                                              .toInt();
                                                                    });
                                                                  }
                                                                }
                                                                await addButtonFunction(
                                                                    totalprice,
                                                                    totalgst,
                                                                    result,
                                                                    tempAddOns,
                                                                    title,
                                                                    ratingfetched);
                                                              } else if (result ==
                                                                  0) {
                                                                await addButtonFunction(
                                                                    datamenu[
                                                                        'totalPrice'],
                                                                    datamenu[
                                                                            'gstAmount']
                                                                        .toInt(),
                                                                    0,
                                                                    tempAddOns,
                                                                    datamenu[
                                                                        'title'],
                                                                    ratingfetched);
                                                              }
                                                            }
                                                          }
                                                        } else {
                                                          setState(() {
                                                            snackBarData =
                                                                "${datamenu['title']} is already added to cart";
                                                          });
                                                          print("match");
                                                        }
                                                      }
                                                      Navigator.pop(context);
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                                content: Text(
                                                                    "Do you want to order food from different resturent"),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                    child: Text(
                                                                      "No",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                  TextButton(
                                                                    child: Text(
                                                                      "Yes",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      callingLoader();
                                                                      removeCartForNewData();
                                                                      setState(
                                                                          () {});
                                                                      getList();
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator.pop(
                                                                          context);
                                                                      if (datamenu[
                                                                              'AddonMenus']
                                                                          .isEmpty) {
                                                                        await addButtonFunction(
                                                                            datamenu['totalPrice'],
                                                                            datamenu['gstAmount'],
                                                                            0,
                                                                            null,
                                                                            datamenu['title'],
                                                                            ratingfetched);
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
                                                                                  menuData: datamenu,
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
                                                                                datamenu['AddonMenus'].length;
                                                                            for (int i = 0;
                                                                                i <= k - 1;
                                                                                i++) {
                                                                              if (datamenu['AddonMenus'][i]['id'] == result) {
                                                                                setState(() {
                                                                                  title = "${datamenu['AddonMenus'][i]['title']} ${datamenu['title']}";

                                                                                  totalprice = datamenu['AddonMenus'][i]['amount'] + datamenu['AddonMenus'][i]['gstAmount'];
                                                                                  totalgst = datamenu['AddonMenus'][i]['gstAmount'];
                                                                                });
                                                                              }
                                                                            }
                                                                            await addButtonFunction(
                                                                                totalprice,
                                                                                totalgst,
                                                                                result,
                                                                                tempAddOns,
                                                                                title,
                                                                                ratingfetched);
                                                                          } else if (result ==
                                                                              0) {
                                                                            await addButtonFunction(
                                                                                datamenu['totalPrice'],
                                                                                datamenu['gstAmount'],
                                                                                0,
                                                                                tempAddOns,
                                                                                datamenu['title'],
                                                                                ratingfetched);
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
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                height: size.height * 0.07,
                                                textColor: Colors.white,
                                                color: Colors.blue,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.shopping_bag,
                                                    ),
                                                    checkdata.contains(
                                                            datamenu['id']
                                                                .toString())
                                                        ? Text(
                                                            "Added",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          )
                                                        : Text(
                                                            "Add To Cart",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                ])),
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
                                        border: Border.all(
                                            color: Colors.blueAccent),
                                        // color: Colors.grey[200],
                                      ),
                                      height: size.height * 0.01,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: size.width * 1,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: size.width * 0.4,
                                            child: Text(
                                              "$baritemCount Items | ₹ $pricebar",
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          Spacer(),
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
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
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            onPressed: () async {
                                              final result =
                                                  await Navigator.push(
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
                          // Expanded(
                          //     flex: 2,
                          //     child: Container(
                          //       height: size.height * 1,
                          //       color: Colors.white,
                          //       child: Container(
                          //         height: size.height * 0.01,
                          //         padding: EdgeInsets.symmetric(horizontal: 10),
                          //         width: size.width * 1,
                          //         color: Colors.lightBlueAccent[200],
                          //         child: Row(
                          //           children: [
                          //             Container(
                          //               width: size.width * 0.65,
                          //               child: Text(
                          //                 snackBarData,
                          //                 overflow: TextOverflow.ellipsis,
                          //                 style: TextStyle(color: Colors.white),
                          //               ),
                          //             ),
                          //             Spacer(),
                          //             FlatButton(
                          //               textColor: Colors.redAccent,
                          //               child: Text("View Cart"),
                          //               onPressed: () async {
                          //                 final result = await Navigator.push(
                          //                     context,
                          //                     MaterialPageRoute(
                          //                         builder: (context) =>
                          //                             CartScreen()));
                          //                 if (result) {
                          //                   setState(() {});
                          //                   getList();
                          //                 }
                          //               },
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ))
                        ],
                      ),
                    )),
    );
  }

  addButtonFunction(price, gst, variantId, addOnData, title, rating) async {
    if (widget.menuStatus == true) {
      int tpye = 0;

      final SharedPreferences cart = await SharedPreferences.getInstance();
      int totalprice = cart.getInt('TotalPrice');
      int gsttotal = cart.getInt('TotalGst');
      int totalcount = cart.getInt('TotalCount');
      int vendorId = cart.getInt('VendorId');
      if (datamenu['isNonVeg'] == false) {
        if (datamenu['isEgg'] == false) {
          tpye = 1;
        } else {
          tpye = 2;
        }
      } else {
        tpye = 3;
      }

      await services.data(datamenu['id']).then((value) => fun(value));
      if (vendorId == 0 || vendorId == datamenu['vendorId']) {
        callingLoader();
        if (data1.isEmpty) {
          setState(() {
            itemAddToCart(
                tpye, price, gst, variantId, addOnData, title, rating);
            checkdata.add(datamenu['id'].toString());

            totalcount = totalcount + 1;
            gsttotal = gsttotal + gst;
            totalprice = totalprice + price;

            vendorId = datamenu['vendorId'];
            cart.setInt('VendorId', vendorId);
            cart.setInt('TotalPrice', totalprice);
            cart.setInt('TotalGst', gsttotal);
            cart.setInt('TotalCount', totalcount);

            cart.setStringList('addedtocart', checkdata);
            snackBarData = "${datamenu['title']} is added to cart";
          });
        } else {
          if (data1[0]['itemName'] != datamenu['title']) {
            setState(() {
              itemAddToCart(
                  tpye, price, gst, variantId, addOnData, title, rating);
              checkdata.add(datamenu['id'].toString());

              totalcount = totalcount + 1;
              gsttotal = gsttotal + gst;
              totalprice = totalprice + price;

              vendorId = datamenu['vendorId'];
              cart.setInt('VendorId', vendorId);
              cart.setInt('TotalPrice', totalprice);
              cart.setInt('TotalGst', gsttotal);
              cart.setInt('TotalCount', totalcount);

              cart.setStringList('addedtocart', checkdata);
              snackBarData = "${datamenu['title']} is added to cart";
            });

            setState(() {
              snackBarData = "${datamenu['title']} is added to cart";
            });
          } else {
            setState(() {
              snackBarData = "${datamenu['title']} is already added to cart";
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
                        await addButtonFunction(
                            price, gst, variantId, addOnData, title, rating);
                      },
                    ),
                  ]);
            });
      }
    } else {
      Fluttertoast.showToast(msg: "Not taking orders now");
    }
  }

  // getItemandNavigateToFavourites(type) async {
  //   setState(() {
  //     // wishListServices.saveUser(
  //     //     datamenu['totalPrice'],
  //     //     1,
  //     //     datamenu['vendorId'],
  //     //     datamenu['id'],
  //     //     datamenu['image1'],
  //     //     datamenu['title'],
  //     //     "Add".toString(),
  //     //     type,
  //     //     0,
  //     //     widget.restaurentName,
  //     //     datamenu['gstAmount'].toInt(),
  //     //     ratingfetched.toString());
  //   });
  //   print("data added");
  // }

  itemAddToCart(tpye, price, gst, variantId, addons, name, rating) async {
    setState(() {
      services.saveUser(
          price,
          1,
          datamenu['vendorId'],
          datamenu['id'],
          datamenu['image1'],
          name,
          "Add".toString(),
          tpye,
          0,
          widget.restaurentName,
          gst,
          variantId,
          addons,
          rating.toString());
    });
    getList();
  }

  func(value) {
    if (mounted) {
      setState(() {
        dataCheck1 = value;
      });
    }
  }

  fun(value) {
    if (mounted) {
      setState(() {
        data1 = value;
      });
    }
  }
}
