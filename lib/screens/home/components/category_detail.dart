import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/Bottomsheet/addbar.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/cart_service.dart';
import 'package:feasturent_costomer_app/components/Cart.dart/addtoCart.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/profile/components/rating.dart';
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

  var pad = 34;

  void initState() {
    super.initState();
    getList();
    datamenu = widget.menuData;
    selectedRadioTile = 0;
  }

  List<String> checkdata = [];
  getList() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    setState(() {
      checkdata = cart.getStringList('addedtocart');
    });
    print(checkdata);
  }

  final services = UserServices();

  var datamenu;
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Container(
          height: size.height * 1,
          child: Stack(children: [
            Container(
              height: size.height * 0.45,
              width: size.width * 1,
              child: Stack(
                children: [
                  Swiper(
                    autoplayDelay: 2500,
                    autoplay: true,
                    itemCount: 3,
                    itemBuilder: (context, index) => Container(
                      child: datamenu['menuImage$index'] != null
                          ? CachedNetworkImage(
                              imageUrl:
                                  S3_BASE_PATH + datamenu['menuImage$index'],
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                          : Image.asset(
                              "assets/images/feasturenttemp.jpeg",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 25,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.favorite),
                        color: (isSelected) ? Colors.red : Colors.white,
                        onPressed: () {
                          if (isSelected == false) {
                            setState(() {
                              isSelected = true;
                              getItemandNavigateToFavourites(_index);
                              Fluttertoast.showToast(
                                  msg: "Item Added to favourites");
                            });
                          } else if (isSelected == true) {
                            setState(() {
                              isSelected = false;
                              removeItemFromFavourites(_index);
                              Fluttertoast.showToast(
                                  msg: "Item removed from Favourites");
                            });
                          }
                        },
                      ))
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
                            padding: const EdgeInsets.only(left: 34, top: 20),
                            child: Icon(
                              Icons.restaurant,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 21),
                            child: Text(
                              datamenu['categories']['name'],
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Spacer(),
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 24, top: 24),
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
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )),
                        ],
                      )),

                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              //color: Colors.red,

                              child: Text(
                                datamenu['title'],
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
                            padding: const EdgeInsets.only(left: 30, top: 2),
                            child: SmoothStarRating(
                                allowHalfRating: false,
                                onRated: (v) {
                                  Text("23");
                                },
                                starCount: 5,
                                rating: rating,
                                size: 23.0,
                                isReadOnly: true,
                                defaultIconData: Icons.star_border_outlined,
                                filledIconData: Icons.star,
                                halfFilledIconData: Icons.star_border,
                                color: Colors.amber,
                                borderColor: Colors.amber,
                                spacing: 0.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RatingPage()),
                                );
                              },
                              child: Text("24 Views"),
                            ),
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
                          padding: const EdgeInsets.only(right: 25, left: 25),
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
                              style: TextStyle(wordSpacing: 2, fontSize: 14),
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
                            left: size.width * 0.11, right: size.width * 0.11),
                        child: MaterialButton(
                          onPressed: () async {
                            int tpye = 0;

                            final SharedPreferences cart =
                                await SharedPreferences.getInstance();
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
                            if (data1.isEmpty) {
                              setState(() {
                                itemAddToCart(tpye);
                                Fluttertoast.showToast(msg: "Item Added");
                                checkdata.add(datamenu['menuId'].toString());
                                cart.setStringList('addedtocart', checkdata);
                              });
                            } else {
                              if (data1[0]['itemName'] != datamenu['title']) {
                                setState(() {
                                  itemAddToCart(tpye);
                                  checkdata.add(datamenu['menuId'].toString());
                                  cart.setStringList('addedtocart', checkdata);
                                });

                                Fluttertoast.showToast(msg: "Item Added");
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "${datamenu['title']} is already added");

                                print("match");
                              }
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
                              checkdata.contains(datamenu['menuId'].toString())
                                  ? Text(
                                      "Added",
                                      style: TextStyle(fontSize: 18),
                                    )
                                  : Text(
                                      "Add",
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
    ));
  }

  getItemandNavigateToFavourites(_index1) async {
    favourite.add(addto(
        isSelected: false,
        counter: 0,
        quantity: 0,
        id: burgerlist[_index1].id,
        subtitle: burgerlist[_index1].subtitle,
        foodPrice: burgerlist[_index1].foodPrice,
        title: burgerlist[_index1].title.toString(),
        starRating: burgerlist[_index1].starRating,
        name: burgerlist[_index1].name.toString(),
        discountText: burgerlist[_index1].discountText,
        vegsymbol: burgerlist[_index1].vegsymbol,
        discountImage: burgerlist[_index1].discountImage,
        foodImage: burgerlist[_index1].foodImage));
  }

  removeItemFromFavourites(_index1) async {
    favourite.clear();
  }

  itemAddToCart(tpye) async {
    final SharedPreferences cart = await SharedPreferences.getInstance();

    var sum = cart.getInt('price');
    sum = sum + datamenu['totalPrice'];
    cart.setInt('price', sum);
    print(sum);
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
          0);
    });
  }

  fun(value) {
    setState(() {
      data1 = value;
    });
  }
}
