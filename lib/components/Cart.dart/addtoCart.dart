import 'package:cached_network_image/cached_network_image.dart';
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
    getList();
  }

  List<String> checkitem = [];
  getList() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      checkitem = cart.getStringList('addedtocart');
    });
    print("list");
    print(checkitem);
  }

  createstorage() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      price = cart.getInt('price');
    });
  }

  final services = UserServices();

  final _textstyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              Navigator.pop(context, () {
                setState(() {});
              });
            },
          ),
        ),
        body: Column(
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
                                        onTap: () {
                                          if (idCheck.isEmpty) {
                                            setState(() {
                                              totalPrice = totalPrice +
                                                  (users[index].itemCount *
                                                      users[index].itemPrice);
                                              countSum = countSum +
                                                  users[index].itemCount;
                                              idCheck.add(users[index].id);
                                              vendorIdCheck
                                                  .add(users[index].vendorId);
                                            });
                                            Fluttertoast.showToast(
                                                msg: "selected");
                                          } else {
                                            if (idCheck
                                                .contains(users[index].id)) {
                                              setState(() {
                                                totalPrice = totalPrice -
                                                    (users[index].itemCount *
                                                        users[index].itemPrice);
                                                countSum = countSum -
                                                    users[index].itemCount;
                                                idCheck.remove(users[index].id);
                                                vendorIdCheck.remove(
                                                    users[index].vendorId);
                                              });
                                              Fluttertoast.showToast(
                                                  msg: "Unselected");
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "selected");
                                              setState(() {
                                                totalPrice = totalPrice +
                                                    (users[index].itemCount *
                                                        users[index].itemPrice);
                                                countSum = countSum +
                                                    users[index].itemCount;
                                                idCheck.add(users[index].id);
                                                vendorIdCheck
                                                    .add(users[index].vendorId);
                                              });
                                            }
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: idCheck
                                                      .contains(users[index].id)
                                                  ? Colors.grey[300]
                                                  : Colors.white,
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
                                            confirmDismiss: (direction) async {
                                              if (direction ==
                                                  DismissDirection.endToStart) {
                                                final bool res =
                                                    await showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            content: Text(
                                                                "Are you sure you want to delete ${users[index].itemName}?"),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                child: Text(
                                                                  "Cancel",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onPressed: () {
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
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  final SharedPreferences
                                                                      cart =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  if (idCheck.contains(
                                                                      users[index]
                                                                          .id)) {
                                                                    setState(
                                                                        () {
                                                                      countSum =
                                                                          countSum -
                                                                              users[index].itemCount;
                                                                      totalPrice =
                                                                          totalPrice -
                                                                              (users[index].itemCount * users[index].itemPrice);
                                                                      price = price -
                                                                          (users[index].itemCount *
                                                                              users[index].itemPrice);
                                                                      cart.setInt(
                                                                          'price',
                                                                          price);
                                                                      services.deleteUser(
                                                                          users[index]
                                                                              .id);
                                                                      checkitem.remove(users[
                                                                              index]
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

                                                                    Navigator.pop(
                                                                        context);
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      services.deleteUser(
                                                                          users[index]
                                                                              .id);
                                                                      checkitem.remove(users[
                                                                              index]
                                                                          .menuItemId
                                                                          .toString());
                                                                      print(
                                                                          checkitem);
                                                                      cart.setStringList(
                                                                          'addedtocart',
                                                                          checkitem);
                                                                      print(
                                                                          checkitem);
                                                                      price = price -
                                                                          (users[index].itemCount *
                                                                              users[index].itemPrice);
                                                                      cart.setInt(
                                                                          'price',
                                                                          price);
                                                                    });

                                                                    Navigator.pop(
                                                                        context);
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
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        width:
                                                            size.width * 0.69,
                                                        height:
                                                            size.height * 0.128,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 0,
                                                              child: Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  height:
                                                                      size.height *
                                                                          0.2,
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: 4,
                                                                        right:
                                                                            4,
                                                                        top: 4),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      child: users[index].imagePath !=
                                                                              null
                                                                          ? CachedNetworkImage(
                                                                              imageUrl: S3_BASE_PATH + users[index].imagePath,
                                                                              height: size.height * 0.1,
                                                                              width: size.width * 0.26,
                                                                              fit: BoxFit.cover,
                                                                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                                                            )
                                                                          : Image
                                                                              .asset(
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
                                                              margin: EdgeInsets
                                                                  .only(
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
                                                                        EdgeInsets
                                                                            .only(
                                                                      top: 6,
                                                                    ),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          users[index]
                                                                              .itemName,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black,
                                                                              fontSize: 14),
                                                                        ),
                                                                        Spacer(),
                                                                        Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 12),
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
                                                                    height: 10,
                                                                  ),
                                                                  Container(
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                            child:
                                                                                Text("h")),
                                                                        Text(
                                                                          "3.0",
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              color: Colors.red,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              50,
                                                                        ),
                                                                        Text(
                                                                          "₹ ${users[index].itemPrice}",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              20,
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
                                                  padding:
                                                      EdgeInsets.only(right: 0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          blurRadius: 2,
                                                          spreadRadius: 2,
                                                          color:
                                                              Colors.grey[300],
                                                          offset: Offset(0, 3))
                                                    ],
                                                  ),
                                                  margin: EdgeInsets.only(
                                                      right: size.width * 0.0),
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
                                                            if (idCheck
                                                                .contains(
                                                                    users[index]
                                                                        .id)) {
                                                              if (users[index]
                                                                      .itemCount >
                                                                  1) {
                                                                setState(() {
                                                                  countSum--;

                                                                  sumtotal = sumtotal -
                                                                      users[index]
                                                                          .itemPrice;
                                                                  totalPrice =
                                                                      totalPrice -
                                                                          users[index]
                                                                              .itemPrice;
                                                                  services.decrementItemCounter(
                                                                      users[index]
                                                                          .id,
                                                                      users[index]
                                                                          .itemCount);
                                                                  price = price -
                                                                      users[index]
                                                                          .itemPrice;
                                                                  cart.setInt(
                                                                      'price',
                                                                      price);
                                                                });
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
                                                                            child:
                                                                                Text(
                                                                              "Cancel",
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          ),
                                                                          FlatButton(
                                                                            child:
                                                                                Text(
                                                                              "Delete",
                                                                              style: TextStyle(color: Colors.red),
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              final SharedPreferences cart = await SharedPreferences.getInstance();

                                                                              // Delete the item from DB etc..
                                                                              setState(() {
                                                                                price = price - users[index].itemPrice;
                                                                                countSum = countSum - users[index].itemCount;
                                                                                totalPrice = totalPrice - users[index].itemPrice;
                                                                                checkitem.remove(users[index].menuItemId.toString());
                                                                                cart.setStringList('addedtocart', checkitem);
                                                                              });
                                                                              setState(() {
                                                                                cart.setInt('price', price);
                                                                                services.deleteUser(users[index].id);
                                                                              });

                                                                              Navigator.pop(context, () {
                                                                                setState(() {});
                                                                              });
                                                                            },
                                                                          ),
                                                                        ],
                                                                      );
                                                                    });
                                                              }
                                                            } else {
                                                              if (users[index]
                                                                      .itemCount >
                                                                  1) {
                                                                setState(() {
                                                                  services.decrementItemCounter(
                                                                      users[index]
                                                                          .id,
                                                                      users[index]
                                                                          .itemCount);
                                                                  price = price -
                                                                      users[index]
                                                                          .itemPrice;
                                                                  cart.setInt(
                                                                      'price',
                                                                      price);
                                                                });
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
                                                                            child:
                                                                                Text(
                                                                              "Cancel",
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          ),
                                                                          FlatButton(
                                                                            child:
                                                                                Text(
                                                                              "Delete",
                                                                              style: TextStyle(color: Colors.red),
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              final SharedPreferences cart = await SharedPreferences.getInstance();

                                                                              // TODO: Delete the item from DB etc..
                                                                              setState(() {
                                                                                price = price - users[index].itemPrice;
                                                                              });
                                                                              setState(() {
                                                                                cart.setInt('price', price);
                                                                                services.deleteUser(users[index].id);
                                                                                checkitem.remove(users[index].menuItemId.toString());
                                                                                cart.setStringList('addedtocart', checkitem);
                                                                              });

                                                                              Navigator.pop(context, () {
                                                                                setState(() {});
                                                                              });
                                                                            },
                                                                          ),
                                                                        ],
                                                                      );
                                                                    });
                                                              }
                                                            }
                                                          },
                                                          child: Icon(
                                                              Icons.remove)),
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
                                                        child: Icon(Icons.add),
                                                        onTap: () async {
                                                          final SharedPreferences
                                                              cart =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          if (idCheck.contains(
                                                              users[index]
                                                                  .id)) {
                                                            setState(() {
                                                              services.incrementItemCounter(
                                                                  users[index]
                                                                      .id,
                                                                  users[index]
                                                                      .itemCount);
                                                              price = price +
                                                                  users[index]
                                                                      .itemPrice;

                                                              countSum++;
                                                              totalPrice =
                                                                  totalPrice +
                                                                      users[index]
                                                                          .itemPrice;
                                                              cart.setInt(
                                                                  'price',
                                                                  price);
                                                            });
                                                          } else {
                                                            setState(() {
                                                              services.incrementItemCounter(
                                                                  users[index]
                                                                      .id,
                                                                  users[index]
                                                                      .itemCount);
                                                              price = price +
                                                                  users[index]
                                                                      .itemPrice;
                                                              cart.setInt(
                                                                  'price',
                                                                  price);
                                                            });
                                                          }
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
                              "₹$price",
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
                              "Discount Price",
                              style: _textstyle,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: Text(
                              "-₹0",
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
                              "₹$totalPrice",
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
                        "$countSum",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: MaterialButton(
                      onPressed: () {
                        if (checkdata == 1) {
                          var distinctIds = vendorIdCheck.toSet().toList();
                          if (totalPrice != 0) {
                            if (distinctIds.length == 1) {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => PlaceOrder());
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Items selected from different restaurant");
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please select any item to place order");
                          }
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }
                      },
                      child: checkdata == 1
                          ? Text("Place Order  ₹ $totalPrice")
                          : Text("Login"),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Colors.blue[600],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Text(
                      "",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ));
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

  fun(value) {
    var data = value;
  }
}
