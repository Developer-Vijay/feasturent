import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/Dineout/view_popular.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shimmer/shimmer.dart';

import 'dineoutdetailpage.dart';

class PopularDininingLists extends StatefulWidget {
  @override
  _PopularDininingListsState createState() => _PopularDininingListsState();
}

class _PopularDininingListsState extends State<PopularDininingLists> {
  @override
  void initState() {
    super.initState();
  }

  List<String> idDataList = [];
  List<String> datadine = [];
  fetchDineoutShared() async {
    final SharedPreferences cart = await SharedPreferences.getInstance();
    idDataList = cart.getStringList('idDineout');
    datadine = cart.getStringList('recommendDineout');
    // String data = datadine.toString();
    // datadine = json.decode(data);
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");

    print("dinneout is list $idDataList");
  }

  int status = 1;
  var responseData1;
  // ignore: missing_return
  Future<List> getpopulardineouts() async {
    fetchDineoutShared();

    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  dineoutpopular");

    var response = await http.get(APP_ROUTES + 'popularDineout?limit=null');

    if (response.statusCode == 200) {
      responseData1 = json.decode(response.body)['data'];
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ done @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

      return responseData1;
    } else if (response.statusCode == 204) {
      responseData1 = [];
      return responseData1;
    }
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
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Popular Dineout Areas",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                    fontSize: size.height * 0.025),
              ),
            ),
            Spacer(),
            Container(
                child: FlatButton(
                    onPressed: () async {
                      if (responseData1 != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ViewAllPopular(data: responseData1),
                            ));
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            "View All",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_rounded,
                          color: kSecondaryTextColor,
                        ),
                      ],
                    )))
          ],
        ),
        Container(
            height: size.height * 0.24,
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
                                  height: size.height * 0.24,
                                  width: size.width * 0.32,
                                  child: InkWell(
                                    onTap: () async {
                                      final SharedPreferences cart =
                                          await SharedPreferences.getInstance();

                                      var dataAddtoList =
                                          snapshot.data[index]['VendorInfo'];
                                      var newdata = json.encode(dataAddtoList);
                                      if (idDataList.contains(snapshot
                                          .data[index]['VendorInfo']['id']
                                          .toString())) {
                                        print("removing adding dinout");
                                        int k = idDataList.indexOf(snapshot
                                            .data[index]['VendorInfo']['id']
                                            .toString());
                                        datadine.removeAt(k);
                                        idDataList.removeAt(k);

                                        idDataList.add(snapshot.data[index]
                                                ['VendorInfo']['id']
                                            .toString());
                                        datadine.add(newdata);
                                        cart.setStringList(
                                            'recommendDineout', datadine);
                                        cart.setStringList(
                                            'idDineout', idDataList);
                                      } else {
                                        idDataList.add(snapshot.data[index]
                                                ['VendorInfo']['id']
                                            .toString());
                                        datadine.add(newdata);
                                        cart.setStringList(
                                            'recommendDineout', datadine);
                                        cart.setStringList(
                                            'idDineout', idDataList);
                                      }
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DineoutDetailPage(
                                                    data: snapshot.data[index]
                                                        ['VendorInfo'],
                                                  )));
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Stack(
                                          children: [
                                            snapshot.data[index]['VendorInfo']
                                                        ['user']['profile'] !=
                                                    null
                                                ? CachedNetworkImage(
                                                    imageUrl: S3_BASE_PATH +
                                                        snapshot.data[index]
                                                                ['VendorInfo']
                                                            ['user']['profile'],
                                                    fit: BoxFit.cover,
                                                    height: size.height * 0.24,
                                                    width: size.width * 0.32,
                                                    placeholder: (context,
                                                            url) =>
                                                        Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  )
                                                : Image.asset(
                                                    "assets/images/feasturenttemp.jpeg",
                                                    height: size.height * 0.24,
                                                    width: size.width * 0.32,
                                                    fit: BoxFit.cover,
                                                  ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                height: size.height * 0.05,
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
                                                      snapshot.data[index][
                                                                      'VendorInfo']
                                                                  ['name'] !=
                                                              null
                                                          ? Text(
                                                              capitalize(
                                                                  "${snapshot.data[index]['VendorInfo']['name']}"),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.height *
                                                                          0.025,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : Text("Name"),
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
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[100],
                            child: Container(
                              width: size.width * 0.31,
                              height: size.height * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )),
      ],
    ));
  }
}
