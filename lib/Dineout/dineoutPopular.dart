import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PopularDininingLists extends StatefulWidget {
  @override
  _PopularDininingListsState createState() => _PopularDininingListsState();
}

class _PopularDininingListsState extends State<PopularDininingLists> {
  final _textstyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Popular Dineout Areas",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                          height: size.height * 0.11,
                          width: size.width * 0.31,
                          child: FlatButton(
                            onPressed: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://media.gettyimages.com/photos/elegant-shopping-mall-picture-id182408547?s=2048x2048",
                                fit: BoxFit.cover,
                                width: size.width * 0.31,
                                height: size.height * 0.2,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text("V3S mall", style: _textstyle)
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                          margin: EdgeInsets.only(left: size.width * 0.001),
                          height: size.height * 0.11,
                          width: size.width * 0.31,
                          child: FlatButton(
                            onPressed: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://media.gettyimages.com/photos/cafebar-in-moscow-picture-id1158221681?s=2048x2048",
                                fit: BoxFit.cover,
                                width: size.width * 0.31,
                                height: size.height * 0.2,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text("Great Indian Place", style: _textstyle)
                  ],
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                          margin: EdgeInsets.only(left: size.width * 0.001),
                          height: size.height * 0.11,
                          width: size.width * 0.31,
                          child: FlatButton(
                            onPressed: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://media.gettyimages.com/photos/family-in-a-cafe-picture-id1089596346?k=6&m=1089596346&s=612x612&w=0&h=w3lny9JWOUDIBTQbMVNVDBu48KMw316UANpAhPV0zdk=",
                                fit: BoxFit.cover,
                                width: size.width * 0.31,
                                height: size.height * 0.2,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text("Ultra Bar", style: _textstyle),


                  ],
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                          margin: EdgeInsets.only(left: size.width * 0.001),
                          height: size.height * 0.11,
                          width: size.width * 0.31,
                          child: FlatButton(
                            onPressed: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://media.gettyimages.com/photos/cafebar-in-moscow-picture-id1158221681?s=2048x2048",
                                fit: BoxFit.cover,
                                width: size.width * 0.31,
                                height: size.height * 0.2,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text("Great Indian Place", style: _textstyle)
                  ],
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                          margin: EdgeInsets.only(left: size.width * 0.001),
                          height: size.height * 0.11,
                          width: size.width * 0.31,
                          child: FlatButton(
                            onPressed: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://media.gettyimages.com/photos/cafebar-in-moscow-picture-id1158221681?s=2048x2048",
                                fit: BoxFit.cover,
                                width: size.width * 0.31,
                                height: size.height * 0.2,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text("Great Indian Place", style: _textstyle)
                  ],
                ),


                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                          margin: EdgeInsets.only(left: size.width * 0.001),
                          height: size.height * 0.11,
                          width: size.width * 0.31,
                          child: FlatButton(
                            onPressed: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://media.gettyimages.com/photos/cafebar-in-moscow-picture-id1158221681?s=2048x2048",
                                fit: BoxFit.cover,
                                width: size.width * 0.31,
                                height: size.height * 0.2,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text("Great Indian Place", style: _textstyle)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
