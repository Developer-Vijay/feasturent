import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class TopbrandsSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        // Column(
        // children: [
        Text("Top Brands",
            style: TextStyle(fontWeight: FontWeight.bold, color: kTextColor)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/Pizzas.jpg")),
                      ),
                      width: size.width - 60,
                      height: size.height * 0.3,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFF961F).withOpacity(0.4),
                              kPrimaryColor.withOpacity(0.3),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: SvgPicture.asset(
                                    "assets/icons/macdonalds.svg"),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.white),
                                    children: [
                                      TextSpan(
                                        text: "Get Discount of \n",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      TextSpan(
                                        text: "40% \n",
                                        style: TextStyle(
                                          fontSize: 43,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "at Dominoes's on your first order & Instant cashback",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // child: Image.asset("assets/images/Cake.jpg", width: size.width - 50,)
                    ),
                    // Text(
                    //   "Best Cake",
                    //   style: TextStyle(color: Colors.white),
                    // ),
                  ],
                )),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/Pizzas.jpg")),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFF961F).withOpacity(0.4),
                      kPrimaryColor.withOpacity(0.3),
                    ],
                  ),
                ),
                width: size.width - 60,
                height: size.height * 0.3,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // gradient: LinearGradient(
                    //   colors: [
                    //     Color(0xFFFF961F).withOpacity(0.4),
                    //     kPrimaryColor.withOpacity(0.3),
                    //   ],
                    // ),
                  ),
                )
                // child: Image.asset("assets/images/Cake.jpg", width: size.width - 50,)
                ),
            Container(
                color: Colors.green,
                // width: 120,
                // height: size.height * 0.2,
                child: Image.asset(
                  "assets/images/Cake.jpg",
                  width: size.width - 50,
                ))
          ],
        )
      ],
    ));
  }
}
