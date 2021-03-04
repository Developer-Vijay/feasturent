import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constants.dart';

class PizzaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(body: Detail()));
  }
}

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

final imageList = [
  "https://media.gettyimages.com/photos/lamb-greek-burger-picture-id637790866?k=6&m=637790866&s=612x612&w=0&h=-VCta3l64UbGq8kJ2Y5rSJJL7-3dSiy-F7wQ6qBKssk=",
  "https://media.gettyimages.com/photos/tasty-hamburger-with-french-fries-on-wooden-table-picture-id872841180?k=6&m=872841180&s=612x612&w=0&h=wQ5og6yidpAUqYq4__09lwh7311vLh2SGXuSG9UeYxQ=",
  "https://media.gettyimages.com/photos/cheeseburger-with-french-fries-picture-id922684138?k=6&m=922684138&s=612x612&w=0&h=-YJjzZ3M99r4luEeryvGXpJnS2VA5mgc4oayeN04Oys="
];

class _DetailState extends State<Detail> {
  int _index1 = 0;

  final imageList = [
    "https://media.gettyimages.com/photos/lamb-greek-burger-picture-id637790866?k=6&m=637790866&s=612x612&w=0&h=-VCta3l64UbGq8kJ2Y5rSJJL7-3dSiy-F7wQ6qBKssk=",
    "https://media.gettyimages.com/photos/tasty-hamburger-with-french-fries-on-wooden-table-picture-id872841180?k=6&m=872841180&s=612x612&w=0&h=wQ5og6yidpAUqYq4__09lwh7311vLh2SGXuSG9UeYxQ=",
    "https://media.gettyimages.com/photos/cheeseburger-with-french-fries-picture-id922684138?k=6&m=922684138&s=612x612&w=0&h=-YJjzZ3M99r4luEeryvGXpJnS2VA5mgc4oayeN04Oys="
  ];
  @override
  Widget build(BuildContext context) {
    var rating = 3.0;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: size.height * 0.35,
              floating: false,
              pinned: true,
              toolbarHeight: size.height * 0.065,
              title: Text("Resturent Name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.height * 0.028,
                  )),
              flexibleSpace: FlexibleSpaceBar(
                  background: Swiper(
                itemCount: foodlist.length,
                itemBuilder: (BuildContext context, int index) =>
                    CachedNetworkImage(
                  imageUrl: foodlist[index].foodImage,
                  fit: BoxFit.cover,
                ),
                autoplayDelay: 2000,
                autoplay: true,
              )),
            ),
            // List Starts From Here
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
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
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 4, right: 4, top: 4),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  burgerlist[index].foodImage,
                                              height: size.height * 0.1,
                                              width: size.width * 0.26,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        // For Add Button
                                        Align(
                                            widthFactor: size.width * 0.0038,
                                            alignment: Alignment.bottomCenter,
                                            heightFactor: size.height * 0.9,
                                            child: Container(
                                              child: MaterialButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _index1 = burgerlist[index]
                                                        .index0;
                                                  });

                                                  getItemandNavigateToCart(
                                                      _index1);
                                                },
                                                color: Colors.white,
                                                minWidth: size.width * 0.17,
                                                height: size.height * 0.033,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14)),
                                                textColor: Colors.white,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.add,
                                                      size: size.height * 0.02,
                                                      color: Colors.blueGrey,
                                                    ),
                                                    Text(
                                                      "ADD",
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.height *
                                                                  0.013,
                                                          color:
                                                              Colors.blueGrey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))
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
                                              top: size.height * 0.01),
                                          padding: EdgeInsets.zero,
                                          child: Row(
                                            children: [
                                              Text(
                                                burgerlist[index].title,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: size.height * 0.016,
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.05,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: CachedNetworkImage(
                                                  imageUrl: burgerlist[index]
                                                      .vegsymbol,
                                                  height: size.height * 0.015,
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (burgerlist[index]
                                                            .isPressed ==
                                                        false) {
                                                      setState(() {
                                                        _index1 =
                                                            burgerlist[index]
                                                                .index0;

                                                        burgerlist[index]
                                                            .isPressed = true;
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Item Added to wishlist");
                                                      });
                                                      getItemandNavigateToFavourites(
                                                          _index1);
                                                    } else if (burgerlist[index]
                                                            .isPressed ==
                                                        true) {
                                                      setState(() {
                                                        burgerlist[index]
                                                            .isPressed = false;
                                                        _index1 =
                                                            burgerlist[index]
                                                                .index0;
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Item removed From Wishlist");
                                                      });
                                                      removeItemFromFavourites(
                                                          _index1);
                                                    }
                                                  },
                                                  child: Icon(
                                                    (Icons.favorite),
                                                    color: (burgerlist[index]
                                                            .isPressed)
                                                        ? Colors.red
                                                        : Colors.grey,
                                                    size: size.height * 0.024,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Text(
                                          burgerlist[index].subtitle,
                                          style: TextStyle(
                                              fontSize: size.height * 0.016,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.006,
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                child: burgerlist[index]
                                                    .starRating,
                                              ),
                                              Text(
                                                "$rating",
                                                style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.016,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: size.height * 0.004,
                                              ),
                                              CachedNetworkImage(
                                                imageUrl: burgerlist[index]
                                                    .discountImage,
                                                height: size.height * 0.02,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.01,
                                              ),
                                              Text(
                                                burgerlist[index].discountText,
                                                style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.014,
                                                    color: kTextColor),
                                              ),
                                              Spacer(),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: size.width * 0.1),
                                                child: Text(
                                                  "₹${burgerlist[index].foodPrice}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          size.height * 0.018,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                  childCount: burgerlist.length),
            )
          ],
        ),
      ),
    );
  }

  getItemandNavigateToCart(_index1) async {
    add2.add(addto(
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

    Fluttertoast.showToast(msg: "Items Added TO the Cart $_index1");
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
}
