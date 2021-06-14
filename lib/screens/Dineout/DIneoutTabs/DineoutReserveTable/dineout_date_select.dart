import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/DineoutReserveTable/dineout_add_guest.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:date_time_format/date_time_format.dart';

class DineoutDateSelection extends StatefulWidget {
  final phone;
  final cate;
  final data;
  const DineoutDateSelection({this.data, this.cate, this.phone});
  @override
  _DineoutDateSelectionState createState() => _DineoutDateSelectionState();
}

DateTime selectedDate = DateTime.now();

final datetime = DateTime.now();

var date = DateTime.parse("$selectedDate");
var formattedDate = "${date.day}-${date.month}-${date.year}";
var myFormat = DateFormat('d-MM-yyyy');

final pageController = PageController(initialPage: 0);

class _DineoutDateSelectionState extends State<DineoutDateSelection> {
  List<TimeList> breaskfastList = [
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "09:00 AM",
        format: "AM",
        hour: 09),
    TimeList(
        isSelected1: false,
        isSelected: false,
        time: "09:30 AM",
        format: "AM",
        hour: 09),
    TimeList(
        isSelected1: false,
        isSelected: false,
        time: "10:00 AM",
        format: "AM",
        hour: 10),
    TimeList(
        isSelected1: false,
        isSelected: false,
        time: "10:30 AM",
        format: "AM",
        hour: 10),
    TimeList(
        isSelected1: false,
        isSelected: false,
        time: "11:00 AM",
        format: "AM",
        hour: 10),
  ];

  List<TimeList> lunchlist = [
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "12:00 PM",
        format: 'PM',
        hour: 12),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "12:30 PM",
        format: 'PM',
        hour: 12),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "01:00 PM",
        format: 'PM',
        hour: 13),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "01:30 PM",
        format: 'PM',
        hour: 13),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "02:00 PM",
        format: 'PM',
        hour: 14),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "02:30 PM",
        format: 'PM',
        hour: 14),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "03:00 PM",
        format: 'PM',
        hour: 15),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "03:30 PM",
        format: 'PM',
        hour: 15),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "04:00 PM",
        format: 'PM',
        hour: 16),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "04:30 PM",
        format: 'PM',
        hour: 16),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "05:00 PM",
        format: 'PM',
        hour: 17),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "05:30 PM",
        format: 'PM',
        hour: 17),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "06:00 PM",
        format: 'PM',
        hour: 18),
  ];

  List<TimeList> dinnerlist = [
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "07:00 PM",
        format: 'PM',
        hour: 19),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "07:30 PM",
        format: 'PM',
        hour: 19),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "08:00 PM",
        format: 'PM',
        hour: 20),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "08:30 PM",
        format: 'PM',
        hour: 20),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "09:00 PM",
        format: 'PM',
        hour: 21),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "09:30 PM",
        format: 'PM',
        hour: 21),
    TimeList(
        isSelected1: true,
        isSelected: false,
        time: "10:00 PM",
        format: ' PM',
        hour: 22),
  ];

  int isSelect = 0;
  bool isSelected = false;
  bool isSelected1 = false;
  bool isSelected2 = false;
  var time;
  @override
  void initState() {
    super.initState();
    isSelected = true;
  }

  cleardata() {
    int k = lunchlist.length - 1;
    for (int i = 0; i <= k; i++) {
      setState(() {
        lunchlist[i].isSelected = false;
      });
    }
    int l = breaskfastList.length - 1;
    for (int m = 0; m <= l; m++) {
      setState(() {
        breaskfastList[m].isSelected = false;
      });
    }
    int x = dinnerlist.length - 1;
    for (int y = 0; y <= x; y++) {
      setState(() {
        dinnerlist[y].isSelected = false;
      });
    }
  }

  timeChecker(month, day, data, index) {
    int hours = data[index].hour;
    print("time $hours");
    var format = data[index].format;
    print("format $format");
    print("month $month");

    print("day $day");

    int cuHour = int.parse(DateTime.now().format('H'));
    // ignore: unused_local_variable
    var cuFormat = DateTime.now().format('A');
    var cuday = DateTime.now().format('d');
    var cuMonth = DateTime.now().format('m');
    if (month == cuMonth) {
      print("month matched");
      if (day == cuday) {
        print("day matched");

        if (hours <= cuHour) {
          print("hours matched");
          cleardata();
          setState(() {
            time = null;
          });
          Fluttertoast.showToast(msg: 'currently unable');
        } else {
          setState(() {
            data[index].isSelected = true;
            time = "${data[index].time}";
          });
        }
      } else {
        setState(() {
          data[index].isSelected = true;
          time = "${data[index].time}";
        });
      }
    } else {
      setState(() {
        data[index].isSelected = true;
        time = "${data[index].time}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(DateTime.now());
    print(DateTime.now().format('h'));
    print(DateTime.now().format('A'));
    print(DateTime.now().format('d'));
    print(DateTime.now().format('m'));

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                children: [
                  widget.data['dineoutImages'].isNotEmpty
                      ? Container(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: size.width * 0.2,
                            height: size.height * 0.1,
                            imageUrl: S3_BASE_PATH +
                                widget.data['dineoutImages'][0]['image'],
                          ),
                        )
                      : Image.asset(
                          "assets/images/defaultdineout.jpg",
                          width: size.width * 0.2,
                          height: size.height * 0.1,
                          fit: BoxFit.cover,
                        ),
                  SizedBox(
                    width: 9,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          capitalize(widget.data['name']),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 21),
                        ),
                        widget.cate == null
                            ? SizedBox()
                            : Container(
                                width: size.width * 0.65,
                                child: Text(
                                  capitalize(widget.cate),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black45),
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: MaterialButton(
              child: Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset('assets/icons/calendar.svg'),
                    tooltip: 'Select Date',
                    iconSize: 40,
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  Text(selectedDate.format("\d-\M\-\Y"))
                ],
              ),
              onPressed: () {
                _selectDate(context);
              },
            ),
          ),
          Container(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.,
              children: [
                Spacer(),
                InputChip(
                  label: Container(
                    width: 62,
                    height: 20,
                    child: Center(
                      child: Text(
                        "Breakfast",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  selectedColor: Colors.blue,
                  disabledColor: Colors.grey[200],
                  elevation: 2,
                  isEnabled: true,
                  backgroundColor: Colors.blueGrey,
                  selected: isSelected1,
                  checkmarkColor: Colors.white,
                  showCheckmark: true,
                  onSelected: (value) {
                    setState(() {
                      isSelect = 1;
                    });
                    pageController.animateToPage(1,
                        duration: Duration(milliseconds: 12),
                        curve: Curves.bounceIn);

                    if (isSelected1 == false) {
                      setState(() {
                        isSelected1 = true;
                        isSelected = false;
                        isSelected2 = false;
                      });
                    } else {
                      setState(() {
                        isSelected1 = false;
                      });
                    }
                  },
                ),
                Spacer(),
                InputChip(
                  backgroundColor: Colors.blueGrey,
                  label: Container(
                    width: 62,
                    height: 20,
                    child: Center(
                      child: Text(
                        "Lunch",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  selectedColor: Colors.blue,
                  disabledColor: Colors.grey[200],
                  elevation: 2,
                  isEnabled: true,
                  selected: isSelected,
                  showCheckmark: true,
                  checkmarkColor: Colors.white,
                  onSelected: (value) {
                    setState(() {
                      isSelect = 2;
                    });
                    pageController.animateToPage(0,
                        duration: Duration(milliseconds: 12),
                        curve: Curves.bounceIn);

                    if (isSelected == false) {
                      setState(() {
                        isSelected = true;
                        isSelected1 = false;
                        isSelected2 = false;
                      });
                    } else {
                      setState(() {
                        isSelected = false;
                      });
                    }
                  },
                ),
                Spacer(),
                InputChip(
                  backgroundColor: Colors.blueGrey,
                  label: Container(
                    width: 62,
                    height: 20,
                    child: Center(
                      child: Text(
                        "Dinner",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  selectedColor: Colors.blue,
                  disabledColor: Colors.grey[200],
                  elevation: 2,
                  isEnabled: true,
                  selected: isSelected2,
                  checkmarkColor: Colors.white,
                  showCheckmark: true,
                  onSelected: (value) {
                    setState(() {
                      isSelect = 3;
                    });
                    pageController.animateToPage(3,
                        duration: Duration(milliseconds: 12),
                        curve: Curves.bounceIn);

                    if (isSelected2 == false) {
                      setState(() {
                        isSelected2 = true;
                        isSelected1 = false;
                        isSelected = false;
                      });
                    } else {
                      setState(() {
                        isSelected2 = false;
                      });
                    }
                  },
                ),
                Spacer(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: PageView(
                pageSnapping: false,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: pageController,
                children: [
                  // Breakfast

                  GridView.builder(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2.4,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0),
                    shrinkWrap: true,
                    itemCount: lunchlist.length,
                    itemBuilder: (context, index) {
                      return InputChip(
                        label: Container(
                            width: 65,
                            height: 20,
                            child: Center(
                              child: lunchlist[index].isSelected == true
                                  ? Text(
                                      lunchlist[index].time,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      lunchlist[index].time,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                            )),
                        selectedColor: Colors.blue,
                        disabledColor: Colors.grey[200],
                        elevation: 2,
                        checkmarkColor: Colors.white,
                        isEnabled: true,
                        selected: lunchlist[index].isSelected,
                        showCheckmark: true,
                        onSelected: (value) {
                          cleardata();
                          if (lunchlist[index].isSelected == true) {
                            print("i think");
                            setState(() {
                              lunchlist[index].isSelected = false;
                              time = null;
                            });
                          } else {
                            timeChecker(selectedDate.format('m'),
                                selectedDate.format('d'), lunchlist, index);

                            print("i dont think");
                          }
                        },
                      );
                    },
                  ),
                  // breakfast
                  GridView.builder(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        childAspectRatio: 2.4,
                        crossAxisCount: 3),
                    shrinkWrap: true,
                    itemCount: breaskfastList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InputChip(
                          label: Container(
                              width: 65,
                              height: 20,
                              child: Center(
                                child: breaskfastList[index].isSelected == true
                                    ? Text(
                                        breaskfastList[index].time,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        breaskfastList[index].time,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                              )),
                          selectedColor: Colors.blue,
                          disabledColor: Colors.grey[200],
                          elevation: 2,
                          isEnabled: true,
                          checkmarkColor: Colors.white,
                          selected: breaskfastList[index].isSelected,
                          showCheckmark: true,
                          onSelected: (value) {
                            cleardata();
                            if (breaskfastList[index].isSelected == true) {
                              setState(() {
                                breaskfastList[index].isSelected = false;
                                time = null;
                              });
                            } else {
                              timeChecker(
                                  selectedDate.format('m'),
                                  selectedDate.format('d'),
                                  breaskfastList,
                                  index);
                            }
                          },
                        ),
                      );
                    },
                  ),

                  // Dinner
                  GridView.builder(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 2.4),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 0),
                    scrollDirection: Axis.vertical,
                    itemCount: dinnerlist.length,
                    itemBuilder: (context, index) {
                      return InputChip(
                        label: Container(
                            width: 65,
                            height: 20,
                            child: Center(
                              child: dinnerlist[index].isSelected == true
                                  ? Text(
                                      dinnerlist[index].time,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      dinnerlist[index].time,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                            )),
                        selectedColor: Colors.blue,
                        disabledColor: Colors.grey[200],
                        elevation: 2,
                        isEnabled: true,
                        selected: dinnerlist[index].isSelected,
                        showCheckmark: true,
                        checkmarkColor: Colors.white,
                        onSelected: (value) {
                          cleardata();
                          if (dinnerlist[index].isSelected == true) {
                            setState(() {
                              dinnerlist[index].isSelected = false;
                              time = null;
                            });
                          } else {
                            timeChecker(selectedDate.format('m'),
                                selectedDate.format('d'), dinnerlist, index);
                          }
                        },
                        // avatar: Icon(
                        //   Icons.lock_clock,
                        //   color: Colors.white,
                        // ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              time == null
                  ? Fluttertoast.showToast(msg: 'Please select valid time')
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DineoutAddMembers(
                              phone: widget.phone,
                              data: widget.data,
                              senddate: selectedDate.format("\d-\M-\Y"),
                              date: selectedDate.format("\d-\M-\Y-\D"),
                              time: time)));
            },
            color: Colors.blue,
            minWidth: size.width * 0.8,
            textColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text("Continue"),
          )
        ],
      ),
    ));
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 30)),
        helpText: "Select Booking Date",
        confirmText: "Confirm");
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
