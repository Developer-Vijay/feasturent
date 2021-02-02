import 'package:flutter/material.dart';

class CheckList extends StatefulWidget {
  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  @override
  Widget build(BuildContext context) {
    bool _value = false;
    return Container(
      child: ListView(
        children: [
          CheckboxListTile(
            title: Text("South Indian"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
            value: _value,
          ),
          CheckboxListTile(
            title: Text("Dineout Pay"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("Dineout Passport"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("Pure Veg"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("5 Star"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("Buffet"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("Happy hours"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          )
        ],
      ),
    );
  }
}

class Cuisins extends StatefulWidget {
  @override
  _CuisinsState createState() => _CuisinsState();
}

class _CuisinsState extends State<Cuisins> {
  @override
  Widget build(BuildContext context) {
    bool _value = false;
    return Container(
      child: ListView(
        children: [
          CheckboxListTile(
            title: Text("Chettinad"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
            value: _value,
          ),
          CheckboxListTile(
            title: Text("North Indian"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("Fast Food"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("Chinese"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("Italian"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("Buffet"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("Desserts"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("Pizza"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("Bakery"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("Cofee"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("South Indian"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
          CheckboxListTile(
            title: Text("Burger"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {},
            value: _value,
          ),
        ],
      ),
    );
  }
}

class SortBY extends StatefulWidget {
  @override
  _SortBYState createState() => _SortBYState();
}

class _SortBYState extends State<SortBY> {
    bool _value1 = false;
     bool _value2 = false;
      bool _value3 = false;
       bool _value4 = false;
  @override
  Widget build(BuildContext context) {
  
    return Container(
      child: ListView(
        children: [
          CheckboxListTile(
            title: Text("Popularity"),
            controlAffinity: ListTileControlAffinity.leading,
            value: _value1,
            onChanged: (value) {
              setState(() {
                _value1 = value;
              });
            },
            
          ),
          CheckboxListTile(
            title: Text("Rating"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              setState(() {
                _value2 = value;
              });
            },
            value: _value2,
          ),
          CheckboxListTile(
            title: Text("Price Low to High"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              setState(() {
                _value3 = value;
              });
            },
            value: _value3,
          ),
          CheckboxListTile(
            title: Text("Price high to Low"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              setState(() {
                _value4 = value;
              });
            },
            value: _value4,
          ),
        ],
      ),
    );
  }
}
