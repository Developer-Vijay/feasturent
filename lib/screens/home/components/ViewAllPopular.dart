import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PopularOnFeast {
  String categoryName = '';
  String categoryImage;
  PopularOnFeast({
    this.categoryName,
    this.categoryImage,
  });
}

List<PopularOnFeast> popular = [
  PopularOnFeast(
      categoryName: 'Chole Bhature',
      categoryImage:
          "https://image.shutterstock.com/z/stock-photo-chole-bhature-or-chick-pea-curry-and-fried-puri-served-in-terracotta-crockery-over-white-1072270610.jpg"),
  PopularOnFeast(
    categoryName: "Special Momos",
    categoryImage:
        "https://image.shutterstock.com/z/stock-photo-traditional-dumpling-vegetarian-momos-food-from-nepal-served-with-tomato-chutney-over-moody-plate-1719536887.jpg",
  ),
  PopularOnFeast(
    categoryName: "Tandori Chicken",
    categoryImage:
        "https://image.shutterstock.com/image-photo/arabian-spicy-food-concept-homemade-600w-1199926645.jpg",
  ),
  PopularOnFeast(
    categoryName: 'Cheese Burger',
    categoryImage:
        "https://image.shutterstock.com/z/stock-photo-big-cheeseburger-with-lots-of-cheese-stock-photo-side-view-of-a-cheeseburger-on-a-black-brick-wall-1680415567.jpg",
  ),
  PopularOnFeast(
    categoryName: "Chicken Biryani",
    categoryImage:
        "https://image.shutterstock.com/z/stock-photo-chicken-kabsa-homemade-arabian-biryani-overhead-view-1048188121.jpg",
  ),
  PopularOnFeast(
    categoryName: "Palak Paneer ",
    categoryImage:
        "https://image.shutterstock.com/z/stock-photo-palak-paneer-curry-made-up-of-spinach-and-cottage-cheese-popular-indian-healthy-lunch-dinner-food-620862170.jpg",
  ),
  PopularOnFeast(
    categoryName: "Masala Dosa",
    categoryImage:
        "https://image.shutterstock.com/z/stock-photo-masala-dosa-indian-savory-crepes-with-potato-filling-top-down-view-783911236.jpg",
  ),
];

class ViewAllPopular extends StatefulWidget {
  @override
  _ViewAllPopularState createState() => _ViewAllPopularState();
}

class _ViewAllPopularState extends State<ViewAllPopular> {
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Popular on Feasturent"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        // padding: EdgeInsets.all(10),
        children: List.generate(popular.length, (index) {
          return Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: popular[index].categoryImage,
                  imageBuilder: (context, imageProvider) => Container(
                    height: sized.height * 0.195,
                    width: sized.height * 0.22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    popular[index].categoryName,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
