import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/Place_Order/place_order.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'CartDataBase/cart_service.dart';
import 'CartDataBase/dataClass.dart';

int price = 0;

class CartScreen extends StatefulWidget {
  final data;
  CartScreen({Key key, this.data}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    createstorage();
    loginCheck();
  }

  int deliverytime = 0;
  var resturantDataStatus;
  Future fetchRestaurantStatus(id) async {
    print("******************  get resturent API hitting*********************");
    var result = await http.get(
        APP_ROUTES + 'getRestaurantInfos' + '?key=BYID&id=' + id.toString());

    if (mounted) {
      resturantStatus = json.decode(result.body)['data'];

      if (resturantStatus.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => _scaffoldKey.currentState.showSnackBar(restaurantSnackBar));
      } else {
        if (resturantStatus[0]['user']['Setting'] == null) {
          setState(() {
            status = false;
          });
          WidgetsBinding.instance.addPostFrameCallback((_) =>
              _scaffoldKey.currentState.showSnackBar(restaurantSnackBar));
        } else {
          setState(() {
            status = resturantStatus[0]['user']['Setting']['isActive'];
          });
          if (status == false) {
            WidgetsBinding.instance.addPostFrameCallback((_) =>
                _scaffoldKey.currentState.showSnackBar(restaurantSnackBar));
          } else {
            checkMenuAvailability(resturantStatus[0]['Menus']);

            setState(() {
              resturantDataStatus = resturantStatus[0]['user'];
            });
            print("#################### delivery time  $deliverytime");
            createstorage();
            setState(() {
              statusno = 0;
            });
            final result = await showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: false,
                enableDrag: false,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => PlaceOrder(
                      deliveryTime: deliverytime,
                      data: resturantDataStatus,
                    ));
            if (result) {
              setState(() {});
              createstorage();
            }
            createstorage();
          }
        }
      }

      setState(() {
        statusno = 0;
      });
    }
    // if (timeData.compareTo(resturantStatus[0]['user']['Setting']['storeTimeStart']) != 1)
    return resturantStatus;
  }

  checkMenuAvailability(resData) async {
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print("##########################################################");
    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    print(resData);
    int k = checkitem.length;
    for (int i = 0; i <= k - 1; i++) {
      int data = int.parse(checkitem[i]);
      await services.data(data).then((value) => fun(value));
      int menuID;
      setState(() {
        menuID = data1[0]['menuItemId'];
      });
      // print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      // print(
      //     "################################     storage         $menuID         ##########################");
      // print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
      for (int j = 0; j <= resData.length - 1; j++) {
        // print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        // print(
        //     "################################     server         ${resData[j]['id']}         ##########################");
        // print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
        if (resData[j]['id'] == menuID) {
          int time = resData[j]['deliveryTime'];
          print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ $time");
          if (time > deliverytime) {
            setState(() {
              deliverytime = time;
            });
          }
          print(
              "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&   availabe  &&&&&&&&&&&&&&");

          Fluttertoast.showToast(msg: " availabe");
        } else {
          print(
              "&&&&&&&&&&&&&&&&&&&&&&&& Not availabe  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");

          Fluttertoast.showToast(msg: "Not availabe");
        }
      }

      print(
          "***************************final menuID id $menuID*************************");
    }
  }

  fun(value) {
    setState(() {
      data1 = value;
    });
  }

  int statusno = 0;

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

  List<String> checkitem = [];

  createstorage() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      checkitem = cart.getStringList('addedtocart');

      totalprice1 = cart.getInt('TotalPrice');
      gsttotal1 = cart.getInt('TotalGst');
      totalcount1 = cart.getInt('TotalCount');
      vendorId1 = cart.getInt('VendorId');
    });
    print("list");
    print(checkitem);
  }

  int gsttotal1;
  int totalprice1;
  int totalcount1;
  int vendorId1;
  final services = UserServices();

  final _textstyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pop(context, true);
      },
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: false,
            title: Text(
              "Cart",
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              children: [
                Expanded(
                  child: Column(children: [
                    Expanded(
                      child: Container(
                          child: FutureBuilder(
                              future: services.fetchUsers(),
                              builder: (ctx, snap) {
                                List<AddToCart> users = snap.data;
                                if (!snap.hasData) {
                                  return Center(
                                    child: Text('No data found'),
                                  );
                                } else {
                                  return ListView.builder(
                                      itemCount: users.length,
                                      shrinkWrap: true,
                                      itemBuilder: (
                                        context,
                                        index,
                                      ) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 2,
                                                        color: Colors.blue[50],
                                                        offset: Offset(1, 4),
                                                        spreadRadius: 2)
                                                  ]),
                                              child: Dismissible(
                                                direction:
                                                    DismissDirection.endToStart,
                                                // ignore: missing_return
                                                confirmDismiss:
                                                    (direction) async {
                                                  if (direction ==
                                                      DismissDirection
                                                          .endToStart) {
                                                    final bool res =
                                                        await showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                content: Text(
                                                                    "Are you sure you want to delete ${users[index].itemName}?"),
                                                                actions: <
                                                                    Widget>[
                                                                  FlatButton(
                                                                    child: Text(
                                                                      "Cancel",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      print(users[
                                                                              index]
                                                                          .menuItemId
                                                                          .toString());
                                                                    },
                                                                  ),
                                                                  FlatButton(
                                                                    child: Text(
                                                                      "Delete",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      callingLoader();

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

                                                                      if (users[index]
                                                                              .itemCount ==
                                                                          totalcount) {
                                                                        setState(
                                                                            () {
                                                                          totalcount =
                                                                              totalcount - users[index].itemCount;
                                                                          gsttotal =
                                                                              gsttotal - (users[index].itemCount * users[index].gst);
                                                                          totalprice =
                                                                              totalprice - (users[index].itemCount * users[index].itemPrice);
                                                                          vendorId =
                                                                              0;

                                                                          cart.setInt(
                                                                              'VendorId',
                                                                              vendorId);
                                                                          cart.setInt(
                                                                              'TotalPrice',
                                                                              totalprice);
                                                                          cart.setInt(
                                                                              'TotalGst',
                                                                              gsttotal);
                                                                          cart.setInt(
                                                                              'TotalCount',
                                                                              totalcount);
                                                                          services
                                                                              .deleteUser(users[index].menuItemId);
                                                                          checkitem.remove(users[index]
                                                                              .menuItemId
                                                                              .toString());
                                                                          print(
                                                                              checkitem);
                                                                          cart.setStringList(
                                                                              'addedtocart',
                                                                              checkitem);
                                                                          print(
                                                                              checkitem);
                                                                        });
                                                                      } else {
                                                                        setState(
                                                                            () {
                                                                          totalcount =
                                                                              totalcount - users[index].itemCount;
                                                                          gsttotal =
                                                                              gsttotal - (users[index].itemCount * users[index].gst);
                                                                          totalprice =
                                                                              totalprice - (users[index].itemCount * users[index].itemPrice);

                                                                          cart.setInt(
                                                                              'TotalPrice',
                                                                              totalprice);
                                                                          cart.setInt(
                                                                              'TotalGst',
                                                                              gsttotal);
                                                                          cart.setInt(
                                                                              'TotalCount',
                                                                              totalcount);
                                                                          services
                                                                              .deleteUser(users[index].menuItemId);
                                                                          checkitem.remove(users[index]
                                                                              .menuItemId
                                                                              .toString());
                                                                          print(
                                                                              checkitem);
                                                                          cart.setStringList(
                                                                              'addedtocart',
                                                                              checkitem);
                                                                          print(
                                                                              checkitem);
                                                                        });
                                                                      }
                                                                      await Future.delayed(Duration(
                                                                          seconds:
                                                                              1));
                                                                      setState(
                                                                          () {});
                                                                      createstorage();
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator.pop(
                                                                          context);
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
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                            width: size.width *
                                                                0.69,
                                                            height:
                                                                size.height *
                                                                    0.128,
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  flex: 0,
                                                                  child: Container(
                                                                      alignment: Alignment.topLeft,
                                                                      height: size.height * 0.2,
                                                                      child: Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                4,
                                                                            right:
                                                                                4,
                                                                            top:
                                                                                4),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          child: users[index].imagePath != null
                                                                              ? CachedNetworkImage(
                                                                                  imageUrl: S3_BASE_PATH + users[index].imagePath,
                                                                                  height: size.height * 0.1,
                                                                                  width: size.width * 0.26,
                                                                                  fit: BoxFit.cover,
                                                                                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
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
                                                                      )),
                                                                ),
                                                                Expanded(
                                                                    child:
                                                                        Container(
                                                                  margin: EdgeInsets.only(
                                                                      left: size
                                                                              .width *
                                                                          0.01),
                                                                  height:
                                                                      size.height *
                                                                          0.2,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        margin:
                                                                            EdgeInsets.only(
                                                                          top:
                                                                              6,
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: size.width * 0.3,
                                                                              child: Text(
                                                                                users[index].itemName,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
                                                                              ),
                                                                            ),
                                                                            Spacer(),
                                                                            Padding(
                                                                                padding: const EdgeInsets.only(right: 12),
                                                                                child: users[index].itemtype == 3
                                                                                    ? CachedNetworkImage(
                                                                                        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
                                                                                        height: size.height * 0.016,
                                                                                      )
                                                                                    : users[index].itemtype == 2
                                                                                        ? Container(
                                                                                            child: Image.asset(
                                                                                            "assets/images/eggeterian.png",
                                                                                            height: size.height * 0.016,
                                                                                          ))
                                                                                        : Container(
                                                                                            child: CachedNetworkImage(
                                                                                              imageUrl: 'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                                                                              height: size.height * 0.016,
                                                                                            ),
                                                                                          ))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            7,
                                                                      ),
                                                                      Container(
                                                                        width: size.width *
                                                                            0.3,
                                                                        child:
                                                                            Text(
                                                                          users[index]
                                                                              .vendorName,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black,
                                                                              fontSize: 11),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Container(child: Text("⭐")),
                                                                            Text(
                                                                              "3.0",
                                                                              style: TextStyle(fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 45,
                                                                            ),
                                                                            Text(
                                                                              "₹ ${users[index].itemPrice}",
                                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 20,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      padding: EdgeInsets.only(
                                                          right: 0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              blurRadius: 2,
                                                              spreadRadius: 2,
                                                              color: Colors
                                                                  .grey[300],
                                                              offset:
                                                                  Offset(0, 3))
                                                        ],
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          right:
                                                              size.width * 0.0),
                                                      child: ButtonBar(
                                                        buttonPadding:
                                                            EdgeInsets.all(3),
                                                        children: [
                                                          InkWell(
                                                              onTap: () async {
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

                                                                if (users[index]
                                                                        .itemCount >
                                                                    1) {
                                                                  callingLoader();

                                                                  setState(() {
                                                                    totalcount--;

                                                                    gsttotal = gsttotal -
                                                                        users[index]
                                                                            .gst;
                                                                    totalprice =
                                                                        totalprice -
                                                                            users[index].itemPrice;
                                                                    services.decrementItemCounter(
                                                                        users[index]
                                                                            .id,
                                                                        users[index]
                                                                            .itemCount);

                                                                    cart.setInt(
                                                                        'TotalPrice',
                                                                        totalprice);
                                                                    cart.setInt(
                                                                        'TotalGst',
                                                                        gsttotal);
                                                                    cart.setInt(
                                                                        'TotalCount',
                                                                        totalcount);
                                                                  });
                                                                  await Future.delayed(
                                                                      Duration(
                                                                          seconds:
                                                                              1));
                                                                  setState(
                                                                      () {});
                                                                  Navigator.pop(
                                                                      context);
                                                                } else if (users[
                                                                            index]
                                                                        .itemCount ==
                                                                    1) {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          content:
                                                                              Text("Are you sure you want to delete ${users[index].itemName}?"),
                                                                          actions: <
                                                                              Widget>[
                                                                            FlatButton(
                                                                              child: Text(
                                                                                "Cancel",
                                                                                style: TextStyle(color: Colors.black),
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                            FlatButton(
                                                                              child: Text(
                                                                                "Delete",
                                                                                style: TextStyle(color: Colors.red),
                                                                              ),
                                                                              onPressed: () async {
                                                                                callingLoader();

                                                                                final SharedPreferences cart = await SharedPreferences.getInstance();
                                                                                int totalprice = cart.getInt('TotalPrice');
                                                                                int gsttotal = cart.getInt('TotalGst');
                                                                                int totalcount = cart.getInt('TotalCount');
                                                                                int vendorId = cart.getInt('VendorId');

                                                                                if (users[index].itemCount == totalcount) {
                                                                                  setState(() {
                                                                                    totalcount = totalcount - users[index].itemCount;
                                                                                    gsttotal = gsttotal - (users[index].itemCount * users[index].gst);
                                                                                    totalprice = totalprice - (users[index].itemCount * users[index].itemPrice);
                                                                                    vendorId = 0;

                                                                                    cart.setInt('VendorId', vendorId);
                                                                                    cart.setInt('TotalPrice', totalprice);
                                                                                    cart.setInt('TotalGst', gsttotal);
                                                                                    cart.setInt('TotalCount', totalcount);
                                                                                    services.deleteUser(users[index].menuItemId);
                                                                                    checkitem.remove(users[index].menuItemId.toString());
                                                                                    print(checkitem);
                                                                                    cart.setStringList('addedtocart', checkitem);
                                                                                    print(checkitem);
                                                                                  });
                                                                                } else {
                                                                                  setState(() {
                                                                                    totalcount = totalcount - users[index].itemCount;
                                                                                    gsttotal = gsttotal - (users[index].itemCount * users[index].gst);
                                                                                    totalprice = totalprice - (users[index].itemCount * users[index].itemPrice);

                                                                                    cart.setInt('TotalPrice', totalprice);
                                                                                    cart.setInt('TotalGst', gsttotal);
                                                                                    cart.setInt('TotalCount', totalcount);
                                                                                    services.deleteUser(users[index].menuItemId);
                                                                                    checkitem.remove(users[index].menuItemId.toString());
                                                                                    print(checkitem);
                                                                                    cart.setStringList('addedtocart', checkitem);
                                                                                    print(checkitem);
                                                                                  });
                                                                                }
                                                                                await Future.delayed(Duration(seconds: 1));
                                                                                setState(() {});
                                                                                createstorage();

                                                                                Navigator.of(context).pop();
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      });
                                                                }
                                                                createstorage();
                                                              },
                                                              child: Icon(Icons
                                                                  .remove)),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                              "${users[index].itemCount}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          InkWell(
                                                            child:
                                                                Icon(Icons.add),
                                                            onTap: () async {
                                                              callingLoader();

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

                                                              setState(() {
                                                                totalcount++;

                                                                gsttotal = gsttotal +
                                                                    users[index]
                                                                        .gst;
                                                                totalprice =
                                                                    totalprice +
                                                                        users[index]
                                                                            .itemPrice;
                                                                services
                                                                    .incrementItemCounter(
                                                                        users[index]
                                                                            .id,
                                                                        users[index]
                                                                            .itemCount)
                                                                    .then((value) =>
                                                                        fun(value));

                                                                cart.setInt(
                                                                    'TotalPrice',
                                                                    totalprice);
                                                                cart.setInt(
                                                                    'TotalGst',
                                                                    gsttotal);
                                                                cart.setInt(
                                                                    'TotalCount',
                                                                    totalcount);
                                                              });
                                                              await Future.delayed(
                                                                  Duration(
                                                                      seconds:
                                                                          1));
                                                              setState(() {});
                                                              print(
                                                                  "@@@@@@@hjjjjjjjjjjjjjjjjjj@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                                                              Navigator.pop(
                                                                  context);
                                                              createstorage();
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }
                              })),
                    ),
                    Divider(
                      thickness: 5,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 9.0),
                        child: Text(
                          "PRICE DETAILS",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 9,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  "Price",
                                  style: _textstyle,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: Text(
                                  "₹${totalprice1 - gsttotal1}",
                                  style: _textstyle,
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  "GST added",
                                  style: _textstyle,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: Text(
                                  "+₹$gsttotal1",
                                  style: TextStyle(
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.w700),
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          // Total Price
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Total Price ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      "(Selected Items)",
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: Text(
                                  "₹$totalprice1",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ]),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        blurRadius: 2, color: Colors.grey[300], spreadRadius: 2)
                  ]),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 4),
                            child: Text(
                              " Total no.of Items",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "$totalcount1",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: MaterialButton(
                          onPressed: () {
                            print(
                                "5555555555555555555555555555555555555555555544444444444******************$vendorId1");
                            if (checkdata == 1) {
                              if (totalprice1 != 0) {
                                if (totalcount1 != 0) {
                                  print("vendor id $vendorId1");

                                  if (statusno == 0) {
                                    setState(() {
                                      statusno = 1;
                                    });
                                    fetchRestaurantStatus(vendorId1);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Placing order...");
                                  }

                                  print("sqllite Id $checkitem");
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Please add any item to place order");
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please add any item to place order");
                              }
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            }
                          },
                          child: checkdata == 1
                              ? statusno == 1
                                  ? Text("Place order...")
                                  : Text("Place Order  ₹ $totalprice1")
                              : Text("Login"),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: Colors.blue[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  callingLoader() {
    showDialog(
        barrierDismissible: false,
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

  var checkdata;
  loginCheck() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('_isAuthenticate') != null) {
      if (prefs.getBool('_isAuthenticate')) {
        setState(() {
          checkdata = 1;
        });
      } else {
        setState(() {
          checkdata = 0;
        });
      }
    } else {
      setState(() {
        checkdata = 0;
      });
    }
  }
}
