import 'package:feasturent_costomer_app/components/AddressBook/addAddress.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/profile/userProfile.dart';
import 'package:flutter/material.dart';

class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  final textstyle = TextStyle(color: Colors.black, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(Icons.arrow_back_sharp),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    "My Addresses",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                onPressed: () {},
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddAdress()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.blue,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Add a new address",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 18,
                child: ListView.builder(
                    itemCount: temp.length,
                    itemBuilder: (context, index) {
                      return Container(
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
                                  PopupMenuButton(
                                    onSelected: (value) {
                                      if (value == 0) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => AddAdress(
                                                    fullName: temp[index]
                                                        .fullnameHolder,
                                                    phoneNumber: temp[index]
                                                        .phonenumberHolder,
                                                    pincode: temp[index]
                                                        .pincodeHolder,
                                                    houseno: temp[index]
                                                        .housenoholder,
                                                    roadname:
                                                        temp[index].roadholder,
                                                    city:
                                                        temp[index].cityholder,
                                                    state:
                                                        temp[index].stateholder,
                                                    landmark: temp[index]
                                                        .landmarkholder,
                                                    indexnumber: temp.indexOf(
                                                        temp[index]))));
                                      } else if (value == 1) {
                                        setState(() {
                                          temp.remove(temp[index]);
                                        });
                                      }
                                    },
                                    itemBuilder: (BuildContext context) => [
                                      PopupMenuItem(
                                        child: Text("Edit"),
                                        enabled: true,
                                        value: 0,
                                      ),
                                      PopupMenuItem(
                                        child: Text("Remove"),
                                        enabled: true,
                                        value: 1,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    temp[index].fullnameHolder,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  Text("${temp[index].phonenumberHolder}",
                                      style: textstyle),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Container(
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: temp[index].valueholder == 0
                                          ? Text(
                                              "Home",
                                              style: textstyle,
                                            )
                                          : Text(
                                              "office",
                                              style: textstyle,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
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
                      );
                    }))
          ]),
        ),
      ),
    );
  }
}
