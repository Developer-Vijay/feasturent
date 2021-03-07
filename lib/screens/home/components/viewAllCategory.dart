import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ViewAllCategory extends StatelessWidget {
  final categoryData;
  const ViewAllCategory({Key key, this.categoryData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(categoryData.length, (index) {
          return Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                  height: sized.height * 0.195,
                  width: sized.height * 0.22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: categoryData[index]['iconImage'] != null
                      ? CachedNetworkImage(
                          imageUrl:
                              S3_BASE_PATH + categoryData[index]['iconImage'],
                          imageBuilder: (context, imageProvider) => Container(
                            height: sized.height * 0.195,
                            width: sized.height * 0.22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            "assets/images/feasturenttemp.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    categoryData[index]['name'],
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
