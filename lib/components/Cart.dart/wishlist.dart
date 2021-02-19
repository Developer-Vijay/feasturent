import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  int _index1 =0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Favourites",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView.builder(
            itemCount: favourite.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onLongPress: () {
                      Fluttertoast.showToast(msg: "Long Presses");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                color: Colors.blue[50],
                                spreadRadius: 3,
                                offset: Offset(0, 3))
                          ]),
                      child: Dismissible(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: size.width * 0.76,
                                    height: size.height * 0.11,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 0,
                                          child: Container(
                                              alignment: Alignment.topLeft,
                                              height: size.height * 0.2,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 4, right: 4, top: 4),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl: favourite[index]
                                                        .foodImage,
                                                    height: size.height * 0.09,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Expanded(
                                            flex: 6,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 4),
                                              height: size.height * 0.2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: 6,
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          favourite[index]
                                                              .title,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                        ),
                                                        Spacer(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 12),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                favourite[index]
                                                                    .vegsymbol,
                                                            height:
                                                                size.height *
                                                                    0.016,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "${favourite[index].subtitle}",
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          child:
                                                              favourite[index]
                                                                  .starRating,
                                                        ),
                                                        Text(
                                                          "3.0",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 50,
                                                        ),
                                                        Text(
                                                          "₹${favourite[index].foodPrice}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),

                        key: ValueKey(index),
                        secondaryBackground: Container(
                          color: Colors.red,
                          padding: EdgeInsets.only(right: 10),
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        background: Container(
                          color: Colors.blue,
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.add_to_photos,
                            color: Colors.white,
                          ),
                        ),

                        // ignore: missing_return
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            final bool res = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(
                                        "Are you sure you want to delete ${favourite[index].title}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                         
                                          setState(() {
                                            favourite.removeAt(index);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });

                            return res;
                          } else if (direction ==
                              DismissDirection.startToEnd) {
                                if(favourite[index].counter==0){
                                   moveItemFromFavaouriteToCart(_index1);
                                }
                               
                                Fluttertoast.showToast(msg:"Item added to Cart" );
                              }
                        },
                      ),
                    )),
              );
            }));
  }

  moveItemFromFavaouriteToCart(_index1) async {
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

        

        
  }
}
