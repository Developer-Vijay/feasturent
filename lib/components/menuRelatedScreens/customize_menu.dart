import 'package:feasturent_costomer_app/components/Cart.dart/AddOnDataBase/addon_service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'foodlistclass.dart';

class CustomizeMenu extends StatefulWidget {
  final menuData;
  const CustomizeMenu({this.menuData});
  @override
  _CustomizeMenuState createState() => _CustomizeMenuState();
}

class _CustomizeMenuState extends State<CustomizeMenu> {
  @override
  void initState() {
    super.initState();
    varientPrice = widget.menuData['totalPrice'];
    setState(() {
      int j = widget.menuData['AddonMenus'].length;

      for (int i = 0; i < j; i++) {
        inputs.add(false);
      }
    });
    fetchData();
    getList();
  }

  final addOnservices = AddOnService();

  // List<String> checkdata = [];
  getList() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      ids = cart.getStringList('addontocart');
    });
    print('This is Ids list : $ids');
  }

  bool addonChecker = false;
  bool variantchecker = false;

  fetchData() {
    int k = widget.menuData['AddonMenus'].length;
    print("menue length $k");
    for (int i = 0; i <= k - 1; i++) {
      if (widget.menuData['AddonMenus'][i]['type'] == 'VARIANT') {
        if (widget.menuData['AddonMenus'][i]['title'].isNotEmpty) {
          print("variant");
          setState(() {
            variantchecker = true;
          });
        }
      } else {
        if (widget.menuData['AddonMenus'][i]['title'].isNotEmpty) {
          print("addon");
          setState(() {
            addonChecker = true;
          });
        }
      }
    }
  }

  List<bool> inputs = new List<bool>();
  fun(value) {
    setState(() {
      data3New = value;
    });
  }

  List addonId = [];
  void ItemChange(bool val, int index, data) async {
    if (val == true) {
      int addOngst = (data['amount'] * (data['gst'] / 100)).toInt();
      totalAddOngst = totalAddOngst + addOngst;
      totalAddOnPrice = totalAddOnPrice + data['amount'] + addOngst;
      ids.add(data['id'].toString());
      addonId.add(data['id']);
    } else {
      int addOngst = (data['amount'] * (data['gst'] / 100)).toInt();
      totalAddOngst = totalAddOngst - addOngst;
      totalAddOnPrice = totalAddOnPrice - data['amount'] - addOngst;
      ids.remove(data['id'].toString());
      addonId.remove(data['id']);
    }
    setState(() {
      inputs[index] = val;
    });
    print(ids);
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

  List ids = [];
  int totalAddOnPrice = 0;
  int totalAddOngst = 0;

  int varientgst = 0;
  int varientPrice = 0;
  int varientid = 0;
  int selectedRadio = -1;
  int temp = 0;
  changeValue(int val, data) {
    setState(() {
      varientgst = (data['amount'] * (data['gst'] / 100)).toInt();
      selectedRadio = val;
      varientPrice = data['amount'] + varientgst;
      varientid = data['id'];
    });
  }

  AddtoCartAddonS() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      tempAddOns = addonId.toString();
    });
    int totalprice = cart.getInt('TotalPrice');
    int gsttotal = cart.getInt('TotalGst');
    int totalcount = cart.getInt('TotalCount');
    callingLoader();
    int k = ids.length;
    for (int i = 0; i <= k - 1; i++) {
      int dataid = int.parse(ids[i]);

      int j = widget.menuData['AddonMenus'].length;

      for (int k = 0; k < j; k++) {
        if (dataid == widget.menuData['AddonMenus'][k]['id']) {
          print("Addon selected ${widget.menuData['AddonMenus'][k]['title']}");

          await addOnservices.data(dataid).then((value) => fun(value));

          if (data3New.isEmpty) {
            print("Before add Count  $totalcount");
            print("Before add price  $totalprice");

            print("databaseEmpty");
            print(" added Addon  ${widget.menuData['AddonMenus'][k]['title']}");
            setState(() {
              //   itemAddToCart(index, tpye, price, gst, variantId);
              totalcount = totalcount + 1;
              gsttotal = gsttotal +
                  (widget.menuData['AddonMenus'][k]['gstAmount']).toInt();
              totalprice = totalprice +
                  (widget.menuData['AddonMenus'][k]['gstAmount']).toInt() +
                  widget.menuData['AddonMenus'][k]['amount'];

              cart.setInt('TotalPrice', totalprice);
              cart.setInt('TotalGst', gsttotal);
              cart.setInt('TotalCount', totalcount);

              cart.setStringList('addontocart', ids);
              print("after add Count  $totalcount");
              print("after add price  $totalprice");

              addtoAddonFunction(widget.menuData['AddonMenus'][k]);
            });
          } else {
            if (data3New[0]['addonId'] != dataid) {
              print("Before add Count  $totalcount");
              print("Before add price  $totalprice");
              print(
                  "  added Addon  ${widget.menuData['AddonMenus'][k]['title']}");

              setState(() {
                totalcount = totalcount + 1;
                gsttotal = gsttotal +
                    (widget.menuData['AddonMenus'][k]['gstAmount']).toInt();
                totalprice = totalprice +
                    (widget.menuData['AddonMenus'][k]['gstAmount']).toInt() +
                    widget.menuData['AddonMenus'][k]['amount'];

                cart.setInt('TotalPrice', totalprice);
                cart.setInt('TotalGst', gsttotal);
                cart.setInt('TotalCount', totalcount);
                cart.setStringList('addontocart', ids);
                addtoAddonFunction(widget.menuData['AddonMenus'][k]);
                print("after add Count  $totalcount");
                print("after add price  $totalprice");
                Fluttertoast.showToast(msg: 'AddOns added');
              });
            } else {
              print(
                  " function required to delete Addon  ${widget.menuData['AddonMenus'][k]['title']}");

              // Add delete function here
              // setState(() {
              //   inputs[index] = true;
              // });
              // print("match");
            }
          }
        } else {
          print(
              "Addon not selected ${widget.menuData['AddonMenus'][k]['title']}");
        }
      }
    }
    Navigator.pop(context);
    Navigator.pop(context, varientid);
  }

  addtoAddonFunction(data) {
    setState(() {
      int price = data['amount'] + (data['gstAmount']).toInt();
      addOnservices.saveUser(price, 1, widget.menuData['vendorId'], data['id'],
          data['title'], 'null', (data['gstAmount']).toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pop(context);
      },
      child: Container(
        height: size.height * 0.8,
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              height: size.height * 0.1,
              width: double.infinity,
              color: Colors.transparent,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: size.height * 0.01),
              height: size.height * 0.7,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: size.height * 0.14,
                    child: Row(
                      children: [
                        Container(
                          height: size.height * 0.2,
                          width: size.width * 0.3,
                          margin: EdgeInsets.only(
                              left: size.width * 0.01,
                              right: size.width * 0.014,
                              top: size.height * 0.007,
                              bottom: size.height * 0.007),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: widget.menuData['image1'] != null
                                ? CachedNetworkImage(
                                    imageUrl: S3_BASE_PATH +
                                        widget.menuData['image1'],
                                    height: size.height * 0.2,
                                    width: size.width * 0.26,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      "assets/images/feasturenttemp.jpeg",
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.asset(
                                    "assets/images/feasturenttemp.jpeg",
                                    height: size.height * 0.2,
                                    width: size.width * 0.26,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: size.height * 0.2,
                            width: size.width * 0.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(top: size.height * 0.025),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: size.width * 0.5,
                                        child: Text(
                                          capitalize(widget.menuData['title']),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: size.height * 0.02),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 12),
                                          child: widget.menuData['isNonVeg'] ==
                                                  false
                                              ? widget.menuData['isEgg'] ==
                                                      false
                                                  ? Container(
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                                        height:
                                                            size.height * 0.016,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                    )
                                                  : Container(
                                                      child: Image.asset(
                                                      "assets/images/eggeterian.png",
                                                      height:
                                                          size.height * 0.016,
                                                    ))
                                              : CachedNetworkImage(
                                                  imageUrl:
                                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/1200px-Non_veg_symbol.svg.png',
                                                  height: size.height * 0.016,
                                                  errorWidget:
                                                      (context, url, error) =>
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
                                        "3.0",
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
                                          "₹${widget.menuData['totalPrice']}",
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
                                      child: widget.menuData['MenuOffers']
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
                                                  child: widget
                                                              .menuData[
                                                                  'MenuOffers']
                                                              .length >=
                                                          2
                                                      ? Row(
                                                          children: [
                                                            widget.menuData['MenuOffers'][0]
                                                                            [
                                                                            'OffersAndCoupon']
                                                                        [
                                                                        'coupon'] ==
                                                                    null
                                                                ? SizedBox()
                                                                : Text(
                                                                    " ${widget.menuData['MenuOffers'][0]['OffersAndCoupon']['coupon']}, ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            size.height *
                                                                                0.015,
                                                                        color:
                                                                            kTextColor),
                                                                  ),
                                                            widget.menuData['MenuOffers'][1]
                                                                            [
                                                                            'OffersAndCoupon']
                                                                        [
                                                                        'coupon'] ==
                                                                    null
                                                                ? SizedBox()
                                                                : Text(
                                                                    " ${widget.menuData['MenuOffers'][1]['OffersAndCoupon']['coupon']}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            size.height *
                                                                                0.015,
                                                                        color:
                                                                            kTextColor),
                                                                  ),
                                                          ],
                                                        )
                                                      : widget.menuData['MenuOffers']
                                                                          [0][
                                                                      'OffersAndCoupon']
                                                                  ['coupon'] ==
                                                              null
                                                          ? SizedBox()
                                                          : Text(
                                                              " ${widget.menuData['MenuOffers'][0]['OffersAndCoupon']['coupon']}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.height *
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
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 9,
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            children: [
                              Text("Variant",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: size.height * 0.025)),
                              Row(
                                children: [
                                  Text(
                                      capitalize("${widget.menuData['title']}"),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: size.height * 0.020)),
                                  Spacer(),
                                  Radio(
                                    groupValue: selectedRadio,
                                    value: -1,
                                    onChanged: (value) {
                                      setState(() {
                                        varientgst = 0;
                                        varientPrice =
                                            widget.menuData['totalPrice'];
                                        varientid = 0;
                                        selectedRadio = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      widget.menuData['AddonMenus'].length,
                                  itemBuilder: (contetx, index) {
                                    if (widget.menuData['AddonMenus'][index]
                                            ['type'] ==
                                        'VARIANT') {
                                      if (widget
                                          .menuData['AddonMenus'][index]
                                              ['title']
                                          .isEmpty) {
                                        return SizedBox();
                                      } else {
                                        return Row(
                                          children: [
                                            Text(
                                                capitalize(widget
                                                        .menuData['AddonMenus']
                                                    [index]['title']),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54,
                                                    fontSize:
                                                        size.height * 0.020)),
                                            Spacer(),
                                            Text(
                                                "₹${widget.menuData['AddonMenus'][index]['amount'] + (widget.menuData['AddonMenus'][index]['amount'] * (widget.menuData['AddonMenus'][index]['gst'] / 100)).toInt()}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize:
                                                        size.height * 0.020)),
                                            Radio(
                                              groupValue: selectedRadio,
                                              value: index,
                                              onChanged: (value) {
                                                temp = 0;
                                                changeValue(
                                                    value,
                                                    widget.menuData[
                                                        'AddonMenus'][index]);
                                              },
                                            ),
                                          ],
                                        );
                                      }
                                    } else {
                                      return SizedBox();
                                    }
                                  }),
                              SizedBox(height: 5),
                              addonChecker == false
                                  ? SizedBox()
                                  : Text("AddOns",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: size.height * 0.025)),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      widget.menuData['AddonMenus'].length,
                                  itemBuilder: (contetx, index) {
                                    if (widget.menuData['AddonMenus'][index]
                                            ['type'] ==
                                        'ADDON') {
                                      if (widget
                                          .menuData['AddonMenus'][index]
                                              ['title']
                                          .isEmpty) {
                                        print("DAta");
                                        return SizedBox();
                                      } else {
                                        print("yes");

                                        return Row(
                                          children: [
                                            Text(
                                                capitalize(widget
                                                        .menuData['AddonMenus']
                                                    [index]['title']),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize:
                                                        size.height * 0.020)),
                                            Spacer(),
                                            Text(
                                                "₹${widget.menuData['AddonMenus'][index]['amount'] + (widget.menuData['AddonMenus'][index]['amount'] * (widget.menuData['AddonMenus'][index]['gst'] / 100)).toInt()}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize:
                                                        size.height * 0.020)),
                                            Checkbox(
                                                value: ids.isEmpty
                                                    ? inputs[index]
                                                    : ids.contains(widget
                                                            .menuData[
                                                                'AddonMenus']
                                                                [index]['id']
                                                            .toString())
                                                        ? true
                                                        : inputs[index],
                                                onChanged: (bool val) {
                                                  ItemChange(
                                                      val,
                                                      index,
                                                      widget.menuData[
                                                          'AddonMenus'][index]);
                                                }),
                                          ],
                                        );
                                      }
                                    } else {
                                      return SizedBox();
                                    }
                                  }),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              margin: EdgeInsets.only(
                                  left: size.width * 0.11,
                                  right: size.width * 0.11),
                              child: MaterialButton(
                                onPressed: () async {
                                  if (variantchecker == true) {
                                    if (varientPrice == 0) {
                                      Fluttertoast.showToast(
                                          msg: 'Please select variant');
                                    } else {
                                      AddtoCartAddonS();
                                    }
                                  } else {
                                    AddtoCartAddonS();
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                height: size.height * 0.07,
                                textColor: Colors.white,
                                color: Colors.blue,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_bag,
                                    ),
                                    variantchecker == true
                                        ? Text(
                                            "Add To Cart  ₹${varientPrice + totalAddOnPrice}",
                                            style: TextStyle(fontSize: 18),
                                          )
                                        : Text(
                                            "Add To Cart  ₹${widget.menuData['totalPrice'] + totalAddOnPrice}",
                                            style: TextStyle(fontSize: 18),
                                          )
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
