import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:feasturent_costomer_app/components/Bottomsheet/offerBottomsheet.dart';
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
  @override
  _OfferListPageState createState() => _OfferListPageState();
}

class _OfferListPageState extends State<OfferListPage> {
  int _index1 = 0;
  int isSelect = 0;
  var tempIndex;

  final _containerDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(
          blurRadius: 2,
          offset: Offset(1, 3),
          color: Colors.blue[50],
          spreadRadius: 2)
    ],
    borderRadius: BorderRadius.circular(5),
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    final ListofFood resturentIndex = ModalRoute.of(context).settings.arguments;

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
                              return ListTile(
                                enabled: true,
                                selected: index == isSelect,
                                title: Text(
                                  trans.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                onTap: () {
                                  if (menu[index].number == 0) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TandooriPage()));
                                  }
                                  index = isSelect;
                                },
                              );
                            },
                          ),
                        ),
                        height: size.height * 0.2,
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
                        fontSize: 14),
                  ),
                  onPressed: () {
                    setState(() {
                      tempIndex = resturentIndex.index0;
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResturentDetail(),
                          settings: RouteSettings(
                            arguments: foodlist[tempIndex],
                          ),
                        ));
                  },
                )
              ],
              title: Text(
                resturentIndex.title,
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
                          builder: (context) => OfferPageScreen()),
                    );
                  })),
          body: ListView(
            children: [
              Column(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 5, left: 15),
                      child: Text(
                        "Indian",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )),
                  Row(
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                              top: size.height * 0.01,
                              left: size.width * 0.033),
                          child: Text(
                            "Burari | 17km",
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
                          "Mobile No- +91 9818069709",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  DottedLine(),
                  SizedBox(
                    height: 20,
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
                                    size: 23.0,
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
                    height: 20,
                  ),
                  DottedLine(),
                  SizedBox(
                    height: 15,
                  ),

                  // List of Discounts

                  Container(
                    height: size.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => OnOfferBottomSheet());
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                height: size.height * 0.068,
                                width: size.width * 0.42,
                                decoration: _containerDecoration,
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01),
                                          child: SvgPicture.asset(
                                            "assets/icons/offer.svg",
                                            width: 15,
                                          )),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: size.width * 0.002,
                                            top: size.height * 0.01),
                                        child: Text(
                                          "50%OFFUPTO100",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
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
                                        style: TextStyle(fontSize: 12),
                                      ))
                                ]),
                              ),
                            ),
                            // Second List
                            SizedBox(
                              width: 12,
                            ),

                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => OnOfferBottomSheet());
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                height: size.height * 0.068,
                                width: size.width * 0.42,
                                decoration: _containerDecoration,
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01),
                                          child: SvgPicture.asset(
                                            "assets/icons/offer.svg",
                                            width: 15,
                                          )),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: size.width * 0.002,
                                            top: size.height * 0.01),
                                        child: Text(
                                          "30%OFFUPTO100",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
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
                                        style: TextStyle(fontSize: 12),
                                      ))
                                ]),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),

                            // Third List
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => OnOfferBottomSheet());
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                height: size.height * 0.068,
                                width: size.width * 0.42,
                                decoration: _containerDecoration,
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01),
                                          child: SvgPicture.asset(
                                            "assets/icons/offer.svg",
                                            width: 15,
                                          )),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: size.width * 0.002,
                                            top: size.height * 0.01),
                                        child: Text(
                                          "20%OFFUPTO100",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                                        style: TextStyle(fontSize: 12),
                                      ))
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                            height: 30,
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
                    itemCount: insideOfferPage.length,
                    itemBuilder: (context, index) {
                      print(insideOfferPage[index].discountText);
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
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      height: size.height * 0.2,
                                      child: Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 4, right: 4, top: 4),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl: insideOfferPage[index]
                                                    .foodImage,
                                                height: size.height * 0.1,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          // For Add Button
                                          Align(
                                            widthFactor: size.width * 0.00368,
                                            alignment: Alignment.bottomCenter,
                                            heightFactor: size.height * 0.00276,
                                            child: Container(
                                              child: MaterialButton(
                                                  onPressed: () {
                                                    addBottonFunction(
                                                        insideOfferPage[index]
                                                            .index0);
                                                  },
                                                  color: Colors.white,
                                                  minWidth: size.width * 0.16,
                                                  height: size.height * 0.033,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14)),
                                                  textColor: Colors.white,
                                                  child: buttonText(
                                                      insideOfferPage[index]
                                                          .index0)),
                                            ),
                                          )
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
                                            margin: EdgeInsets.only(top: 6),
                                            child: Row(
                                              children: [
                                                Text(
                                                  insideOfferPage[index].title,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 12),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        insideOfferPage[index]
                                                            .vegsymbol,
                                                    height: size.height * 0.02,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            insideOfferPage[index].subtitle,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 3,
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
                                                      fontSize: 13,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Spacer(),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: size.width * 0.1),
                                                  child: Text(
                                                    "₹${insideOfferPage[index].foodPrice}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl:
                                                      insideOfferPage[index]
                                                          .discountImage,
                                                  height: size.height * 0.026,
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  insideOfferPage[index]
                                                      .discountText,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: kTextColor),
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
                ],
              )
            ],
          )),
    );
  }

  addBottonFunction(index) {
    if (insideOfferPage[index].addedStatus == "Add") {
      print(insideOfferPage[index].index0);
      Fluttertoast.showToast(msg: "${insideOfferPage[index].title} is added");

      print(_index1);

      getItemandNavigateToCart(index);
      setState(() {
        insideOfferPage[index].addedStatus = "Added";
      });
    } else if (insideOfferPage[index].addedStatus == "Added") {
      Fluttertoast.showToast(
          msg: "${insideOfferPage[index].title} is already added");
    }
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
    // print(index1);
    print("add item");
    add2.add(addto(
        isSelected: false,
        counter: 1,
        quantity: 0,
        id: insideOfferPage[index].id,
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
