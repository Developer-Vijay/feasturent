import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/Place_Order/place_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

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
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(children: [
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        itemCount: add2.length,
                        shrinkWrap: true,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                if (add2[index].isSelected == false) {
                                  setState(() {
                                    add2[index].isSelected = true;
                                    countSum = countSum + add2[index].counter;
                                    totalPrice = totalPrice +
                                        (add2[index].foodPrice *
                                            add2[index].counter);
                                  });
                                } else if (add2[index].isSelected = true) {
                                  setState(() {
                                    add2[index].isSelected = false;

                                    countSum = countSum - add2[index].counter;
                                    totalPrice = totalPrice -
                                        (add2[index].foodPrice *
                                            add2[index].counter);
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: add2[index].isSelected
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
                                  direction: DismissDirection.endToStart,
                                  confirmDismiss: (direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      final bool res = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Text(
                                                  "Are you sure you want to delete ${add2[index].title}?"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () {
                                                    // TODO: Delete the item from DB etc..
                                                    if (add2[index]
                                                            .isSelected ==
                                                        true) {
                                                      setState(() {
                                                        int temp =
                                                            add2[index].id;
                                                        insideOfferPage[temp]
                                                                .addedStatus =
                                                            "Add";
                                                        sumtotal = sumtotal -
                                                            (add2[index]
                                                                    .counter *
                                                                add2[index]
                                                                    .foodPrice);
                                                        countSum = countSum -
                                                            add2[index].counter;
                                                        totalPrice = totalPrice -
                                                            (add2[index]
                                                                    .counter *
                                                                add2[index]
                                                                    .foodPrice);

                                                        add2.removeAt(index);
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    } else {
                                                      setState(() {
                                                        int temp =
                                                            add2[index].id;
                                                        insideOfferPage[temp]
                                                                .addedStatus =
                                                            "Add";
                                                        sumtotal = sumtotal -
                                                            (add2[index]
                                                                    .counter *
                                                                add2[index]
                                                                    .foodPrice);

                                                        add2.removeAt(index);
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
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
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: size.width * 0.69,
                                              height: size.height * 0.128,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 0,
                                                    child: Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        height:
                                                            size.height * 0.2,
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 4,
                                                                  right: 4,
                                                                  top: 4),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: add2[
                                                                      index]
                                                                  .foodImage,
                                                              height:
                                                                  size.height *
                                                                      0.09,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                    margin: EdgeInsets.only(
                                                        left:
                                                            size.width * 0.01),
                                                    height: size.height * 0.2,
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
                                                            top: 6,
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                add2[index]
                                                                    .title,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              Spacer(),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            12),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: add2[
                                                                          index]
                                                                      .vegsymbol,
                                                                  height:
                                                                      size.height *
                                                                          0.013,
                                                                ),
                                                              )
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
                                                                child: add2[
                                                                        index]
                                                                    .starRating,
                                                              ),
                                                              Text(
                                                                "3.0",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                width: 50,
                                                              ),
                                                              Text(
                                                                "₹ ${add2[index].foodPrice}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
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
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(right: 0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 2,
                                                spreadRadius: 2,
                                                color: Colors.grey[300],
                                                offset: Offset(0, 3))
                                          ],
                                        ),
                                        margin: EdgeInsets.only(
                                            right: size.width * 0.0),
                                        child: ButtonBar(
                                          buttonPadding: EdgeInsets.all(3),
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  if (add2[index].isSelected ==
                                                      true) {
                                                    if (add2[index].counter >
                                                        1) {
                                                      setState(() {
                                                        countSum--;
                                                        add2[index].counter--;
                                                        sumtotal = sumtotal -
                                                            add2[index]
                                                                .foodPrice;
                                                        totalPrice =
                                                            totalPrice -
                                                                add2[index]
                                                                    .foodPrice;
                                                      });

                                                      print("Decrease");
                                                    } else if (add2[index]
                                                            .counter ==
                                                        1) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              content: Text(
                                                                  "Are you sure you want to delete ${add2[index].title}?"),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  child: Text(
                                                                    "Cancel",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
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
                                                                      () {
                                                                    // TODO: Delete the item from DB etc..
                                                                    setState(
                                                                        () {
                                                                      int temp =
                                                                          add2[index]
                                                                              .id;
                                                                      insideOfferPage[temp]
                                                                              .addedStatus =
                                                                          "Add";
                                                                      sumtotal =
                                                                          sumtotal -
                                                                              add2[index].foodPrice;
                                                                      countSum =
                                                                          countSum -
                                                                              add2[index].counter;
                                                                      totalPrice =
                                                                          totalPrice -
                                                                              add2[index].foodPrice;
                                                                      add2.removeAt(
                                                                          index);
                                                                    });

                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    }
                                                  } else {
                                                    if (add2[index].counter >
                                                        1) {
                                                      setState(() {
                                                        add2[index].counter--;
                                                        sumtotal = sumtotal -
                                                            add2[index]
                                                                .foodPrice;
                                                      });

                                                      print("Decrease");
                                                    } else if (add2[index]
                                                            .counter ==
                                                        1) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              content: Text(
                                                                  "Are you sure you want to delete ${add2[index].title}?"),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  child: Text(
                                                                    "Cancel",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
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
                                                                      () {
                                                                    // TODO: Delete the item from DB etc..
                                                                    setState(
                                                                        () {
                                                                      int temp =
                                                                          add2[index]
                                                                              .id;
                                                                      insideOfferPage[temp]
                                                                              .addedStatus =
                                                                          "Add";
                                                                      sumtotal =
                                                                          sumtotal -
                                                                              add2[index].foodPrice;

                                                                      add2.removeAt(
                                                                          index);
                                                                    });

                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    }
                                                  }
                                                },
                                                child: Icon(Icons.remove)),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("${add2[index].counter}",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              child: Icon(Icons.add),
                                              onTap: () {
                                                if (add2[index].isSelected ==
                                                    true) {
                                                  setState(() {
                                                    countSum++;

                                                    add2[index].counter++;

                                                    sumtotal = sumtotal +
                                                        add2[index].foodPrice;
                                                    totalPrice = totalPrice +
                                                        add2[index].foodPrice;
                                                  });
                                                } else {
                                                  setState(() {
                                                    add2[index].counter++;

                                                    sumtotal = sumtotal +
                                                        add2[index].foodPrice;
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
                        }),
                  ),
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
                              "₹$sumtotal",
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
                        if (totalPrice != 0) {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => PlaceOrder());
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please select any item to place order");
                        }
                      },
                      child: Text("Place Order  ₹ $totalPrice"),
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
}
