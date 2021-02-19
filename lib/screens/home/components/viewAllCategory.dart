import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoriesItem {
  String categoryName = '';
  String categoryImage;
  CategoriesItem({
    this.categoryName,
    this.categoryImage,
  });
}

List<CategoriesItem> category = [
  CategoriesItem(
      categoryName: 'Thali',
      categoryImage:
          'https://image.shutterstock.com/z/stock-photo-typical-indian-food-from-jaipur-thali-rajasthani-1010465743.jpg'),
  CategoriesItem(
    categoryName: 'South Indian',
    categoryImage:
        "https://image.shutterstock.com/z/stock-photo-group-of-south-indian-food-like-masala-dosa-uttapam-idli-idly-wada-vada-sambar-appam-semolina-1153818823.jpg",
  ),
  CategoriesItem(
    categoryName: 'Cake & Desserts',
    categoryImage:
        "https://image.shutterstock.com/z/stock-photo-board-with-delicious-caramel-cake-on-table-768814738.jpg",
  ),
  CategoriesItem(
    categoryName: 'Burger',
    categoryImage:
        "https://image.shutterstock.com/z/stock-photo-classic-hamburger-with-cheese-bacon-tomato-and-lettuce-on-dark-wooden-background-1677795556.jpg",
  ),
  CategoriesItem(
    categoryName: 'Chinese',
    categoryImage:
        "https://image.shutterstock.com/z/stock-photo-schezwan-noodles-or-vegetable-hakka-noodles-or-chow-mein-is-a-popular-indo-chinese-recipes-served-1251390421.jpg",
  ),
  CategoriesItem(
    categoryName: 'North Indian',
    categoryImage:
        "https://image.shutterstock.com/z/stock-photo-murgh-makhani-butter-chicken-tikka-masala-served-with-roti-paratha-and-plain-rice-along-with-1210314505.jpg",
  ),
  CategoriesItem(
    categoryName: 'Snacks and Beverages',
    categoryImage:
        "https://image.shutterstock.com/z/stock-photo-punjabi-aloo-samosa-or-potato-samosa-recipe-or-indian-traditional-aloo-samosa-indian-chat-recipe-1508653862.jpg",
  ),
];

class ViewAllCategory extends StatefulWidget {
  @override
  _ViewAllCategoryState createState() => _ViewAllCategoryState();
}

class _ViewAllCategoryState extends State<ViewAllCategory> {
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        // padding: EdgeInsets.all(10),
        children: List.generate(category.length, (index) {
          return Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: category[index].categoryImage,
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
                    category[index].categoryName,
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
