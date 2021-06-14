import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class OnOfferBottomSheet extends StatefulWidget {
  final amount;
  final data;
  OnOfferBottomSheet({Key key, this.data, this.amount}) : super(key: key);
  @override
  _OnOfferBottomSheetState createState() => _OnOfferBottomSheetState();
}

class _OnOfferBottomSheetState extends State<OnOfferBottomSheet> {
  @override
  void initState() {
    offerData = widget.data;
    super.initState();
  }

  var offerData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.58,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    Navigator.pop(context);
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
                margin: EdgeInsets.only(left: 6, top: 15),
                padding: EdgeInsets.all(2),
                child: DottedBorder(
                  strokeWidth: 1,
                  radius: Radius.circular(20),
                  color: Colors.black,
                  child: Text(
                    "${widget.amount}",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              capitalize("${offerData['title']}"),
              style: offerSheetStyle,
            ),
          ),
          offerData['description'] != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    offerData['description'],
                    style: offerCommonStyle,
                  ))
              : SizedBox(),
          offerData['description'] != null
              ? SizedBox(
                  height: 12,
                )
              : SizedBox(),
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
                    " offer Valid ${offerData['perUserValidity']} per user ",
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
                    " offer valid till ${offerData['couponValidity']}",
                    style: TextStyle(color: kTextColor),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
