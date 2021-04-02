import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'restaurant_tracking.dart';

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
  }

  var data;
  @override
  Widget build(BuildContext context) {
    print(data);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Container(
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
            ),
            Expanded(
              flex: 13,
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 10),
                            child: Text(
                              data['name'],
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.028,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(right: 15, top: 10),
                            child: SmoothStarRating(
                                allowHalfRating: true,
                                onRated: (value) {},
                                starCount: 5,
                                rating: 4,
                                size: 23.0,
                                isReadOnly: false,
                                defaultIconData: Icons.star_border_outlined,
                                filledIconData: Icons.star,
                                halfFilledIconData: Icons.star_border,
                                color: Colors.amber,
                                borderColor: Colors.amber[300],
                                spacing: 0.0),
                          ),
                        ],
                      ),
                      data['cuisine'] == null
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, bottom: 10, right: 130),
                              child: Container(
                                width: size.width * 0.1,
                                child: Text(
                                  data['cuisine'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: size.height * 0.017,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
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
                              // color: Colors.red,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: size.height * 0.036,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                      child: data['user']['Setting'] == null
                                          ? Text("Not Avialable",
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize:
                                                      size.height * 0.016))
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
                                                          fontSize:
                                                              size.height *
                                                                  0.016)))),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: size.width * 0.25,
                              // color: Colors.red,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: size.height * 0.036,
                                    color: Colors.grey[700],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "1.5Km",
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
                              // color: Colors.red,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.delivery_dining,
                                    size: size.height * 0.036,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                      child: data['user']['Setting'] == null
                                          ? Text("Not Avialable",
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize:
                                                      size.height * 0.016))
                                          : Container(
                                              child: data['user']['Setting']
                                                          ['deliveryType'] ==
                                                      null
                                                  ? Text("Not Avialable",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: size.height *
                                                              0.016))
                                                  : Text(
                                                      "${data['user']['Setting']['deliveryType']}",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize:
                                                              size.height *
                                                                  0.016)))),
                                ],
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Padding(
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
                                      fontSize: size.height * 0.016,
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MapView(),
                                          ));
                                    },
                                    child: Text(
                                      "Get Direction",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Padding(
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
                                data['contact'],
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 15,
                                    color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: data['about'] == null
                            ? Text(
                                "Not added any discription",
                                style: TextStyle(fontSize: 15),
                              )
                            : Text(
                                data['about'].toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
