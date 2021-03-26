import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:feasturent_costomer_app/components/Bottomsheet/offerBottomsheet.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/ResturentInfo/resturentDetail.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/offerpage.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/tandooriScreen.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/home-screen.dart';
import 'package:feasturent_costomer_app/screens/home/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart ' as http;
import 'dart:convert';

var infodata;

class OfferListPage extends StatefulWidget {
  final restaurantDa;
  const OfferListPage({Key key, this.restaurantDa}) : super(key: key);

  @override
  _OfferListPageState createState() => _OfferListPageState();
}

class _OfferListPageState extends State<OfferListPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      infodata = widget.restaurantDa;
      restaurantDataCopy = widget.restaurantDa;
    });
    calculateDeliveryTime(restaurantDataCopy);
    getList();
    fetchRestaurantStatus();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double timeTake = 0;
  calculateDeliveryTime(restaurantDataCopy) {
    int k = restaurantDataCopy['Menus'].length;
    for (int i = 0; i <= k - 1; i++) {
      timeTake = timeTake + restaurantDataCopy['Menus'][i]['deliveryTime'];
    }
    timeTake = timeTake / k;

    deliverTime = timeTake.toInt();
    print("dilebvtimr  $deliverTime");
  }

  int deliverTime;
  Future fetchRestaurantStatus() async {
    int id = restaurantDataCopy['id'] as int;
    if (restaurantDataCopy['user']['Setting'] == null) {
      status = false;
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => _scaffoldKey.currentState.showSnackBar(restaurantSnackBar));
    } else {
      status = restaurantDataCopy['user']['Setting']['isActive'];
      if (status == false) {
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => _scaffoldKey.currentState.showSnackBar(restaurantSnackBar));
      } else {
        var result = await http.get(APP_ROUTES +
            'getRestaurantInfos' +
            '?key=BYID&id=' +
            id.toString());
        var hours = DateTime.now().hour;

        var mintue = DateTime.now().minute;
        // var timeData = "$hours:$mintue" ;
        // print(timeData);
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
                  _scaffoldKey.currentState.showSnackBar(restaurantSnackBar));
            }
          }
        });
      }
    }

    // if (timeData.compareTo(resturantStatus[0]['user']['Setting']['storeTimeStart']) != 1)
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
    });
    print(checkdata);
  }

  final services = UserServices();
  int typefood = 0;
  int isSelect = 0;
  var restaurantDataCopy;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          floatingActionButton: restaurantDataCopy['VendorCategories'].length ==
                  0
              ? Container()
              : MaterialButton(
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
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
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
                                      },
                                      child: ListTile(
                                        enabled: true,
                                        selected: index == isSelect,
                                        title: Text(
                                          restaurantDataCopy['VendorCategories']
                                              [index]['title'],
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
          appBar: AppBar(
              backgroundColor: Colors.white,
              actions: [
                FlatButton(
                  child: Text(
                    "More Info..",
                    style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.017),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResturentDetail(
                            restaurantDataInfo: restaurantDataCopy,
                          ),
                          // settings: RouteSettings(
                          //   arguments: restaurantDataCopy,
                          // ),
                        ));
                  },
                )
              ],
              title: Text(
                restaurantDataCopy['name'],
                // resturentIndex.title,
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
                      MaterialPageRoute(
                          builder: (context) => OfferPageScreen()),
                    );
                  })),
          body: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  restaurantDataCopy['type'] == null
                      ? SizedBox()
                      : Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: size.width * 0.03,
                              ),
                              width: size.width * 0.5,
                              child: Text(
                                restaurantDataCopy['type'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.005,
                            ),
                          ],
                        ),
                  Row(
                    children: [
                      Container(
                          width: size.height * 0.22,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: size.width * 0.033),
                          child: Text(
                            restaurantDataCopy['Address']['address'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                // fontSize: size.height * 0.016,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          )),
                      Spacer(),
                      InkWell(
                        onTap: () async {
                          var url = 'tel:${restaurantDataCopy['contact']}';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(
                              top: size.height * 0.01,
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
                    height: size.height * 0.034,
                  ),
                  DottedLine(),
                  SizedBox(
                    height: size.height * 0.024,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    isReadOnly: false,
                                    defaultIconData: Icons.star_border_outlined,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_border,
                                    color: Colors.black,
                                    borderColor: Colors.black,
                                    spacing: 0.0),
                              ),
                              Text(
                                "4.1",
                                style: offerRowHeadingStyle,
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(left: size.width * 0.04),
                              child: Text(
                                "Taste 80%",
                                style: offerCommonStyle,
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
                          ? SizedBox()
                          : Container(
                              margin: EdgeInsets.only(right: size.width * 0.02),
                              child: Column(
                                children: [
                                  Text("₹ ${restaurantDataCopy['avgCost']}",
                                      style: offerRowHeadingStyle),
                                  Text(
                                      "Cost for ${restaurantDataCopy['forPeople']}")
                                ],
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  DottedLine(),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  // List of Discounts
                  restaurantDataCopy['user']['OffersAndCoupons'].isEmpty
                      ? SizedBox()
                      : Container(
                          height: size.height * 0.08,
                          child: ListView.builder(
                            itemCount: restaurantDataCopy['user']
                                    ['OffersAndCoupons']
                                .length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => OnOfferBottomSheet(
                                            data: restaurantDataCopy['user']
                                                ['OffersAndCoupons'][index],
                                          ));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(4),
                                  padding: EdgeInsets.all(4),
                                  height: size.height * 0.1,
                                  width: size.width * 0.42,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 3,
                                          color: Colors.blue[50],
                                          offset: Offset(1, 3),
                                          spreadRadius: 3)
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: size.width * 0.02,
                                                top: size.height * 0.012),
                                            child: SvgPicture.asset(
                                              "assets/icons/offer.svg",
                                              width: size.width * 0.04,
                                            )),
                                        SizedBox(
                                          width: size.width * 0.02,
                                        ),
                                        Container(
                                          width: size.width * 0.3,
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.002,
                                              top: size.height * 0.01),
                                          child: Text(
                                            "${restaurantDataCopy['user']['OffersAndCoupons'][index]['description']}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: size.height * 0.015,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(
                                            left: size.width * 0.08,
                                            top: size.height * 0.002),
                                        child: Text(
                                          "Use ${restaurantDataCopy['user']['OffersAndCoupons'][index]['coupon']}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: size.height * 0.014),
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
                          margin: EdgeInsets.only(left: size.width * 0.02),
                          child: ClipOval(
                            child: Icon(
                              Icons.hourglass_bottom_rounded,
                              color: Colors.lightBlue,
                            ),
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
                                  "Offline",
                                  style: offerRowHeadingStyle,
                                ))
                    ],
                  )),
                  SizedBox(
                    height: size.height * 0.055,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: size.width * 0.05),
                      child: Text("Recommended", style: offerRecommendStyle)),

                  SizedBox(
                    height: size.height * 0.022,
                  ),

                  // List 1
                  ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: restaurantDataCopy['Menus'].length,
                    itemBuilder: (context, index) {
                      int tpye = 0;

                      return InkWell(
                        onTap: () {
                          var menuD;
                          setState(() {
                            menuD = restaurantDataCopy['Menus'][index];
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoodSlider(
                                        menuData: menuD,
                                        menuStatus: status,
                                        restaurentName:
                                            restaurantDataCopy['name'],
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: status == true
                                      ? Colors.white
                                      : Colors.blue[50],
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
                              child: Dismissible(
                                direction: DismissDirection.endToStart,
                                // ignore: missing_return
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    final bool res = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Text(
                                                "Are you sure you want to delete ${restaurantDataCopy['Menus'][index]['title']}?"),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              FlatButton(
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                onPressed: () async {
                                                  print(restaurantDataCopy[
                                                      'Menus'][index]['id']);
                                                  await services
                                                      .data(restaurantDataCopy[
                                                          'Menus'][index]['id'])
                                                      .then((value) =>
                                                          fun(value));

                                                  final SharedPreferences cart =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  if (idCheck.contains(
                                                      data1[0]['id'])) {
                                                    setState(() {
                                                      countSum = countSum -
                                                          data1[0]['itemCount'];
                                                      totalPrice = totalPrice -
                                                          (data1[0][
                                                                  'itemCount'] *
                                                              data1[0][
                                                                  'itemPrice']);
                                                      price = price -
                                                          (data1[0][
                                                                  'itemCount'] *
                                                              data1[0][
                                                                  'itemPrice']);
                                                      cart.setInt(
                                                          'price', price);
                                                      services.deleteUser(
                                                          data1[0]['id']);
                                                      idCheck.remove(
                                                          data1[0]['id']);
                                                      vendorIdCheck.remove(
                                                          data1[0]['vendorId']);
                                                      checkdata.remove(data1[0]
                                                              ['menuItemId']
                                                          .toString());
                                                      print(checkdata);
                                                      cart.setStringList(
                                                          'addedtocart',
                                                          checkdata);
                                                    });

                                                    Navigator.pop(context);
                                                  } else {
                                                    setState(() {
                                                      services.deleteUser(
                                                          data1[0]['id']);
                                                      checkdata.remove(data1[0]
                                                              ['menuItemId']
                                                          .toString());
                                                      print(checkdata);
                                                      cart.setStringList(
                                                          'addedtocart',
                                                          checkdata);
                                                      print(checkdata);
                                                      price = price -
                                                          (data1[0][
                                                                  'itemCount'] *
                                                              data1[0][
                                                                  'itemPrice']);
                                                      cart.setInt(
                                                          'price', price);
                                                    });

                                                    Navigator.pop(context);
                                                  }
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: restaurantDataCopy[
                                                                'Menus'][index]
                                                            ['image1'] !=
                                                        null
                                                    ? CachedNetworkImage(
                                                        imageUrl: S3_BASE_PATH +
                                                            restaurantDataCopy[
                                                                        'Menus']
                                                                    [index]
                                                                ['image1'],
                                                        height:
                                                            size.height * 0.1,
                                                        width:
                                                            size.width * 0.26,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                          "assets/images/feasturenttemp.jpeg",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : Image.asset(
                                                        "assets/images/feasturenttemp.jpeg",
                                                        height:
                                                            size.height * 0.1,
                                                        width:
                                                            size.width * 0.26,
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
                                                      await SharedPreferences
                                                          .getInstance();
                                                  if (restaurantDataCopy[
                                                              'Menus'][index]
                                                          ['isNonVeg'] ==
                                                      false) {
                                                    if (restaurantDataCopy[
                                                                'Menus'][index]
                                                            ['isEgg'] ==
                                                        false) {
                                                      tpye = 1;
                                                    } else {
                                                      tpye = 2;
                                                    }
                                                  } else {
                                                    tpye = 3;
                                                  }

                                                  await services
                                                      .data(restaurantDataCopy[
                                                          'Menus'][index]['id'])
                                                      .then((value) =>
                                                          fun(value));
                                                  if (data1.isEmpty) {
                                                    setState(() {
                                                      itemAddToCart(
                                                          index, tpye);
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "${restaurantDataCopy['Menus'][index]['title']} Added");
                                                      checkdata.add(
                                                          restaurantDataCopy[
                                                                      'Menus']
                                                                  [index]['id']
                                                              .toString());
                                                      cart.setStringList(
                                                          'addedtocart',
                                                          checkdata);
                                                    });

                                                    final snackBar = SnackBar(
                                                      duration:
                                                          Duration(seconds: 1),
                                                      backgroundColor: Colors
                                                          .lightBlueAccent[200],
                                                      content: Text(
                                                          "${restaurantDataCopy['Menus'][index]['title']} is added to cart"),
                                                      action: SnackBarAction(
                                                        textColor:
                                                            Colors.redAccent,
                                                        label: "View Cart",
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          CartScreen()));
                                                        },
                                                      ),
                                                    );

                                                    Scaffold.of(context)
                                                        .showSnackBar(snackBar);
                                                  } else {
                                                    if (data1[0]['itemName'] !=
                                                        restaurantDataCopy[
                                                                'Menus'][index]
                                                            ['title']) {
                                                      setState(() {
                                                        itemAddToCart(
                                                            index, tpye);
                                                        checkdata.add(
                                                            restaurantDataCopy[
                                                                        'Menus']
                                                                    [
                                                                    index]['id']
                                                                .toString());
                                                        cart.setStringList(
                                                            'addedtocart',
                                                            checkdata);
                                                      });

                                                      Fluttertoast.showToast(
                                                          msg: "Item Added");
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "${restaurantDataCopy['Menus'][index]['title']} is already added");

                                                      print("match");
                                                    }
                                                  }
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Not taking orders now");
                                                }
                                              },
                                              color: Colors.white,
                                              minWidth: size.width * 0.16,
                                              height: size.height * 0.033,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14)),
                                              textColor: Colors.white,
                                              child: checkdata.isEmpty
                                                  ? Center(
                                                      child: Text(
                                                        "Add",
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.015,
                                                            color: Colors
                                                                .blueGrey),
                                                      ),
                                                    )
                                                  : checkdata.contains(
                                                          restaurantDataCopy[
                                                                      'Menus']
                                                                  [index]['id']
                                                              .toString())
                                                      ? Center(
                                                          child: Text(
                                                            "Added",
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.015,
                                                                color: Colors
                                                                    .blueGrey),
                                                          ),
                                                        )
                                                      : Center(
                                                          child: Text(
                                                            "Add",
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
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
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: size.height * 0.01),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    restaurantDataCopy['Menus']
                                                        [index]['title'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: size.height *
                                                            0.019),
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 12),
                                                      child: restaurantDataCopy[
                                                                          'Menus']
                                                                      [index][
                                                                  'isNonVeg'] ==
                                                              false
                                                          ? restaurantDataCopy[
                                                                              'Menus']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'isEgg'] ==
                                                                  false
                                                              ? Container(
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl:
                                                                        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                                                    height: size
                                                                            .height *
                                                                        0.016,
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  child: Image
                                                                      .asset(
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
                                                height: size.height * 0.005),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: restaurantDataCopy[
                                                                            'Menus']
                                                                        [index]
                                                                    ['Category']
                                                                ['iconImage'] ==
                                                            "null"
                                                        ? Image.asset(
                                                            "assets/icons/discount_icon.jpg",
                                                            height:
                                                                size.height *
                                                                    0.02,
                                                          )
                                                        : SizedBox(),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.006,
                                                  ),
                                                  Text(
                                                    restaurantDataCopy['Menus']
                                                            [index]['Category']
                                                        ['name'],
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.014,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.002,
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Container(child: Text("⭐")),
                                                  Text(
                                                    "3.0",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.014,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            size.width * 0.1),
                                                    child: Text(
                                                      "₹${restaurantDataCopy['Menus'][index]['totalPrice']}",
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.height *
                                                                  0.018,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                  child: restaurantDataCopy[
                                                                          'Menus']
                                                                      [index]
                                                                  ['MenuOffers']
                                                              .length !=
                                                          0
                                                      ? Row(
                                                          children: [
                                                            Image.asset(
                                                              "assets/icons/discount_icon.jpg",
                                                              height:
                                                                  size.height *
                                                                      0.02,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.006,
                                                            ),
                                                            Container(
                                                              child: restaurantDataCopy['Menus'][index]
                                                                              [
                                                                              'MenuOffers']
                                                                          .length >=
                                                                      2
                                                                  ? Row(
                                                                      children: [
                                                                        Text(
                                                                          "OfferID ${restaurantDataCopy['Menus'][index]['MenuOffers'][0]['offerId']}, ",
                                                                          style: TextStyle(
                                                                              fontSize: size.height * 0.015,
                                                                              color: kTextColor),
                                                                        ),
                                                                        Text(
                                                                          "OfferID ${restaurantDataCopy['Menus'][index]['MenuOffers'][1]['offerId']}",
                                                                          style: TextStyle(
                                                                              fontSize: size.height * 0.015,
                                                                              color: kTextColor),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : Text(
                                                                      "OfferID ${restaurantDataCopy['Menus'][index]['MenuOffers'][0]['offerId']}",
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
                                      ))
                                ]),
                              )),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              )
            ],
          )),
    );
  }

  itemAddToCart(index, tpye) async {
    final SharedPreferences cart = await SharedPreferences.getInstance();

    var sum = cart.getInt('price');
    sum = sum + restaurantDataCopy['Menus'][index]['totalPrice'];
    cart.setInt('price', sum);
    print(sum);
    setState(() {
      // itemCount.add(value)
      services.saveUser(
        restaurantDataCopy['Menus'][index]['totalPrice'],
        1,
        restaurantDataCopy['Menus'][index]['vendorId'],
        restaurantDataCopy['Menus'][index]['id'],
        restaurantDataCopy['Menus'][index]['image1'],
        restaurantDataCopy['Menus'][index]['title'],
        "Add".toString(),
        tpye,
        0,
        restaurantDataCopy['name'],
      );
    });
  }

  fun(value) {
    setState(() {
      data1 = value;
    });
  }
}
