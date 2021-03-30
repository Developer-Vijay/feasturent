import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/DineoutReserveTable/dineout_date_select.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutlist.dart';
import 'package:flutter/material.dart';

class PortfolioGallerySubPage extends StatefulWidget {
  final data;
  const PortfolioGallerySubPage({Key key, this.data}) : super(key: key);

  @override
  _PortfolioGallerySubPageState createState() =>
      _PortfolioGallerySubPageState();
}

class _PortfolioGallerySubPageState extends State<PortfolioGallerySubPage> {
  var data;
  @override
  void initState() {
    super.initState();
    data = widget.data;
    print("////////");
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    final _textstyle = TextStyle(color: Colors.black);
    Size size = MediaQuery.of(context).size;
    return Container(
        child: ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 8, right: 30, top: 20, bottom: 20),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, spreadRadius: 3, color: Colors.blue[50])
                  ],
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: data['name'] != null
                            ? Text(
                                '${data['name']}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )
                            : Text("Name of the Restaurant")),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                        child: data['Address']['address'] != null
                            ? Text(
                                data['Address']['address'],
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              )
                            : Text("Address")),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Container(
                            child: data['avgCost'] != null
                                ? Text(
                                    " ₹ ${data['avgCost']}",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  )
                                : Text("offers")),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "for",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                            child: data['forPeople'] != null
                                ? Text(
                                    data['forPeople'],
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  )
                                : Text("Data")),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Call -",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                            child: data['Address']['address'] != null
                                ? Text(
                                    data['user']['phone'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text("phone"))
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "Now Closed",
                          style:
                              TextStyle(color: Colors.red[700], fontSize: 12),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Opens at 07:00 PM",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Pay 10% of Total Bill using PromoCash",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
              )),
        ),
        Container(
            child: ListView.builder(
          itemCount: dineoutlist.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 2,
                          color: Colors.blue[50])
                    ],
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  onTap: () {
                    if (dineoutlist[index].number == 3) {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => Container(
                              height: size.height * 0.6,
                              child: DineoutDateSelection(
                                data: data,
                              )));
                    } else {
                      print(dineoutlist[index].number);
                    }
                  },
                  leading: Container(child: dineoutlist[index].icon),
                  enabled: true,
                  title: Text(dineoutlist[index].title),
                  subtitle: Text(dineoutlist[index].subtitle),
                ),
              ),
            );
          },
        )),
      ],
    ));
  }
}
