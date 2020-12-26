import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:feasturent_costomer_app/constants.dart';

class ItemCard extends StatelessWidget {
  final String title, shopName, svgSrc;
  final Function press;
  const ItemCard({
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
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.7),
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
        child: InkWell(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 0),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.13),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    svgSrc,
                    width: size.width * 0.13,
                    height: size.height * 0.04,
                    // size.width * 0.18 means it use 18% of total width
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.white),
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
      ),
    );
  }
}
