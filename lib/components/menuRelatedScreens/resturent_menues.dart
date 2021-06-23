import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:feasturent_costomer_app/ShimmerEffects/offer_restaurant_effect.dart';
import 'package:feasturent_costomer_app/components/Bottomsheet/offerBottomsheet.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/ResturentInfo/resturentDetail.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/resturentCateMenues.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart ' as http;
import 'dart:convert';
import 'foodlistclass.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/customize_menu.dart';

var infodata;

class OfferListPage extends StatefulWidget {
  final ratingVendor;
  final restID;
  final restaurantDa;
  const OfferListPage(
      {Key key, this.restaurantDa, this.restID, this.ratingVendor})
      : super(key: key);

  @override
  _OfferListPageState createState() => _OfferListPageState();
}

class _OfferListPageState extends State<OfferListPage> {
  bool showVeg = false;
  bool showNonveg = false;
  bool showall = false;
  bool showegg = false;
  @override
  void initState() {
    super.initState();
    showall =true;
    if (widget.restID != null) {
      fetchData(widget.restID);
    } else {
      setState(() {
        ratingVendor = widget.ratingVendor;
      });
      setState(() {
        dataChecker = true;

        infodata = widget.restaurantDa;
        restaurantDataCopy = widget.restaurantDa;
        menulistLength = restaurantDataCopy['Menus'].length;
      });
      calculateDeliveryTime(restaurantDataCopy);
      getList();
      // fetchData(48);
      fetchRestaurantStatus();
    }
  }

  double ratingVendor;
  int menulistLength;
  bool dataChecker = false;
  bool dataValidator = false;
  // ignore: missing_return
  fetchData(id) async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  get resturents");
    var result = await http.get(Uri.parse(
      APP_ROUTES +
          'getRestaurantInfos' +
          '?key=BYID&id=$id' +
          '&latitude=' +
          latitude.toString() +
          '&longitude=' +
          longitude.toString(),
    ));
    var restaurantData = json.decode(result.body)['data'];
  
    if (restaurantData.isEmpty || restaurantData == null) {
      setState(() {
        dataChecker = true;

        dataValidator = true;
      });
    } else {
      setState(() {
        menulistLength = restaurantData[0]['Menus'].length;

        infodata = restaurantData[0];
        restaurantDataCopy = restaurantData[0];
      });

      // if (restaurantData[0]['avgRating'] != null) {
      //   ratingVendor = restaurantData[0]['avgRating'][0]['avgRating'].toInt();
      // }
      setState(() {
        dataChecker = true;
      });

      calculateDeliveryTime(restaurantDataCopy);
      getList();
      fetchRestaurantStatus();
    }
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

  String snackBarData = "Items in cart";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double timeTake = 0;
  calculateDeliveryTime(restaurantDataCopy) {
    int k = restaurantDataCopy['Menus'].length;
    for (int i = 0; i <= k - 1; i++) {
      timeTake = timeTake + restaurantDataCopy['Menus'][i]['deliveryTime'];
    }
    timeTake = timeTake / k;

    deliverTime = timeTake.toInt();
  }

  int deliverTime;
  Future fetchRestaurantStatus() async {
    int id = restaurantDataCopy['id'];
  
    if (restaurantDataCopy['user']['Setting'] == null) {
      status = false;
      WidgetsBinding.instance.addPostFrameCallback(
          // ignore: deprecated_member_use
          (_) => _scaffoldKey.currentState.showSnackBar(restaurantSnackBar));
    } else {
      status = restaurantDataCopy['user']['Setting']['isActive'];

      if (status == false) {
        WidgetsBinding.instance.addPostFrameCallback(
            // ignore: deprecated_member_use
            (_) => _scaffoldKey.currentState.showSnackBar(restaurantSnackBar));
      } else {
        print(
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  get resturent");

        var result = await http.get(Uri.parse(
          APP_ROUTES +
              'getRestaurantInfos' +
              '?key=BYID&id=$id'
                  '&latitude=' +
              latitude.toString() +
              '&longitude=' +
              longitude.toString(),
        ));
        print("?????????");
        print(result.statusCode);
        print("################");
        if (result.statusCode == 200) {
          if (mounted) {
            setState(() {
              resturantStatus = json.decode(result.body)['data'];
              if (resturantStatus[0]['user']['Setting'] == null) {
                status = false;
                WidgetsBinding.instance.addPostFrameCallback((_) =>
                    _scaffoldKey.currentState.showSnackBar(restaurantSnackBar));
              } else {
                status = resturantStatus[0]['user']['Setting']['isActive'];
                if (status == false) {
                  WidgetsBinding.instance.addPostFrameCallback((_) =>
                      _scaffoldKey.currentState
                          .showSnackBar(restaurantSnackBar));
                }
              }
            });
          }
        }
        // else {
        //   print("???????");
        //   print(result.statusCode);
        //   print("??????????");
        //   if (mounted) {
        //     setState(() {
        //       status = false;
        //       WidgetsBinding.instance.addPostFrameCallback((_) =>
        //           // ignore: deprecated_member_use
        //           _scaffoldKey.currentState.showSnackBar(restaurantSnackBar));
        //     });
        //   }
        // }
      }
    }

    return resturantStatus;
  }

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

  var resturantStatus;
  bool status = true;
  List<String> checkdata = [];
  getList() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      checkdata = cart.getStringList('addedtocart');
      baritemCount = cart.getInt('TotalCount');
      pricebar = cart.getInt('TotalPrice');
    });
  }

  int baritemCount = 0;
  int pricebar = 0;
  final services = UserServices();
  int typefood = 0;
  int isSelect = 0;
  var restaurantDataCopy;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: dataChecker == false
          ? Scaffold(
              body:OfferResatuarantEffect()
            )
          : dataValidator == true
              ? Scaffold(
                  body: Center(
                    child: Text("Something went wrong please try later..."),
                  ),
                )
              : Scaffold(
                  key: _scaffoldKey,
                  floatingActionButton: restaurantDataCopy['VendorCategories']
                              .length ==
                          0
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                itemBuilder: (context) {
                                  return <PopupMenuEntry<Widget>>[
                                    PopupMenuItem<Widget>(
                                      enabled: true,
                                      child: Container(
                                        decoration: ShapeDecoration(
                                            color: Colors.grey[100],
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        child: Scrollbar(
                                          child: ListView.builder(
                                            itemCount: restaurantDataCopy[
                                                    'VendorCategories']
           
                                                .length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  final result =
                                                      await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                VendorCategoryPage(
                                                              vendorId: restaurantDataCopy[
                                                                          'VendorCategories']
                                                                      [
                                                                      index]['id']
                                                                  .toString(),
                                                              menudata:
                                                                  restaurantDataCopy,
                                                            ),
                                                          ));
                                                  if (result) {
                                                    setState(() {});
                                                    getList();
                                                  }
                                                },
                                                child: ListTile(
                                                  enabled: true,
                                                  selected: index == isSelect,
                                                  title: Row(
                                                    children: [
                                                      Text(
                                                        capitalize(
                                                            restaurantDataCopy[
                                                                    'VendorCategories']
                                                                [
                                                                index]['title']),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize:
                                                              size.height *
                                                                  0.02,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                          " ${restaurantDataCopy['VendorCategories'][index]['Menus'].length}")
                                                    ],
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
                  appBar: AppBar(
                      backgroundColor: Colors.white,
                      actions: [
                        TextButton(
                          child: Text(
                            "More Info..",
                            style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.017),
                          ),
                          onPressed: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResturentDetail(
                                    restaurantDataInfo: restaurantDataCopy,
                                  ),
                                ));
                            if (result) {
                              setState(() {});
                              getList();
                            }
                          },
                        )
                      ],
                      title: Text(
                        capitalize(restaurantDataCopy['name']),
                        style: TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      shadowColor: Colors.white,
                      leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          iconSize: size.height * 0.03,
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          })),
                  body: Column(
                    children: [
                      Expanded(
                        flex: 25,
                        child: ListView(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height * 0.025,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: size.height * 0.22,
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(
                                            left: size.width * 0.033),
                                        child: Text(
                                          restaurantDataCopy['Address']
                                              ['address'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              // fontSize: size.height * 0.016,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Spacer(),
                                    InkWell(
                                      onTap: () async {
                                        var url =
                                            'tel:${restaurantDataCopy['contact']}';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        margin: EdgeInsets.only(
                                            right: size.width * 0.033),
                                        child: Text(
                                          "Mobile No- +91 ${restaurantDataCopy['contact']}",
                                          style: TextStyle(
                                              fontSize: size.height * 0.016,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.030,
                                ),
                                DottedLine(),
                                SizedBox(
                                  height: size.height * 0.022,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: SmoothStarRating(
                                                  allowHalfRating: false,
                                                  onRated: (v) {
                                                    Text("23");
                                                  },
                                                  starCount: 1,
                                                  rating: 3.0,
                                                  size: size.height * 0.025,
                                                  isReadOnly: true,
                                                  defaultIconData: Icons
                                                      .star_border_outlined,
                                                  filledIconData: Icons.star,
                                                  halfFilledIconData:
                                                      Icons.star_border,
                                                  color: Colors.black,
                                                  borderColor: Colors.black,
                                                  spacing: 0.0),
                                            ),
                                            Text(
                                              "$ratingVendor",
                                              style: offerRowHeadingStyle,
                                            ),
                                          ],
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: size.width * 0.04),
                                            child: ratingVendor == 5
                                                ? Text(
                                                    "Popularity 100%",
                                                  )
                                                : ratingVendor == 4
                                                    ? Text(
                                                        "Popularity 80%",
                                                      )
                                                    : ratingVendor == 3
                                                        ? Text(
                                                            "Popularity 60%",
                                                          )
                                                        : ratingVendor == 2
                                                            ? Text(
                                                                "Popularity 40%",
                                                              )
                                                            : Text(
                                                                "Popularity 20%",
                                                              ))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "$deliverTime minutes",
                                          style: offerRowHeadingStyle,
                                        ),
                                        Text("Delivery Time")
                                      ],
                                    ),
                                    restaurantDataCopy['avgCost'] == null
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                right: size.width * 0.02),
                                            child: Column(
                                              children: [
                                                Text("₹ 250",
                                                    style:
                                                        offerRowHeadingStyle),
                                                Text("Cost for one")
                                              ],
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(
                                                right: size.width * 0.02),
                                            child: Column(
                                              children: [
                                                Text(
                                                    "₹ ${restaurantDataCopy['avgCost']}",
                                                    style:
                                                        offerRowHeadingStyle),
                                                Text(
                                                    "Cost for ${restaurantDataCopy['forPeople']}")
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.022,
                                ),
                                DottedLine(),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),

                                // List of Discounts
                                restaurantDataCopy['user']['OffersAndCoupons']
                                        .isEmpty
                                    ? SizedBox()
                                    : Container(
                                        height: size.height * 0.085,
                                        child: ListView.builder(
                                          itemCount: restaurantDataCopy['user']
                                                  ['OffersAndCoupons']
                                              .length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            var couponDetatil;

                                            if (restaurantDataCopy['user']
                                                    ['OffersAndCoupons']
                                                .isEmpty) {
                                            } else {
                                              if (restaurantDataCopy['user']
                                                          ['OffersAndCoupons']
                                                      [index]['discount'] ==
                                                  null) {
                                                String symbol;
                                                if (restaurantDataCopy['user'][
                                                                'OffersAndCoupons']
                                                            [index][
                                                        'couponDiscountType'] ==
                                                    "PERCENT") {
                                                  symbol = "%";
                                                } else {
                                                  symbol = "₹";
                                                }

                                                couponDetatil =
                                                    "${restaurantDataCopy['user']['OffersAndCoupons'][index]['couponDiscount']}$symbol off";
                                              } else {
                                                String symbol;
                                                if (restaurantDataCopy['user']
                                                            ['OffersAndCoupons']
                                                        [
                                                        index]['discountType'] ==
                                                    "PERCENT") {
                                                  symbol = "%";
                                                } else {
                                                  symbol = "₹";
                                                }

                                                couponDetatil =
                                                    "${restaurantDataCopy['user']['OffersAndCoupons'][index]['discount']}$symbol off";
                                              }
                                            }

                                            return InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) =>
                                                        OnOfferBottomSheet(
                                                          data: restaurantDataCopy[
                                                                      'user'][
                                                                  'OffersAndCoupons']
                                                              [index],
                                                          amount: couponDetatil,
                                                        ));
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(4),
                                                padding: EdgeInsets.all(4),
                                                height: size.height * 0.15,
                                                width: size.width * 0.42,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 3,
                                                        color: Colors.blue[50],
                                                        offset: Offset(1, 3),
                                                        spreadRadius: 3)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                ),
                                                child: Column(children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          margin: EdgeInsets.only(
                                                              left: size.width *
                                                                  0.02,
                                                              top: size.height *
                                                                  0.012),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/icons/offer.svg",
                                                            width: size.width *
                                                                0.04,
                                                          )),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.02,
                                                      ),
                                                      Container(
                                                        width: size.width * 0.3,
                                                        margin: EdgeInsets.only(
                                                            left: size.width *
                                                                0.002,
                                                            top: size.height *
                                                                0.01),
                                                        child: Text(
                                                          "${restaurantDataCopy['user']['OffersAndCoupons'][index]['title']}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  size.height *
                                                                      0.015,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      margin: EdgeInsets.only(
                                                          left:
                                                              size.width * 0.08,
                                                          top: size.height *
                                                              0.002),
                                                      child: Text(
                                                        couponDetatil,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                size.height *
                                                                    0.014),
                                                      ))
                                                ]),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                SizedBox(
                                  height: size.height * 0.014,
                                ),
                                Container(
                                    child: Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: size.width * 0.03),
                                        child: status == true
                                            ? Container(
                                                height: size.height * 0.04,
                                                width: size.width * 0.06,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.green,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.green,
                                                          blurRadius: 5)
                                                    ]),
                                              )
                                            : Container(
                                                height: size.height * 0.04,
                                                width: size.width * 0.06,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.red,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.red,
                                                          blurRadius: 5)
                                                    ]),
                                              )),
                                    Container(
                                        margin: EdgeInsets.only(
                                          left: size.width * 0.03,
                                        ),
                                        child: status == true
                                            ? Text(
                                                "Online",
                                                style: offerRowHeadingStyle,
                                              )
                                            : Text(
                                                "Currently closed...",
                                                style: offerRowHeadingStyle,
                                              )),
                                    restaurantDataCopy['isBrand'] != "1"
                                        ? SizedBox()
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Image.asset(
                                                'assets/images/brand.png',
                                                height: 30,
                                                width: 50,
                                              ),
                                            ],
                                          ),
                                    Spacer(),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      height: 32.2,
                                      width: 150,
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              height: 15,
                                              width: 140,
                                              color: Colors.grey[100],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    showVeg = false;
                                                    showNonveg = false;
                                                    showall = true;
                                                    showegg = false;
                                                  });
                                                  setState(() {});
                                                },
                                                child: ClipOval(
                                                  child: Container(
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle),
                                                      child: showall == true
                                                          ? Image.asset(
                                                              "assets/icons/all.png",
                                                            )
                                                          : ColorFiltered(
                                                              colorFilter:
                                                                  ColorFilter.mode(
                                                                      Colors
                                                                          .grey,
                                                                      BlendMode
                                                                          .color),
                                                              child:
                                                                  Image.asset(
                                                                "assets/icons/all.png",
                                                              ),
                                                            )),
                                                ),
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    showVeg = true;
                                                    showNonveg = false;
                                                    showall = false;
                                                    showegg = false;
                                                  });
                                                  setState(() {});
                                                },
                                                child: ClipOval(
                                                  child: Container(
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle),
                                                      child: showVeg == true
                                                          ? Image.asset(
                                                              "assets/icons/veg.png",
                                                            )
                                                          : ColorFiltered(
                                                              colorFilter:
                                                                  ColorFilter.mode(
                                                                      Colors
                                                                          .grey,
                                                                      BlendMode
                                                                          .color),
                                                              child:
                                                                  Image.asset(
                                                                "assets/icons/veg.png",
                                                              ),
                                                            )),
                                                ),
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    showVeg = false;
                                                    showNonveg = true;
                                                    showall = false;
                                                    showegg = false;
                                                  });
                                                  setState(() {});
                                                },
                                                child: ClipOval(
                                                  child: Container(
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: showNonveg == true
                                                          ? Image.asset(
                                                              "assets/icons/nonveg.png",
                                                            )
                                                          : ColorFiltered(
                                                              colorFilter:
                                                                  ColorFilter.mode(
                                                                      Colors
                                                                          .grey,
                                                                      BlendMode
                                                                          .color),
                                                              child:
                                                                  Image.asset(
                                                                "assets/icons/nonveg.png",
                                                              ),
                                                            )),
                                                ),
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    showVeg = false;
                                                    showNonveg = false;
                                                    showall = false;
                                                    showegg = true;
                                                  });
                                                  setState(() {});
                                                },
                                                child: ClipOval(
                                                  child: Container(
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: showegg == true
                                                          ? Image.asset(
                                                              "assets/icons/egg.png",
                                                            )
                                                          : ColorFiltered(
                                                              colorFilter:
                                                                  ColorFilter.mode(
                                                                      Colors
                                                                          .grey,
                                                                      BlendMode
                                                                          .color),
                                                              child:
                                                                  Image.asset(
                                                                "assets/icons/egg.png",
                                                              ),
                                                            )),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    )
                                  ],
                                )),
                                SizedBox(
                                  height: size.height * 0.055,
                                ),
                                menulistLength >= 8
                                    ? Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(
                                            left: size.width * 0.05),
                                        child: Text("Recommended",
                                            style: offerRecommendStyle))
                                    : SizedBox(),

                                menulistLength >= 8
                                    ? SizedBox(
                                        height: size.height * 0.022,
                                      )
                                    : SizedBox(),
                                menulistLength >= 8
                                    ? ListView.builder(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: menulistLength >= 10
                                            ? 10
                                            : menulistLength,
                                        itemBuilder: (context, index) {
                                          int tpye = 0;
                                          double rating = 1.0;
                                          int ratingLength = 1;
                                          if (restaurantDataCopy['Menus'][index]
                                                  ['ReviewAndRatings']
                                              .isNotEmpty) {
                                            int k = restaurantDataCopy['Menus']
                                                    [index]['ReviewAndRatings']
                                                .length;
                                            ratingLength = k;
                                            for (int i = 0; i <= k - 1; i++) {
                                              rating = rating +
                                                  double.parse(restaurantDataCopy[
                                                                      'Menus']
                                                                  [index]
                                                              [
                                                              'ReviewAndRatings']
                                                          [i]['id']
                                                      .toString());
                                            }
                                            rating = rating / k;
                                            if (rating >= 5) {
                                              rating = 5.0;
                                            }
                                          }
                                          if (showall == true) {
                                            if (rating > 2.5) {
                                              print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ all");
                                              return InkWell(
      onTap: () async {
        var menuD;
        var name;
        setState(() {
          menuD = restaurantDataCopy['Menus'][index];
          name = restaurantDataCopy['name'];
        });
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodSlider(
                      menuData: menuD,
                      menuStatus: status,
                      restaurentName: name,
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
                color: status == true ? Colors.white : Colors.blue[50],
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
            child: checkdata.contains(
                    restaurantDataCopy['Menus'][index]['id'].toString())
                ? Dismissible(
                    direction: checkdata.contains(
                            restaurantDataCopy['Menus'][index]['id'].toString())
                        ? DismissDirection.endToStart
                        : DismissDirection.horizontal,
                    // ignore: missing_return
                    confirmDismiss:
                        // ignore: missing_return
                        (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        final bool res = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Are you sure you want to delete ${restaurantDataCopy['Menus'][index]['title']}?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      callingLoader();
                                    
                                      await services
                                          .data(restaurantDataCopy['Menus']
                                              [index]['id'])
                                          .then((value) => fun(value));

                                      final SharedPreferences cart =
                                          await SharedPreferences.getInstance();
                                      int totalprice =
                                          cart.getInt('TotalPrice');
                                      int gsttotal = cart.getInt('TotalGst');
                                      int totalcount =
                                          cart.getInt('TotalCount');
                                      int vendorId = cart.getInt('VendorId');

                                      if (checkdata.isNotEmpty &&
                                          checkdata.contains(
                                              restaurantDataCopy['Menus'][index]
                                                      ['id']
                                                  .toString())) {
                                        if (data1[0]['itemCount'] ==
                                            totalcount) {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);
                                            vendorId = 0;
                                            cart.setInt('VendorId', vendorId);
                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);

                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        } else {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);

                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);
                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          snackBarData =
                                              "${restaurantDataCopy['Menus'][index]['title']} is already remove from cart";
                                        });
                                      }
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                        return res;
                      }
                    },
                    key: ValueKey(index),
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: menuDesign(index, size, rating, tpye))
                : menuDesign(index, size, rating, tpye)),
      ),
    );
                                            } else {
                                              return SizedBox();
                                            }
                                          } else if (showVeg == true) {
                                            if (restaurantDataCopy['Menus']
                                                    [index]['isNonVeg'] ==
                                                false) {
                                              if (rating > 2.5) {
                                                print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEe veg");
                                                    print(restaurantDataCopy['Menus'][index]['title']);

                                                return InkWell(
      onTap: () async {
        var menuD;
        var name;
        setState(() {
          menuD = restaurantDataCopy['Menus'][index];
          name = restaurantDataCopy['name'];
        });
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodSlider(
                      menuData: menuD,
                      menuStatus: status,
                      restaurentName: name,
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
                color: status == true ? Colors.white : Colors.blue[50],
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
            child: checkdata.contains(
                    restaurantDataCopy['Menus'][index]['id'].toString())
                ? Dismissible(
                    direction: checkdata.contains(
                            restaurantDataCopy['Menus'][index]['id'].toString())
                        ? DismissDirection.endToStart
                        : DismissDirection.horizontal,
                    // ignore: missing_return
                    confirmDismiss:
                        // ignore: missing_return
                        (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        final bool res = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Are you sure you want to delete ${restaurantDataCopy['Menus'][index]['title']}?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      callingLoader();
                                    
                                      await services
                                          .data(restaurantDataCopy['Menus']
                                              [index]['id'])
                                          .then((value) => fun(value));

                                      final SharedPreferences cart =
                                          await SharedPreferences.getInstance();
                                      int totalprice =
                                          cart.getInt('TotalPrice');
                                      int gsttotal = cart.getInt('TotalGst');
                                      int totalcount =
                                          cart.getInt('TotalCount');
                                      int vendorId = cart.getInt('VendorId');

                                      if (checkdata.isNotEmpty &&
                                          checkdata.contains(
                                              restaurantDataCopy['Menus'][index]
                                                      ['id']
                                                  .toString())) {
                                        if (data1[0]['itemCount'] ==
                                            totalcount) {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);
                                            vendorId = 0;
                                            cart.setInt('VendorId', vendorId);
                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);

                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        } else {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);

                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);
                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          snackBarData =
                                              "${restaurantDataCopy['Menus'][index]['title']} is already remove from cart";
                                        });
                                      }
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                        return res;
                      }
                    },
                    key: ValueKey(index),
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: menuDesign(index, size, rating, tpye))
                : menuDesign(index, size, rating, tpye)),
      ),
    );
                                              } else {
                                                return SizedBox();
                                              }
                                            } else {
                                              return SizedBox();
                                            }
                                          } else if (showNonveg == true) {
                                            if (restaurantDataCopy['Menus']
                                                    [index]['isNonVeg'] ==
                                                true) {
                                              if (rating > 2.5) {
                                                print("Non  ccccccccccccccccccccccccccc veg");
                                               return InkWell(
      onTap: () async {
        var menuD;
        var name;
        setState(() {
          menuD = restaurantDataCopy['Menus'][index];
          name = restaurantDataCopy['name'];
        });
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodSlider(
                      menuData: menuD,
                      menuStatus: status,
                      restaurentName: name,
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
                color: status == true ? Colors.white : Colors.blue[50],
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
            child: checkdata.contains(
                    restaurantDataCopy['Menus'][index]['id'].toString())
                ? Dismissible(
                    direction: checkdata.contains(
                            restaurantDataCopy['Menus'][index]['id'].toString())
                        ? DismissDirection.endToStart
                        : DismissDirection.horizontal,
                    // ignore: missing_return
                    confirmDismiss:
                        // ignore: missing_return
                        (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        final bool res = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Are you sure you want to delete ${restaurantDataCopy['Menus'][index]['title']}?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      callingLoader();
                                    
                                      await services
                                          .data(restaurantDataCopy['Menus']
                                              [index]['id'])
                                          .then((value) => fun(value));

                                      final SharedPreferences cart =
                                          await SharedPreferences.getInstance();
                                      int totalprice =
                                          cart.getInt('TotalPrice');
                                      int gsttotal = cart.getInt('TotalGst');
                                      int totalcount =
                                          cart.getInt('TotalCount');
                                      int vendorId = cart.getInt('VendorId');

                                      if (checkdata.isNotEmpty &&
                                          checkdata.contains(
                                              restaurantDataCopy['Menus'][index]
                                                      ['id']
                                                  .toString())) {
                                        if (data1[0]['itemCount'] ==
                                            totalcount) {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);
                                            vendorId = 0;
                                            cart.setInt('VendorId', vendorId);
                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);

                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        } else {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);

                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);
                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          snackBarData =
                                              "${restaurantDataCopy['Menus'][index]['title']} is already remove from cart";
                                        });
                                      }
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                        return res;
                      }
                    },
                    key: ValueKey(index),
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: menuDesign(index, size, rating, tpye))
                : menuDesign(index, size, rating, tpye)),
      ),
    );
                                              } else {
                                                return SizedBox();
                                              }
                                            } else {
                                              return SizedBox();
                                            }
                                          } else if (showegg == true) {
                                            if (restaurantDataCopy['Menus']
                                                    [index]['isEgg'] ==
                                                true) {
                                              if (rating > 2.5) {
                                                print("DDDDDDDDDDDDDDDDDDDDDDdd  EGG");
                                               return InkWell(
      onTap: () async {
        var menuD;
        var name;
        setState(() {
          menuD = restaurantDataCopy['Menus'][index];
          name = restaurantDataCopy['name'];
        });
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodSlider(
                      menuData: menuD,
                      menuStatus: status,
                      restaurentName: name,
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
                color: status == true ? Colors.white : Colors.blue[50],
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
            child: checkdata.contains(
                    restaurantDataCopy['Menus'][index]['id'].toString())
                ? Dismissible(
                    direction: checkdata.contains(
                            restaurantDataCopy['Menus'][index]['id'].toString())
                        ? DismissDirection.endToStart
                        : DismissDirection.horizontal,
                    // ignore: missing_return
                    confirmDismiss:
                        // ignore: missing_return
                        (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        final bool res = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Are you sure you want to delete ${restaurantDataCopy['Menus'][index]['title']}?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      callingLoader();
                                    
                                      await services
                                          .data(restaurantDataCopy['Menus']
                                              [index]['id'])
                                          .then((value) => fun(value));

                                      final SharedPreferences cart =
                                          await SharedPreferences.getInstance();
                                      int totalprice =
                                          cart.getInt('TotalPrice');
                                      int gsttotal = cart.getInt('TotalGst');
                                      int totalcount =
                                          cart.getInt('TotalCount');
                                      int vendorId = cart.getInt('VendorId');

                                      if (checkdata.isNotEmpty &&
                                          checkdata.contains(
                                              restaurantDataCopy['Menus'][index]
                                                      ['id']
                                                  .toString())) {
                                        if (data1[0]['itemCount'] ==
                                            totalcount) {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);
                                            vendorId = 0;
                                            cart.setInt('VendorId', vendorId);
                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);

                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        } else {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);

                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);
                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          snackBarData =
                                              "${restaurantDataCopy['Menus'][index]['title']} is already remove from cart";
                                        });
                                      }
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                        return res;
                      }
                    },
                    key: ValueKey(index),
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: menuDesign(index, size, rating, tpye))
                : menuDesign(index, size, rating, tpye)),
      ),
    );
                                              } else {
                                                return SizedBox();
                                              }
                                            } else {
                                              return SizedBox();
                                            }
                                          } else {
                                            return SizedBox();
                                          }
                                        },
                                      )
                                    : SizedBox(),
                                menulistLength >= 8
                                    ? SizedBox(
                                        height: size.height * 0.002,
                                      )
                                    : SizedBox(),
                                Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(
                                        left: size.width * 0.05),
                                    child: Text("All Menus",
                                        style: offerRecommendStyle)),

                                SizedBox(
                                  height: size.height * 0.022,
                                ),
                                // List 2
                                ListView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: menulistLength,
                                  itemBuilder: (context, index) {
                                    int tpye = 0;
                                    double rating = 1.0;
                                    int ratingLength = 1;
                                    if (restaurantDataCopy['Menus'][index]
                                            ['ReviewAndRatings']
                                        .isNotEmpty) {
                                      int k = restaurantDataCopy['Menus'][index]
                                              ['ReviewAndRatings']
                                          .length;
                                      ratingLength = k;
                                      for (int i = 0; i <= k - 1; i++) {
                                        rating = rating +
                                            double.parse(
                                                restaurantDataCopy['Menus']
                                                                [index]
                                                            ['ReviewAndRatings']
                                                        [i]['id']
                                                    .toString());
                                      }
                                      rating = rating / k;
                                      if (rating >= 5) {
                                        rating = 5.0;
                                      }
                                    }
                                    if (showall == true) {
                                      if (rating > 2.5) {
                                    return InkWell(
      onTap: () async {
        var menuD;
        var name;
        setState(() {
          menuD = restaurantDataCopy['Menus'][index];
          name = restaurantDataCopy['name'];
        });
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodSlider(
                      menuData: menuD,
                      menuStatus: status,
                      restaurentName: name,
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
                color: status == true ? Colors.white : Colors.blue[50],
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
            child: checkdata.contains(
                    restaurantDataCopy['Menus'][index]['id'].toString())
                ? Dismissible(
                    direction: checkdata.contains(
                            restaurantDataCopy['Menus'][index]['id'].toString())
                        ? DismissDirection.endToStart
                        : DismissDirection.horizontal,
                    // ignore: missing_return
                    confirmDismiss:
                        // ignore: missing_return
                        (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        final bool res = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Are you sure you want to delete ${restaurantDataCopy['Menus'][index]['title']}?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      callingLoader();
                                    
                                      await services
                                          .data(restaurantDataCopy['Menus']
                                              [index]['id'])
                                          .then((value) => fun(value));

                                      final SharedPreferences cart =
                                          await SharedPreferences.getInstance();
                                      int totalprice =
                                          cart.getInt('TotalPrice');
                                      int gsttotal = cart.getInt('TotalGst');
                                      int totalcount =
                                          cart.getInt('TotalCount');
                                      int vendorId = cart.getInt('VendorId');

                                      if (checkdata.isNotEmpty &&
                                          checkdata.contains(
                                              restaurantDataCopy['Menus'][index]
                                                      ['id']
                                                  .toString())) {
                                        if (data1[0]['itemCount'] ==
                                            totalcount) {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);
                                            vendorId = 0;
                                            cart.setInt('VendorId', vendorId);
                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);

                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        } else {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);

                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);
                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          snackBarData =
                                              "${restaurantDataCopy['Menus'][index]['title']} is already remove from cart";
                                        });
                                      }
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                        return res;
                      }
                    },
                    key: ValueKey(index),
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: menuDesign(index, size, rating, tpye))
                : menuDesign(index, size, rating, tpye)),
      ),
    );
                                      } else {
                                        return SizedBox();
                                      }
                                    } else {
                                      if (showVeg == true) {
                                        if (restaurantDataCopy['Menus'][index]
                                                ['isNonVeg'] ==
                                            false) {
                                       return InkWell(
      onTap: () async {
        var menuD;
        var name;
        setState(() {
          menuD = restaurantDataCopy['Menus'][index];
          name = restaurantDataCopy['name'];
        });
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodSlider(
                      menuData: menuD,
                      menuStatus: status,
                      restaurentName: name,
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
                color: status == true ? Colors.white : Colors.blue[50],
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
            child: checkdata.contains(
                    restaurantDataCopy['Menus'][index]['id'].toString())
                ? Dismissible(
                    direction: checkdata.contains(
                            restaurantDataCopy['Menus'][index]['id'].toString())
                        ? DismissDirection.endToStart
                        : DismissDirection.horizontal,
                    // ignore: missing_return
                    confirmDismiss:
                        // ignore: missing_return
                        (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        final bool res = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Are you sure you want to delete ${restaurantDataCopy['Menus'][index]['title']}?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      callingLoader();
                                    
                                      await services
                                          .data(restaurantDataCopy['Menus']
                                              [index]['id'])
                                          .then((value) => fun(value));

                                      final SharedPreferences cart =
                                          await SharedPreferences.getInstance();
                                      int totalprice =
                                          cart.getInt('TotalPrice');
                                      int gsttotal = cart.getInt('TotalGst');
                                      int totalcount =
                                          cart.getInt('TotalCount');
                                      int vendorId = cart.getInt('VendorId');

                                      if (checkdata.isNotEmpty &&
                                          checkdata.contains(
                                              restaurantDataCopy['Menus'][index]
                                                      ['id']
                                                  .toString())) {
                                        if (data1[0]['itemCount'] ==
                                            totalcount) {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);
                                            vendorId = 0;
                                            cart.setInt('VendorId', vendorId);
                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);

                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        } else {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);

                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);
                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          snackBarData =
                                              "${restaurantDataCopy['Menus'][index]['title']} is already remove from cart";
                                        });
                                      }
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                        return res;
                      }
                    },
                    key: ValueKey(index),
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: menuDesign(index, size, rating, tpye))
                : menuDesign(index, size, rating, tpye)),
      ),
    );
                                        } else {
                                          return SizedBox();
                                        }
                                      } else if (showNonveg == true) {
                                        if (restaurantDataCopy['Menus'][index]
                                                ['isNonVeg'] ==
                                            true) {
                                       return InkWell(
      onTap: () async {
        var menuD;
        var name;
        setState(() {
          menuD = restaurantDataCopy['Menus'][index];
          name = restaurantDataCopy['name'];
        });
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodSlider(
                      menuData: menuD,
                      menuStatus: status,
                      restaurentName: name,
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
                color: status == true ? Colors.white : Colors.blue[50],
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
            child: checkdata.contains(
                    restaurantDataCopy['Menus'][index]['id'].toString())
                ? Dismissible(
                    direction: checkdata.contains(
                            restaurantDataCopy['Menus'][index]['id'].toString())
                        ? DismissDirection.endToStart
                        : DismissDirection.horizontal,
                    // ignore: missing_return
                    confirmDismiss:
                        // ignore: missing_return
                        (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        final bool res = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Are you sure you want to delete ${restaurantDataCopy['Menus'][index]['title']}?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      callingLoader();
                                    
                                      await services
                                          .data(restaurantDataCopy['Menus']
                                              [index]['id'])
                                          .then((value) => fun(value));

                                      final SharedPreferences cart =
                                          await SharedPreferences.getInstance();
                                      int totalprice =
                                          cart.getInt('TotalPrice');
                                      int gsttotal = cart.getInt('TotalGst');
                                      int totalcount =
                                          cart.getInt('TotalCount');
                                      int vendorId = cart.getInt('VendorId');

                                      if (checkdata.isNotEmpty &&
                                          checkdata.contains(
                                              restaurantDataCopy['Menus'][index]
                                                      ['id']
                                                  .toString())) {
                                        if (data1[0]['itemCount'] ==
                                            totalcount) {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);
                                            vendorId = 0;
                                            cart.setInt('VendorId', vendorId);
                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);

                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        } else {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);

                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);
                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          snackBarData =
                                              "${restaurantDataCopy['Menus'][index]['title']} is already remove from cart";
                                        });
                                      }
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                        return res;
                      }
                    },
                    key: ValueKey(index),
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: menuDesign(index, size, rating, tpye))
                : menuDesign(index, size, rating, tpye)),
      ),
    );
                                        } else {
                                          return SizedBox();
                                        }
                                      } else if (showegg == true) {
                                        if (restaurantDataCopy['Menus'][index]
                                                ['isEgg'] ==
                                            true) {
                                         return InkWell(
      onTap: () async {
        var menuD;
        var name;
        setState(() {
          menuD = restaurantDataCopy['Menus'][index];
          name = restaurantDataCopy['name'];
        });
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodSlider(
                      menuData: menuD,
                      menuStatus: status,
                      restaurentName: name,
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
                color: status == true ? Colors.white : Colors.blue[50],
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
            child: checkdata.contains(
                    restaurantDataCopy['Menus'][index]['id'].toString())
                ? Dismissible(
                    direction: checkdata.contains(
                            restaurantDataCopy['Menus'][index]['id'].toString())
                        ? DismissDirection.endToStart
                        : DismissDirection.horizontal,
                    // ignore: missing_return
                    confirmDismiss:
                        // ignore: missing_return
                        (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        final bool res = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Are you sure you want to delete ${restaurantDataCopy['Menus'][index]['title']}?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      callingLoader();
                                    
                                      await services
                                          .data(restaurantDataCopy['Menus']
                                              [index]['id'])
                                          .then((value) => fun(value));

                                      final SharedPreferences cart =
                                          await SharedPreferences.getInstance();
                                      int totalprice =
                                          cart.getInt('TotalPrice');
                                      int gsttotal = cart.getInt('TotalGst');
                                      int totalcount =
                                          cart.getInt('TotalCount');
                                      int vendorId = cart.getInt('VendorId');

                                      if (checkdata.isNotEmpty &&
                                          checkdata.contains(
                                              restaurantDataCopy['Menus'][index]
                                                      ['id']
                                                  .toString())) {
                                        if (data1[0]['itemCount'] ==
                                            totalcount) {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);
                                            vendorId = 0;
                                            cart.setInt('VendorId', vendorId);
                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);

                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        } else {
                                          setState(() {
                                            snackBarData =
                                                "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                            totalcount = totalcount -
                                                data1[0]['itemCount'];
                                            gsttotal = gsttotal -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['gst']);
                                            totalprice = totalprice -
                                                (data1[0]['itemCount'] *
                                                    data1[0]['itemPrice']);

                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);
                                            checkdata.remove(data1[0]
                                                    ['menuItemId']
                                                .toString());
                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            removeAddOnWithMenu(
                                                data1[0]['addons']);
                                            services.deleteUser(
                                                data1[0]['menuItemId']);
                                            getList();
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          snackBarData =
                                              "${restaurantDataCopy['Menus'][index]['title']} is already remove from cart";
                                        });
                                      }
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                        return res;
                      }
                    },
                    key: ValueKey(index),
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: menuDesign(index, size, rating, tpye))
                : menuDesign(index, size, rating, tpye)),
      ),
    );
                                        } else {
                                          return SizedBox();
                                        }
                                      } else {
                                        return SizedBox();
                                      }
                                    }

                                    // return InkWell(
                                    //   onTap: () async {
                                    //     var menuD;
                                    //     var name;
                                    //     setState(() {
                                    //       menuD = restaurantDataCopy['Menus']
                                    //           [index];
                                    //       name = restaurantDataCopy['name'];
                                    //     });
                                    //     final result = await Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) =>
                                    //                 FoodSlider(
                                    //                   menuData: menuD,
                                    //                   menuStatus: status,
                                    //                   restaurentName: name,
                                    //                   rating: rating,
                                    //                   ratinglength:
                                    //                       ratingLength,
                                    //                 )));
                                    //     if (result) {
                                    //       setState(() {});
                                    //       getList();
                                    //     }
                                    //   },
                                    //   child: Padding(
                                    //     padding:
                                    //         const EdgeInsets.only(bottom: 14),
                                    //     child: Container(
                                    //         decoration: BoxDecoration(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10),
                                    //             color: status == true
                                    //                 ? Colors.white
                                    //                 : Colors.blue[50],
                                    //             boxShadow: [
                                    //               BoxShadow(
                                    //                   blurRadius: 2,
                                    //                   color: Colors.blue[50],
                                    //                   offset: Offset(1, 3),
                                    //                   spreadRadius: 2)
                                    //             ]),
                                    //         margin: EdgeInsets.only(
                                    //           left: size.width * 0.02,
                                    //           right: size.width * 0.02,
                                    //         ),
                                    //         height: size.height * 0.14,
                                    //         child:
                                    //             checkdata.contains(
                                    //                     restaurantDataCopy[
                                    //                                 'Menus']
                                    //                             [index]['id']
                                    //                         .toString())
                                    //                 ? Dismissible(
                                    //                     direction:
                                    //                         DismissDirection
                                    //                             .endToStart,
                                    //                     // ignore: missing_return
                                    //                     confirmDismiss:
                                    //                         // ignore: missing_return
                                    //                         (direction) async {
                                    //                       if (direction ==
                                    //                           DismissDirection
                                    //                               .endToStart) {
                                    //                         final bool res =
                                    //                             await showDialog(
                                    //                                 context:
                                    //                                     context,
                                    //                                 builder:
                                    //                                     (BuildContext
                                    //                                         context) {
                                    //                                   return AlertDialog(
                                    //                                     content:
                                    //                                         Text("Are you sure you want to delete ${restaurantDataCopy['Menus'][index]['title']}?"),
                                    //                                     actions: <
                                    //                                         Widget>[
                                    //                                       TextButton(
                                    //                                         child:
                                    //                                             Text(
                                    //                                           "Cancel",
                                    //                                           style: TextStyle(color: Colors.black),
                                    //                                         ),
                                    //                                         onPressed:
                                    //                                             () {
                                    //                                           Navigator.pop(context);
                                    //                                         },
                                    //                                       ),
                                    //                                       TextButton(
                                    //                                         child:
                                    //                                             Text(
                                    //                                           "Delete",
                                    //                                           style: TextStyle(color: Colors.red),
                                    //                                         ),
                                    //                                         onPressed:
                                    //                                             () async {
                                    //                                           callingLoader();
                                    //                                           print(restaurantDataCopy['Menus'][index]['id']);
                                    //                                           await services.data(restaurantDataCopy['Menus'][index]['id']).then((value) => fun(value));

                                    //                                           final SharedPreferences cart = await SharedPreferences.getInstance();
                                    //                                           int totalprice = cart.getInt('TotalPrice');
                                    //                                           int gsttotal = cart.getInt('TotalGst');
                                    //                                           int totalcount = cart.getInt('TotalCount');
                                    //                                           int vendorId = cart.getInt('VendorId');

                                    //                                           if (checkdata.isNotEmpty && checkdata.contains(restaurantDataCopy['Menus'][index]['id'].toString())) {
                                    //                                             if (data1[0]['itemCount'] == totalcount) {
                                    //                                               setState(() {
                                    //                                                 snackBarData = "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                    //                                                 totalcount = totalcount - data1[0]['itemCount'];
                                    //                                                 gsttotal = gsttotal - (data1[0]['itemCount'] * data1[0]['gst']);
                                    //                                                 totalprice = totalprice - (data1[0]['itemCount'] * data1[0]['itemPrice']);
                                    //                                                 vendorId = 0;
                                    //                                                 cart.setInt('VendorId', vendorId);
                                    //                                                 cart.setInt('TotalPrice', totalprice);
                                    //                                                 cart.setInt('TotalGst', gsttotal);
                                    //                                                 cart.setInt('TotalCount', totalcount);
                                    //                                                 checkdata.remove(data1[0]['menuItemId'].toString());
                                    //                                                 print(checkdata);
                                    //                                                 cart.setStringList('addedtocart', checkdata);
                                    //                                                 removeAddOnWithMenu(data1[0]['addons']);

                                    //                                                 services.deleteUser(data1[0]['menuItemId']);
                                    //                                                 getList();
                                    //                                               });
                                    //                                             } else {
                                    //                                               setState(() {
                                    //                                                 snackBarData = "${restaurantDataCopy['Menus'][index]['title']} is remove from cart";
                                    //                                                 totalcount = totalcount - data1[0]['itemCount'];
                                    //                                                 gsttotal = gsttotal - (data1[0]['itemCount'] * data1[0]['gst']);
                                    //                                                 totalprice = totalprice - (data1[0]['itemCount'] * data1[0]['itemPrice']);

                                    //                                                 cart.setInt('TotalPrice', totalprice);
                                    //                                                 cart.setInt('TotalGst', gsttotal);
                                    //                                                 cart.setInt('TotalCount', totalcount);
                                    //                                                 checkdata.remove(data1[0]['menuItemId'].toString());
                                    //                                                 print(checkdata);
                                    //                                                 cart.setStringList('addedtocart', checkdata);
                                    //                                                 removeAddOnWithMenu(data1[0]['addons']);
                                    //                                                 services.deleteUser(data1[0]['menuItemId']);
                                    //                                                 getList();
                                    //                                               });
                                    //                                             }
                                    //                                           } else {
                                    //                                             setState(() {
                                    //                                               snackBarData = "${restaurantDataCopy['Menus'][index]['title']} is already remove from cart";
                                    //                                             });
                                    //                                           }
                                    //                                           Navigator.pop(context);
                                    //                                           Navigator.pop(context);
                                    //                                         },
                                    //                                       ),
                                    //                                     ],
                                    //                                   );
                                    //                                 });
                                    //                         return res;
                                    //                       }
                                    //                     },
                                    //                     key: ValueKey(index),
                                    //                     background: Container(
                                    //                       color: Colors.red,
                                    //                       padding:
                                    //                           EdgeInsets.only(
                                    //                               right: 10),
                                    //                       alignment: Alignment
                                    //                           .centerRight,
                                    //                       child: Icon(
                                    //                         Icons.delete,
                                    //                         color: Colors.white,
                                    //                       ),
                                    //                     ),
                                    //                     child: Row(children: [
                                    //                       Expanded(
                                    //                           flex: 0,
                                    //                           child: Stack(
                                    //                             children: [
                                    //                               Container(
                                    //                                 alignment:
                                    //                                     Alignment
                                    //                                         .topCenter,
                                    //                                 height:
                                    //                                     size.height *
                                    //                                         0.2,
                                    //                                 width:
                                    //                                     size.width *
                                    //                                         0.3,
                                    //                                 child:
                                    //                                     Container(
                                    //                                   margin: EdgeInsets.only(
                                    //                                       left: size.width *
                                    //                                           0.01,
                                    //                                       right: size.width *
                                    //                                           0.014,
                                    //                                       top: size.height *
                                    //                                           0.008),
                                    //                                   child:
                                    //                                       ClipRRect(
                                    //                                     borderRadius:
                                    //                                         BorderRadius.circular(10),
                                    //                                     child: restaurantDataCopy['Menus'][index]['image1'] !=
                                    //                                             null
                                    //                                         ? CachedNetworkImage(
                                    //                                             imageUrl: S3_BASE_PATH + restaurantDataCopy['Menus'][index]['image1'],
                                    //                                             height: size.height * 0.1,
                                    //                                             width: size.width * 0.26,
                                    //                                             fit: BoxFit.cover,
                                    //                                             placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                    //                                             errorWidget: (context, url, error) => Image.asset(
                                    //                                               "assets/images/feasturenttemp.jpeg",
                                    //                                               fit: BoxFit.cover,
                                    //                                             ),
                                    //                                           )
                                    //                                         : Image.asset(
                                    //                                             "assets/images/feasturenttemp.jpeg",
                                    //                                             height: size.height * 0.1,
                                    //                                             width: size.width * 0.26,
                                    //                                             fit: BoxFit.cover,
                                    //                                           ),
                                    //                                   ),
                                    //                                 ),
                                    //                               ),
                                    //                               Positioned(
                                    //                                 top: size
                                    //                                         .height *
                                    //                                     0.09,
                                    //                                 bottom: size
                                    //                                         .height *
                                    //                                     0.02,
                                    //                                 left: size
                                    //                                         .width *
                                    //                                     0.058,
                                    //                                 right: size
                                    //                                         .width *
                                    //                                     0.058,
                                    //                                 child:
                                    //                                     MaterialButton(
                                    //                                   onPressed:
                                    //                                       () async {
                                    //                                     if (status ==
                                    //                                         true) {
                                    //                                       final SharedPreferences
                                    //                                           cart =
                                    //                                           await SharedPreferences.getInstance();

                                    //                                       int vendorId =
                                    //                                           cart.getInt('VendorId');

                                    //                                       await services
                                    //                                           .data(restaurantDataCopy['Menus'][index]['id'])
                                    //                                           .then((value) => fun(value));

                                    //                                       if (vendorId == 0 ||
                                    //                                           vendorId == restaurantDataCopy['Menus'][index]['vendorId']) {
                                    //                                         callingLoader();

                                    //                                         if (data1.isEmpty) {
                                    //                                           if (restaurantDataCopy['Menus'][index]['AddonMenus'].isEmpty) {
                                    //                                             await addButtonFunction(tpye, index, restaurantDataCopy['Menus'][index]['totalPrice'], restaurantDataCopy['Menus'][index]['gstAmount'], 0, null, restaurantDataCopy['Menus'][index]['title'], rating);
                                    //                                           } else {
                                    //                                             tempAddOns = null;
                                    //                                             final result = await showModalBottomSheet(
                                    //                                                 isScrollControlled: true,
                                    //                                                 isDismissible: false,
                                    //                                                 enableDrag: false,
                                    //                                                 backgroundColor: Colors.transparent,
                                    //                                                 context: context,
                                    //                                                 builder: (context) => CustomizeMenu(
                                    //                                                       menuData: restaurantDataCopy['Menus'][index],
                                    //                                                     ));

                                    //                                             if (result != null) {
                                    //                                               if (result > 0) {
                                    //                                                 int totalprice = 0;
                                    //                                                 int totalgst = 0;
                                    //                                                 String title;
                                    //                                                 int k = restaurantDataCopy['Menus'][index]['AddonMenus'].length;
                                    //                                                 for (int i = 0; i <= k - 1; i++) {
                                    //                                                   if (restaurantDataCopy['Menus'][index]['AddonMenus'][i]['id'] == result) {
                                    //                                                     setState(() {
                                    //                                                       title = "${restaurantDataCopy['Menus'][index]['AddonMenus'][i]['title']} ${restaurantDataCopy['Menus'][index]['title']}";
                                    //                                                       totalprice = restaurantDataCopy['Menus'][index]['AddonMenus'][i]['amount'] + restaurantDataCopy['Menus'][index]['AddonMenus'][i]['gstAmount'].toInt();
                                    //                                                       totalgst = restaurantDataCopy['Menus'][index]['AddonMenus'][i]['gstAmount'].toInt();
                                    //                                                     });
                                    //                                                   }
                                    //                                                 }
                                    //                                                 await addButtonFunction(tpye, index, totalprice, totalgst, result, tempAddOns, title, rating);
                                    //                                               } else if (result == 0) {
                                    //                                                 await addButtonFunction(tpye, index, restaurantDataCopy['Menus'][index]['totalPrice'], restaurantDataCopy['Menus'][index]['gstAmount'].toInt(), 0, tempAddOns, restaurantDataCopy['Menus'][index]['title'], rating);
                                    //                                               }
                                    //                                             }
                                    //                                           }
                                    //                                         } else {
                                    //                                           if (data1[0]['menuItemId'] != restaurantDataCopy['Menus'][index]['id']) {
                                    //                                             if (restaurantDataCopy['Menus'][index]['AddonMenus'].isEmpty) {
                                    //                                               await addButtonFunction(tpye, index, restaurantDataCopy['Menus'][index]['totalPrice'], restaurantDataCopy['Menus'][index]['gstAmount'].toInt(), 0, null, restaurantDataCopy['Menus'][index]['title'], rating);
                                    //                                             } else {
                                    //                                               tempAddOns = null;
                                    //                                               final result = await showModalBottomSheet(
                                    //                                                   isScrollControlled: true,
                                    //                                                   isDismissible: false,
                                    //                                                   enableDrag: false,
                                    //                                                   backgroundColor: Colors.transparent,
                                    //                                                   context: context,
                                    //                                                   builder: (context) => CustomizeMenu(
                                    //                                                         menuData: restaurantDataCopy['Menus'][index],
                                    //                                                       ));

                                    //                                               if (result != null) {
                                    //                                                 if (result > 0) {
                                    //                                                   int totalprice = 0;
                                    //                                                   int totalgst = 0;
                                    //                                                   String title;
                                    //                                                   int k = restaurantDataCopy['Menus'][index]['AddonMenus'].length;
                                    //                                                   for (int i = 0; i <= k - 1; i++) {
                                    //                                                     title = "${restaurantDataCopy['Menus'][index]['AddonMenus'][i]['title']} ${restaurantDataCopy['Menus'][index]['title']}";
                                    //                                                     if (restaurantDataCopy['Menus'][index]['AddonMenus'][i]['id'] == result) {
                                    //                                                       setState(() {
                                    //                                                         totalprice = restaurantDataCopy['Menus'][index]['AddonMenus'][i]['amount'] + restaurantDataCopy['Menus'][index]['AddonMenus'][i]['gstAmount'].toInt();
                                    //                                                         totalgst = restaurantDataCopy['Menus'][index]['AddonMenus'][i]['gstAmount'].toInt();
                                    //                                                       });
                                    //                                                     }
                                    //                                                   }
                                    //                                                   await addButtonFunction(tpye, index, totalprice, totalgst, result, tempAddOns, title, rating);
                                    //                                                 } else if (result == 0) {
                                    //                                                   await addButtonFunction(tpye, index, restaurantDataCopy['Menus'][index]['totalPrice'], restaurantDataCopy['Menus'][index]['gstAmount'].toInt(), 0, tempAddOns, restaurantDataCopy['Menus'][index]['title'], rating);
                                    //                                                 }
                                    //                                               }
                                    //                                             }
                                    //                                           } else {
                                    //                                             setState(() {
                                    //                                               snackBarData = "${restaurantDataCopy['Menus'][index]['title']} is already added to cart";
                                    //                                             });
                                    //                                             print("match");
                                    //                                           }
                                    //                                         }
                                    //                                         Navigator.pop(context);
                                    //                                       } else {
                                    //                                         showDialog(
                                    //                                             context: context,
                                    //                                             builder: (BuildContext context) {
                                    //                                               return AlertDialog(content: Text("Do you want to order food from different resturent"), actions: <Widget>[
                                    //                                                 TextButton(
                                    //                                                   child: Text(
                                    //                                                     "No",
                                    //                                                     style: TextStyle(color: Colors.black),
                                    //                                                   ),
                                    //                                                   onPressed: () {
                                    //                                                     Navigator.pop(context);
                                    //                                                   },
                                    //                                                 ),
                                    //                                                 TextButton(
                                    //                                                   child: Text(
                                    //                                                     "Yes",
                                    //                                                     style: TextStyle(color: Colors.black),
                                    //                                                   ),
                                    //                                                   onPressed: () async {
                                    //                                                     callingLoader();
                                    //                                                     removeCartForNewData();
                                    //                                                     setState(() {});
                                    //                                                     getList();
                                    //                                                     Navigator.pop(context);
                                    //                                                     Navigator.pop(context);
                                    //                                                     if (restaurantDataCopy['Menus'][index]['AddonMenus'].isEmpty) {
                                    //                                                       await addButtonFunction(tpye, index, restaurantDataCopy['Menus'][index]['totalPrice'], restaurantDataCopy['Menus'][index]['gstAmount'].toInt(), 0, null, restaurantDataCopy['Menus'][index]['title'], rating);
                                    //                                                     } else {
                                    //                                                       tempAddOns = null;
                                    //                                                       final result = await showModalBottomSheet(
                                    //                                                           isScrollControlled: true,
                                    //                                                           isDismissible: false,
                                    //                                                           enableDrag: false,
                                    //                                                           backgroundColor: Colors.transparent,
                                    //                                                           context: context,
                                    //                                                           builder: (context) => CustomizeMenu(
                                    //                                                                 menuData: restaurantDataCopy['Menus'][index],
                                    //                                                               ));

                                    //                                                       if (result != null) {
                                    //                                                         if (result > 0) {
                                    //                                                           int totalprice = 0;
                                    //                                                           int totalgst = 0;
                                    //                                                           String title;
                                    //                                                           int k = restaurantDataCopy['Menus'][index]['AddonMenus'].length;
                                    //                                                           for (int i = 0; i <= k - 1; i++) {
                                    //                                                             if (restaurantDataCopy['Menus'][index]['AddonMenus'][i]['id'] == result) {
                                    //                                                               setState(() {
                                    //                                                                 title = "${restaurantDataCopy['Menus'][index]['AddonMenus'][i]['title']} ${restaurantDataCopy['Menus'][index]['title']}";
                                    //                                                                 totalprice = restaurantDataCopy['Menus'][index]['AddonMenus'][i]['amount'] + restaurantDataCopy['Menus'][index]['AddonMenus'][i]['gstAmount'].toInt();
                                    //                                                                 totalgst = restaurantDataCopy['Menus'][index]['AddonMenus'][i]['gstAmount'].toInt();
                                    //                                                               });
                                    //                                                             }
                                    //                                                           }
                                    //                                                           await addButtonFunction(tpye, index, totalprice, totalgst, result, tempAddOns, title, rating);
                                    //                                                         } else if (result == 0) {
                                    //                                                           await addButtonFunction(tpye, index, restaurantDataCopy['Menus'][index]['totalPrice'], restaurantDataCopy['Menus'][index]['gstAmount'].toInt(), 0, tempAddOns, restaurantDataCopy['Menus'][index]['title'], rating);
                                    //                                                         }
                                    //                                                       }
                                    //                                                     }
                                    //                                                   },
                                    //                                                 ),
                                    //                                               ]);
                                    //                                             });
                                    //                                       }
                                    //                                     } else {
                                    //                                       Fluttertoast.showToast(
                                    //                                           msg: "Not taking orders now");
                                    //                                     }
                                    //                                   },
                                    //                                   color: checkdata
                                    //                                           .isEmpty
                                    //                                       ? Colors
                                    //                                           .white
                                    //                                       : checkdata.contains(restaurantDataCopy['Menus'][index]['id'].toString())
                                    //                                           ? Colors.blue
                                    //                                           : Colors.white,
                                    //                                   minWidth:
                                    //                                       size.width *
                                    //                                           0.16,
                                    //                                   height: size
                                    //                                           .height *
                                    //                                       0.033,
                                    //                                   shape: RoundedRectangleBorder(
                                    //                                       borderRadius:
                                    //                                           BorderRadius.circular(14)),
                                    //                                   child: checkdata
                                    //                                           .isEmpty
                                    //                                       ? Center(
                                    //                                           child: Text(
                                    //                                             "Add",
                                    //                                             style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, color: Colors.blueGrey),
                                    //                                           ),
                                    //                                         )
                                    //                                       : checkdata.contains(restaurantDataCopy['Menus'][index]['id'].toString())
                                    //                                           ? Center(
                                    //                                               child: Text(
                                    //                                                 "Added",
                                    //                                                 style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, color: Colors.white),
                                    //                                               ),
                                    //                                             )
                                    //                                           : Center(
                                    //                                               child: Text(
                                    //                                                 "Add",
                                    //                                                 style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, color: Colors.blueGrey),
                                    //                                               ),
                                    //                                             ),
                                    //                                 ),
                                    //                               )
                                    //                             ],
                                    //                           )),
                                    //                       Expanded(
                                    //                           flex: 6,
                                    //                           child: Container(
                                    //                             height:
                                    //                                 size.height *
                                    //                                     0.2,
                                    //                             child: Column(
                                    //                               crossAxisAlignment:
                                    //                                   CrossAxisAlignment
                                    //                                       .start,
                                    //                               mainAxisSize:
                                    //                                   MainAxisSize
                                    //                                       .max,
                                    //                               children: [
                                    //                                 Container(
                                    //                                   margin: EdgeInsets.only(
                                    //                                       top: size.height *
                                    //                                           0.01),
                                    //                                   child:
                                    //                                       Row(
                                    //                                     children: [
                                    //                                       Container(
                                    //                                         width:
                                    //                                             size.width * 0.5,
                                    //                                         child:
                                    //                                             Text(
                                    //                                           capitalize(restaurantDataCopy['Menus'][index]['title']),
                                    //                                           overflow: TextOverflow.ellipsis,
                                    //                                           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: size.height * 0.019),
                                    //                                         ),
                                    //                                       ),
                                    //                                       Spacer(),
                                    //                                       Padding(
                                    //                                           padding: const EdgeInsets.only(right: 12),
                                    //                                           child: restaurantDataCopy['Menus'][index]['isNonVeg'] == false
                                    //                                               ? restaurantDataCopy['Menus'][index]['isEgg'] == false
                                    //                                                   ? Container(
                                    //                                                       child: CachedNetworkImage(
                                    //                                                         imageUrl: 'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                    //                                                         height: size.height * 0.016,
                                    //                                                         errorWidget: (context, url, error) => Icon(Icons.error),
                                    //                                                       ),
                                    //                                                     )
                                    //                                                   : Container(
                                    //                                                       child: Image.asset(
                                    //                                                       "assets/images/eggeterian.png",
                                    //                                                       height: size.height * 0.016,
                                    //                                                     ))
                                    //                                               : CachedNetworkImage(
                                    //                                                   imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
                                    //                                                   height: size.height * 0.016,
                                    //                                                   errorWidget: (context, url, error) => Icon(Icons.error),
                                    //                                                 ))
                                    //                                     ],
                                    //                                   ),
                                    //                                 ),
                                    //                                 SizedBox(
                                    //                                     height: size.height *
                                    //                                         0.005),
                                    //                                 SizedBox(
                                    //                                   height: size
                                    //                                           .height *
                                    //                                       0.002,
                                    //                                 ),
                                    //                                 Container(
                                    //                                   child:
                                    //                                       Row(
                                    //                                     children: [
                                    //                                       Container(
                                    //                                           child: Text("⭐")),
                                    //                                       Text(
                                    //                                         "${restaurantDataCopy['Menus'][index]['ReviewAndRatings'].length}",
                                    //                                         style: TextStyle(
                                    //                                             fontSize: size.height * 0.014,
                                    //                                             color: Colors.red,
                                    //                                             fontWeight: FontWeight.bold),
                                    //                                       ),
                                    //                                       Spacer(),
                                    //                                       Container(
                                    //                                         margin:
                                    //                                             EdgeInsets.only(right: size.width * 0.1),
                                    //                                         child:
                                    //                                             Text(
                                    //                                           "₹${restaurantDataCopy['Menus'][index]['totalPrice']}",
                                    //                                           style: TextStyle(fontSize: size.height * 0.018, color: Colors.black, fontWeight: FontWeight.bold),
                                    //                                         ),
                                    //                                       ),
                                    //                                     ],
                                    //                                   ),
                                    //                                 ),
                                    //                                 SizedBox(
                                    //                                   height: size
                                    //                                           .height *
                                    //                                       0.003,
                                    //                                 ),
                                    //                                 Container(
                                    //                                   child: Container(
                                    //                                       child: restaurantDataCopy['Menus'][index]['MenuOffers'].length != 0
                                    //                                           ? Row(
                                    //                                               children: [
                                    //                                                 Image.asset(
                                    //                                                   "assets/icons/discount_icon.jpg",
                                    //                                                   height: size.height * 0.02,
                                    //                                                 ),
                                    //                                                 SizedBox(
                                    //                                                   width: size.width * 0.006,
                                    //                                                 ),
                                    //                                                 Container(
                                    //                                                   child: restaurantDataCopy['Menus'][index]['MenuOffers'].length >= 2
                                    //                                                       ? Row(
                                    //                                                           children: [
                                    //                                                             restaurantDataCopy['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon'] == null
                                    //                                                                 ? SizedBox()
                                    //                                                                 : Text(
                                    //                                                                     " ${restaurantDataCopy['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon']}, ",
                                    //                                                                     style: TextStyle(fontSize: size.height * 0.015, color: kTextColor),
                                    //                                                                   ),
                                    //                                                             restaurantDataCopy['Menus'][index]['MenuOffers'][1]['OffersAndCoupon']['coupon'] == null
                                    //                                                                 ? SizedBox()
                                    //                                                                 : Text(
                                    //                                                                     " ${restaurantDataCopy['Menus'][index]['MenuOffers'][1]['OffersAndCoupon']['coupon']}",
                                    //                                                                     style: TextStyle(fontSize: size.height * 0.015, color: kTextColor),
                                    //                                                                   ),
                                    //                                                           ],
                                    //                                                         )
                                    //                                                       : restaurantDataCopy['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon'] == null
                                    //                                                           ? SizedBox()
                                    //                                                           : Text(
                                    //                                                               " ${restaurantDataCopy['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon']}",
                                    //                                                               style: TextStyle(fontSize: size.height * 0.015, color: kTextColor),
                                    //                                                             ),
                                    //                                                 ),
                                    //                                               ],
                                    //                                             )
                                    //                                           : SizedBox()),
                                    //                                 ),
                                    //                               ],
                                    //                             ),
                                    //                           )),
                                    //                       restaurantDataCopy['Menus']
                                    //                                       [
                                    //                                       index]
                                    //                                   [
                                    //                                   'AddonMenus']
                                    //                               .isEmpty
                                    //                           ? SizedBox()
                                    //                           : RotatedBox(
                                    //                               quarterTurns:
                                    //                                   -1,
                                    //                               child: Text(
                                    //                                 "Customize",
                                    //                                 style: TextStyle(
                                    //                                     fontWeight:
                                    //                                         FontWeight
                                    //                                             .bold,
                                    //                                     color: Colors
                                    //                                         .black54,
                                    //                                     fontSize:
                                    //                                         size.height *
                                    //                                             0.015),
                                    //                               )),
                                    //                     ]),
                                    //                   )
                                    //                 : Row(children: [
                                    //                     Expanded(
                                    //                         flex: 0,
                                    //                         child: Stack(
                                    //                           children: [
                                    //                             Container(
                                    //                               alignment:
                                    //                                   Alignment
                                    //                                       .topCenter,
                                    //                               height:
                                    //                                   size.height *
                                    //                                       0.2,
                                    //                               width:
                                    //                                   size.width *
                                    //                                       0.3,
                                    //                               child:
                                    //                                   Container(
                                    //                                 margin: EdgeInsets.only(
                                    //                                     left: size.width *
                                    //                                         0.01,
                                    //                                     right: size.width *
                                    //                                         0.014,
                                    //                                     top: size.height *
                                    //                                         0.008),
                                    //                                 child:
                                    //                                     ClipRRect(
                                    //                                   borderRadius:
                                    //                                       BorderRadius.circular(
                                    //                                           10),
                                    //                                   child: restaurantDataCopy['Menus'][index]['image1'] !=
                                    //                                           null
                                    //                                       ? CachedNetworkImage(
                                    //                                           imageUrl: S3_BASE_PATH + restaurantDataCopy['Menus'][index]['image1'],
                                    //                                           height: size.height * 0.1,
                                    //                                           width: size.width * 0.26,
                                    //                                           fit: BoxFit.cover,
                                    //                                           placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                    //                                           errorWidget: (context, url, error) => Image.asset(
                                    //                                             "assets/images/feasturenttemp.jpeg",
                                    //                                             fit: BoxFit.cover,
                                    //                                           ),
                                    //                                         )
                                    //                                       : Image
                                    //                                           .asset(
                                    //                                           "assets/images/feasturenttemp.jpeg",
                                    //                                           height: size.height * 0.1,
                                    //                                           width: size.width * 0.26,
                                    //                                           fit: BoxFit.cover,
                                    //                                         ),
                                    //                                 ),
                                    //                               ),
                                    //                             ),
                                    //                             Positioned(
                                    //                               top:
                                    //                                   size.height *
                                    //                                       0.09,
                                    //                               bottom:
                                    //                                   size.height *
                                    //                                       0.02,
                                    //                               left:
                                    //                                   size.width *
                                    //                                       0.058,
                                    //                               right:
                                    //                                   size.width *
                                    //                                       0.058,
                                    //                               child:
                                    //                                   MaterialButton(
                                    //                                 onPressed:
                                    //                                     () async {
                                    //                                   if (status ==
                                    //                                       true) {
                                    //                                     final SharedPreferences
                                    //                                         cart =
                                    //                                         await SharedPreferences.getInstance();

                                    //                                     int vendorId =
                                    //                                         cart.getInt('VendorId');

                                    //                                     await services
                                    //                                         .data(restaurantDataCopy['Menus'][index][
                                    //                                             'id'])
                                    //                                         .then((value) =>
                                    //                                             fun(value));

                                    //                                     if (vendorId ==
                                    //                                             0 ||
                                    //                                         vendorId ==
                                    //                                             restaurantDataCopy['Menus'][index]['vendorId']) {
                                    //                                       callingLoader();

                                    //                                       if (data1
                                    //                                           .isEmpty) {
                                    //                                         if (restaurantDataCopy['Menus'][index]['AddonMenus'].isEmpty) {
                                    //                                           await addButtonFunction(tpye, index, restaurantDataCopy['Menus'][index]['totalPrice'], restaurantDataCopy['Menus'][index]['gstAmount'], 0, null, restaurantDataCopy['Menus'][index]['title'], rating);
                                    //                                         } else {
                                    //                                           tempAddOns = null;
                                    //                                           final result = await showModalBottomSheet(
                                    //                                               isScrollControlled: true,
                                    //                                               isDismissible: false,
                                    //                                               enableDrag: false,
                                    //                                               backgroundColor: Colors.transparent,
                                    //                                               context: context,
                                    //                                               builder: (context) => CustomizeMenu(
                                    //                                                     menuData: restaurantDataCopy['Menus'][index],
                                    //                                                   ));

                                    //                                           if (result != null) {
                                    //                                             if (result > 0) {
                                    //                                               int totalprice = 0;
                                    //                                               int totalgst = 0;
                                    //                                               String title;
                                    //                                               int k = restaurantDataCopy['Menus'][index]['AddonMenus'].length;
                                    //                                               for (int i = 0; i <= k - 1; i++) {
                                    //                                                 if (restaurantDataCopy['Menus'][index]['AddonMenus'][i]['id'] == result) {
                                    //                                                   setState(() {
                                    //                                                     title = "${restaurantDataCopy['Menus'][index]['AddonMenus'][i]['title']} ${restaurantDataCopy['Menus'][index]['title']}";
                                    //                                                     totalprice = restaurantDataCopy['Menus'][index]['AddonMenus'][i]['amount'] + restaurantDataCopy['Menus'][index]['AddonMenus'][i]['gstAmount'].toInt();
                                    //                                                     totalgst = restaurantDataCopy['Menus'][index]['AddonMenus'][i]['gstAmount'].toInt();
                                    //                                                   });
                                    //                                                 }
                                    //                                               }
                                    //                                               await addButtonFunction(tpye, index, totalprice, totalgst, result, tempAddOns, title, rating);
                                    //                                             } else if (result == 0) {
                                    //                                               await addButtonFunction(tpye, index, restaurantDataCopy['Menus'][index]['totalPrice'], restaurantDataCopy['Menus'][index]['gstAmount'].toInt(), 0, tempAddOns, restaurantDataCopy['Menus'][index]['title'], rating);
                                    //                                             }
                                    //                                           }
                                    //                                         }
                                    //                                       } else {
                                    //                                         if (data1[0]['menuItemId'] !=
                                    //                                             restaurantDataCopy['Menus'][index]['id']) {
                                    //                                           if (restaurantDataCopy['Menus'][index]['AddonMenus'].isEmpty) {
                                    //                                             await addButtonFunction(tpye, index, restaurantDataCopy['Menus'][index]['totalPrice'], restaurantDataCopy['Menus'][index]['gstAmount'].toInt(), 0, null, restaurantDataCopy['Menus'][index]['title'], rating);
                                    //                                           } else {
                                    //                                             tempAddOns = null;
                                    //                                             final result = await showModalBottomSheet(
                                    //                                                 isScrollControlled: true,
                                    //                                                 isDismissible: false,
                                    //                                                 enableDrag: false,
                                    //                                                 backgroundColor: Colors.transparent,
                                    //                                                 context: context,
                                    //                                                 builder: (context) => CustomizeMenu(
                                    //                                                       menuData: restaurantDataCopy['Menus'][index],
                                    //                                                     ));

                                    //                                             if (result != null) {
                                    //                                               if (result > 0) {
                                    //                                                 int totalprice = 0;
                                    //                                                 int totalgst = 0;
                                    //                                                 String title;
                                    //                                                 int k = restaurantDataCopy['Menus'][index]['AddonMenus'].length;
                                    //                                                 for (int i = 0; i <= k - 1; i++) {
                                    //                                                   title = "${restaurantDataCopy['Menus'][index]['AddonMenus'][i]['title']} ${restaurantDataCopy['Menus'][index]['title']}";
                                    //                                                   if (restaurantDataCopy['Menus'][index]['AddonMenus'][i]['id'] == result) {
                                    //                                                     setState(() {
                                    //                                                       totalprice = restaurantDataCopy['Menus'][index]['AddonMenus'][i]['amount'] + restaurantDataCopy['Menus'][index]['AddonMenus'][i]['gstAmount'].toInt();
                                    //                                                       totalgst = restaurantDataCopy['Menus'][index]['AddonMenus'][i]['gstAmount'].toInt();
                                    //                                                     });
                                    //                                                   }
                                    //                                                 }
                                    //                                                 await addButtonFunction(tpye, index, totalprice, totalgst, result, tempAddOns, title, rating);
                                    //                                               } else if (result == 0) {
                                    //                                                 await addButtonFunction(tpye, index, restaurantDataCopy['Menus'][index]['totalPrice'], restaurantDataCopy['Menus'][index]['gstAmount'].toInt(), 0, tempAddOns, restaurantDataCopy['Menus'][index]['title'], rating);
                                    //                                               }
                                    //                                             }
                                    //                                           }
                                    //                                         } else {
                                    //                                           setState(() {
                                    //                                             snackBarData = "${restaurantDataCopy['Menus'][index]['title']} is already added to cart";
                                    //                                           });
                                    //                                           print("match");
                                    //                                         }
                                    //                                       }
                                    //                                       Navigator.pop(
                                    //                                           context);
                                    //                                     } else {
                                    //                                       showDialog(
                                    //                                           context: context,
                                    //                                           builder: (BuildContext context) {
                                    //                                             return AlertDialog(content: Text("Do you want to order food from different resturent"), actions: <Widget>[
                                    //                                               TextButton(
                                    //                                                 child: Text(
                                    //                                                   "No",
                                    //                                                   style: TextStyle(color: Colors.black),
                                    //                                                 ),
                                    //                                                 onPressed: () {
                                    //                                                   Navigator.pop(context);
                                    //                                                 },
                                    //                                               ),
                                    //                                               TextButton(
                                    //                                                 child: Text(
                                    //                                                   "Yes",
                                    //                                                   style: TextStyle(color: Colors.black),
                                    //                                                 ),
                                    //                                                 onPressed: () async {
                                    //                                                   callingLoader();
                                    //                                                   removeCartForNewData();
                                    //                                                   setState(() {});
                                    //                                                   getList();
                                    //                                                   Navigator.pop(context);
                                    //                                                   Navigator.pop(context);
                                    //                                                   if (restaurantDataCopy['Menus'][index]['AddonMenus'].isEmpty) {
                                    //                                                     await addButtonFunction(tpye, index, restaurantDataCopy['Menus'][index]['totalPrice'], restaurantDataCopy['Menus'][index]['gstAmount'].toInt(), 0, null, restaurantDataCopy['Menus'][index]['title'], rating);
                                    //                                                   } else {
                                    //                                                     tempAddOns = null;
                                    //                                                     final result = await showModalBottomSheet(
                                    //                                                         isScrollControlled: true,
                                    //                                                         isDismissible: false,
                                    //                                                         enableDrag: false,
                                    //                                                         backgroundColor: Colors.transparent,
                                    //                                                         context: context,
                                    //                                                         builder: (context) => CustomizeMenu(
                                    //                                                               menuData: restaurantDataCopy['Menus'][index],
                                    //                                                             ));

                                    //                                                     if (result != null) {
                                    //                                                       if (result > 0) {
                                    //                                                         int totalprice = 0;
                                    //                                                         int totalgst = 0;
                                    //                                                         String title;
                                    //                                                         int k = restaurantDataCopy['Menus'][index]['AddonMenus'].length;
                                    //                                                         for (int i = 0; i <= k - 1; i++) {
                                    //                                                           if (restaurantDataCopy['Menus'][index]['AddonMenus'][i]['id'] == result) {
                                    //                                                             setState(() {
                                    //                                                               title = "${restaurantDataCopy['Menus'][index]['AddonMenus'][i]['title']} ${restaurantDataCopy['Menus'][index]['title']}";
                                    //                                                               totalprice = restaurantDataCopy['Menus'][index]['AddonMenus'][i]['amount'] + restaurantDataCopy['Menus'][index]['AddonMenus'][i]['gstAmount'].toInt();
                                    //                                                               totalgst = restaurantDataCopy['Menus'][index]['AddonMenus'][i]['gstAmount'].toInt();
                                    //                                                             });
                                    //                                                           }
                                    //                                                         }
                                    //                                                         await addButtonFunction(tpye, index, totalprice, totalgst, result, tempAddOns, title, rating);
                                    //                                                       } else if (result == 0) {
                                    //                                                         await addButtonFunction(tpye, index, restaurantDataCopy['Menus'][index]['totalPrice'], restaurantDataCopy['Menus'][index]['gstAmount'].toInt(), 0, tempAddOns, restaurantDataCopy['Menus'][index]['title'], rating);
                                    //                                                       }
                                    //                                                     }
                                    //                                                   }
                                    //                                                 },
                                    //                                               ),
                                    //                                             ]);
                                    //                                           });
                                    //                                     }
                                    //                                   } else {
                                    //                                     Fluttertoast.showToast(
                                    //                                         msg:
                                    //                                             "Not taking orders now");
                                    //                                   }
                                    //                                 },
                                    //                                 color: checkdata
                                    //                                         .isEmpty
                                    //                                     ? Colors
                                    //                                         .white
                                    //                                     : checkdata.contains(restaurantDataCopy['Menus'][index]['id'].toString())
                                    //                                         ? Colors.blue
                                    //                                         : Colors.white,
                                    //                                 minWidth:
                                    //                                     size.width *
                                    //                                         0.16,
                                    //                                 height: size
                                    //                                         .height *
                                    //                                     0.033,
                                    //                                 shape: RoundedRectangleBorder(
                                    //                                     borderRadius:
                                    //                                         BorderRadius.circular(14)),
                                    //                                 child: checkdata
                                    //                                         .isEmpty
                                    //                                     ? Center(
                                    //                                         child:
                                    //                                             Text(
                                    //                                           "Add",
                                    //                                           style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, color: Colors.blueGrey),
                                    //                                         ),
                                    //                                       )
                                    //                                     : checkdata.contains(restaurantDataCopy['Menus'][index]['id'].toString())
                                    //                                         ? Center(
                                    //                                             child: Text(
                                    //                                               "Added",
                                    //                                               style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, color: Colors.white),
                                    //                                             ),
                                    //                                           )
                                    //                                         : Center(
                                    //                                             child: Text(
                                    //                                               "Add",
                                    //                                               style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, color: Colors.blueGrey),
                                    //                                             ),
                                    //                                           ),
                                    //                               ),
                                    //                             )
                                    //                           ],
                                    //                         )),
                                    //                     Expanded(
                                    //                         flex: 6,
                                    //                         child: Container(
                                    //                           height:
                                    //                               size.height *
                                    //                                   0.2,
                                    //                           child: Column(
                                    //                             crossAxisAlignment:
                                    //                                 CrossAxisAlignment
                                    //                                     .start,
                                    //                             mainAxisSize:
                                    //                                 MainAxisSize
                                    //                                     .max,
                                    //                             children: [
                                    //                               Container(
                                    //                                 margin: EdgeInsets.only(
                                    //                                     top: size.height *
                                    //                                         0.01),
                                    //                                 child: Row(
                                    //                                   children: [
                                    //                                     Container(
                                    //                                       width:
                                    //                                           size.width * 0.5,
                                    //                                       child:
                                    //                                           Text(
                                    //                                         capitalize(restaurantDataCopy['Menus'][index]['title']),
                                    //                                         overflow:
                                    //                                             TextOverflow.ellipsis,
                                    //                                         style: TextStyle(
                                    //                                             fontWeight: FontWeight.bold,
                                    //                                             color: Colors.black,
                                    //                                             fontSize: size.height * 0.019),
                                    //                                       ),
                                    //                                     ),
                                    //                                     Spacer(),
                                    //                                     Padding(
                                    //                                         padding:
                                    //                                             const EdgeInsets.only(right: 12),
                                    //                                         child: restaurantDataCopy['Menus'][index]['isNonVeg'] == false
                                    //                                             ? restaurantDataCopy['Menus'][index]['isEgg'] == false
                                    //                                                 ? Container(
                                    //                                                     child: CachedNetworkImage(
                                    //                                                       imageUrl: 'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                    //                                                       height: size.height * 0.016,
                                    //                                                       errorWidget: (context, url, error) => Icon(Icons.error),
                                    //                                                     ),
                                    //                                                   )
                                    //                                                 : Container(
                                    //                                                     child: Image.asset(
                                    //                                                     "assets/images/eggeterian.png",
                                    //                                                     height: size.height * 0.016,
                                    //                                                   ))
                                    //                                             : CachedNetworkImage(
                                    //                                                 imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
                                    //                                                 height: size.height * 0.016,
                                    //                                                 errorWidget: (context, url, error) => Icon(Icons.error),
                                    //                                               ))
                                    //                                   ],
                                    //                                 ),
                                    //                               ),
                                    //                               SizedBox(
                                    //                                   height: size
                                    //                                           .height *
                                    //                                       0.005),
                                    //                               SizedBox(
                                    //                                 height: size
                                    //                                         .height *
                                    //                                     0.002,
                                    //                               ),
                                    //                               Container(
                                    //                                 child: Row(
                                    //                                   children: [
                                    //                                     Container(
                                    //                                         child:
                                    //                                             Text("⭐")),
                                    //                                     Text(
                                    //                                       "${rating.toStringAsFixed(1)}",
                                    //                                       style: TextStyle(
                                    //                                           fontSize: size.height * 0.014,
                                    //                                           color: Colors.red,
                                    //                                           fontWeight: FontWeight.bold),
                                    //                                     ),
                                    //                                     Spacer(),
                                    //                                     Container(
                                    //                                       margin:
                                    //                                           EdgeInsets.only(right: size.width * 0.1),
                                    //                                       child:
                                    //                                           Text(
                                    //                                         "₹${restaurantDataCopy['Menus'][index]['totalPrice']}",
                                    //                                         style: TextStyle(
                                    //                                             fontSize: size.height * 0.018,
                                    //                                             color: Colors.black,
                                    //                                             fontWeight: FontWeight.bold),
                                    //                                       ),
                                    //                                     ),
                                    //                                   ],
                                    //                                 ),
                                    //                               ),
                                    //                               SizedBox(
                                    //                                 height: size
                                    //                                         .height *
                                    //                                     0.003,
                                    //                               ),
                                    //                               Container(
                                    //                                 child: Container(
                                    //                                     child: restaurantDataCopy['Menus'][index]['MenuOffers'].length != 0
                                    //                                         ? Row(
                                    //                                             children: [
                                    //                                               Image.asset(
                                    //                                                 "assets/icons/discount_icon.jpg",
                                    //                                                 height: size.height * 0.02,
                                    //                                               ),
                                    //                                               SizedBox(
                                    //                                                 width: size.width * 0.006,
                                    //                                               ),
                                    //                                               Container(
                                    //                                                 child: restaurantDataCopy['Menus'][index]['MenuOffers'].length >= 2
                                    //                                                     ? Row(
                                    //                                                         children: [
                                    //                                                           restaurantDataCopy['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon'] == null
                                    //                                                               ? SizedBox()
                                    //                                                               : Text(
                                    //                                                                   " ${restaurantDataCopy['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon']}, ",
                                    //                                                                   style: TextStyle(fontSize: size.height * 0.015, color: kTextColor),
                                    //                                                                 ),
                                    //                                                           restaurantDataCopy['Menus'][index]['MenuOffers'][1]['OffersAndCoupon']['coupon'] == null
                                    //                                                               ? SizedBox()
                                    //                                                               : Text(
                                    //                                                                   " ${restaurantDataCopy['Menus'][index]['MenuOffers'][1]['OffersAndCoupon']['coupon']}",
                                    //                                                                   style: TextStyle(fontSize: size.height * 0.015, color: kTextColor),
                                    //                                                                 ),
                                    //                                                         ],
                                    //                                                       )
                                    //                                                     : restaurantDataCopy['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon'] == null
                                    //                                                         ? SizedBox()
                                    //                                                         : Text(
                                    //                                                             " ${restaurantDataCopy['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon']}",
                                    //                                                             style: TextStyle(fontSize: size.height * 0.015, color: kTextColor),
                                    //                                                           ),
                                    //                                               ),
                                    //                                             ],
                                    //                                           )
                                    //                                         : SizedBox()),
                                    //                               ),
                                    //                             ],
                                    //                           ),
                                    //                         )),
                                    //                     restaurantDataCopy['Menus']
                                    //                                     [index][
                                    //                                 'AddonMenus']
                                    //                             .isEmpty
                                    //                         ? SizedBox()
                                    //                         : RotatedBox(
                                    //                             quarterTurns:
                                    //                                 -1,
                                    //                             child: Text(
                                    //                               "Customize",
                                    //                               style: TextStyle(
                                    //                                   fontWeight:
                                    //                                       FontWeight
                                    //                                           .bold,
                                    //                                   color: Colors
                                    //                                       .black54,
                                    //                                   fontSize:
                                    //                                       size.height *
                                    //                                           0.015),
                                    //                             )),
                                    //                   ])),
                                    //   ),
                                    // );
                                  },
                                ),
                                SizedBox(
                                  height: 60,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      ////////////////
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
                                    border:
                                        Border.all(color: Colors.blueAccent),
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
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
                  )),
    );
  }

  addButtonFunction(
      tpye, index, price, gst, variantId, addOnData, name, rating) async {
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
                index, tpye, price, gst, variantId, addOnData, name, rating);
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
          if (data1[0]['menuItemId'] !=
              restaurantDataCopy['Menus'][index]['id']) {
            setState(() {
              itemAddToCart(
                  index, tpye, price, gst, variantId, addOnData, name, rating);
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
                            variantId, addOnData, name, rating);
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

  menuDesign(index, size, rating, tpye) {
    return Row(children: [
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
                    child: restaurantDataCopy['Menus'][index]['image1'] != null
                        ? CachedNetworkImage(
                            imageUrl: S3_BASE_PATH +
                                restaurantDataCopy['Menus'][index]['image1'],
                            height: size.height * 0.1,
                            width: size.width * 0.26,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Image.asset(
                              "assets/images/feasturenttemp.jpeg",
                              height: size.height * 0.1,
                              width: size.width * 0.26,
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/feasturenttemp.jpeg",
                              fit: BoxFit.cover,
                            ),
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
                left: size.width * 0.058,
                right: size.width * 0.058,
                child: MaterialButton(
                  onPressed: () async {
                    if (status == true) {
                      final SharedPreferences cart =
                          await SharedPreferences.getInstance();

                      int vendorId = cart.getInt('VendorId');

                      await services
                          .data(restaurantDataCopy['Menus'][index]['id'])
                          .then((value) => fun(value));

                      if (vendorId == 0 ||
                          vendorId ==
                              restaurantDataCopy['Menus'][index]['vendorId']) {
                        callingLoader();

                        if (data1.isEmpty) {
                          if (restaurantDataCopy['Menus'][index]['AddonMenus']
                              .isEmpty) {
                            await addButtonFunction(
                                tpye,
                                index,
                                restaurantDataCopy['Menus'][index]
                                    ['totalPrice'],
                                restaurantDataCopy['Menus'][index]['gstAmount']
                                    .toInt(),
                                0,
                                null,
                                restaurantDataCopy['Menus'][index]['title'],
                                rating);
                          } else {
                            tempAddOns = null;
                            final result = await showModalBottomSheet(
                                isScrollControlled: true,
                                isDismissible: false,
                                enableDrag: false,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => CustomizeMenu(
                                      menuData: restaurantDataCopy['Menus']
                                          [index],
                                    ));

                            if (result != null) {
                              if (result > 0) {
                                int totalprice = 0;
                                int totalgst = 0;
                                String title;
                                int k = restaurantDataCopy['Menus'][index]
                                        ['AddonMenus']
                                    .length;
                                for (int i = 0; i <= k - 1; i++) {
                                  if (restaurantDataCopy['Menus'][index]
                                          ['AddonMenus'][i]['id'] ==
                                      result) {
                                    setState(() {
                                      title =
                                          "${restaurantDataCopy['Menus'][index]['AddonMenus'][i]['title']} ${restaurantDataCopy['Menus'][index]['title']}";
                                      totalprice = restaurantDataCopy['Menus']
                                                  [index]['AddonMenus'][i]
                                              ['amount'] +
                                          restaurantDataCopy['Menus'][index]
                                                  ['AddonMenus'][i]['gstAmount']
                                              .toInt();
                                      totalgst = restaurantDataCopy['Menus']
                                                  [index]['AddonMenus'][i]
                                              ['gstAmount']
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
                                    restaurantDataCopy['Menus'][index]
                                        ['totalPrice'],
                                    restaurantDataCopy['Menus'][index]
                                            ['gstAmount']
                                        .toInt(),
                                    0,
                                    tempAddOns,
                                    restaurantDataCopy['Menus'][index]['title'],
                                    rating);
                              }
                            }
                          }
                        } else {
                          if (data1[0]['menuItemId'] !=
                              restaurantDataCopy['Menus'][index]['id']) {
                            if (restaurantDataCopy['Menus'][index]['AddonMenus']
                                .isEmpty) {
                              await addButtonFunction(
                                  tpye,
                                  index,
                                  restaurantDataCopy['Menus'][index]
                                      ['totalPrice'],
                                  restaurantDataCopy['Menus'][index]
                                          ['gstAmount']
                                      .toInt()
                                      .toInt,
                                  0,
                                  null,
                                  restaurantDataCopy['Menus'][index]['title'],
                                  rating);
                            } else {
                              tempAddOns = null;
                              final result = await showModalBottomSheet(
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  enableDrag: false,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => CustomizeMenu(
                                        menuData: restaurantDataCopy['Menus']
                                            [index],
                                      ));

                              if (result != null) {
                                if (result > 0) {
                                  int totalprice = 0;
                                  int totalgst = 0;
                                  String title;
                                  int k = restaurantDataCopy['Menus'][index]
                                          ['AddonMenus']
                                      .length;
                                  for (int i = 0; i <= k - 1; i++) {
                                    title =
                                        "${restaurantDataCopy['Menus'][index]['AddonMenus'][i]['title']} ${restaurantDataCopy['Menus'][index]['title']}";
                                    if (restaurantDataCopy['Menus'][index]
                                            ['AddonMenus'][i]['id'] ==
                                        result) {
                                      setState(() {
                                        totalprice = restaurantDataCopy['Menus']
                                                    [index]['AddonMenus'][i]
                                                ['amount'] +
                                            restaurantDataCopy['Menus'][index]
                                                        ['AddonMenus'][i]
                                                    ['gstAmount']
                                                .toInt();
                                        totalgst = restaurantDataCopy['Menus']
                                                    [index]['AddonMenus'][i]
                                                ['gstAmount']
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
                                      restaurantDataCopy['Menus'][index]
                                          ['totalPrice'],
                                      restaurantDataCopy['Menus'][index]
                                              ['gstAmount']
                                          .toInt(),
                                      0,
                                      tempAddOns,
                                      restaurantDataCopy['Menus'][index]
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
                                        if (restaurantDataCopy['Menus'][index]
                                                ['AddonMenus']
                                            .isEmpty) {
                                          await addButtonFunction(
                                              tpye,
                                              index,
                                              restaurantDataCopy['Menus'][index]
                                                  ['totalPrice'],
                                              restaurantDataCopy['Menus'][index]
                                                      ['gstAmount']
                                                  .toInt(),
                                              0,
                                              null,
                                              restaurantDataCopy['Menus'][index]
                                                  ['title'],
                                              rating);
                                        } else {
                                          tempAddOns = null;
                                          final result =
                                              await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  isDismissible: false,
                                                  enableDrag: false,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) =>
                                                      CustomizeMenu(
                                                        menuData:
                                                            restaurantDataCopy[
                                                                'Menus'][index],
                                                      ));

                                          if (result != null) {
                                            if (result > 0) {
                                              int totalprice = 0;
                                              int totalgst = 0;
                                              String title;
                                              int k =
                                                  restaurantDataCopy['Menus']
                                                          [index]['AddonMenus']
                                                      .length;
                                              for (int i = 0; i <= k - 1; i++) {
                                                if (restaurantDataCopy['Menus']
                                                                [index]
                                                            ['AddonMenus'][i]
                                                        ['id'] ==
                                                    result) {
                                                  setState(() {
                                                    title =
                                                        "${restaurantDataCopy['Menus'][index]['AddonMenus'][i]['title']} ${restaurantDataCopy['Menus'][index]['title']}";
                                                    totalprice = restaurantDataCopy[
                                                                        'Menus']
                                                                    [index]
                                                                ['AddonMenus']
                                                            [i]['amount'] +
                                                        restaurantDataCopy['Menus']
                                                                        [index][
                                                                    'AddonMenus']
                                                                [i]['gstAmount']
                                                            .toInt();
                                                    totalgst = restaurantDataCopy[
                                                                        'Menus']
                                                                    [index]
                                                                ['AddonMenus']
                                                            [i]['gstAmount']
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
                                                  restaurantDataCopy['Menus']
                                                      [index]['totalPrice'],
                                                  restaurantDataCopy['Menus']
                                                          [index]['gstAmount']
                                                      .toInt(),
                                                  0,
                                                  tempAddOns,
                                                  restaurantDataCopy['Menus']
                                                      [index]['title'],
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
                      Fluttertoast.showToast(msg: "Not taking orders now");
                    }
                  },
                  color: checkdata.isEmpty
                      ? Colors.white
                      : checkdata.contains(restaurantDataCopy['Menus'][index]
                                  ['id']
                              .toString())
                          ? Colors.blue
                          : Colors.white,
                  minWidth: size.width * 0.16,
                  height: size.height * 0.033,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  // textColor:
                  //     Colors
                  //         .white,
                  child: checkdata.isEmpty
                      ? Center(
                          child: Text(
                            "Add",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                                color: Colors.blueGrey),
                          ),
                        )
                      : checkdata.contains(restaurantDataCopy['Menus'][index]
                                  ['id']
                              .toString())
                          ? Center(
                              child: Text(
                                "Added",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                    color: Colors.white),
                              ),
                            )
                          : Center(
                              child: Text(
                                "Add",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
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
                  margin: EdgeInsets.only(top: size.height * 0.01),
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.5,
                        child: Text(
                          capitalize(
                              restaurantDataCopy['Menus'][index]['title']),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: size.height * 0.019),
                        ),
                      ),
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: restaurantDataCopy['Menus'][index]
                                      ['isNonVeg'] ==
                                  false
                              ? restaurantDataCopy['Menus'][index]['isEgg'] ==
                                      false
                                  ? Container(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                        height: size.height * 0.016,
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    )
                                  : Container(
                                      child: Image.asset(
                                      "assets/images/eggeterian.png",
                                      height: size.height * 0.016,
                                    ))
                              : CachedNetworkImage(
                                  imageUrl:
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
                                  height: size.height * 0.016,
                                  errorWidget: (context, url, error) =>
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
                      Container(child: Text("⭐")),
                      Text(
                        "${restaurantDataCopy['Menus'][index]['ReviewAndRatings'].length}",
                        style: TextStyle(
                            fontSize: size.height * 0.014,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: size.width * 0.1),
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
                      child: restaurantDataCopy['Menus'][index]['MenuOffers']
                                  .length !=
                              0
                          ? Row(
                              children: [
                                Image.asset(
                                  "assets/icons/discount_icon.jpg",
                                  height: size.height * 0.02,
                                ),
                                SizedBox(
                                  width: size.width * 0.006,
                                ),
                                Container(
                                  child: restaurantDataCopy['Menus'][index]
                                                  ['MenuOffers']
                                              .length >=
                                          2
                                      ? Row(
                                          children: [
                                            restaurantDataCopy['Menus'][index][
                                                                'MenuOffers'][0]
                                                            ['OffersAndCoupon']
                                                        ['coupon'] ==
                                                    null
                                                ? SizedBox()
                                                : Text(
                                                    " ${restaurantDataCopy['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon']}, ",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.015,
                                                        color: kTextColor),
                                                  ),
                                            restaurantDataCopy['Menus'][index][
                                                                'MenuOffers'][1]
                                                            ['OffersAndCoupon']
                                                        ['coupon'] ==
                                                    null
                                                ? SizedBox()
                                                : Text(
                                                    " ${restaurantDataCopy['Menus'][index]['MenuOffers'][1]['OffersAndCoupon']['coupon']}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.015,
                                                        color: kTextColor),
                                                  ),
                                          ],
                                        )
                                      : restaurantDataCopy['Menus'][index]
                                                          ['MenuOffers'][0]
                                                      ['OffersAndCoupon']
                                                  ['coupon'] ==
                                              null
                                          ? SizedBox()
                                          : Text(
                                              " ${restaurantDataCopy['Menus'][index]['MenuOffers'][0]['OffersAndCoupon']['coupon']}",
                                              style: TextStyle(
                                                  fontSize: size.height * 0.015,
                                                  color: kTextColor),
                                            ),
                                ),
                              ],
                            )
                          : SizedBox()),
                ),
              ],
            ),
          )),
      restaurantDataCopy['Menus'][index]['AddonMenus'].isEmpty
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
    ]);
  }

}
