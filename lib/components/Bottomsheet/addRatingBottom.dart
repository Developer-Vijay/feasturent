import 'dart:convert';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;

class AddRatingPage extends StatefulWidget {
  final data;
  AddRatingPage({this.data});
  @override
  _AddRatingPageState createState() => _AddRatingPageState();
}

class _AddRatingPageState extends State<AddRatingPage> {
  TextEditingController _commentController = TextEditingController();
  var userId;
  var authorization;
  var refreshToken;
  var _commentvalidate;
  var rating = 1.0;
  bool isValidate = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(children: [
        Container(
            alignment: Alignment.topRight,
            child: FlatButton(
              onPressed: () {
                _AddComment();
              },
              child: Text(
                "Post",
                style: TextStyle(fontSize: 18),
              ),
            )),
        Divider(
          thickness: 1,
        ),
        ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                        height: size.height * 0.09,
                        width: size.width * 1,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: SmoothStarRating(
                                  allowHalfRating: false,
                                  onRated: (value) {
                                    setState(() {
                                      rating = value;
                                    });
                                  },
                                  starCount: 5,
                                  rating: rating,
                                  size: 45.0,
                                  isReadOnly: false,
                                  defaultIconData: Icons.star_border_outlined,
                                  filledIconData: Icons.star,
                                  halfFilledIconData: Icons.star_border,
                                  color: Colors.amber,
                                  borderColor: Colors.amber,
                                  spacing: 0.0),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 2),
                              child: Text(
                                "$rating",
                                style: TextStyle(color: kTextColor),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: size.width * 0.03, right: size.width * 0.03),
                  child: TextField(
                    autocorrect: false,
                    controller: _commentController,
                    maxLength: 500,
                    maxLines: 7,
                    style: TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        hintText: "Add an Comment",
                        errorText: _commentvalidate),
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }

  Future _AddComment() async {
    // for name
    if (_commentController.text.isEmpty) {
      setState(() {
        _commentvalidate =
            "Please Enter The Comment and Star Rating Before Posting It";
        isValidate = false;
      });
    } else {
      setState(() {
        isValidate = true;
        _commentvalidate = null;
      });
    }
    if (isValidate = true) {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getInt('userId');
      authorization = prefs.getString('sessionToken');
      refreshToken = prefs.getString('refreshToken');
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  rating reviwe");

      var response = await http.post(COMMON_API + 'ratingReview', body: {
        "userId": "$userId",
        "vendorId": "${widget.data['vendorId']}",
        "menuId": "${widget.data['orderMenues'][0]['Menu']['id']}",
        "rating": "$rating",
        "review": "${_commentController.text}"
      }, headers: {
        "authorization": authorization,
        "refreshToken": refreshToken
      });
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "${responseData['message']}");
      } else if (response.statusCode == 401) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove(
          'name',
        );
        prefs.remove('sessionToken');
        prefs.remove('refreshToken');
        prefs.remove('userNumber');
        prefs.remove('userProfile');
        prefs.remove('customerName');
        prefs.remove('userId');
        prefs.remove('loginId');
        prefs.remove('userEmail');
        prefs.remove("loginBy");
        takeUser = false;
        emailid = null;
        photo = null;
        userName = null;

        prefs.setBool("_isAuthenticate", false);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        Fluttertoast.showToast(msg: "${responseData['message']}");
      }
    } else {
      Fluttertoast.showToast(msg: "Error occured");
    }
  }
}
