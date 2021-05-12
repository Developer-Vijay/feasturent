import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/components/category_detail.dart';
import 'package:flutter/material.dart';

class ViewAllPopular extends StatelessWidget {
  final popularData;
  const ViewAllPopular({Key key, this.popularData}) : super(key: key);
  @override
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
        children: List.generate(popularData.length, (index) {
          if (popularData[index] != null) {
            return Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryDetailPage(
                                    menuData: popularData[index],
                                  )));
                    },
                    child: Container(
                      height: sized.height * 0.195,
                      width: sized.height * 0.22,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.lightBlue[100], blurRadius: 20)
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: popularData[index]['menuImage1'] != null
                          ? CachedNetworkImage(
                              imageUrl: S3_BASE_PATH +
                                  popularData[index]['menuImage1'],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: sized.height * 0.195,
                                width: sized.height * 0.22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) => Image.asset(
                                "assets/images/feasturenttemp.jpeg",
                                fit: BoxFit.cover,
                              ),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      capitalize(popularData[index]['title']),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        }),
      ),
    );
  }
}
