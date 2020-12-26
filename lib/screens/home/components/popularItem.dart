import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:feasturent_costomer_app/constants.dart';

class PopularItem extends StatelessWidget {
  final String title, shopName, svgSrc;
  final Function press;
  const PopularItem({
    Key key,
    this.title,
    this.shopName,
    this.svgSrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provide you the total height and width of the screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      width: size.width * 0.95,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 20,
            color: Color(0xFFB0CCE1).withOpacity(0.32),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: size.width * 0.22,
                height: size.height * 0.09,
                margin: EdgeInsets.only(bottom: 0),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.13),
                  shape: BoxShape.rectangle,
                ),
                child: SvgPicture.asset(
                  svgSrc,
                  width: size.width * 0.13,
                  height: size.height * 0.04,
                  // size.width * 0.18 means it use 18% of total width
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: kTextColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '★★★★',
                    style: TextStyle(
                        color: kSecondaryTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        '₹ ',
                        style: TextStyle(
                            color: kSecondaryTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      Text(
                        '2000.00',
                        style: TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Spacer(),
              Column(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                      iconSize: 18,
                      icon: Icon(Icons.favorite, color: kSecondaryTextColor),
                      onPressed: press,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                      iconSize: 18,
                      icon:
                          Icon(Icons.shopping_cart, color: kSecondaryTextColor),
                      onPressed: press,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Text(
              //   shopName,
              //   style: TextStyle(fontSize: 12),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
