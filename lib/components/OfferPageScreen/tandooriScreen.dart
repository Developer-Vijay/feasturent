import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/screens/home/slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'foodlistclass.dart';

class TandooriPage extends StatefulWidget {
  @override
  _TandooriPageState createState() => _TandooriPageState();
}

class _TandooriPageState extends State<TandooriPage> {
  int _index1 = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Tandoori",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: tandorilist.length,
          itemBuilder: (context, index) {
            print(tandorilist[index].discountText);
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FoodSlider()));
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
                    height: size.height * 0.12,
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
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: tandorilist[index].foodImage,
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
                                          print(tandorilist[index].index0);

                                          setState(() {
                                            _index1 = tandorilist[index].index0;
                                          });
                                          print(_index1);

                                          getItemandNavigateToCart(_index1);

                                          // showModalBottomSheet(
                                          //     context: context,
                                          //     builder: (context) =>
                                          //         Sheet());
                                        },
                                        color: Colors.white,
                                        minWidth: size.width * 0.16,
                                        height: size.height * 0.033,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14)),
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
                                                  fontSize: 10,
                                                  color: Colors.blueGrey),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 6),
                                  child: Row(
                                    children: [
                                      Text(
                                        tandorilist[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 16),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              tandorilist[index].vegsymbol,
                                          height: size.height * 0.02,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  tandorilist[index].subtitle,
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
                                        child: tandorilist[index].starRating,
                                      ),
                                      Text(
                                        "3.0",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: size.width * 0.1),
                                        child: Text(
                                          "₹${tandorilist[index].foodPrice}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                // Container(
                                //   child: Row(
                                //     children: [
                                //       CachedNetworkImage(
                                //         imageUrl:
                                //             tandorilist[index]
                                //                 .discountImage,
                                //         height: size.height * 0.026,
                                //       ),
                                //       SizedBox(
                                //         width: 2,
                                //       ),
                                //       Text(
                                //         tandorilist[index]
                                //             .discountText,
                                //         style: TextStyle(
                                //             fontSize: 12,
                                //             color: kTextColor),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ))
                    ])),
              ),
            );
          },
        ),
      ),
    );
  }

  getItemandNavigateToCart(_index1) async {
    // print(index1);
    print("add item");
    add2.add(addto(
        isSelected: false,
        counter: 0,
        quantity: 0,
        id: tandorilist[_index1].id,
        foodPrice: tandorilist[_index1].foodPrice,
        title: tandorilist[_index1].title.toString(),
        starRating: tandorilist[_index1].starRating,
        // name: tandorilist[_index1].name.toString(),
        discountText: tandorilist[_index1].discountText,
        vegsymbol: tandorilist[_index1].vegsymbol,
        discountImage: tandorilist[_index1].discountImage,
        foodImage: tandorilist[_index1].foodImage));

    Fluttertoast.showToast(msg: "Items Added TO the Cart $_index1");
  }
}
