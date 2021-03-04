import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:feasturent_costomer_app/components/Bottomsheet/offerBottomsheet.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/ResturentInfo/resturentDetail.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/offerpage.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/tandooriScreen.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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
      restaurantDataCopy = widget.restaurantDa;
    });
  }

  int _index1 = 0;
  int isSelect = 0;
  var restaurantDataCopy;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          floatingActionButton: MaterialButton(
            onPressed: () {},
            child: PopupMenuButton(
                child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.12,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24)),
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    )),
                offset: Offset(-1.0, -220.0),
                elevation: 0,
                color: Colors.grey[100],
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
                            padding: EdgeInsets.only(top: 20),
                            itemCount: menu.length,
                            itemBuilder: (context, index) {
                              final trans = menu[index].title;
                              return InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TandooriPage(),
                                          settings: RouteSettings(
                                              arguments: menu[index])));
                                },
                                child: ListTile(
                                  enabled: true,
                                  selected: index == isSelect,
                                  title: Text(
                                    menu[index].title,
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
                        width: size.width * 0.8,
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
                    setState(() {
                      // tempIndex = resturentIndex.index0;
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResturentDetail(),
                          // settings: RouteSettings(
                          //   arguments: foodlist[tempIndex],
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
                          builder: (context) => OfferPageScreen(null)),
                    );
                  })),
          body: ListView(
            children: [
              Column(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(
                          top: size.height * 0.01, left: size.width * 0.03),
                      child: Text(
                        "Restaurant Category",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w700),
                      )),
                  Row(
                    children: [
                      Container(
                          width: size.height * 0.25,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                              top: size.height * 0.01,
                              left: size.width * 0.033),
                          child: Text(
                            restaurantDataCopy['Address']['address'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          )),
                      Spacer(),
                      Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(
                            top: size.height * 0.01, right: size.width * 0.033),
                        child: Text(
                          "Mobile No- +91 ${restaurantDataCopy['contact']}",
                          style: TextStyle(
                              fontSize: size.height * 0.016,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
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
                            "39 minutes",
                            style: offerRowHeadingStyle,
                          ),
                          Text("Delivery Time")
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: size.width * 0.02),
                        child: Column(
                          children: [
                            Text("₹ 75", style: offerRowHeadingStyle),
                            Text("Cost for one")
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

                  Container(
                    height: size.height * 0.08,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => OnOfferBottomSheet());
                          },
                          child: Container(                            margin: EdgeInsets.all(4),

                            padding: EdgeInsets.all(4),
                            height: size.height * 0.1,
                            width: size.width * 0.42,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    color: Colors.blue[50],
                                    offset: Offset(1,3),
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
                                          top: size.height * 0.01),
                                      child: SvgPicture.asset(
                                        "assets/icons/offer.svg",
                                        width: size.width * 0.04,
                                      )),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: size.width * 0.002,
                                        top: size.height * 0.01),
                                    child: Text(
                                      "50%OFFUPTO100",
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
                                    "Use Welcome50",
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
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://media.gettyimages.com/vectors/logo-of-two-green-leaves-in-a-yellow-background-vector-id186896873?k=6&m=186896873&s=612x612&w=0&h=nwQBGKYtsyeD4TlxoGtH6SSENQENlZGxmTXAwIWBJ5k=",
                            height: size.height * 0.03,
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                            left: size.width * 0.03,
                          ),
                          child: Text(
                            "PURE VEG",
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
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoodSlider()));
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl: insideOfferPage[index]
                                                    .foodImage,
                                                height: size.height * 0.1,
                                                width: size.width * 0.26,
                                                fit: BoxFit.fill,
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
                                              onPressed: () {
                                                if (insideOfferPage[index]
                                                        .addedStatus ==
                                                    "Add") {
                                                  final snackBar = SnackBar(
                                                    backgroundColor: Colors
                                                        .lightBlueAccent[200],
                                                    content: Text(
                                                        "${insideOfferPage[index].title} is added to cart"),
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
                                                  getItemandNavigateToCart(
                                                      index);
                                                  setState(() {
                                                    insideOfferPage[index]
                                                        .addedStatus = "Added";
                                                  });
                                                } else if (insideOfferPage[
                                                            index]
                                                        .addedStatus ==
                                                    "Added") {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "${insideOfferPage[index].title} is already added");
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
                                              child: Center(
                                                  child: buttonText(
                                                      insideOfferPage[index]
                                                          .index0)),
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
                                                      fontSize:
                                                          size.height * 0.019),
                                                ),
                                                Spacer(),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 12),
                                                    child: restaurantDataCopy[
                                                                        'Menus']
                                                                    [index]
                                                                ['isNonVeg'] ==
                                                            false
                                                        ? restaurantDataCopy[
                                                                            'Menus']
                                                                        [index]
                                                                    ['isEgg'] ==
                                                                false
                                                            ? Container(
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      'https://www.pngkey.com/png/full/261-2619381_chitr-veg-symbol-svg-veg-and-non-veg.png',
                                                                  height:
                                                                      size.height *
                                                                          0.016,
                                                                ),
                                                              )
                                                            : Container(
                                                                child:
                                                                    Image.asset(
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
                                                          ))
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: size.height * 0.005),
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
                                                      ? CachedNetworkImage(
                                                          imageUrl:
                                                              insideOfferPage[
                                                                      index]
                                                                  .discountImage,
                                                          height: size.height *
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
                                                Container(
                                                  child: insideOfferPage[index]
                                                      .starRating,
                                                ),
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
                                                      right: size.width * 0.1),
                                                  child: Text(
                                                    "₹${restaurantDataCopy['Menus'][index]['totalPrice']}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.018,
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
                                                          CachedNetworkImage(
                                                            imageUrl:
                                                                insideOfferPage[
                                                                        index]
                                                                    .discountImage,
                                                            height:
                                                                size.height *
                                                                    0.02,
                                                          ),
                                                          SizedBox(
                                                            width: size.width *
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
                                                                            fontSize: size.height *
                                                                                0.015,
                                                                            color:
                                                                                kTextColor),
                                                                      ),
                                                                      Text(
                                                                        "OfferID ${restaurantDataCopy['Menus'][index]['MenuOffers'][1]['offerId']}",
                                                                        style: TextStyle(
                                                                            fontSize: size.height *
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
                              ])),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          )),
    );
  }

  buttonText(index) {
    if (insideOfferPage[index].addedStatus == "Add") {
      return Row(
        children: [
          Icon(
            Icons.add,
            size: 15,
            color: Colors.blueGrey,
          ),
          Text(
            insideOfferPage[index].addedStatus,
            style: TextStyle(fontSize: 10, color: Colors.blueGrey),
          ),
        ],
      );
    } else if (insideOfferPage[index].addedStatus == "Added") {
      return Row(
        children: [
          Text(
            insideOfferPage[index].addedStatus,
            style: TextStyle(fontSize: 10, color: Colors.blueGrey),
          ),
        ],
      );
    }
  }

  getItemandNavigateToCart(index) async {
    sumtotal = sumtotal + insideOfferPage[index].foodPrice;

    add2.add(addto(
        isSelected: false,
        counter: 1,
        quantity: 0,
        sum1: 0,
        id: insideOfferPage[index].index0,
        foodPrice: insideOfferPage[index].foodPrice,
        title: insideOfferPage[index].title.toString(),
        starRating: insideOfferPage[index].starRating,
        name: insideOfferPage[index].name.toString(),
        discountText: insideOfferPage[index].discountText,
        vegsymbol: insideOfferPage[index].vegsymbol,
        discountImage: insideOfferPage[index].discountImage,
        foodImage: insideOfferPage[index].foodImage));
  }
}
