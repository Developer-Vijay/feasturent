import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/DineoutReserveTable/dineput_book_summary.dart';
import 'package:flutter/material.dart';

class DineoutAddMembers extends StatefulWidget {
  var date;
  var time;
  DineoutAddMembers({this.date, this.time});
  @override
  _DineoutAddMembersState createState() => _DineoutAddMembersState();
}

class _DineoutAddMembersState extends State<DineoutAddMembers> {
  int counter = 0;
  int counter1 = 0;
  var showdate;
  var showtime;
  @override
  void initState() {
    super.initState();
    counter = 0;
    counter1 = 0;
    showdate = widget.date;
    showtime = widget.time;
  }

  @override
  void dispose() {
    super.dispose();
    counter = 0;
    counter1 = 0;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "$showdate",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "$showtime",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            Padding(
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
                                  color: Colors.red[300], fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "50% Off Total Bill",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
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
                            Text(
                              "1 Guest(s)",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              "from",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "₹ 35",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("25 left for 26th Feb"),
                            Spacer(),
                            MaterialButton(
                                onPressed: () {},
                                minWidth: 50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  "BUY NOW",
                                  style: TextStyle(fontSize: 12),
                                ),
                                color: Colors.white)
                          ],
                        ),
                        Container(
                          height: 3,
                          width: size.width * 0.7,
                          color: Colors.red[300],
                          child: Text("1"),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Avaliable All Days",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.amber[100],
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Only Applicable when Paying using Dineout Pay",
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Container(
                          height: 6,
                          width: size.width * 0.9,
                          color: Colors.blue,
                          child: Text("1"),
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Container(
                height: size.height * 0.2,
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
                      child: Text("Choose the Number of Guests going"),
                    ),
                    SizedBox(height: size.height * 0.04),
                    Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Male",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
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
                              if (counter1 == 0) {
                                setState(() {
                                  counter = 0;
                                });
                              } else {
                                setState(() {
                                  counter1--;
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
                        Text("$counter1"),
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
                                counter1++;
                              });
                            },
                            child: Icon(
                              Icons.add,
                              size: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.099,
                        ),
                        Text(
                          "Female",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
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
                                if (counter == 0) {
                                  setState(() {
                                    counter = 0;
                                  });
                                } else {
                                  setState(() {
                                    counter--;
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
                        Text("$counter"),
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
                                counter++;
                              });
                            },
                            child: Icon(
                              Icons.add,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.13,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DineoutBookingSummary(
                              date: showdate,
                              time: showtime,
                              femalecount: counter1,
                              malecount: counter,
                            )));
              },
              child: Text("Continue to Reserve"),
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: size.width * 0.9,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            )
          ],
        ),
      ),
    );
  }
}
