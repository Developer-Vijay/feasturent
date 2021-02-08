import 'package:feasturent_costomer_app/components/ListForSearch/list_data2.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String select = "";
  bool select1 = false;
  final pageController = PageController(initialPage: 0);
  bool _value ;
  final _style =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15);
  bool isSelected = false;
  bool isenabled = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: size.height * 1,
          child: ListView(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                          ),
                          onPressed: () {}),
                      Spacer(),
                      Text(
                        "Filter and Sort",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Spacer(),
                      FlatButton(
                        child: Text("Reset",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Divider(),
                  Container(
                    color: Colors.grey[300],
                    width: size.width * 1,
                    height: size.height * 0.18,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputChip(
                            label: Text(isSelected ? "Selected" : "Select"),
                            deleteIcon: Icon(Icons.close),
                            labelStyle: TextStyle(color: Colors.blue),
                            selectedColor: Colors.white,
                            onSelected: (bool value) {
                              setState(() {
                                isSelected = value;
                              });
                            },
                            onDeleted: () {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Delete Clicked"),
                                duration: Duration(milliseconds: 1),
                              ));
                            },
                            selected: isSelected,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(color: Colors.white),
                            margin: EdgeInsets.only(right: size.width * 0.03),
                            child: TextField(
                              autocorrect: false,
                              onTap: () {
                                showSearch(
                                    context: context,
                                    delegate: FoodItemsSearch());
                              },
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  hintText: "Search",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  suffixIcon: Icon(Icons.close)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.58,
                    width: size.width * 1,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.grey[300],
                                  height: size.height * 0.58,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          "Quick Filters",
                                          style: _style,
                                        ),
                                        selectedTileColor: Colors.white,
                                        enabled: true,
                                        selected: true,
                                        onTap: () {
                                          isSelected = true;
                                          pageController.animateToPage(0,
                                              duration:
                                                  Duration(milliseconds: 12),
                                              curve: Curves.bounceIn);
                                        },
                                      ),
                                      ListTile(
                                        title: Text("Cuisines", style: _style),
                                        selectedTileColor: Colors.white,
                                        enabled: true,
                                        onTap: () {
                                          pageController.animateToPage(1,
                                              duration:
                                                  Duration(milliseconds: 12),
                                              curve: Curves.bounceIn);
                                        },
                                        selected: false,
                                      ),
                                      ListTile(
                                        title: Text("Tags", style: _style),
                                        selectedTileColor: Colors.white,
                                        enabled: true,
                                        selected: false,
                                      ),
                                      ListTile(
                                        title: Text("Features", style: _style),
                                        selectedTileColor: Colors.white,
                                        enabled: true,
                                        selected: false,
                                      ),
                                      ListTile(
                                        title: Text("Dineout Passport",
                                            style: _style),
                                        selectedTileColor: Colors.white,
                                        onTap: () {
                                          pageController.animateToPage(2,
                                              duration:
                                                  Duration(milliseconds: 12),
                                              curve: Curves.bounceIn);
                                        },
                                        enabled: true,
                                        selected: false,
                                      ),
                                      ListTile(
                                        title: Text("SORT BY", style: _style),
                                        selectedTileColor: Colors.white,
                                        enabled: true,
                                        
                                        
                                        onTap: () {
                                          setState(() {
                                            select1 = _value;
                                          });

                                          pageController.animateToPage(3,
                                              duration:
                                                  Duration(milliseconds: 12),
                                              curve: Curves.bounceIn);
                                        },
                                        selected: select1,
                                        
                                      ),
                                    ],
                                  ),
                                )),

                            //Main Item Starts  From here or Chanageable
                            Expanded(
                                flex: 5,
                                child: Container(
                                    height: size.height * 0.58,
                                    color: Colors.white,
                                    child: PageView(
                                        controller: pageController,
                                        children: [
                                          ListView(
                                            children: [
                                              CheckboxListTile(
                                                title: Text("North Indian"),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value;
                                                  });
                                                },
                                                value: _value,
                                              ),
                                              CheckboxListTile(
                                                title: Text("Dineout Pay"),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value;
                                                  });
                                                },
                                                value: _value,
                                              ),
                                              CheckboxListTile(
                                                title: Text("Dineout Passport"),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value;
                                                  });
                                                },
                                                value: _value,
                                              ),
                                              CheckboxListTile(
                                                title: Text("Pure Veg"),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value;
                                                  });
                                                },
                                                value: _value,
                                              ),
                                              CheckboxListTile(
                                                title: Text("5 Star"),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value;
                                                  });
                                                },
                                                value: _value,
                                              ),
                                              CheckboxListTile(
                                                title: Text("Buffet"),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value;
                                                  });
                                                },
                                                value: _value,
                                              ),
                                              CheckboxListTile(
                                                title: Text("Happy hours"),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value;
                                                  });
                                                },
                                                value: _value,
                                              )
                                            ],
                                          ),
                                          Cuisins(),
                                          CheckList(),
                                          SortBY()
                                        ])))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    child: Text("Apply Filters"),
                    color: Colors.deepOrange,
                    textColor: Colors.white,
                    minWidth: size.width * 0.9,
                    height: size.height * 0.07,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {},
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodItemsSearch extends SearchDelegate<String> {
  final foodlist = ["Chole Bhature", "Rajma Chawal", "Noodles", "Soup"];
  final foodsubtitle = [
    "Dhaba da Shaba",
    "Punjabi tadka",
    "Foodie Cafe",
    "Italin Cuisines"
  ];

  final recentFoodsearched = [
    "Tomato Soup",
    "Maggie",
    "Bhindi Masala",
    "Aloo Gobhi"
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions

    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(
            Icons.close,
          ))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Card(
      child: Center(
        child: Text(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final mylist = query.isEmpty
        ? recentFoodsearched
        : foodlist.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.food_bank),
        title: Text(foodlist[index]),
        subtitle: Text(foodsubtitle[index]),
      ),
      itemCount: mylist.length,
    );
  }
}
