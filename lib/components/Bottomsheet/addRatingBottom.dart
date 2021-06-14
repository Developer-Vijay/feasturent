import 'dart:convert';
import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;

class AddRatingPage extends StatefulWidget {
  // final menuLength;
  final data;
  AddRatingPage({
    this.data,
  });
  @override
  _AddRatingPageState createState() => _AddRatingPageState();
}

class RatingListdata {
  int menuId;
  double rating;
  String review;
  TextEditingController commentController;
  RatingListdata(this.menuId, this.rating, this.review, this.commentController);
  Map toJson() => {
        'menuId': menuId,
        'rating': rating,
        'review': review,
      };
}

class _AddRatingPageState extends State<AddRatingPage> {
  @override
  void initState() {
    data = widget.data;
    super.initState();
    setState(() {
      int j = data['orderMenues'].length;
      print("this is from customize page lenth $j");
      for (int i = 0; i < j; i++) {
        print("Menue name${data['orderMenues'][i]['Menu']['id']}");
        inputs.add(RatingListdata(data['orderMenues'][i]['Menu']['id'], 0.0,
            null, TextEditingController()));
      }
    });
  }

  var data;
  // TextEditingController _commentController = TextEditingController();
  List<RatingListdata> inputs = [];

  var userId;
  var authorization;
  var refreshToken;
  var _commentvalidate;
  bool isValidate = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(children: [
        Expanded(
          flex: 1,
          child: Container(
              alignment: Alignment.topRight,
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  _AddComment();
                },
                child: Text(
                  "Post",
                  style: TextStyle(fontSize: 18),
                ),
              )),
        ),
        Divider(
          thickness: 1,
        ),
        Expanded(
          flex: 9,
          child: ListView.builder(
              itemCount: data['orderMenues'].length,
              itemBuilder: (context, index) {
                // var rating = 0.0;

                // _commentController.text = inputs[index].review;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(data['orderMenues'][index]['Menu']['title']),
                    ),
                    Row(
                      children: [
                        Container(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: SmoothStarRating(
                              allowHalfRating: false,
                              onRated: (value) {
                                setState(() {
                                  inputs[index].rating = value;
                                });
                              },
                              starCount: 5,
                              rating: inputs[index].rating,
                              size: 30.0,
                              isReadOnly: false,
                              defaultIconData: Icons.star_border_outlined,
                              filledIconData: Icons.star,
                              halfFilledIconData: Icons.star_border,
                              color: Colors.amber,
                              borderColor: Colors.amber,
                              spacing: 0.0),
                        )),
                        inputs[index].rating == 0
                            ? SizedBox()
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 2),
                                child: Text(
                                  "${inputs[index].rating}",
                                  style: TextStyle(color: kTextColor),
                                ),
                              ),
                      ],
                    ),
                    inputs[index].rating == 0
                        ? SizedBox()
                        : Container(
                            margin: EdgeInsets.only(
                                top: size.height * 0.02,
                                left: size.width * 0.03,
                                right: size.width * 0.03),
                            child: TextField(
                              autocorrect: false,
                              controller: inputs[index].commentController,
                              maxLength: 250,
                              maxLines: 4,
                              onChanged: (value) {
                                setState(() {
                                  inputs[index].review = value;
                                });
                                print(
                                    "this is change data ${inputs[index].review}");
                              },
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
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              }),
        ),
      ]),
    );
  }

  // ignore: non_constant_identifier_names
  Future _AddComment() async {
    int j = data['orderMenues'].length;
    for (int i = 0; i <= j - 1; i++) {
      if (inputs[i].rating == 0.0) {
        setState(() {
          isValidate = false;
          Fluttertoast.showToast(msg: "Please give rating to all menues");
        });
        break;
      } else {
        setState(() {
          isValidate = true;
        });
      }
    }
    // for name

    if (isValidate == true) {
      callingLoader();
      print("good to go");
      print(inputs);
      var jsonTags = jsonEncode(inputs);
      print(jsonTags);
      var decode = jsonDecode(jsonTags);
      print(decode);

      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getInt('userId');
      authorization = prefs.getString('sessionToken');
      refreshToken = prefs.getString('refreshToken');
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  rating reviwe");
      Map data = {
        "userId": "$userId",
        "vendorId": "${widget.data['vendorId']}",
        "menuRating": inputs,
        "status": "true"
      };
      print(data);

      var requestBody = jsonEncode(data);
      print(requestBody);
      var response = await http.post(Uri.parse(COMMON_API + 'ratingReview'),
          body: requestBody,
          headers: {
            "authorization": authorization,
            "refreshToken": refreshToken,
            "Content-Type": "application/json"
          });
      print(response.statusCode);

      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        var responseData = json.decode(response.body);
        Navigator.pop(context);
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Thanks for giving your precious  time");
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
        Navigator.pop(context);
        Navigator.pop(context);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        Navigator.pop(context);
        Navigator.pop(context);

        print(response.body);
        // var responseData = json.decode(response.body);
        // Fluttertoast.showToast(msg: "${responseData['message']}");
      }
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Something went wrong...");

      print("Error occured");
    }
  }

  callingLoader() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
                content: Row(
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text("Loading"),
                ),
              ],
            )));
  }
}
