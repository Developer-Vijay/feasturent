import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(blurRadius: 2, color: Colors.blue[100], spreadRadius: 2)
        ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "By the bay is a bar located in Netaji Subhash Place . The Price has a beach Theme ",
                maxLines: 5,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Icon(
                    Icons.food_bank,
                    color: Colors.orange[600],
                    size: 28,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Cuisines",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Multi-Cuisine , North Indian , Italian, AMerican ,Seafood",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Icon(
                    Icons.fastfood_rounded,
                    color: Colors.orange[600],
                    size: 28,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Type",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Cafe,Dineout Pay Future Vouchers,Safe To Eat Out , Contactless Dinning",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Icon(
                    Icons.food_bank,
                    color: Colors.orange[600],
                    size: 28,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Average Cost",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "1,500 for 2",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
