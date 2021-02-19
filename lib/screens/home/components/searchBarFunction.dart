import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class Searchbar extends SearchDelegate<String> {
  Searchbar({
    String hintText,
  }) : super(
          keyboardType: TextInputType.text,
          searchFieldLabel: hintText,
          textInputAction: TextInputAction.search,
        );
  final foodlist = ["Chole Bhature", "Rajma Chawal", "Noodles", "Soup"];
  final foodsubtitle = [
    "Dhaba da Shaba",
    "Punjabi tadka",
    "Foodie Cafe",
    "Italin Cuisines"
  ];
  final imagelist = [
    "https://image.shutterstock.com/image-photo/chole-bhature-indian-dish-spicy-260nw-1133160284.jpg",
    "https://image.shutterstock.com/z/stock-photo-kidney-bean-curry-or-rajma-or-rajmah-chawal-and-roti-typical-north-indian-main-course-selective-620241002.jpg",
    "https://image.shutterstock.com/z/stock-photo-schezwan-noodles-or-vegetable-hakka-noodles-or-chow-mein-is-a-popular-indo-chinese-recipes-served-1251390421.jpg",
    "https://image.shutterstock.com/image-photo/pumpkin-carrot-soup-tadka-cream-260nw-409170664.jpg"
  ];

  final recentFoodsearched = [
    "Tomato Soup",
    "Maggie",
    "Bhindi Masala",
    "Aloo Gobhi"
  ];

  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => super.searchFieldLabel;
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = " ";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Card(
      child: Center(
        child: Text(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    final mylist = query.isEmpty
        ? recentFoodsearched
        : foodlist.where((p) => p.startsWith(query)).toList();
    return Container(
        child: ListView.builder(
      itemBuilder: (context, index) => Column(
        children: [
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        offset: Offset(0, 3),
                        spreadRadius: 2,
                        color: Colors.grey[300])
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: imagelist[index],
                  fit: BoxFit.fill,
                  height: 42,
                  width: 44,
                ),
              ),
            ),
            title: Text(foodlist[index]),
            subtitle: Text(foodsubtitle[index]),
            onTap: () {
              showResults(context);
            },
          ),
        ],
      ),
      itemCount: mylist.length,
    ));
  }
}
