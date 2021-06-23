import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OfferResatuarantEffect extends StatefulWidget {
  @override
  _OfferResatuarantEffectState createState() => _OfferResatuarantEffectState();
}

class _OfferResatuarantEffectState extends State<OfferResatuarantEffect> {
  bool _enabled = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          enabled: _enabled,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                        top: size.height * 0.02, left: size.width * 0.036),
                    height: size.height * 0.026,
                    width: size.width * 0.3,
                  ),

                  Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 5, left: 15),
                        height: size.height * 0.026,
                        color: Colors.white,
                        width: size.width * 0.3,
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 5, left: 15),
                        height: size.height * 0.026,
                        color: Colors.white,
                        width: size.width * 0.3,
                      ),
                    ],
                  ),

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
                                height: size.height * 0.05,
                                width: size.width * 0.9,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Container(
                    height: size.height * 0.04,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              height: size.height * 0.068,
                              width: size.width * 0.42,
                              color: Colors.white,
                              child: Column(children: [
                                Row(
                                  children: [
                                    Container(
                                      height: size.height * 0.068,
                                      width: size.width * 0.42,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      height: size.height * 0.068,
                                      width: size.width * 0.42,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: size.height * 0.068,
                                  width: size.width * 0.42,
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.08,
                                      top: size.height * 0.002),
                                )
                              ]),
                            ),
                            // Second List
                            SizedBox(
                              width: 12,
                            ),

                            Container(
                              padding: EdgeInsets.all(4),
                              height: size.height * 0.068,
                              width: size.width * 0.42,
                              child: Column(children: [
                                Row(
                                  children: [
                                    Container(
                                      height: size.height * 0.068,
                                      width: size.width * 0.42,
                                      color: Colors.white,
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.02,
                                          top: size.height * 0.01),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      height: size.height * 0.068,
                                      width: size.width * 0.42,
                                      color: Colors.white,
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.02,
                                          top: size.height * 0.01),
                                    )
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: size.height * 0.03,
                                  width: size.width * 0.42,
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.08,
                                      top: size.height * 0.002),
                                )
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // List 1
                  ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
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
                                              child: Container(
                                                height: size.height * 0.026,
                                                width: size.width * 0.026,
                                              )),
                                        ),
                                        // For Add Button
                                        Align(
                                            widthFactor: 1.42,
                                            alignment: Alignment.bottomCenter,
                                            heightFactor: 2.2,
                                            child: Container(
                                              height: size.height * 0.026,
                                              width: size.width * 0.026,
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
                                          margin: EdgeInsets.only(top: 6),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: size.height * 0.026,
                                                width: size.width * 0.026,
                                              ),
                                              Spacer(),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 12),
                                                  child: Container(
                                                    height: size.height * 0.026,
                                                    width: size.width * 0.026,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Container(
                                          height: size.height * 0.026,
                                          width: size.width * 0.026,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                height: size.height * 0.026,
                                                width: size.width * 0.026,
                                              ),
                                              Container(
                                                height: size.height * 0.026,
                                                width: size.width * 0.026,
                                              ),
                                              Spacer(),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: size.width * 0.1),
                                                  child: Container(
                                                    height: size.height * 0.026,
                                                    width: size.width * 0.026,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                height: size.height * 0.026,
                                                width: size.width * 0.026,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Container(
                                                height: size.height * 0.026,
                                                width: size.width * 0.026,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                            ])),
                      );
                    },
                  )
                ],
              )
            ],
          )),
    );
  }
}
