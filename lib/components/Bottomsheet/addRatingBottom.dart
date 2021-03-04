import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../constants.dart';

class AddRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AddRatingPage(),
    );
  }
}

class AddRatingPage extends StatefulWidget {
  @override
  _AddRatingPageState createState() => _AddRatingPageState();
}

class _AddRatingPageState extends State<AddRatingPage> {
  TextEditingController _commentController = TextEditingController();

  var _commentvalidate;
  var rating = 3.0;
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
                Fluttertoast.showToast(msg: "Comment Posted");
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
                                  allowHalfRating: true,
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

  Future<void> _AddComment() async {
    // for name
    if (_commentController.text.isEmpty) {
      setState(() {
        _commentvalidate =
            "Please Enter The Comment and Star Rating Before Posting It";
      });
    } else {
      setState(() {
        _commentvalidate = null;
      });
    }
  }
}
