import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutdetailpage.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ViewAllPopular extends StatelessWidget {
  var data;
  ViewAllPopular({this.data});
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Dineouts"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(data.length, (index) {
          return Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Container(
              color: Colors.red,
              height: sized.height * 0.195,
              width: sized.height * 0.22,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (DineoutDetailPage(
                                data: data[index]['VendorInfo'],
                              ))));
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      children: [
                        data[index]['VendorInfo']['dineoutImages'].isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: S3_BASE_PATH +
                                    data[index]['VendorInfo']['dineoutImages']
                                        [0]['image'],
                                fit: BoxFit.cover,
                                height: sized.height * 0.35,
                                width: sized.height * 0.35,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
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
                            color: Colors.black.withOpacity(0.7),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  data[index]['VendorInfo']['name'] != null
                                      ? Text(
                                          capitalize(
                                              "${data[index]['VendorInfo']['name']}"),
                                          style: TextStyle(
                                              fontSize: sized.height * 0.025,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
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
