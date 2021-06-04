import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutdetailpage.dart';
import 'package:feasturent_costomer_app/screens/Dineout/view_all_best.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Collections extends StatefulWidget {
  @override
  _CollectionsState createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
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

  var responseData;
  // ignore: missing_return
  Future<List> getdineouts() async {
    fetchDineoutShared();
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  dineout");
    var response = await http.get(APP_ROUTES + 'dineout' + '?key=ALL');
    if (response.statusCode == 200) {
      responseData = json.decode(response.body)['data'];
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ done @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

      return responseData;
    } else if (response.statusCode == 204) {
      responseData = [];
      return responseData;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Container(
        child: FutureBuilder<List<dynamic>>(
          future: getdineouts(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.isEmpty
                  ? SizedBox()
                  : Container(
                      padding: const EdgeInsets.all(8.0),
                      height: size.height * 0.30,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "Best Collections",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kTextColor,
                                      fontSize: size.height * 0.025),
                                ),
                              ),
                              Spacer(),
                              Container(
                                  child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewAllDineoutCollection(
                                                      data: snapshot.data),
                                            ));
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
                          Expanded(
                            child: Container(
                              height: size.height * 0.22,
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      final SharedPreferences cart =
                                          await SharedPreferences.getInstance();

                                      var dataAddtoList = snapshot.data[index];
                                      var newdata = json.encode(dataAddtoList);
                                      if (idDataList.contains(snapshot
                                          .data[index]['id']
                                          .toString())) {
                                        print("removing adding dinout");
                                        int k = idDataList.indexOf(snapshot
                                            .data[index]['id']
                                            .toString());
                                        datadine.removeAt(k);
                                        idDataList.removeAt(k);

                                        idDataList.add(snapshot.data[index]
                                                ['id']
                                            .toString());
                                        datadine.add(newdata);
                                        cart.setStringList(
                                            'recommendDineout', datadine);
                                        cart.setStringList(
                                            'idDineout', idDataList);
                                      } else {
                                        idDataList.add(snapshot.data[index]
                                                ['id']
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
                                                    data: snapshot.data[index],
                                                  )));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                          left: size.width * 0.04,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Stack(
                                          children: [
                                            snapshot.data[index]['user']
                                                        ['profile'] !=
                                                    null
                                                ? CachedNetworkImage(
                                                    imageUrl: S3_BASE_PATH +
                                                        snapshot.data[index]
                                                            ['user']['profile'],
                                                    height: size.height * 0.2,
                                                    width: size.width * 0.34,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      height: size.height * 0.2,
                                                      width: size.width * 0.34,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                      "assets/images/defaultdineout.jpg",
                                                      fit: BoxFit.cover,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  )
                                                : Image.asset(
                                                    "assets/images/defaultdineout.jpg",
                                                    height: size.height * 0.2,
                                                    width: size.width * 0.34,
                                                    fit: BoxFit.cover,
                                                  ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                height: size.height * 0.07,
                                                width: size.width * 0.34,
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height:
                                                            size.height * 0.063,
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5,
                                                                top: 10),
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                    text: capitalize(
                                                                        "${snapshot.data[index]['name']}\n"),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            size.height *
                                                                                0.022,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                TextSpan(
                                                                    text:
                                                                        " ${snapshot.data[index]['Address']['city']}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            size.height *
                                                                                0.018,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                              ]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            } else {
              return Container(
                padding: const EdgeInsets.all(8.0),
                height: size.height * 0.30,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Best Collections",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kTextColor,
                                fontSize: size.height * 0.025),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    Expanded(
                      child: Container(
                          height: size.height * 0.22,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 15),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[100],
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    height: size.height * 0.2,
                                    width: size.width * 0.34,
                                  ),
                                ),
                              );
                            },
                          )),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
