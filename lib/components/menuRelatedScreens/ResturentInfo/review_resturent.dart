import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../../constants.dart';

class ReturentReview extends StatefulWidget {
  final resturentRatingid;
  ReturentReview({Key key, this.resturentRatingid});
  @override
  _ReturentReviewState createState() => _ReturentReviewState();
}

class _ReturentReviewState extends State<ReturentReview> {
  Future<List<dynamic>> fetchRating() async {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  get resturents Rating ${widget.resturentRatingid}");

    var result = await http.get(Uri.parse(
      COMMON_API +
          'ratingReview' +
          '?key=BYVENDOR&id=${widget.resturentRatingid}   ',
    ));
    print(result);
    var data = json.decode(result.body)['data'];

    data = data['allRating'][0]['ReviewAndRatings'];
    print(data);

    return data;
  }

  double rating = 2.0;

  double rating2 = 3.0;

  double rating3 = 4.0;

  double rating4 = 5.0;

  var titlesize = 14.0;

  var textsize = 13.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: FutureBuilder<List<dynamic>>(
        future: fetchRating(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            return snapshot.data.isEmpty
                ? Center(
                    child: Text("No one gives rating till now"),
                  )
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          width: size.width * 0.1,
                          // height: size.height * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 8,
                                    ),
                                    child: snapshot.data[index]['user']
                                                ['profile'] ==
                                            null
                                        ? CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: size.height * 0.045,
                                            child: Container(
                                                width: size.height * 0.7,
                                                decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: new DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: AssetImage(
                                                            "assets/images/avatar.png")))),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: size.height * 0.045,
                                            child: Container(
                                                width: size.height * 0.7,
                                                decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: new DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: CachedNetworkImageProvider(
                                                            S3_BASE_PATH +
                                                                snapshot.data[
                                                                            index]
                                                                        ['user']
                                                                    [
                                                                    'profile'])))),
                                          ),
                                  ),
                                  Container(
                                    width: size.width * 0.3,
                                    padding: const EdgeInsets.only(
                                        left: 12.0, top: 8),
                                    child: snapshot.data[index]['user']
                                                ['name'] ==
                                            null
                                        ? Text(
                                            "${snapshot.data[index]['user']['name']} ${snapshot.data[index]['user']['lastName']}",
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: titlesize),
                                          )
                                        : Text(
                                            'Anomyous',
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: titlesize),
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: SmoothStarRating(
                                        allowHalfRating: true,
                                        onRated: (value) {
                                          setState(() {
                                            rating = value;
                                          });
                                        },
                                        starCount: 5,
                                        rating: double.parse(
                                            snapshot.data[index]['rating']),
                                        size: 23.0,
                                        isReadOnly: true,
                                        defaultIconData:
                                            Icons.star_border_outlined,
                                        filledIconData: Icons.star,
                                        halfFilledIconData: Icons.star_border,
                                        color: Colors.amber,
                                        borderColor: Colors.amber,
                                        spacing: 0.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 6),
                                    child: Text(
                                      "${double.parse(snapshot.data[index]['rating'])} ",
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                  )
                                ],
                              ),
                              snapshot.data[index]['review'] == null
                                  ? Container(
                                      margin: EdgeInsets.only(top: 10),
                                      padding:
                                          EdgeInsets.only(left: 9, right: 9),
                                      child: Text(
                                        "Not added reviiew",
                                        style: TextStyle(
                                            fontSize: textsize,
                                            color: Colors.blueGrey),
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(top: 10),
                                      padding:
                                          EdgeInsets.only(left: 9, right: 9),
                                      child: Text(
                                        "${snapshot.data[index]['review']}",
                                        style: TextStyle(
                                            fontSize: textsize,
                                            color: Colors.blueGrey),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      );
                    });
          } else {
            return ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: size.width * 0.1,
                        // height: size.height * 0.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 8,
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: size.height * 0.045,
                                      child: Container(
                                          width: size.height * 0.7,
                                          decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white)),
                                    )),
                                SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  color: Colors.white,
                                  width: size.width * 0.3,
                                  padding:
                                      const EdgeInsets.only(left: 12.0, top: 8),
                                  child: Text(''),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Container(
                                    color: Colors.white,
                                    width: size.width * 0.25,
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                    ),
                                    child: Text('')),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  color: Colors.white,
                                  width: 10,
                                  padding:
                                      const EdgeInsets.only(left: 8, bottom: 6),
                                  child: Text(
                                    "",
                                  ),
                                )
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              height: 100,
                              width: size.width * 1,
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.only(left: 9, right: 9),
                              child: Text(
                                "",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            );
          }
        },
      )),
    );
  }
}
