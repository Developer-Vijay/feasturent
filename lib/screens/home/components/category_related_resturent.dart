import 'package:feasturent_costomer_app/components/menuRelatedScreens/resturent_menues.dart';
import 'package:feasturent_costomer_app/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';

class CategoryRelatedMenues extends StatefulWidget {
  final categoryName;
  final categoryid;
  const CategoryRelatedMenues({Key key, this.categoryName, this.categoryid})
      : super(key: key);
  @override
  _CategoryRelatedMenuesState createState() => _CategoryRelatedMenuesState();
}

class _CategoryRelatedMenuesState extends State<CategoryRelatedMenues> {
  @override
  void initState() {
    super.initState();
    setState(() {
      menuName = widget.categoryName;
      cateId = widget.categoryid;
    });
    print(menuName);
    getList();
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

  var menuName;
  var cateId;

  final services = UserServices();

  List<String> checkitem = [];
  getList() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      checkitem = cart.getStringList('addedtocart');
    });
    print("list");
    print(checkitem);
  }

  var restaurantDataCopy;
  var restaurantMenu;
  var restaurantData;

  Future<List<dynamic>> fetchAllRestaurant() async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  get resturents");

    var result = await http.get(Uri.parse(
      APP_ROUTES +
          'getRestaurantInfos' +
          '?key=BYCATID&id=$cateId' +
          '&latitude=' +
          latitude.toString() +
          '&longitude=' +
          longitude.toString(),
    ));
    print(result.statusCode);
    var restaurantfullData;
    if (result.statusCode == 200) {
      restaurantfullData = json.decode(result.body)['data'];
      if (restaurantfullData.isEmpty) {
        restaurantData = [];

        return restaurantData;
      } else {
        restaurantData = restaurantfullData;
        return restaurantData;
      }
    } else {
      restaurantData = [
        {"data": "error"}
      ];
      return restaurantData;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(capitalize(menuName)),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: fetchAllRestaurant(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.isNotEmpty
                  // ignore: unrelated_type_equality_checks
                  ? snapshot.data[0]['data'] == "error"
                      ? Center(
                          child: Text("Something went wrong"),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var couponDetatil;
                            // double rating = 1.0;
                            // int j =
                            //     snapshot.data[index]['VendorRatingReviews'].length;

                            // for (int i = 0; i < j - 1; i++) {
                            //   rating = rating +
                            //       double.parse(snapshot.data[index]
                            //           ['VendorRatingReviews'][i]['rating']);
                            // }
                            // rating = rating / j;
                            if (snapshot.data[index]['user']['OffersAndCoupons']
                                .isEmpty) {
                            } else {
                              if (snapshot.data[index]['user']
                                      ['OffersAndCoupons'][0]['discount'] ==
                                  null) {
                                String symbol;
                                if (snapshot.data[index]['user']
                                            ['OffersAndCoupons'][0]
                                        ['couponDiscountType'] ==
                                    "PERCENT") {
                                  symbol = "%";
                                } else {
                                  symbol = "₹";
                                }

                                couponDetatil =
                                    "${snapshot.data[index]['user']['OffersAndCoupons'][0]['couponDiscount']}$symbol off";
                              } else {
                                String symbol;
                                if (snapshot.data[index]['user']
                                            ['OffersAndCoupons'][0]
                                        ['discountType'] ==
                                    "PERCENT") {
                                  symbol = "%";
                                } else {
                                  symbol = "₹";
                                }

                                couponDetatil =
                                    "${snapshot.data[index]['user']['OffersAndCoupons'][0]['discount']}$symbol off";
                              }
                            }
                            int k = snapshot.data[index]['cuisines'].length;

                            var categoryData = '';
                            if (k != 0) {
                              for (int j = 0; j <= k - 1; j++) {
                                categoryData =
                                    '$categoryData${snapshot.data[index]['cuisines'][j]['Category']['name']},';
                              }
                            } else {
                              categoryData = null;
                            }
                            print(categoryData);
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OfferListPage(
                                            ratingVendor: snapshot.data[index]
                                                ['avgRating'],
                                            restaurantDa:
                                                snapshot.data[index])));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 2,
                                              color: Colors.grey[200],
                                              offset: Offset(0, 3),
                                              spreadRadius: 2)
                                        ]),
                                    margin: EdgeInsets.only(
                                      left: size.width * 0.02,
                                      right: size.width * 0.02,
                                    ),
                                    height: size.height * 0.135,
                                    child: Row(children: [
                                      Expanded(
                                          flex: 0,
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            height: size.height * 0.2,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(8),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: snapshot.data[index]
                                                                    ['user']
                                                                ['profile'] !=
                                                            null
                                                        ? CachedNetworkImage(
                                                            imageUrl: S3_BASE_PATH +
                                                                snapshot.data[
                                                                            index]
                                                                        ['user']
                                                                    ['profile'],
                                                            height:
                                                                size.height *
                                                                    0.18,
                                                            width: size.width *
                                                                0.3,
                                                            fit: BoxFit.fill,
                                                            placeholder: (context,
                                                                    url) =>
                                                                Center(
                                                                    child: Image
                                                                        .asset(
                                                              "assets/images/defaultrestaurent.png",
                                                              height:
                                                                  size.height *
                                                                      0.18,
                                                              width:
                                                                  size.width *
                                                                      0.3,
                                                              fit: BoxFit.cover,
                                                            )),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                          )
                                                        : Image.asset(
                                                            "assets/images/defaultrestaurent.png",
                                                            height:
                                                                size.height *
                                                                    0.18,
                                                            width: size.width *
                                                                0.3,
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                                      top: size.height * 0.02),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        capitalize(
                                                            snapshot.data[index]
                                                                ['name']),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize:
                                                                size.height *
                                                                    0.02),
                                                      ),
                                                      Spacer(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 12),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.005,
                                                ),
                                                categoryData == null
                                                    ? SizedBox()
                                                    : Container(
                                                        width:
                                                            size.width * 0.38,
                                                        child: Text(
                                                          "$categoryData",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize:
                                                                size.height *
                                                                    0.0175,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                SizedBox(
                                                  height: size.height * 0.015,
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      snapshot
                                                              .data[index]
                                                                  ['avgRating']
                                                              .isEmpty
                                                          ? Text(
                                                              "⭐1.0",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.height *
                                                                          0.016,
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Container(
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                        "⭐"),
                                                                  ),
                                                                  Text(
                                                                    "${snapshot.data[index]['avgRating'][0]['avgRating'].toStringAsFixed(1)}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            size.height *
                                                                                0.016,
                                                                        color: Colors
                                                                            .red,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                      Spacer(),
                                                      couponDetatil == null
                                                          ? SizedBox()
                                                          : Image.asset(
                                                              "assets/icons/discount_icon.jpg",
                                                              height:
                                                                  size.height *
                                                                      0.02,
                                                            ),
                                                      couponDetatil == null
                                                          ? snapshot.data[index]
                                                                      [
                                                                      'avgCost'] ==
                                                                  null
                                                              ? SizedBox()
                                                              : Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    right: 12.0,
                                                                  ),
                                                                  child: Text(
                                                                    "₹ ${snapshot.data[index]['avgCost']} Cost for ${snapshot.data[index]['forPeople']}",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            size.height *
                                                                                0.016,
                                                                        color:
                                                                            kTextColor),
                                                                  ),
                                                                )
                                                          : Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                right: 12.0,
                                                              ),
                                                              child: Text(
                                                                couponDetatil,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        size.height *
                                                                            0.016,
                                                                    color:
                                                                        kTextColor),
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                    ])),
                              ),
                            );
                          },
                        )
                  : Center(
                      child: Text(
                          "No resturent available related with this category"),
                    );
            } else {
              return LoadingListPage();
            }
          },
        ));
  }

  fun(value) {
    setState(() {
      data1 = value;
    });
  }
}
