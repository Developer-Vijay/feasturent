import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/DineoutReserveTable/dineput_book_summary.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants.dart';

// ignore: must_be_immutable
class DineoutAddMembers extends StatefulWidget {
  final phone;
  var date;
  var time;
  var data;
  var senddate;
  DineoutAddMembers(
      {this.date, this.time, this.senddate, this.data, this.phone});
  @override
  _DineoutAddMembersState createState() => _DineoutAddMembersState();
}

class _DineoutAddMembersState extends State<DineoutAddMembers> {
  int male = 0;
  int female = 0;
  int children = 0;
  int adult = 0;
  int guest = 0;

  var showdate;
  var showtime;
  var senddate;
  @override
  void initState() {
    super.initState();
    male = 0;
    female = 0;
    children = 0;
    showdate = widget.date;
    showtime = widget.time;
    senddate = widget.senddate;
  }

  @override
  void dispose() {
    super.dispose();
    male = 0;
    female = 0;
    children = 0;
  }

  @override
  Widget build(BuildContext context) {
    guest = male + female + children;
    adult = male + female;
    print(guest);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(capitalize(widget.data['name'])),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12, top: 12, bottom: 12),
              child: Container(
                height: size.height * 0.07,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$showdate",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$showtime",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: widget.data['user']['OffersAndCoupons'].isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        var couponDetatil;

                        if (widget.data['user']['OffersAndCoupons'][index]
                                ['discount'] ==
                            null) {
                          String symbol;
                          if (widget.data['user']['OffersAndCoupons'][index]
                                  ['couponDiscountType'] ==
                              "PERCENT") {
                            symbol = "%";
                          } else {
                            symbol = "₹";
                          }

                          couponDetatil =
                              "${widget.data['user']['OffersAndCoupons'][index]['couponDiscount']}$symbol off";
                        } else {
                          String symbol;
                          if (widget.data['user']['OffersAndCoupons'][index]
                                  ['discountType'] ==
                              "PERCENT") {
                            symbol = "%";
                          } else {
                            symbol = "₹";
                          }

                          couponDetatil =
                              "${widget.data['user']['OffersAndCoupons'][index]['discount']}$symbol off";
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      color: Colors.blue[50],
                                      spreadRadius: 2,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.bar_chart_sharp,
                                          color: Colors.red[300],
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          "Trending",
                                          style: TextStyle(
                                              color: Colors.red[300],
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            child: widget.data['user']
                                                            ['OffersAndCoupons']
                                                        [index]['title'] !=
                                                    null
                                                ? Text(
                                                    capitalize(
                                                        "${widget.data['user']['OffersAndCoupons'][index]['title']}"),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                : Text("Coupon Details...")),
                                        Spacer(),
                                        CircleAvatar(
                                          backgroundColor: Colors.grey[200],
                                          child: Icon(
                                            Icons.note,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: widget.data['user']
                                                          ['OffersAndCoupons']
                                                      [index]['coupon'] !=
                                                  null
                                              ? Text(
                                                  'Use coupon code : ${widget.data['user']['OffersAndCoupons'][index]['coupon']}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              : SizedBox(
                                                  width: 6,
                                                ),
                                        ),
                                        Spacer(),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Container(
                                            child: couponDetatil != null
                                                ? Text(
                                                    "₹ $couponDetatil",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                : Text("Coupon discount")),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            child: widget.data['user'][
                                                                'OffersAndCoupons']
                                                            [index]
                                                        ['couponValidity'] !=
                                                    null
                                                ? Text(
                                                    ' The offer is valid till - ${widget.data['user']['OffersAndCoupons'][index]['couponValidity']}',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : Text("No offer Avalioable")),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 3,
                                      width: size.width * 0.98,
                                      color: Colors.red[300],
                                      child: Text("1"),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    widget.data['user']['OffersAndCoupons']
                                                [index]['description'] ==
                                            ''
                                        ? SizedBox()
                                        : Text(
                                            "Avaliable All Time",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                    widget.data['user']['OffersAndCoupons']
                                                [index]['description'] ==
                                            ''
                                        ? SizedBox()
                                        : SizedBox(
                                            height: 5,
                                          ),
                                    widget.data['user']['OffersAndCoupons']
                                                [index]['description'] ==
                                            ''
                                        ? SizedBox()
                                        : Container(
                                            width: size.width * 1,
                                            decoration: BoxDecoration(
                                                color: Colors.amber[100],
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.data['user']
                                                        ['OffersAndCoupons']
                                                    [index]['description'],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                    widget.data['user']['OffersAndCoupons']
                                                [index]['description'] ==
                                            ''
                                        ? SizedBox()
                                        : Container(
                                            height: 6,
                                            width: size.width * 0.9,
                                            color: Colors.blue,
                                          ),
                                  ],
                                ),
                              )),
                        );
                      },
                    )
                  : Text(
                      "No offers added",
                      style: TextStyle(color: Colors.black54),
                    ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Container(
                height: size.height * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 3,
                          color: Colors.blue[50],
                          offset: Offset(2, 2))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select Guests",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Text(
                          "Choose the Number of Guests going",
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        )),
                    SizedBox(height: size.height * 0.04),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Male",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey[50],
                            foregroundColor: Colors.blue,
                            radius: 12,
                            child: InkWell(
                              onTap: () {
                                if (male == 0) {
                                  setState(() {
                                    male = 0;
                                  });
                                } else {
                                  setState(() {
                                    male--;
                                  });
                                }
                              },
                              child: Icon(
                                Icons.remove,
                                size: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "$male",
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey[50],
                            foregroundColor: Colors.blue,
                            radius: 12,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  male++;
                                });
                              },
                              child: Icon(
                                Icons.add,
                                size: 18,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Female",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey[50],
                            foregroundColor: Colors.blue,
                            radius: 12,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (female == 0) {
                                    setState(() {
                                      female = 0;
                                    });
                                  } else {
                                    setState(() {
                                      female--;
                                    });
                                  }
                                });
                              },
                              child: Icon(
                                Icons.remove,
                                size: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "$female",
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey[50],
                            foregroundColor: Colors.blue,
                            radius: 12,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  female++;
                                });
                              },
                              child: Icon(
                                Icons.add,
                                size: 18,
                              ),
                            ),
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Children",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey[50],
                            foregroundColor: Colors.blue,
                            radius: 12,
                            child: InkWell(
                              onTap: () {
                                if (children == 0) {
                                  setState(() {
                                    children = 0;
                                  });
                                } else {
                                  setState(() {
                                    children--;
                                  });
                                }
                              },
                              child: Icon(
                                Icons.remove,
                                size: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "$children",
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey[50],
                            foregroundColor: Colors.blue,
                            radius: 12,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  children++;
                                });
                              },
                              child: Icon(
                                Icons.add,
                                size: 18,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: MaterialButton(
                onPressed: () {
                  if (male == 0 && female == 0) {
                    Fluttertoast.showToast(msg: 'Please add no. of guest');
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DineoutBookingSummary(
                                  phone: widget.phone,
                                  date: showdate,
                                  time: showtime,
                                  data: widget.data,
                                  femalecount: female,
                                  malecount: male,
                                  childcount: children,
                                  totalguest: guest,
                                  senddate: senddate,
                                  adult: adult,
                                )));
                  }
                },
                child: Text("Continue to Reserve"),
                color: Colors.blue,
                minWidth: size.width * 0.8,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
