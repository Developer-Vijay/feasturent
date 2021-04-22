import 'dart:convert';
import 'package:feasturent_costomer_app/components/AddressBook/newAddressPage.dart';
import 'package:feasturent_costomer_app/components/OfferPageScreen/foodlistclass.dart';
import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddAdress extends StatefulWidget {
  final fullName;
  final phoneNumber;
  final pincode;
  final houseno;
  final roadname;
  final landmark;
  final city;
  final state;
  final type;
  final indexnumber;
  const AddAdress({
    Key key,
    this.fullName,
    this.city,
    this.houseno,
    this.landmark,
    this.phoneNumber,
    this.pincode,
    this.roadname,
    this.state,
    this.type,
    this.indexnumber,
  }) : super(key: key);
  @override
  _AddAdressState createState() => _AddAdressState();
}

class _AddAdressState extends State<AddAdress> {
  @override
  void initState() {
    super.initState();
    isSelected = true;
    data = "Home";
    if (widget.fullName != null) {
      setState(() {
        citiesSelected.text = widget.city;
        _fullnamecontroller.text = widget.fullName;
        _phonenumbercontroller.text = widget.phoneNumber;
        _pincodecontroller.text = widget.pincode;
        _housenocontroller.text = widget.houseno;
        _roadnamecontroller.text = widget.roadname;
        _landmarkcontroller.text = widget.landmark;
        stateSelected.text = widget.state;
      });
      if (widget.type == 0) {
        setState(() {
          isSelected = true;
        });
      } else if (widget.type == 1) {
        setState(() {
          isSelected1 = true;
        });
      }
    }
  }

  TextEditingController citiesSelected = TextEditingController();
  TextEditingController _fullnamecontroller = TextEditingController();
  TextEditingController _phonenumbercontroller = TextEditingController();
  TextEditingController _pincodecontroller = TextEditingController();
  TextEditingController _housenocontroller = TextEditingController();
  TextEditingController _roadnamecontroller = TextEditingController();
  TextEditingController _landmarkcontroller = TextEditingController();

  var _fullNameValidate;
  var _phoneNumberValidate;
  var _pincodeValidate;
  var _housenoValidate;
  var _roadnameValidate;
  var _landmarkValidate;
  var _cityValidate;
  var _stateValidate;
  bool _isValidate = true;
  var data;
  var temparay = 0;
  String _authorization = '';
  String _refreshtoken = '';
  var userid;
  var latitudes;
  var longitudes;
  void getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userId');
  }

  TextEditingController stateSelected = TextEditingController();
  bool isSelected = false;
  bool isSelected1 = false;

  double latadd;
  double longadd;

  var location = "Error";

  bool isLoading = false;
  Coordinates coordinates;

  Future<void> getlocation() async {
    try {
      final geopos = await Geolocator.checkPermission();
      print(geopos);
      final geopostion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(geopostion);
      setState(() {
        latadd = geopostion.latitude;
        longadd = geopostion.longitude;
        coordinates = Coordinates(latadd, longadd);
      });

      coordinates = Coordinates(latadd, longadd);
      try {
        var locate =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        final prefs = await SharedPreferences.getInstance();
        var username = prefs.getString('name');
        var phonenumber = prefs.getString('userNumber');
        setState(() {
          _pincodecontroller.text = locate.first.postalCode;
          stateSelected.text = locate.first.adminArea;
          _roadnamecontroller.text = locate.first.addressLine;
          citiesSelected.text = locate.first.locality;
          _landmarkcontroller.text = locate.first.subAdminArea;
          _fullnamecontroller.text = username.toString();
          _phonenumbercontroller.text = phonenumber.toString();
        });
      } catch (error) {
        Fluttertoast.showToast(msg: "Unable to load your location");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Please check your location is ON");
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    stateSelected.dispose();
    citiesSelected.dispose();
    _fullnamecontroller.dispose();
    _phonenumbercontroller.dispose();
    _housenocontroller.dispose();
    _landmarkcontroller.dispose();
    _roadnamecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Add Delivery Address",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    )
                  ],
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.only(
                      left: size.width * 0.05, right: size.width * 0.05),
                  child: TextField(
                    controller: _fullnamecontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(12.0),
                        ),
                      ),
                      labelText: 'Full Name (Required)*',
                      errorText: _fullNameValidate,
                      counterText: "",
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: size.width * 0.05, right: size.width * 0.05),
                  child: TextField(
                    obscureText: false,
                    controller: _phonenumbercontroller,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(12.0),
                        ),
                      ),
                      labelText: 'Phone number (Required)*',
                      errorText: _phoneNumberValidate,
                      counterText: "",
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: size.width * 0.05, right: size.width * 0.06),
                        child: TextField(
                          obscureText: false,
                          controller: _pincodecontroller,
                          onChanged: (value) {},
                          keyboardType: TextInputType.text,
                          maxLength: 6,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(12.0),
                              ),
                            ),
                            labelText: 'Pincode (Required)*',
                            errorText: _pincodeValidate,
                            counterText: "",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: size.width * 0.05),
                      child: MaterialButton(
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_location,
                              size: 15,
                            ),
                            Text(
                              "Use Current Location",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => new AlertDialog(
                                      content: Row(
                                    children: [
                                      CircularProgressIndicator(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Text("Loading"),
                                      )
                                    ],
                                  )));
                          getlocation();
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                            child: TextField(
                          controller: citiesSelected,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(12.0),
                                ),
                              ),
                              labelText: 'Cities',
                              counterText: "",
                              errorText: _cityValidate),
                        )),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                            margin: EdgeInsets.only(
                                left: size.width * 0.0,
                                right: size.width * 0.05),
                            child: TextField(
                              controller: stateSelected,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(12.0),
                                    ),
                                  ),
                                  labelText: 'State',
                                  counterText: "",
                                  errorText: _stateValidate),
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: size.width * 0.05, right: size.width * 0.05),
                  child: TextField(
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 20,
                    controller: _housenocontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(12.0),
                          ),
                        ),
                        labelText: 'House No.,Building Name (Optional)',
                        errorText: _housenoValidate,
                        counterText: ""),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: size.width * 0.05, right: size.width * 0.05),
                  child: TextField(
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _roadnamecontroller,
                    maxLength: 50,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(12.0),
                        ),
                      ),
                      errorText: _roadnameValidate,
                      labelText: 'Full Address (Required)*',
                      counterText: "",
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: size.width * 0.05, right: size.width * 0.05),
                  child: TextField(
                    obscureText: false,
                    controller: _landmarkcontroller,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 40,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(12.0),
                        ),
                      ),
                      labelText: 'Add Landmark',
                      errorText: _landmarkValidate,
                      counterText: "",
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: size.width * 0.056),
                    child: Text(
                      "Type Of Address",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800),
                    )),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: InputChip(
                        label: Text(
                          "Home",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        selectedColor: Colors.blue,
                        disabledColor: Colors.grey[200],
                        elevation: 2,
                        isEnabled: true,
                        selected: isSelected,
                        showCheckmark: false,
                        onSelected: (value) {
                          setState(() {
                            isSelected = true;
                            isSelected1 = false;
                            data = "Home";
                          });
                        },
                        avatar: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: InputChip(
                        label: Text(
                          "Office",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        selectedColor: Colors.blue,
                        disabledColor: Colors.grey[200],
                        elevation: 2,
                        isEnabled: true,
                        selected: isSelected1,
                        showCheckmark: false,
                        onSelected: (value) {
                          setState(() {
                            isSelected = false;
                            isSelected1 = true;
                            data = "Office";
                          });
                        },
                        avatar: Icon(
                          Icons.house,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                MaterialButton(
                  onPressed: () {
                    _address();
                  },
                  child: Text(
                    "Save Address",
                    style: TextStyle(fontSize: 18),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: size.width * 0.88,
                  height: size.height * 0.06,
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }

  Future<void> _address() async {
    if (_fullnamecontroller.text.isEmpty) {
      setState(() {
        _fullNameValidate = "Please enter the fullname";
        _isValidate = false;
      });
    } else {
      setState(() {
        _fullNameValidate = null;
        _isValidate = true;
      });
    }
    // Validation For Phone Number
    if (_phonenumbercontroller.text.isEmpty) {
      setState(() {
        _phoneNumberValidate = "please enter the phone number";
        _isValidate = false;
      });
    } else if (_phonenumbercontroller.text.length < 10) {
      setState(() {
        _phoneNumberValidate = "phone number should be of 10 digit";
        _isValidate = false;
      });
    } else {
      setState(() {
        _phoneNumberValidate = null;
        _isValidate = true;
      });
    }
    // Validation For Pin Code
    if (_pincodecontroller.text.isEmpty) {
      setState(() {
        _pincodeValidate = "Please enter the pincode";
        _isValidate = false;
      });
    } else {
      setState(() {
        _pincodeValidate = null;
        _isValidate = true;
      });
    }
    // Validation For city
    if (citiesSelected.text.isEmpty) {
      setState(() {
        _cityValidate = "Please enter the city";
        _isValidate = false;
      });
    } else {
      setState(() {
        _cityValidate = null;
        _isValidate = true;
      });
    }
    // Validation For state
    if (stateSelected.text.isEmpty) {
      setState(() {
        _stateValidate = "Please enter the state";
        _isValidate = false;
      });
    } else {
      setState(() {
        _stateValidate = null;
        _isValidate = true;
      });
    }
    // Validation For House No.
    // if (_housenocontroller.text.isEmpty) {
    //   setState(() {
    //     _housenoValidate = "Please enter the house no.";
    //     _isValidate = false;
    //   });
    // } else {
    //   setState(() {
    //     _housenoValidate = null;
    //     _isValidate = true;
    //   });
    // } // Validation For Roadname
    if (_roadnamecontroller.text.isEmpty) {
      setState(() {
        _roadnameValidate = "Please enter the road name";
        _isValidate = false;
      });
    } else {
      setState(() {
        _roadnameValidate = null;
        _isValidate = true;
      });
    }
    // Validation For Landmark
    if (_landmarkcontroller.text.isEmpty) {
      setState(() {
        _landmarkValidate = "Please enter the Landmark";
        _isValidate = false;
      });
    } else {
      setState(() {
        _landmarkValidate = null;
        _isValidate = true;
      });
    }

    if (_isValidate == true) {
      final prefs = await SharedPreferences.getInstance();
      _authorization = prefs.getString('sessionToken');
      userid = prefs.getInt('userId');
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  addOrderAddress");

      _refreshtoken = prefs.getString('refreshToken');
      var response = await http.post(USER_API + 'addOrderAddress', body: {
        "name": _fullnamecontroller.text,
        "phone": _phonenumbercontroller.text,
        "userId": userid.toString(),
        "address": _roadnamecontroller.text,
        "state": stateSelected.text,
        "city": citiesSelected.text,
        "addressFor": data.toString(),
        "pinCode": _pincodecontroller.text,
        "landMark": _landmarkcontroller.text,
        "latitude": latadd.toString(),
        "longitude": longadd.toString()
      }, headers: {
        "authorization": _authorization,
        "refreshtoken": _refreshtoken
      });
      var responsData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: responsData['message']);
        Navigator.pop(context, true);
      } else if (response.statusCode == 401) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove(
          'name',
        );
        prefs.remove('sessionToken');
        prefs.remove('refreshToken');
        prefs.remove('userNumber');
        prefs.remove('userProfile');
        prefs.remove('customerName');
        prefs.remove('userId');
        prefs.remove('loginId');
        prefs.remove('userEmail');
        prefs.remove("loginBy");
        takeUser = false;
        emailid = null;
        photo = null;
        userName = null;

        prefs.setBool("_isAuthenticate", false);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        setState(() {
          Fluttertoast.showToast(msg: responsData['message']);
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Please Fill the above field to continue");
    }
  }
}
