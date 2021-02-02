import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/constants.dart';

class ItemCard extends StatelessWidget {
  final String title, shopName, categoryIcon;
  final Function press;
  const ItemCard({
    Key key,
    this.title,
    this.shopName,
    this.categoryIcon,
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
                  child: categoryIcon == null
                      ? Image.asset(
                          'assets/icons/foodnotfound.png',
                          width: size.width * 0.13,
                          height: size.height * 0.04,
                        )
                      : Image.network(
                          S3_BASE_PATH + categoryIcon,
                          width: size.width * 0.13,
                          height: size.height * 0.04,
                        ),
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
