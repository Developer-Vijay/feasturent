import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/constants.dart';

class OfferFilter extends StatefulWidget {
  @override
  _OfferFilterState createState() => _OfferFilterState();
}

class _OfferFilterState extends State<OfferFilter> {
  String select = "";
  int isSelect = 0;

  bool select1 = false;
  final pageController = PageController(initialPage: 0);
  bool isSelected = false;
  bool isenabled = false;
  changeValue(int val, data) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Sort And Fliter",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 11,
              child: Container(
                color: Colors.red,
                width: size.width * 1,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              color: Colors.grey[300],
                              height: size.height * 0.40104,
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: filtered.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          filtered[index].name,
                                        ),
                                        enabled: true,
                                        selectedTileColor: Colors.white,
                                        selected: index == isSelect,
                                        onTap: () {
                                          setState(() {
                                            isSelect = index;
                                          });

                                          pageController.animateToPage(
                                              filtered[index].pagecount,
                                              duration:
                                                  Duration(milliseconds: 12),
                                              curve: Curves.bounceIn);
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Container(
                                height: size.height * 0.40104,
                                color: Colors.white,
                                child: PageView(
                                    controller: pageController,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Show Resturent by",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount: sorted.length,
                                                itemBuilder: (contetx, index) {
                                                  return Row(
                                                    children: [
                                                      Radio(
                                                        groupValue:
                                                            selectedRadio,
                                                        value: index,
                                                        onChanged: (value) {
                                                          changeValue(value,
                                                              sorted[index]);
                                                        },
                                                      ),
                                                      Text(sorted[index].name,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  size.height *
                                                                      0.020)),
                                                      Spacer(),
                                                    ],
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Cuisines",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount: cusisinesList.length,
                                                itemBuilder: (contetx, index) {
                                                  return CheckboxListTile(
                                                    title: Text(
                                                        cusisinesList[index]
                                                            .name),
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        cusisinesList[index]
                                                            .index = value;
                                                      });
                                                    },
                                                    value: cusisinesList[index]
                                                        .index,
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Show Resturents with",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount: offerMore.length,
                                                itemBuilder: (contetx, index) {
                                                  return CheckboxListTile(
                                                    title: Text(
                                                        offerMore[index].name),
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        offerMore[index].index =
                                                            value;
                                                      });
                                                    },
                                                    value:
                                                        offerMore[index].index,
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    ])))
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                flex: 2,
                child: MaterialButton(
                  child: Text("Apply"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  minWidth: size.width * 0.9,
                  height: size.height * 0.07,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
