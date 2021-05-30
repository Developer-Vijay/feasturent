import 'package:feasturent_costomer_app/components/Bottomsheet/addRatingBottom.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/AddOnDataBase/addon_service.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/notificationsfiles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';

class RepeatOrderPage extends StatefulWidget {
  final itemData;
  final data;
  const RepeatOrderPage({Key key, this.itemData, this.data}) : super(key: key);

  @override
  _RepeatOrderPageState createState() => _RepeatOrderPageState();
}

class _RepeatOrderPageState extends State<RepeatOrderPage> {
  Notifications notifications = Notifications();

  @override
  void initState() {
    super.initState();
    setState(() {
      itemData1 = widget.itemData;
    });
  }

  var itemData1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orderdetails =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w400);
    final orderHeading =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w600);
    final item = TextStyle(color: Colors.black, fontWeight: FontWeight.w600);
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pop(context, true);
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            title: Text("Order Summary"),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 15,
                child: ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Your Order",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ListView.builder(
                          itemCount: itemData1['orderMenues'].length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  color: Colors.black38,
                                  thickness: 0.8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        itemData1['orderMenues'][index]
                                                    ['variant'] !=
                                                null
                                            ? Text(
                                                capitalize(
                                                    "${itemData1['orderMenues'][index]['variant']['title']} ${itemData1['orderMenues'][index]['Menu']['title']}"),
                                                style: item,
                                              )
                                            : Text(
                                                capitalize(
                                                    "${itemData1['orderMenues'][index]['Menu']['title']}"),
                                                style: item,
                                              ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  color: Colors.black54),
                                              padding: EdgeInsets.only(
                                                  top: 2,
                                                  left: 2,
                                                  right: 5,
                                                  bottom: 2),
                                              margin: EdgeInsets.only(top: 8),
                                              child: Text(
                                                "${itemData1['orderMenues'][index]['quantity']} ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                            Text(" * ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black54,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            itemData1['orderMenues'][index]
                                                        ['variant'] !=
                                                    null
                                                ? Text(
                                                    "₹ ${itemData1['orderMenues'][index]['variant']['amount']}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w600))
                                                : Text(
                                                    "₹ ${itemData1['orderMenues'][index]['Menu']['price']}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                            Spacer(),
                                            itemData1['orderMenues'][index]
                                                        ['variant'] !=
                                                    null
                                                ? Text(
                                                    "₹ ${(itemData1['orderMenues'][index]['variant']['amount'] * itemData1['orderMenues'][index]['quantity'])}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))
                                                : Text(
                                                    "₹ ${(itemData1['orderMenues'][index]['Menu']['price'] * itemData1['orderMenues'][index]['quantity'])}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "GST added",
                                              style: item,
                                            ),
                                            Spacer(),
                                            itemData1['orderMenues'][index]
                                                        ['variant'] !=
                                                    null
                                                ? Text(
                                                    "₹ ${itemData1['orderMenues'][index]['variant']['gstAmount'].toInt() * itemData1['orderMenues'][index]['quantity']}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))
                                                : Text(
                                                    "₹ ${itemData1['orderMenues'][index]['Menu']['gstAmount'].toInt() * itemData1['orderMenues'][index]['quantity']}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                          ],
                                        )
                                      ]),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            );
                          },
                        ),
                        itemData1['orderAddons'].isEmpty
                            ? SizedBox()
                            : ListView.builder(
                                itemCount: itemData1['orderAddons'].length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(
                                        color: Colors.black38,
                                        thickness: 0.8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                capitalize(
                                                    "${itemData1['orderAddons'][index]['addons']['title']}"),
                                                style: item,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        color: Colors.black54),
                                                    padding: EdgeInsets.only(
                                                        top: 2,
                                                        left: 2,
                                                        right: 5,
                                                        bottom: 2),
                                                    margin:
                                                        EdgeInsets.only(top: 8),
                                                    child: Text(
                                                      "${itemData1['orderAddons'][index]['quantity']} ",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    ),
                                                  ),
                                                  Text(" * ",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Text(
                                                      "₹ ${itemData1['orderAddons'][index]['addons']['amount']}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Spacer(),
                                                  Text(
                                                      "₹ ${(itemData1['orderAddons'][index]['addons']['amount'] * itemData1['orderAddons'][index]['quantity'])}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "GST added",
                                                    style: item,
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                      "₹ ${itemData1['orderAddons'][index]['addons']['gstAmount'].toInt() * itemData1['orderAddons'][index]['quantity']}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ],
                                              )
                                            ]),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  );
                                },
                              ),
                        Divider(
                          color: Colors.black38,
                          thickness: 0.8,
                        ),
                        itemData1['donation'] == 0
                            ? SizedBox()
                            : Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Donation",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${itemData1['donation']} ₹ +",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                        itemData1['discountPrice'] == 0
                            ? SizedBox()
                            : Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Discount Price",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${itemData1['discountPrice']} ₹ -",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                        Container(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Grand Total",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${(itemData1['orderPrice'] - itemData1['discountPrice'] + itemData1['donation'])} ₹",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  textDirection: TextDirection.rtl,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Order Details",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Resturent Name",
                            style: orderHeading,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            capitalize(itemData1['VendorInfo']['name']),
                            style: orderdetails,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Order Number",
                            style: orderHeading,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "${itemData1['id'].toString()}",
                            style: orderdetails,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Payment",
                            style: orderHeading,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "${itemData1['paymentMode'].toString()}",
                            style: orderdetails,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Date and Time",
                            style: orderHeading,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "${widget.data}",
                            style: orderdetails,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Delivered to",
                            style: orderHeading,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: itemData1['OrderAddress'] == null
                              ? Text(
                                  "Not Available",
                                  style: orderdetails,
                                )
                              : Text(
                                  itemData1['OrderAddress']['address'],
                                  style: orderdetails,
                                ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: itemData1['orderStatus'] != "PENDING"
                      ? Container(
                          child: itemData1['orderStatus'] != "CANCELED"
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: itemData1['orderStatus'] ==
                                                "DELIVERED"
                                            ? OutlineButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14)),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Repeat Order",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                textColor: Colors.blue,
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 2),
                                                onPressed: () {
                                                  repeatOrderFunction(
                                                      itemData1,
                                                      itemData1['vendorId'],
                                                      itemData1['VendorInfo']
                                                          ['name']);
                                                },
                                              )
                                            : SizedBox()),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          child: itemData1['orderStatus'] ==
                                                  "DELIVERED"
                                              ? OutlineButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  textColor: Colors.blue,
                                                  borderSide: BorderSide(
                                                      color: Colors.amber,
                                                      width: 2),
                                                  child: Text("Give Rating"),
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                        enableDrag: true,
                                                        isScrollControlled:
                                                            true,
                                                        context: context,
                                                        builder: (context) => Container(
                                                            height:
                                                                size.height *
                                                                    0.8,
                                                            child: AddRatingPage(
                                                                data:
                                                                    itemData1)));
                                                  },
                                                )
                                              : SizedBox()),
                                    )
                                  ],
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Text(
                                      "Order is Cancelled",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              "IN PROGRESS",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ))
            ],
          )),
    );
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

  repeatOrderFunction(data, vendorid, vendorName) async {
    callingLoader();
    await removeCartForNewData();
    final services = UserServices();
    final addOnservices = AddOnService();

    List<String> menuids = [];
    List<String> addonids = [];

    final SharedPreferences cart = await SharedPreferences.getInstance();
    menuids = [];
    addonids = [];

    int totalprice = cart.getInt('TotalPrice');
    int gsttotal = cart.getInt('TotalGst');
    int totalcount = cart.getInt('TotalCount');
    int vendorId = cart.getInt('VendorId');
    vendorId = vendorid;
    if (data['orderAddons'].isNotEmpty) {
      int addOnLength = data['orderAddons'].length;
      for (int i = 0; i <= addOnLength - 1; i++) {
        addonids.add(data['orderAddons'][i]['id'].toString());
        totalcount = totalcount + data['orderAddons'][i]['quantity'];
        totalprice = totalprice +
            data['orderAddons'][i]['addons']['amount'].toInt() +
            data['orderAddons'][i]['addons']['gstAmount'].toInt();
        gsttotal =
            gsttotal + data['orderAddons'][i]['addons']['gstAmount'].toInt();
        addOnservices.saveUser(
            data['orderAddons'][i]['addons']['amount'].toInt(),
            data['orderAddons'][i]['quantity'],
            vendorid,
            data['orderAddons'][i]['id'],
            data['orderAddons'][i]['addons']['title'],
            vendorName,
            data['orderAddons'][i]['addons']['gstAmount'].toInt());
      }
    }
    int orderLength = data['orderMenues'].length;
    print(
        "::::::::::::::::::::::::::::::::  WAIT  ::::::::::::::::::::::::::::::::::::::::::::");
    print(orderLength);
    services.fetchUsers().then((value) => print(value));
    for (int k = 0; k <= orderLength - 1; k++) {
      if (data['orderMenues'][k]['variant'] != null) {
        int type;
        if (data['orderMenues'][k]['Menu']['isNonVeg'] == false) {
          if (data['orderMenues'][k]['Menu']['isEgg'] == false) {
            type = 1;
          } else {
            type = 2;
          }
        } else {
          type = 3;
        }
        String title =
            "${data['orderMenues'][k]['variant']['title']} ${data['orderMenues'][k]['Menu']['title']}";
        int totalPricr = data['orderMenues'][k]['variant']['amount'].toInt() +
            data['orderMenues'][k]['variant']['gstAmount'].toInt();
        menuids.add(data['orderMenues'][k]['Menu']['id'].toString());
        totalcount = totalcount + data['orderMenues'][k]['quantity'];
        totalprice = totalprice +
            data['orderMenues'][k]['variant']['amount'].toInt() +
            data['orderMenues'][k]['variant']['gstAmount'].toInt();
        gsttotal =
            gsttotal + data['orderMenues'][k]['variant']['gstAmount'].toInt();
        services.saveUser(
            totalPricr,
            data['orderMenues'][k]['quantity'],
            vendorid,
            data['orderMenues'][k]['Menu']['id'],
            data['orderMenues'][k]['Menu']['image1'],
            title,
            "ADD".toString(),
            type,
            0,
            vendorName,
            data['orderMenues'][k]['variant']['gstAmount'].toInt(),
            data['orderMenues'][k]['variant']['id'],
            null,
            '1.0');
      } else {
        int type;
        if (data['orderMenues'][k]['Menu']['isNonVeg'] == false) {
          if (data['orderMenues'][k]['Menu']['isEgg'] == false) {
            type = 1;
          } else {
            type = 2;
          }
        } else {
          type = 3;
        }
        menuids.add(data['orderMenues'][k]['Menu']['id'].toString());
        totalcount = totalcount + data['orderMenues'][k]['quantity'];
        totalprice =
            totalprice + data['orderMenues'][k]['Menu']['totalPrice'].toInt();
        gsttotal =
            gsttotal + data['orderMenues'][k]['Menu']['gstAmount'].toInt();
        services.saveUser(
            data['orderMenues'][k]['Menu']['totalPrice'].toInt(),
            data['orderMenues'][k]['quantity'],
            vendorid,
            data['orderMenues'][k]['Menu']['id'],
            data['orderMenues'][k]['Menu']['image1'],
            data['orderMenues'][k]['Menu']['title'],
            "ADD".toString(),
            type,
            0,
            vendorName,
            data['orderMenues'][k]['Menu']['gstAmount'].toInt(),
            0,
            null,
            '1.0');
      }
    }
    cart.setStringList('addedtocart', menuids);
    cart.setStringList('addontocart', addonids);

    cart.setInt('TotalPrice', totalprice);
    cart.setInt('TotalGst', gsttotal);
    cart.setInt('TotalCount', totalcount);
    cart.setInt('VendorId', vendorId);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CartScreen()));
  }
}
