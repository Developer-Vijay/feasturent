import 'package:dropdownfield/dropdownfield.dart';
import 'package:feasturent_costomer_app/components/bottom_nav_bar.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class AddAdress extends StatefulWidget {
  @override
  _AddAdressState createState() => _AddAdressState();
}

class _AddAdressState extends State<AddAdress> {
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

  bool _isValidate = false;

  String selectedCity = "";

  List<String> cities = [
    "Delhi",
    "Mumbai",
    "Bahadurgarh",
    "Kolkata",
    "Noida",
    "Gurgaon",
    "Jhajjar",
  ];
  TextEditingController stateSelected = TextEditingController();
  String selectedState = "";
  List<String> state = ["Delhi", "Haryana", "Madhya Pradesh"];
  bool isSelected = false;
  bool isSelected1 = false;

  double add1;
  double add2;

  String postalcode = "";
  String city = "";
  String states = "";
  String colony = "";
  String landmark = "";
  String roadname = "";
  String houseno = "";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getAddressBasedonLocation();
  }

  getCurrentLocation() async {
    final geopostion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      add1 = geopostion.latitude;
      add2 = geopostion.longitude;
      print(add1);
      print(add2);
    });
  }

  getAddressBasedonLocation() async {
    final coordinates = Coordinates(28.6882745, 76.9595292);
    print(add1);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    setState(() {
      postalcode = address.first.postalCode;
      city = address.first.locality;
      states = address.first.adminArea;
      houseno = address.first.countryCode;
      roadname = address.first.subAdminArea;
      colony = address.first.countryName;
      landmark = address.first.featureName;

      print(landmark);
    });
  }

  Future<void> getlocation() async {
    print("working");
    setState(() {
      isLoading = true;

      _pincodecontroller.text = postalcode;
      _roadnamecontroller.text = city;
      _housenocontroller.text = houseno;
      citiesSelected.text = city;
      stateSelected.text = states;
      _landmarkcontroller.text = landmark;
    });
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
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Bottomnavbar()));
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
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 10,
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
                    maxLength: 10,
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
                          ),
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
                              ),
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
                        labelText: 'House No.,Building Name (Required)*',
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
                      labelText: 'Road name,Area, Colony (Required)*',
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
                        label: Text("home"),
                        selectedColor: Colors.white,
                        elevation: 2,
                        isEnabled: true,
                        selected: isSelected,
                        showCheckmark: false,
                        onSelected: (value) {
                          setState(() {
                            isSelected = value;
                          });
                        },
                        avatar: Icon(Icons.home),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: InputChip(
                        label: Text("Office"),
                        selectedColor: Colors.white,
                        elevation: 2,
                        isEnabled: true,
                        selected: isSelected1,
                        showCheckmark: false,
                        onSelected: (value) {
                          setState(() {
                            isSelected1 = value;
                          });
                        },
                        avatar: Icon(Icons.house),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                MaterialButton(
                  onPressed: () => getItemandNavigate(context),
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
        _fullNameValidate = "Please enter the details";
        _isValidate = true;
      });
    } else {
      setState(() {
        _fullNameValidate = null;
        _isValidate = false;
      });
    }
    // Validation For Phone Number
    if (_phonenumbercontroller.text.isEmpty) {
      setState(() {
        _phoneNumberValidate = "please enter the details";
        _isValidate = true;
      });
    } else if (_phonenumbercontroller.text.length < 10) {
      setState(() {
        _phoneNumberValidate = "phone number should be of 10 digit";
        _isValidate = true;
      });
    } else {
      setState(() {
        _phoneNumberValidate = null;
        _isValidate = false;
      });
    }
    // Validation For Pin Code
    if (_pincodecontroller.text.isEmpty) {
      setState(() {
        _pincodeValidate = "Please enter the details";
        _isValidate = true;
      });
    } else {
      setState(() {
        _pincodeValidate = null;
        _isValidate = false;
      });
    }
    // Validation For House No.
    if (_housenocontroller.text.isEmpty) {
      setState(() {
        _housenoValidate = "Please enter the details";
        _isValidate = true;
      });
    } else {
      setState(() {
        _housenoValidate = null;
        _isValidate = false;
      });
    } // Validation For Roadname
    if (_roadnamecontroller.text.isEmpty) {
      setState(() {
        _roadnameValidate = "Please enter the details";
        _isValidate = true;
      });
    } else {
      setState(() {
        _roadnameValidate = null;
        _isValidate = false;
      });
    }
    // Validation For Landmark
    if (_landmarkcontroller.text.isEmpty) {
      setState(() {
        _landmarkValidate = "Please enter the details";
        _isValidate = true;
      });
    } else {
      setState(() {
        _landmarkValidate = null;
        _isValidate = false;
      });
    }
  }

  getItemandNavigate(BuildContext context) async {
    temp.insertAll(0, [
      Addresses(
        fullnameHolder: _fullnamecontroller.text.toString(),
        phonenumberHolder: _phonenumbercontroller.text.toString(),
        pincodeHolder: _pincodecontroller.text.toString(),
        cityholder: selectedCity.toString(),
        stateholder: stateSelected.text.toString(),
        landmarkholder: _landmarkcontroller.text.toString(),
        roadholder: _roadnamecontroller.text.toString(),
        housenoholder: _housenocontroller.text.toString(),
      )
    ]);
    Navigator.pop(context);
  }
}
