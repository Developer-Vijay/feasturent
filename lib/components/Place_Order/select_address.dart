import 'package:feasturent_costomer_app/components/AddressBook/addAddress.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/Place_Order/place_order.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';

class SelectAddress extends StatefulWidget {
  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  final textstyle = TextStyle(color: Colors.black, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // padding: EdgeInsets.only(top: 7, left: 7, right: 7),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: size.height * 0.75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "Select an address",
                  style: TextStyle(
                      color: Colors.black, fontSize: size.height * 0.0275),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.clear,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 7,
            color: Colors.grey,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddAdress()));
            },
            child: Container(
              height: size.height * 0.06,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.red,
                      size: size.height * 0.025,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Add Address",
                      style: TextStyle(
                          color: Colors.red, fontSize: size.height * 0.0225),
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 7,
            color: Colors.grey,
          ),
          Row(
            children: [
              Container(
                height: size.height * 0.06,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Saved Addresses",
                      style: TextStyle(
                          color: Colors.black, fontSize: size.height * 0.0225),
                    )),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: temp.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        userNameWithNumber =
                            "${temp[index].fullnameHolder}, ${temp[index].phonenumberHolder}";

                        addAddress =
                            "${temp[index].housenoholder},${temp[index].roadholder},${temp[index].stateholder}";
                      });
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => PlaceOrder()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(blurRadius: 2, color: Colors.grey[500])
                          ]),
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Address",
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                                Spacer(),

                                // ignore: non_constant_identifier_names
                                PopupMenuButton(
                                  onSelected: (value) {
                                    temp.remove(temp[index]);
                                  },
                                  itemBuilder: (BuildContext) => [
                                    PopupMenuItem(
                                      child: Text("Edit"),
                                      enabled: true,
                                    ),
                                    PopupMenuItem(
                                      child: Text("Remove"),
                                      enabled: true,
                                      value: temp,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  temp[index].fullnameHolder,
                                  // "${widget.fullnameHolder}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(temp[index].phonenumberHolder,
                                style: textstyle),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              temp[index].pincodeHolder,
                              style: textstyle,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              temp[index].cityholder,
                              style: textstyle,
                            ),
                            Text(
                              temp[index].stateholder,
                              style: textstyle,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              temp[index].housenoholder,
                              style: textstyle,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              temp[index].roadholder,
                              style: textstyle,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              temp[index].landmarkholder,
                              style: textstyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
