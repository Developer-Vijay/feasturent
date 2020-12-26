import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/components/popularItem.dart';
import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/screens/details/details-screen.dart';

class PopularList extends StatelessWidget {
  const PopularList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular on feasturent",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: kTextColor),
              ),
              FlatButton(
                  onPressed: () => {print('View All')},
                  child: Row(
                    children: [
                      Text(
                        "View All",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: kPrimaryColor),
                      ),
                      Icon(
                        Icons.arrow_right_rounded,
                        color: kSecondaryTextColor,
                      )
                    ],
                  ))
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              PopularItem(
                svgSrc: "assets/icons/burger_beer.svg",
                title: "Burger & Beer",
                shopName: "MacDonald's",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DetailsScreen();
                      },
                    ),
                  );
                },
              ),
              PopularItem(
                svgSrc: "assets/icons/chinese_noodles.svg",
                title: "Chinese & Noodles",
                shopName: "Wendys",
                press: () {},
              ),
              PopularItem(
                svgSrc: "assets/icons/burger_beer.svg",
                title: "Burger & Beer",
                shopName: "MacDonald's",
                press: () {},
              ),
              PopularItem(
                svgSrc: "assets/icons/chinese_noodles.svg",
                title: "Maggie",
                shopName: "Wendys",
                press: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
