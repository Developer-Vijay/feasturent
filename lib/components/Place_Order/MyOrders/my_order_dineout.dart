import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import '../../../shimmer_effect.dart';
import 'my_orders_resturent.dart';
import 'package:date_time_format/date_time_format.dart';

class MyOrdersDineout extends StatefulWidget {
  @override
  _MyOrdersDineoutState createState() => _MyOrdersDineoutState();
}

class _MyOrdersDineoutState extends State<MyOrdersDineout> {
  var snapshot = dineoutorders;

  @override
  Widget build(BuildContext context) {
    final textstyle1 =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w800);
    final textstyle2 = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    );
    Size size = MediaQuery.of(context).size;
    return Container(
        child: ListView(
      children: [
        dineoutorders != null
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.length,
                // ignore: missing_return
                itemBuilder: (BuildContext context, index) {
                  DateTime currentTime = DateTime.now();

                  DateTime _timed =
                      DateTime.parse(snapshot[index]['customerBookingDate']);
                  var data2 = _timed.toLocal();
                  var data4 = _timed.toLocal();
                  // ignore: unused_local_variable
                  var time = snapshot[index]['tableTiming'];
                  DateTime timedate;

                  print("############");
                  if (snapshot[index]['tableTiming']
                          .contains(RegExp(r'[a-z]')) ==
                      false) {
                    timedate = DateFormat('HH:mm aaa')
                        .parse(snapshot[index]['tableTiming']);
                  } else {
                    timedate =
                        DateTime.parse(snapshot[index]['customerBookingDate']);
                  }
                  // print(snapshot[index]['tableTiming']
                  //     .contains(RegExp(r'[a-z]')));
                  // print(new DateFormat('HH:mm aaa').parse(snapshot[index]
                  //     ['tableTiming'])); // 2020-07-10 23:09:00.000

                  print("check........");
                  print(data2);
                  var data5 = data4.format("\d \F\ \Y");
                  var data3 = data2.format("\l");
                  var data8 = timedate.format("\h:\i \A");

                  int orderyear = int.parse(data4.format('Y'));
                  int ordermonth = int.parse(data4.format('m'));
                  int orderday = int.parse(data4.format('d'));
                  int orderhrs = int.parse(timedate.format('H'));
                  int ordermins = int.parse(timedate.format('i'));

                  // ignore: unused_local_variable
                  int currentyear = int.parse(currentTime.format('Y'));
                  int currentmonth = int.parse(currentTime.format('m'));
                  int currentday = int.parse(currentTime.format('d'));
                  int currenthrs = int.parse(currentTime.format('H'));
                  int currentmins = int.parse(currentTime.format('i'));

                  // print("order day = ${data4.format('d')}");
                  // print("order months = ${data4.format('m')}");
                  // print("order year = ${data4.format('Y')}");
                  // print("order hrs = ${data4.format('H')}");
                  // print("order mins = ${data4.format('i')}");

                  // print(
                  //     "@@@@@@@@@@@@@@@@@@%%%%%%%%%%%%%%%%%%%%%%%%%@@@@@@@@@@@@@@@@");

                  // print("current day = ${currentTime.format('d')}");
                  // print("current months = ${currentTime.format('m')}");
                  // print("current year = ${currentTime.format('Y')}");
                  // print("current hrs = ${currentTime.format('H')}");
                  // print("current mins = ${currentTime.format('i')}");
                  int totalperson = int.parse(snapshot[index]['male']) +
                      int.parse(snapshot[index]['child']) +
                      int.parse(snapshot[index]['female']);
                  // print(currentTime.difference(data2));
                  // print(data3);
                  {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 12.0, top: 20, bottom: 10.0),
                      child: InkWell(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1,
                                      spreadRadius: 3,
                                      color: Colors.blue[50],
                                      offset: Offset(1, 3))
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: size.width * 0.55,
                                          padding: const EdgeInsets.only(
                                              left: 12.0, top: 10),
                                          child: Text(
                                            capitalize(snapshot[index]
                                                ['VendorInfo']['name']),
                                            style: textstyle1,
                                          ),
                                        ),
                                        Container(
                                          color: Color(0xfffaf1ab),
                                          margin: const EdgeInsets.all(5.0),
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            capitalize(
                                                "Booking ID - ${snapshot[index]['bookingId']}"),
                                            style: textstyle1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: snapshot[index]['VendorInfo']
                                                    ['user']['profile'] !=
                                                null
                                            ? CachedNetworkImage(
                                                imageUrl: S3_BASE_PATH +
                                                    snapshot[index]
                                                            ['VendorInfo']
                                                        ['user']['profile'],
                                                fit: BoxFit.fill,
                                                height: size.height * 0.1,
                                                width: size.width * 0.26,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              )
                                            : Image.asset(
                                                "assets/images/defaultdineout.jpg",
                                                height: size.height * 0.1,
                                                width: size.width * 0.26,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.025,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "$data5",
                                        style: textstyle2,
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        "Lucnh for $totalperson",
                                        style: textstyle2,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.005,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "$data3 at $data8",
                                        style: textstyle1,
                                      ),
                                    ),
                                    Spacer(),
                                    snapshot[index]['vendorBookingStatus'] ==
                                            null
                                        ? SizedBox()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              '${snapshot[index]['vendorBookingStatus']}',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.025,
                                ),
                                orderyear != currentyear
                                    ? datacheck(index, size)
                                    : ordermonth != currentmonth
                                        ? datacheck(index, size)
                                        : orderday != currentday
                                            ? datacheck(index, size)
                                            : orderhrs != currenthrs
                                                ? datacheck(index, size)
                                                : ordermins == currentmins
                                                    ? MaterialButton(
                                                        child: Text("Cancel"),
                                                        color: Colors.red,
                                                        textColor: Colors.white,
                                                        onPressed: () {
                                                          // cancelOrder(snapshot.data[index]);
                                                        },
                                                      )
                                                    : datacheck(index, size),

                                // Row(
                                //     children: [
                                //       Spacer(),
                                //       Container(
                                //         decoration: BoxDecoration(
                                //             color: Colors
                                //                 .red
                                //                 .shade400,
                                //             borderRadius: BorderRadius
                                //                 .all(Radius
                                //                     .circular(
                                //                         5))),
                                //         width: size.width *
                                //             0.425,
                                //         height: 50,
                                //         child: Center(
                                //           child: Text(
                                //             "Write A Review",
                                //             style: TextStyle(
                                //                 color: Colors
                                //                     .white,
                                //                 fontSize:
                                //                     16,
                                //                 fontWeight:
                                //                     FontWeight
                                //                         .bold),
                                //           ),
                                //         ),
                                //       ),
                                //       SizedBox(
                                //         width: size.width *
                                //             0.05,
                                //       ),
                                //       Container(
                                //         width: size.width *
                                //             0.425,
                                //         height: 50,
                                //         decoration: BoxDecoration(
                                //             color: Colors
                                //                 .red
                                //                 .shade400,
                                //             borderRadius: BorderRadius
                                //                 .all(Radius
                                //                     .circular(
                                //                         5))),
                                //         child: Center(
                                //           child: Text(
                                //             "Reserve Again",
                                //             style: TextStyle(
                                //                 color: Colors
                                //                     .white,
                                //                 fontSize:
                                //                     16,
                                //                 fontWeight:
                                //                     FontWeight
                                //                         .bold),
                                //           ),
                                //         ),
                                //       ),
                                //       Spacer(),
                                //     ],
                                //   ),
                                SizedBox(
                                  height: size.height * 0.025,
                                ),
                              ],
                            )),
                      ),
                    );
                  }
                })
            : LoadingListPage()
      ],
    ));
  }

  datacheck(index, size) {
    if (snapshot[index]['vendorBookingStatus'] == 'VISTED') {
      return Row(
        children: [
          Spacer(),
          Container(
            decoration: BoxDecoration(
                color: Colors.red.shade400,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            width: size.width * 0.425,
            height: 50,
            child: Center(
              child: Text(
                "Write A Review",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.05,
          ),
          Container(
            width: size.width * 0.425,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.red.shade400,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: Text(
                "Reserve Again",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Spacer(),
        ],
      );
    } else {
      return Center(
        child: Text(
          "Not visited",
          style: TextStyle(
              color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }
  }
}
