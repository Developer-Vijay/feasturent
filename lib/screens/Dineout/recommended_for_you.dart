import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants.dart';
import 'dineoutdetailpage.dart';

class RecommendedForU extends StatefulWidget {
  @override
  _RecommendedForUState createState() => _RecommendedForUState();
}

class _RecommendedForUState extends State<RecommendedForU> {
  @override
  void initState() {
    super.initState();
  }

  int status = 1;
  var responseData1;
  // ignore: missing_return
  Future<List> getpopulardineouts() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();

    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  dineoutpopular");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print('#############################################');
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print('#############################################');
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print('#############################################');
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print('#############################################');
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print('#############################################');

    var data = cart.getStringList('recommendDineout');
    var nedata = data.reversed;
    print(data);
    // String datastring = nedata.toString();
    // var response = await http.get(APP_ROUTES + 'popularDineout?limit=null');
    print(nedata);
    var datareversed = nedata.toList();
    // if (response.statusCode == 200) {
    var dedata = json.decode(datareversed.toString());
    return dedata; //   print(
    //       "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ done @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    //   print(responseData1);
    //   return responseData1;
    // } else if (response.statusCode == 204) {
    //   responseData1 = [];
    //   return responseData1;
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                "Recommended For You",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                    fontSize: size.height * 0.025),
              ),
            ),
          ],
        ),
        Container(
            height: size.height * 0.26,
            child: FutureBuilder<List>(
              future: getpopulardineouts(),
// ignore: missing_return
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data.isEmpty
                      ? SizedBox(
                          child: Center(
                            child: Text("No data Available"),
                          ),
                        )
                      : Container(
                          child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 4.0, left: 15),
                              child: Container(
                                  height: size.height * 0.26,
                                  width: size.width * 0.4,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DineoutDetailPage(
                                                    data: snapshot.data[index],
                                                  )));
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Stack(
                                          children: [
                                            snapshot.data[index]['user']
                                                        ['profile'] !=
                                                    null
                                                ? CachedNetworkImage(
                                                    imageUrl: S3_BASE_PATH +
                                                        snapshot.data[index]
                                                            ['user']['profile'],
                                                    fit: BoxFit.cover,
                                                    height: size.height * 0.26,
                                                    width: size.width * 0.4,
                                                    placeholder: (context,
                                                            url) =>
                                                        Center(
                                                            child: Center(
                                                                child:
                                                                    CircularProgressIndicator())),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        "https://im1.dineout.co.in/images/uploads/restaurant/sharpen/2/e/p/p20298-1484731590587f34c63a2a1.jpg?tr=tr:n-medium",
                                                    fit: BoxFit.cover,
                                                    height: size.height * 0.26,
                                                    width: size.width * 0.4,
                                                    placeholder: (context,
                                                            url) =>
                                                        Center(
                                                            child: Center(
                                                                child:
                                                                    CircularProgressIndicator())),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                height: size.height * 0.125,
                                                width: size.width * 1,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'EAT, SAVE, REPEAT.',
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.height *
                                                                    0.015,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        capitalize(
                                                            "${snapshot.data[index]['name']}"),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.height *
                                                                    0.033,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        'the Total Bill',
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.height *
                                                                    0.015,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  )),
                            );
                          },
                        ));
                } else {
                  return Container(
                      child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 15),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            height: size.height * 0.24,
                            width: size.width * 0.4,
                          ),
                        ),
                      );
                    },
                  ));
                }
              },
            )),
      ],
    ));
  }
}
