import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailResturent extends StatefulWidget {
  final restaurantInfo;
  const DetailResturent({Key key, this.restaurantInfo}) : super(key: key);

  @override
  _DetailResturentState createState() => _DetailResturentState();
}

class _DetailResturentState extends State<DetailResturent> {
  @override
  void initState() {
    super.initState();
    setState(() {
      data = widget.restaurantInfo;
    });
    getcategory();
  }

  getcategory() {
    if (data['cuisines'] != null) {
      int k = data['cuisines'].length;
      print(k);
      var categoryData = '';

      if (k != 0) {
        for (int j = 0; j <= k - 1; j++) {
          categoryData =
              '$categoryData ${data['cuisines'][j]['Category']['name']},';
        }
        category = categoryData;
      } else {
        categoryData = null;
      }
    } else {
      category = "Category/Cuisions";
    }
  }

  var category = "Category/Cuisions";
  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  var data;
  @override
  Widget build(BuildContext context) {
    print(data);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
              height: size.width * 0.5,
              width: size.width * 1,
              child: data['user']['profile'] != null
                  ? CachedNetworkImage(
                      imageUrl: S3_BASE_PATH + data['user']['profile'],
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : Image.asset(
                      "assets/images/feasturenttemp.jpeg",
                      fit: BoxFit.cover,
                    ),
            ),
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 10),
                          child: Text(
                            capitalize(data['name']),
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: size.height * 0.028,
                            ),
                          ),
                        ),
                        Spacer(),
                        data['avgRating'] == null
                            ? SizedBox()
                            : Container(
                                margin: EdgeInsets.only(right: 15, top: 10),
                                child: SmoothStarRating(
                                    allowHalfRating: true,
                                    onRated: (value) {},
                                    starCount: 5,
                                    rating: double.parse(data['avgRating']),
                                    size: 23.0,
                                    isReadOnly: true,
                                    defaultIconData: Icons.star_border_outlined,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_border,
                                    color: Colors.amber,
                                    borderColor: Colors.amber[300],
                                    spacing: 0.0),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    data['cuisines'] == null
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 15, bottom: 10, right: 130),
                            child: Container(
                              width: size.width * 0.75,
                              child: Text(
                                category,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.firaSans(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                          ),
                    Container(
                      margin: EdgeInsets.all(10),
                      height: size.height * 0.1,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Spacer(),
                          Container(
                            width: size.width * 0.25,
                            child: Column(
                              children: [
                                Tooltip(
                                  message: "Store Timing",
                                  child: Icon(
                                    Icons.timer_outlined,
                                    size: size.height * 0.036,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                    child: data['user']['Setting'] == null
                                        ? Text("Not Avialable",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: size.height * 0.016))
                                        : Container(
                                            child: data['user']['Setting']
                                                        ['storeTimeStart'] ==
                                                    null
                                                ? Text("Not Avialable",
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: size.height *
                                                            0.016))
                                                : Text(
                                                    "${data['user']['Setting']['storeTimeStart']}-${data['user']['Setting']['storeTimeEnd']}",
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: size.height *
                                                            0.016)))),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: size.width * 0.25,
                            child: Column(
                              children: [
                                Tooltip(
                                  message: "Distance",
                                  child: Icon(
                                    Icons.location_on,
                                    size: size.height * 0.036,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                data['distance'] == null
                                    ? Text(
                                        "Not Avialable",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: size.height * 0.016),
                                      )
                                    : data['distance'].toInt() == 0
                                        ? Text(
                                            "Near you",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: size.height * 0.016),
                                          )
                                        : Text(
                                            "${data['distance'].toInt()}Km",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: size.height * 0.016),
                                          )
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: size.width * 0.25,
                            child: Column(
                              children: [
                                Tooltip(
                                  message: "Delivery option",
                                  child: Icon(
                                    Icons.delivery_dining,
                                    size: size.height * 0.036,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                    child: data['user']['Setting'] == null
                                        ? Text("Not Avialable",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: size.height * 0.016))
                                        : Container(
                                            child: data['user']['Setting']['deliveryType'] ==
                                                    null
                                                ? Text("Not Avialable",
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: size.height *
                                                            0.016))
                                                : data['user']['Setting']['deliveryType'] ==
                                                        'BOTH'
                                                    ? Text("TakeAway/Delivery",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: size.height *
                                                                0.016))
                                                    : Text("${data['user']['Setting']['deliveryType']}",
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: size.height * 0.016)))),
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    data['Address']['latitude'].isEmpty &&
                            data['Address']['longitude'].isEmpty
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: data['about'] == null
                                ? Text(
                                    "Not added any discription",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  )
                                : Text(
                                    "About us:- ${data['about'].toString()}",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ),
                          ),
                    data['fssaiNumber'] == null
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              "FSSAI Number:- ${data['fssaiNumber']}",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                    data['Address']['latitude'].isEmpty &&
                            data['Address']['longitude'].isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/map.svg",
                                  height: size.height * 0.035,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    width: size.height * 0.22,
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(
                                        top: size.height * 0.01,
                                        left: size.width * 0.033),
                                    child: Text(
                                      data['Address']['address'],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: size.height * 0.018,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600),
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                data['Address']['latitude'].isEmpty &&
                                        data['Address']['longitude'].isEmpty
                                    ? SizedBox()
                                    : InkWell(
                                        onTap: () {
                                          openMap(
                                              double.parse(
                                                  data['Address']['latitude']),
                                              double.parse(data['Address']
                                                  ['longitude']));
                                        },
                                        child: Text(
                                          "Get Direction",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                  )
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: size.height * 0.06,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, top: 10.0),
                                    child: Text(
                                      "Locate & Contact",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.5,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    openMap(
                                        double.parse(
                                            data['Address']['latitude']),
                                        double.parse(
                                            data['Address']['longitude']));
                                  },
                                  child: Container(
                                    height: size.height * 0.25,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black26, width: 0.5),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/images/mapshow.jpeg'))),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, top: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        openMap(
                                            double.parse(
                                                data['Address']['latitude']),
                                            double.parse(
                                                data['Address']['longitude']));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.red[300],
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
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
                                      Text(
                                        data['contact'],
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54),
                                      ),
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
                                              decoration:
                                                  TextDecoration.underline,
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
                    data['Address']['latitude'].isEmpty &&
                            data['Address']['longitude'].isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: size.height * 0.035,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  data['contact'],
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                ),
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
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    data['Address']['latitude'].isNotEmpty &&
                            data['Address']['longitude'].isNotEmpty
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: data['about'] == null
                                ? Text(
                                    "Not added any discription",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  )
                                : Text(
                                    "About us:- ${data['about'].toString()}",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ),
                          ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
