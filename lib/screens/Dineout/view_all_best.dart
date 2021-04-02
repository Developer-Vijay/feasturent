import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutdetailpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../constants.dart';

class ViewAllDineoutCollection extends StatelessWidget {
  var data;
  ViewAllDineoutCollection({this.data});
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Best Collections"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(data.length, (index) {
          return Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (DineoutDetailPage(
                                  data: data[index],
                                ))));
                  },
                  child: Container(
                    height: sized.height * 0.195,
                    width: sized.height * 0.22,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.lightBlue[100], blurRadius: 20)
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: data[index]['dineoutImages'].isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: S3_BASE_PATH +
                                data[index]['dineoutImages'][0]['image'],
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    data[index]['name'],
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
