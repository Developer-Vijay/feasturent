import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/DineoutReserveTable/dineout_date_select.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class PortfolioGallerySubPage extends StatefulWidget {
  final data;
  const PortfolioGallerySubPage({Key key, this.data}) : super(key: key);

  @override
  _PortfolioGallerySubPageState createState() =>
      _PortfolioGallerySubPageState();
}

class _PortfolioGallerySubPageState extends State<PortfolioGallerySubPage> {
  var data;
  @override
  void initState() {
    super.initState();
    data = widget.data;
    getSession();
    fetchCategory();
  }

  bool status = false;
  Future<void> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      status = prefs.getBool("_isAuthenticate");
    });
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  var categoryData = '';
  fetchCategory() {
    int k = data['cuisines'].length;
    print(k);

    if (k != 0) {
      for (int j = 0; j <= k - 1; j++) {
        categoryData =
            '$categoryData${data['cuisines'][j]['Category']['name']},';
      }
    } else {
      categoryData = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, spreadRadius: 3, color: Colors.blue[50])
                  ],
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: data['name'] != null
                            ? Text(
                                capitalize('${data['name']}'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )
                            : Text("Name of the Restaurant")),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                        width: size.width * 0.65,
                        child: categoryData != null
                            ? Text(
                                categoryData,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              )
                            : SizedBox()),
                    SizedBox(
                      height: 4,
                    ),
                    data['avgCost'] != null
                        ? Row(
                            children: [
                              Text(
                                "Avg Cost : ",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              Container(
                                  child: data['avgCost'] != null
                                      ? Text(
                                          " ₹ ${data['avgCost']}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        )
                                      : Text("₹ 500")),
                              Text(
                                " for ",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              Container(
                                  child: data['forPeople'] != null
                                      ? Text(
                                          data['forPeople'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        )
                                      : Text("2")),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 4,
                    ),
                    Row(children: [
                      Text(
                        "Dineout Timing: ",
                        style: TextStyle(color: Colors.black),
                      ),
                      data['user']['Setting'] == null
                          ? Text("Not Avialable",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: size.height * 0.016))
                          : data['user']['Setting']['storeTimeStart'] == null
                              ? Text("Not Avialable",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: size.height * 0.016))
                              : Text(
                                  "${data['user']['Setting']['storeTimeStart']}-${data['user']['Setting']['storeTimeEnd']}",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: size.height * 0.016)),
                    ])
                  ],
                ),
              )),
        ),
        Container(
            // margin: EdgeInsets.only(top: 5),
            child: ListView.builder(
          itemCount: dineoutlist.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Container(
                height: 75,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: Offset(1, 3),
                          color: Colors.blue[50])
                    ],
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: ListTile(
                    onTap: () {
                      if (dineoutlist[index].number == 3) {
                        if (status == true) {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => Container(
                                  height: size.height * 0.6,
                                  child: DineoutDateSelection(
                                    cate: categoryData,
                                    data: data,
                                    phone: data['contact'],
                                  )));
                        } else {
                          Fluttertoast.showToast(msg: "Please login First");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }
                      } else {
                        print(dineoutlist[index].number);
                      }
                    },
                    leading: Container(child: dineoutlist[index].icon),
                    enabled: true,
                    title: Text(dineoutlist[index].title),
                  ),
                ),
              ),
            );
          },
        )),
        SizedBox(
          height: 10,
        ),
        data['Address']['latitude'].isEmpty &&
                data['Address']['longitude'].isEmpty
            ? SizedBox()
            : Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: Offset(1, 3),
                          color: Colors.blue[50])
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 10.0),
                        child: Text(
                          "Locate & Contact",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.5,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        openMap(double.parse(data['Address']['latitude']),
                            double.parse(data['Address']['longitude']));
                      },
                      child: Container(
                        height: size.height * 0.25,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black26, width: 0.5),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    AssetImage('assets/images/mapshow.jpeg'))),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                        child: InkWell(
                          onTap: () {
                            openMap(double.parse(data['Address']['latitude']),
                                double.parse(data['Address']['longitude']));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/map.svg",
                                height: size.height * 0.035,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Open with map",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.red[300],
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              width: size.height * 0.35,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.width * 0.033),
                              child: Text(
                                data['Address']['address'],
                                style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: size.height * 0.035,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              width: size.height * 0.2,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.width * 0.033),
                              child: Text(
                                data['contact'],
                                style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              )),
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              var url = 'tel:${data['contact']}';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Text(
                              "Call",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 17,
                                  color: Colors.red[300],
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
        data['Address']['latitude'].isNotEmpty &&
                data['Address']['longitude'].isNotEmpty
            ? SizedBox()
            : Container(
                child: ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    child: Container(
                      height: 75,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 2,
                                offset: Offset(1, 3),
                                color: Colors.blue[50])
                          ],
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: ListTile(
                          onTap: () async {
                            var url = 'tel:${data['contact']}';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          leading: Icon(
                            Icons.call,
                            color: Colors.green,
                            size: 30,
                          ),
                          enabled: true,
                          title: data['Address']['address'] != null
                              ? Text(
                                  " +91 ${data['user']['phone']}",
                                )
                              : Text("phone Number Not Avaliable"),
                          // subtitle: Text(dineoutlist[index].subtitle),
                        ),
                      ),
                    ),
                  );
                },
              )),
        data['Address']['latitude'].isNotEmpty &&
                data['Address']['longitude'].isNotEmpty
            ? SizedBox()
            : SizedBox(
                height: 30,
              ),
        data['Address']['latitude'].isNotEmpty &&
                data['Address']['longitude'].isNotEmpty
            ? SizedBox()
            : data['Address']['address'] == null
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: Offset(1, 3),
                                  color: Colors.blue[50])
                            ]),
                        child: Center(
                          child: ListTile(
                            leading: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.location_on),
                              color: Colors.redAccent,
                            ),
                            title: Text(
                              data['Address']['address'],
                            ),
                          ),
                        )),
                  )
      ],
    ));
  }
}
