import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';

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
    fetchCategory();
  }

  var categoryData = '';
  fetchCategory() {
    int k = data['cuisines'].length;
    print(k);

    if (k != 0) {
      for (int j = 0; j <= k - 1; j++) {
        categoryData =
            '$categoryData ${data['cuisines'][j]['Category']['name']},';
      }
    } else {
      categoryData = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [],
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                capitalize(
                    "${data['name']} is located in ${data['Address']['address']}"),
                maxLines: 5,
                style: GoogleFonts.firaSans(fontSize: 13, color: Colors.black),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/CUISINES.png',
                    height: 28,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "CUISINE",
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
                  child: categoryData != null
                      ? Text(
                          categoryData,
                          style: GoogleFonts.nanumGothic(
                              fontSize: 13, color: Colors.black),
                        )
                      : Text('Not added yet')),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/TYPES.png',
                    height: 28,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "TYPE",
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
                          style: GoogleFonts.nanumGothic(
                              fontSize: 13, color: Colors.black),
                        )
                      : Text("Not added yet")),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/AVERAGE COST.png',
                    height: 28,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "AVERAGE COST",
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
                          style: GoogleFonts.nanumGothic(
                              fontSize: 13, color: Colors.black),
                        )
                      : Text("Not added yet")),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/FEATURES & FACILITY.png',
                    height: 28,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "FACILITIES AND FEATURES",
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
                          style: GoogleFonts.nanumGothic(
                              fontSize: 13, color: Colors.black),
                        )
                      : Text("Not added yet")),
            ],
          ),
        ),
      ),
    );
  }
}
