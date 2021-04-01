import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/screens/home/slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/tandooriScreen.dart';

class ResturentMenu extends StatefulWidget {
  final resturentMenu;
  const ResturentMenu({Key key, this.resturentMenu}) : super(key: key);
  @override
  _ResturentMenuState createState() => _ResturentMenuState();
}

class _ResturentMenuState extends State<ResturentMenu> {
  final services = UserServices();
  @override
  void initState() {
    super.initState();
    getList();
    restaurantDataCopy = widget.resturentMenu;
  }

  List<String> checkdata = [];
  getList() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      checkdata = cart.getStringList('addedtocart');
    });
    print(checkdata);
  }

  var restaurantDataCopy;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: restaurantDataCopy['VendorCategories'].length == 0
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
                                  restaurantDataCopy['VendorCategories'].length,
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
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: restaurantDataCopy['Menus'].length,
        itemBuilder: (context, index) {
          int tpye = 0;

          return InkWell(
            onTap: () {
              bool status;
              var menuD;
              if (restaurantDataCopy['user']['Setting'] == null) {
                setState(() {
                  status = false;
                });
              } else {
                setState(() {
                  status = restaurantDataCopy['user']['Setting']['isActive'];
                });
              }
              setState(() {
                menuD = restaurantDataCopy['Menus'][index];
              });
              print(status);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodSlider(
                            menuData: menuD,
                            menuStatus: status,
                            restaurentName: restaurantDataCopy['name'],
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                                  child: restaurantDataCopy['Menus'][index]
                                              ['image1'] !=
                                          null
                                      ? CachedNetworkImage(
                                          imageUrl: S3_BASE_PATH +
                                              restaurantDataCopy['Menus'][index]
                                                  ['image1'],
                                          height: size.height * 0.1,
                                          width: size.width * 0.26,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
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
                              left: size.width * 0.06,
                              right: size.width * 0.06,
                              child: Container(
                                child: MaterialButton(
                                  onPressed: () async {
                                    final SharedPreferences cart =
                                        await SharedPreferences.getInstance();
                                    if (restaurantDataCopy['Menus'][index]
                                            ['isNonVeg'] ==
                                        false) {
                                      if (restaurantDataCopy['Menus'][index]
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
                                        .data(restaurantDataCopy['Menus'][index]
                                            ['id'])
                                        .then((value) => fun(value));
                                    if (data1.isEmpty) {
                                      setState(() {
                                        itemAddToCart(index, tpye);
                                        Fluttertoast.showToast(
                                            msg: "Item Added");
                                        checkdata.add(
                                            restaurantDataCopy['Menus'][index]
                                                    ['id']
                                                .toString());
                                        cart.setStringList(
                                            'addedtocart', checkdata);
                                      });

                                      final snackBar = SnackBar(
                                        duration: Duration(seconds: 1),
                                        backgroundColor:
                                            Colors.lightBlueAccent[200],
                                        content: Text(
                                            "${restaurantDataCopy['Menus'][index]['title']} is added to cart"),
                                        action: SnackBarAction(
                                          textColor: Colors.redAccent,
                                          label: "View Cart",
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CartScreen()));
                                          },
                                        ),
                                      );

                                      Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      if (data1[0]['itemName'] !=
                                          restaurantDataCopy['Menus'][index]
                                              ['title']) {
                                        setState(() {
                                          itemAddToCart(index, tpye);
                                          checkdata.add(
                                              restaurantDataCopy['Menus'][index]
                                                      ['id']
                                                  .toString());
                                          cart.setStringList(
                                              'addedtocart', checkdata);
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
                                  },
                                  color: Colors.white,
                                  minWidth: size.width * 0.16,
                                  height: size.height * 0.033,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                  textColor: Colors.white,
                                  child: checkdata.contains(
                                          restaurantDataCopy['Menus'][index]
                                                  ['id']
                                              .toString())
                                      ? Text(
                                          "Added",
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.015,
                                              color: Colors.blueGrey),
                                        )
                                      : Text(
                                          "Add",
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
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
                                margin:
                                    EdgeInsets.only(top: size.height * 0.01),
                                child: Row(
                                  children: [
                                    Text(
                                      restaurantDataCopy['Menus'][index]
                                          ['title'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: size.height * 0.019),
                                    ),
                                    Spacer(),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: restaurantDataCopy['Menus']
                                                    [index]['isNonVeg'] ==
                                                false
                                            ? restaurantDataCopy['Menus'][index]
                                                        ['isEgg'] ==
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
                                                    height: size.height * 0.016,
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
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: restaurantDataCopy['Menus'][index]
                                                  ['Category']['iconImage'] ==
                                              "null"
                                          ? Image.asset(
                                              "assets/icons/discount_icon.jpg",
                                              height: size.height * 0.02,
                                            )
                                          : SizedBox(),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.006,
                                    ),
                                    Text(
                                      restaurantDataCopy['Menus'][index]
                                          ['Category']['name'],
                                      style: TextStyle(
                                          fontSize: size.height * 0.014,
                                          fontWeight: FontWeight.bold),
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
                                    Container(
                                      child: Text("⭐"),
                                    ),
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
                                    child: restaurantDataCopy['Menus'][index]
                                                    ['MenuOffers']
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
                                                child: restaurantDataCopy[
                                                                        'Menus']
                                                                    [index]
                                                                ['MenuOffers']
                                                            .length >=
                                                        2
                                                    ? Row(
                                                        children: [
                                                          Text(
                                                            "OfferID ${restaurantDataCopy['Menus'][index]['MenuOffers'][0]['offerId']}, ",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.015,
                                                                color:
                                                                    kTextColor),
                                                          ),
                                                          Text(
                                                            "OfferID ${restaurantDataCopy['Menus'][index]['MenuOffers'][1]['offerId']}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.015,
                                                                color:
                                                                    kTextColor),
                                                          ),
                                                        ],
                                                      )
                                                    : Text(
                                                        "OfferID ${restaurantDataCopy['Menus'][index]['MenuOffers'][0]['offerId']}",
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.height *
                                                                    0.015,
                                                            color: kTextColor),
                                                      ),
                                              ),
                                            ],
                                          )
                                        : SizedBox()),
                              ),
                            ],
                          ),
                        ))
                  ])),
            ),
          );
        },
      ),
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
          restaurantDataCopy['name']);
    });
  }

  fun(value) {
    setState(() {
      data1 = value;
    });
  }
}
