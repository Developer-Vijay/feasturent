import 'package:dotted_border/dotted_border.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/insideofferpage.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class OnOfferBottomSheet extends StatefulWidget {
  @override
  _OnOfferBottomSheetState createState() => _OnOfferBottomSheetState();
}

class _OnOfferBottomSheetState extends State<OnOfferBottomSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.56,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: size.height * 0.022, left: size.width * 0.03),
                child: Text(
                  "Offer Details",
                  style: offerRecommendStyle,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: size.height * 0.022, left: size.width * 0.03),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => OfferListPage()),
                    );
                  },
                ),
              )
            ],
          ),
          Divider(
            height: 2,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 6),
                padding: EdgeInsets.all(2),
                child: DottedBorder(
                  strokeWidth: 1,
                  radius: Radius.circular(20),
                  color: Colors.black,
                  child: Text(
                    "WELCOME1234",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.content_copy),
                onPressed: () async {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Get 20% discount on your First order using Axis Bank Cards",
              style: offerSheetStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Use code Welcome50 and get 50% discount up to INR 300/-on orders above INR 600/-",
              style: offerCommonStyle,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: size.width * 0.03),
              child: Text(
                "Terms and Conditions",
                style: offerRowHeadingStyle,
              )),
          SizedBox(
            height: size.height * 0.034,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: size.width * 0.01),
                  child: Text(
                    " offer Valid thrice per user per month",
                    style: TextStyle(color: kTextColor),
                  )),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: size.width * 0.01),
                  child: Text(
                    " The maximum discount is upto 400",
                    style: TextStyle(color: kTextColor),
                  )),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: size.width * 0.01),
                  child: Text(
                    " offer valid on minimum card value",
                    style: TextStyle(color: kTextColor),
                  )),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: size.width * 0.01),
                  child: Text(
                    " offer valid till 14th feb",
                    style: TextStyle(color: kTextColor),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
