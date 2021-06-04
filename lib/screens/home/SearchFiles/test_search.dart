import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/SearchFiles/dineout_search.dart';
import 'package:feasturent_costomer_app/screens/home/SearchFiles/dishSearch.dart';
import 'package:feasturent_costomer_app/screens/home/SearchFiles/resturent_search.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();

    onSearchTextChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: AppBar(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            style: TextStyle(color: Colors.white),
            decoration: new InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Search',
                border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          actions: [
            new IconButton(
              icon: new Icon(Icons.cancel),
              onPressed: () {
                if (controller.text.isEmpty) {
                  Navigator.pop(context);
                } else {
                  controller.clear();
                  onSearchTextChanged('');
                }
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Dishes"),
              Tab(text: "Resturent"),
              Tab(text: "DineOut")
            ],
          ),
        ),
        body: TabBarView(children: [
          DishSearch(),
          SearchResturent(),
          DineoutSearch(),
        ]),
      ),
    ));
  }

  onSearchTextChanged(String text) async {
    print("#################### $text");
    final response = await http.get(
      Uri.parse( APP_ROUTES +
        'appSearch?searchKey=$text&latitude=$latitude&longitude=$longitude')
     );

    if (mounted) {
      setState(() {
        resultData = json.decode(response.body)['data'];
      });
    }
  }
}

var resultData;
