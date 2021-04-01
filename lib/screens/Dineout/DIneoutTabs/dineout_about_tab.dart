import 'package:flutter/material.dart';

class About extends StatefulWidget {
  final data;
  const About({this.data});
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  var data;
  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
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
                height: 10,
              ),
              Text(
              " ${data['name']} is located in ${data['Address']['address']}",
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
                  child: data['cuisine'] != null
                      ? Text(
                          data['cuisine'],
                          style: TextStyle(color: Colors.black),
                        )
                      : Text("Cuisenes")),
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
                  child: data['type'] != null
                      ? Text(
                          data['type'],
                          style: TextStyle(color: Colors.black),
                        )
                      : Text("type")),
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
                  child: data['avgCost'] != null
                      ? Text(
                          " ₹ ${data['avgCost']} for ${data['forPeople']}",
                          style: TextStyle(color: Colors.black),
                        )
                      : Text("avgCost")),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.filter_b_and_w,
                    color: Colors.orange[600],
                    size: 28,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "facilities and Features",
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
                  child: data['facilitiesFeatures'] != null
                      ? Text(
                          data['facilitiesFeatures'],
                          style: TextStyle(color: Colors.black),
                        )
                      : Text("type")),
            ],
          ),
        ),
      ),
    );
  }
}
