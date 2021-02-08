import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DineoutGridview extends StatefulWidget {
  @override
  _DineoutGridviewState createState() => _DineoutGridviewState();
}

class _DineoutGridviewState extends State<DineoutGridview> {
  final _decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            blurRadius: 3,
            offset: Offset(2, 3),
            color: Colors.grey[300],
            spreadRadius: 2)
      ]);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 4,
          children: [
            Container(
                decoration: _decoration,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/offer.svg",
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Outdoor")
                  ],
                )),
            Container(
                decoration: _decoration,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/offer.svg",
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Outdoor")
                  ],
                )),
            Container(
                decoration: _decoration,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/offer.svg",
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Outdoor")
                  ],
                )),
            Container(
                decoration: _decoration,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/offer.svg",
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Outdoor")
                  ],
                )),
            Container(
                decoration:_decoration,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/offer.svg",
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Outdoor")
                  ],
                )),
            Container(
                decoration:_decoration,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/offer.svg",
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Outdoor")
                  ],
                )),
            Container(
                decoration:_decoration,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/offer.svg",
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Outdoor")
                  ],
                )),
            Container(
                decoration: _decoration,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/offer.svg",
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Outdoor")
                  ],
                ),
                ),
          ]),
    );
  }
}
