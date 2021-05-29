import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';

import 'package:feasturent_costomer_app/screens/home/slider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ViewAllPopular extends StatefulWidget {
  final popularData;
  const ViewAllPopular({Key key, this.popularData}) : super(key: key);

  @override
  _ViewAllPopularState createState() => _ViewAllPopularState();
}

class _ViewAllPopularState extends State<ViewAllPopular> {
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
        children: List.generate(widget.popularData.length, (index) {
          return Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Container(
              color: Colors.white,
              height: sized.height * 0.195,
              width: sized.height * 0.22,
              child: InkWell(
                onTap: () {
                  var menuD;
                  setState(() {
                    menuD = widget.popularData[index];
                  });
                  List<ChangeJson> dataList = [];
                  List addonList = menuD['variant'];
                  addonList.addAll(menuD['addon']);
                  print("this is list");
                  List<AddonMenus> createListAddon = [];

                  if (addonList.isNotEmpty) {
                    int k = addonList.length;
                    for (int i = 0; i <= k - 1; i++) {
                      createListAddon.add(AddonMenus(
                          addonList[i]['id'],
                          menuD['menuId'],
                          addonList[i]['type'],
                          addonList[i]['title'],
                          addonList[i]['amount'],
                          addonList[i]['gst'],
                          addonList[i]['gstAmount'].toInt()));
                    }
                  }
                  print("this is without encode list");
                  print(createListAddon);

                  print("this is  encode list");
                  var dataencoded = jsonEncode(createListAddon);
                  print(dataencoded);
                  print("this is  dencode list");
                  var datadecode = jsonDecode(dataencoded);
                  print(datadecode);

                  dataList.add(ChangeJson(
                      menuD['menuId'],
                      menuD['vendorId'],
                      menuD['title'],
                      menuD['description'],
                      menuD['itemPrice'],
                      menuD['gst'],
                      menuD['gstAmount'],
                      menuD['totalPrice'],
                      menuD['deliveryTime'],
                      menuD['isNonVeg'],
                      menuD['isEgg'],
                      menuD['isCombo'],
                      menuD['menuImage1'],
                      menuD['menuImage2'],
                      menuD['menuImage3'],
                      datadecode, []));
                  print("this is data list open #####");
                  var dataNew = jsonEncode(dataList[0]);
                  var finaldata = jsonDecode(dataNew);
                  print(finaldata);
                  print("this is data list close #####");

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoodSlider(
                                menuData: finaldata,
                                menuStatus: true,
                                restaurentName: menuD['restaurantName'],
                                rating: 1.0,
                                ratinglength: 1,
                              )));
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Stack(
                      children: [
                        widget.popularData[index]['menuImage1'] != null
                            ? CachedNetworkImage(
                                imageUrl: S3_BASE_PATH +
                                    widget.popularData[index]['menuImage1'],
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
                                  widget.popularData[index]['title'] != null
                                      ? Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            capitalize(widget.popularData[index]
                                                ['title']),
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
