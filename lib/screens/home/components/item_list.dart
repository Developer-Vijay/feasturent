import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/screens/details/details-screen.dart';
import 'package:feasturent_costomer_app/screens/home/components/item_card.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
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
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              ItemCard(
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
              ItemCard(
                svgSrc: "assets/icons/chinese_noodles.svg",
                title: "Chinese & Noodles",
                shopName: "Wendys",
                press: () {},
              ),
              ItemCard(
                svgSrc: "assets/icons/burger_beer.svg",
                title: "Burger & Beer",
                shopName: "MacDonald's",
                press: () {},
              ),
              ItemCard(
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
