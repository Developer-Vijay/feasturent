
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:http/http.dart' as http;

class GiveRating extends StatefulWidget {
  final data;
  GiveRating({this.data});

  @override
  _GiveRatingState createState() => _GiveRatingState();
}

class _GiveRatingState extends State<GiveRating> {
  var userId;
  var authorization;
  var refreshToken;
  var _commentvalidate;
  var ratings = 0.0;
  TextEditingController _ratingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rating"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Text(
                  "$ratings",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: SmoothStarRating(
                  color: Colors.amber,
                  borderColor: Colors.amber,
                  rating: ratings,
                  size: 50,
                  onRated: (rating) {
                    setState(() {
                      ratings = rating;
                    });
                  },
                  starCount: 5,
                  allowHalfRating: false,
                ),
              ),
              Divider(
                thickness: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: TextField(
                      maxLines: 8,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8),
                          hintText: "Tell us Your Experience.........."),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    minWidth: 400,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {},
                    child: Text("SUBMIT YOUR FEEDBACK"),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // Future addrating() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   userId = prefs.getInt('userId');
  //   authorization = prefs.getString('sessionToken');
  //   refreshToken = prefs.getString('refreshToken');
  //   var response =await  http.post(COMMON_API + 'ratingReview', body: {
  //     "userId": "$userId",
  //     "vendorId": "${widget.data['vendorId']}",
  //     "menuId": "${widget.data['orderMenues'][0]['Menu']['id']}",
  //     "rating": "$ratings",
  //     "review": "${_ratingController.text}"
  //   }, headers: {
  //     "authorization": authorization,
  //     "refreshToken": refreshToken
  //   });
  //   if(response.statusCode==200)
  // }
}
