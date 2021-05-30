import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/screens/home/components/category_related_resturent.dart';
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
          return Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Container(
              color: Colors.white,
              height: sized.height * 0.195,
              width: sized.height * 0.22,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryRelatedMenues(
                          categoryName: categoryData[index]['name'],
                          categoryid: categoryData[index]['id'].toString(),
                        ),
                      ));
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Stack(
                      children: [
                        categoryData[index]['iconImage'] != null
                            ? CachedNetworkImage(
                                imageUrl: S3_BASE_PATH +
                                    categoryData[index]['iconImage'],
                                height: sized.height * 0.35,
                                width: sized.height * 0.35,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: sized.height * 0.35,
                                  width: sized.height * 0.35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                placeholder: (context, url) => Image.asset(
                                  "assets/images/feasturenttemp.jpeg",
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )
                            : Image.asset(
                                "assets/images/feasturenttemp.jpeg",
                                height: sized.height * 0.35,
                                width: sized.height * 0.35,
                                fit: BoxFit.cover,
                              ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: sized.height * 0.05,
                            width: sized.width * 1,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  categoryData[index]['name'] != null
                                      ? Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            capitalize(
                                                categoryData[index]['name']),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: sized.height * 0.025,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )
                                      : Text("...."),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          );
        }),
      ),
    );
  }
}
