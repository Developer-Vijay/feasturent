import 'package:feasturent_costomer_app/screens/home/slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Bottomsheetwidget(),
    );
  }
}

class Bottomsheetwidget extends StatefulWidget {
  @override
  _BottomsheetwidgetState createState() => _BottomsheetwidgetState();
}

class _BottomsheetwidgetState extends State<Bottomsheetwidget> {
  var _checked = false;
  var _checked2 = false;
  int selectedRadioTile = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        height: 500,
        margin: EdgeInsets.all(6),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cheese Burger",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: (IconButton(
                          icon: Icon(
                            Icons.clear,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoodSlider()),
                            );
                          },
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Expanded(
              flex: 16,
              child: ListView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "Choose Your Bun",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Please Select Any Option",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      RadioListTile(
                        title: Text(
                          "Regular",
                          style: TextStyle(fontSize: 14),
                        ),
                        groupValue: selectedRadioTile,
                        value: 1,
                        selected: false,
                        activeColor: Colors.blue,
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (val) {
                          setState(() {
                            selectedRadioTile = val;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Wheat"),
                        subtitle: Text(
                          "₹ 10",
                          style: TextStyle(fontSize: 15),
                        ),
                        groupValue: selectedRadioTile,
                        value: 2,
                        controlAffinity: ListTileControlAffinity.trailing,
                        selected: false,
                        activeColor: Colors.blue,
                        onChanged: (val) {
                          setState(() {
                            selectedRadioTile = val;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Extra",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      CheckboxListTile(
                        value: _checked,
                        onChanged: (bool value) {
                          setState(() {
                            print(value);
                            _checked = value;
                          });
                        },
                        title: Text(
                          "Barbeque Mayonese",
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: Text("₹ 10"),
                      ),
                      CheckboxListTile(
                        value: _checked2,
                        onChanged: (value) {
                          setState(() {
                            print(value);
                            _checked2 = value;
                          });
                        },
                        title: Text(
                          "Cheese",
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: Text("₹ 17"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 20),
              child: MaterialButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: "items Added to the Cart");
                },
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 20),
                ),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 4,
                minWidth: 365,
              ),
            )
          ],
        ),
      ),
    );
  }
}
