import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/components/WishList/WishListDataBase/wishlist_service.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CategoryDetailPage extends StatefulWidget {
  final menuData;
  const CategoryDetailPage({Key key, this.menuData}) : super(key: key);
  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  bool isSelected = false;

  var rating = 3.0;
  int _current = 0;
  int _index = 0;
  int selectedRadioTile;
  String snackBarData = "Item in cart";
  var pad = 34;

  var restaurantMenu;

  void initState() {
    super.initState();
    getList();
    datamenu = widget.menuData;
    selectedRadioTile = 0;
  }

  var menuId;
  List<String> checkdata = [];
  getList() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      checkdata = cart.getStringList('addedtocart');
    });
    print(checkdata);
  }

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
          child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 23,
              child: Container(
                  height: size.height * 1,
                  child: Stack(children: [
                    Container(
                      height: size.height * 0.45,
                      width: size.width * 1,
                      child: Stack(
                        children: [
                          Container(
                            height: size.height * 0.45,
                            width: size.width * 1,
                            child: datamenu['menuImage1'] != null
                                ? datamenu['menuImage2'] != null
                                    ? datamenu['menuImage3'] != null
                                        ? Swiper(
                                            autoplayDelay: 2500,
                                            autoplay: true,
                                            itemCount: 4,
                                            itemBuilder: (context, index) =>
                                                Container(
                                              child:
                                                  datamenu['menuImage$index'] !=
                                                          null
                                                      ? CachedNetworkImage(
                                                          imageUrl: S3_BASE_PATH +
                                                              datamenu[
                                                                  'menuImage$index'],
                                                          fit: BoxFit.cover,
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
                                          )
                                        : Swiper(
                                            autoplayDelay: 2500,
                                            autoplay: true,
                                            itemCount: 3,
                                            itemBuilder: (context, index) =>
                                                Container(
                                              child:
                                                  datamenu['menuImage$index'] !=
                                                          null
                                                      ? CachedNetworkImage(
                                                          imageUrl: S3_BASE_PATH +
                                                              datamenu[
                                                                  'menuImage$index'],
                                                          fit: BoxFit.cover,
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
                                          )
                                    : CachedNetworkImage(
                                        imageUrl: S3_BASE_PATH +
                                            datamenu['menuImage1'],
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          "assets/images/feasturenttemp.jpeg",
                                          fit: BoxFit.cover,
                                        ),
                                        errorWidget: (context, url, error) =>
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 34, top: 20),
                                    child: Icon(
                                      Icons.restaurant,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 12, top: 21),
                                  //   child: Text(
                                  //     datamenu['categories']['name'],
                                  //     style: TextStyle(fontSize: 14),
                                  //   ),
                                  // ),
                                  Spacer(),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          right: 24, top: 24),
                                      child: datamenu['isNonVeg'] == false
                                          ? datamenu['isEgg'] == false
                                              ? Container(
                                                  child: CachedNetworkImage(
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                    imageUrl:
                                                        'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                                    height: size.height * 0.016,
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
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            )),
                                ],
                              )),

                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      width: size.width * 0.7,
                                      child: Text(
                                        datamenu['title'],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),

                              // Price
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 30, top: 2),
                                    child: SmoothStarRating(
                                        allowHalfRating: false,
                                        onRated: (v) {
                                          Text("23");
                                        },
                                        starCount: 5,
                                        rating: rating,
                                        size: 23.0,
                                        isReadOnly: true,
                                        defaultIconData:
                                            Icons.star_border_outlined,
                                        filledIconData: Icons.star,
                                        halfFilledIconData: Icons.star_border,
                                        color: Colors.amber,
                                        borderColor: Colors.amber,
                                        spacing: 0.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text("24 Views"),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: Text(
                                      "₹ ${datamenu['totalPrice']}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
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
                                      top: 25, right: 25, left: 25),
                                  child: Container(
                                    height: size.height * 0.27,
                                    child: Text(
                                      "Description : ${datamenu['description']}",
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          wordSpacing: 2, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                margin: EdgeInsets.only(
                                    left: size.width * 0.11,
                                    right: size.width * 0.11),
                                child: MaterialButton(
                                  onPressed: () async {
                                    int tpye = 0;

                                    final SharedPreferences cart =
                                        await SharedPreferences.getInstance();
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

                                    await services
                                        .data(datamenu['menuId'])
                                        .then((value) => fun(value));
                                    if (vendorId == 0 ||
                                        vendorId == datamenu['vendorId']) {
                                      if (data1.isEmpty) {
                                        setState(() {
                                          itemAddToCart(tpye);
                                          checkdata.add(
                                              datamenu['menuId'].toString());

                                          totalcount = totalcount + 1;
                                          gsttotal =
                                              gsttotal + datamenu['gstAmount'];
                                          totalprice = totalprice +
                                              datamenu['totalPrice'];

                                          vendorId = datamenu['vendorId'];
                                          cart.setInt('VendorId', vendorId);
                                          cart.setInt('TotalPrice', totalprice);
                                          cart.setInt('TotalGst', gsttotal);
                                          cart.setInt('TotalCount', totalcount);

                                          cart.setStringList(
                                              'addedtocart', checkdata);
                                          snackBarData =
                                              "${datamenu['title']} is added to cart";
                                        });
                                      } else {
                                        if (data1[0]['itemName'] !=
                                            datamenu['title']) {
                                          setState(() {
                                            itemAddToCart(tpye);
                                            checkdata.add(
                                                datamenu['menuId'].toString());

                                            totalcount = totalcount + 1;
                                            gsttotal = gsttotal +
                                                datamenu['gstAmount'];
                                            totalprice = totalprice +
                                                datamenu['totalPrice'];

                                            vendorId = datamenu['vendorId'];
                                            cart.setInt('VendorId', vendorId);
                                            cart.setInt(
                                                'TotalPrice', totalprice);
                                            cart.setInt('TotalGst', gsttotal);
                                            cart.setInt(
                                                'TotalCount', totalcount);

                                            cart.setStringList(
                                                'addedtocart', checkdata);
                                            snackBarData =
                                                "${datamenu['title']} is added to cart";
                                          });

                                          setState(() {
                                            snackBarData =
                                                "${datamenu['title']} is added to cart";
                                          });
                                        } else {
                                          setState(() {
                                            snackBarData =
                                                "${datamenu['title']} is already added to cart";
                                          });
                                          print("match");
                                        }
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please Add order from Single Resturent");
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  height: size.height * 0.07,
                                  textColor: Colors.white,
                                  color: Colors.blue,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.shopping_bag,
                                      ),
                                      checkdata.contains(
                                              datamenu['menuId'].toString())
                                          ? Text(
                                              "Added",
                                              style: TextStyle(fontSize: 18),
                                            )
                                          : Text(
                                              "Add To Cart",
                                              style: TextStyle(fontSize: 18),
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
      )),
    );
  }

  itemAddToCart(tpye) async {
    final SharedPreferences cart = await SharedPreferences.getInstance();

    // var sum = cart.getInt('price');
    // sum = sum + datamenu['totalPrice'];
    // cart.setInt('price', sum);
    // print(sum);
    setState(() {
      // itemCount.add(value)
      services.saveUser(
          datamenu['totalPrice'],
          1,
          datamenu['vendorId'],
          datamenu['menuId'],
          datamenu['menuImage1'],
          datamenu['title'],
          "Add".toString(),
          tpye,
          0,
          datamenu['restaurantName'],
          datamenu['gstAmount']);
    });
  }

  fun(value) {
    setState(() {
      data1 = value;
    });
  }
}
