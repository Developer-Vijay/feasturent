import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/resturent_menues.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class ViewallRestaurant extends StatefulWidget {
  final restData;
  const ViewallRestaurant({Key key, this.restData}) : super(key: key);
  @override
  _ViewallRestaurantState createState() => _ViewallRestaurantState();
}

class _ViewallRestaurantState extends State<ViewallRestaurant> {
  @override
  void initState() {
    super.initState();
    setState(() {
      restaurantData = widget.restData;
      print(restaurantData);
    });
  }

  var restaurantData;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("All Restaurant"),
        ),
        body: Container(
          child: widget.restData.length == 0
              ? Center(
                  child: Container(
                    child: Image.asset(
                      "assets/images/norestaurent.png",
                      height: 200,
                      width: 300,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: restaurantData.length,
                  itemBuilder: (context, index) {
                    var couponDetatil;

                    if (restaurantData[index]['user']['OffersAndCoupons']
                        .isEmpty) {
                    } else {
                      if (restaurantData[index]['user']['OffersAndCoupons'][0]
                              ['discount'] ==
                          null) {
                        String symbol;
                        if (restaurantData[index]['user']['OffersAndCoupons'][0]
                                ['couponDiscountType'] ==
                            "PERCENT") {
                          symbol = "%";
                        } else {
                          symbol = "???";
                        }

                        couponDetatil =
                            "${restaurantData[index]['user']['OffersAndCoupons'][0]['couponDiscount']}$symbol off";
                      } else {
                        String symbol;
                        if (restaurantData[index]['user']['OffersAndCoupons'][0]
                                ['discountType'] ==
                            "PERCENT") {
                          symbol = "%";
                        } else {
                          symbol = "???";
                        }

                        couponDetatil =
                            "${restaurantData[index]['user']['OffersAndCoupons'][0]['discount']}$symbol off";
                      }
                    }

                    int k = restaurantData[index]['cuisines'].length;
                    print(k);
                    var categoryData = '';
                    if (k != 0) {
                      for (int j = 0; j <= k - 1; j++) {
                        categoryData =
                            '$categoryData${restaurantData[index]['cuisines'][j]['Category']['name']},';
                      }
                    } else {
                      categoryData = null;
                    }
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OfferListPage(
                                    ratingVendor: restaurantData[index]
                                        ['avgRating'],
                                    restaurantDa: restaurantData[index])));
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
                                                BorderRadius.circular(10),
                                            child: restaurantData[index]['user']
                                                        ['profile'] !=
                                                    null
                                                ? CachedNetworkImage(
                                                    imageUrl: S3_BASE_PATH +
                                                        restaurantData[index]
                                                            ['user']['profile'],
                                                    height: size.height * 0.18,
                                                    width: size.width * 0.3,
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                      "assets/images/defaultrestaurent.png",
                                                      height:
                                                          size.height * 0.18,
                                                      width: size.width * 0.3,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  )
                                                : Image.asset(
                                                    "assets/images/defaultrestaurent.png",
                                                    height: size.height * 0.18,
                                                    width: size.width * 0.3,
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
                                                capitalize(restaurantData[index]
                                                    ['name']),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize:
                                                        size.height * 0.02),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
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
                                                width: size.width * 0.5,
                                                child: Text(
                                                  "$categoryData",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.0175,
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
                                              restaurantData[index]
                                                          ['avgRating'] ==
                                                      null
                                                  ? Text(
                                                      "???1.0",
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.height *
                                                                  0.016,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : Container(
                                                      child: Row(children: [
                                                      Container(
                                                        child: Text("???"),
                                                      ),
                                                      Text(
                                                        "${restaurantData[index]['avgRating']}",
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.height *
                                                                    0.016,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ])),
                                              Spacer(),
                                              couponDetatil == null
                                                  ? SizedBox()
                                                  : Image.asset(
                                                      "assets/icons/discount_icon.jpg",
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                              couponDetatil == null
                                                  ? restaurantData[index]
                                                              ['avgCost'] ==
                                                          ''
                                                      ? SizedBox()
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: 12.0,
                                                          ),
                                                          child: Text(
                                                            "??? ${restaurantData[index]['avgCost']} Cost for ${restaurantData[index]['forPeople']}",
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
                                                          const EdgeInsets.only(
                                                        right: 12.0,
                                                      ),
                                                      child: Text(
                                                        couponDetatil,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                size.height *
                                                                    0.016,
                                                            color: kTextColor),
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
                ),
        ));
  }
}
