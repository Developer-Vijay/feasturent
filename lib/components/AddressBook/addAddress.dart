import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

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
  bool _isValidate = false;
  var data;
  var temparay = 0;

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
      final geopostion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        latadd = geopostion.latitude;
        longadd = geopostion.longitude;

        coordinates = Coordinates(latadd, longadd);
      });
      try {
        var locate =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);

        setState(() {
          _pincodecontroller.text = locate.first.postalCode;
          stateSelected.text = locate.first.locality;
          _roadnamecontroller.text = locate.first.adminArea;
          citiesSelected.text = locate.first.subLocality;
          _landmarkcontroller.text = locate.first.addressLine;
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
                        Navigator.pop(context, () {
                          setState(() {});
                        });
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
                            data = 0;
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
                            data = 1;
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
                  onPressed: () => _address(),
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
        _phoneNumberValidate = "please enter the phone number";
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
        _pincodeValidate = "Please enter the pincode";
        _isValidate = true;
      });
    } else {
      setState(() {
        _pincodeValidate = null;
        _isValidate = false;
      });
    }
    // Validation For city
    if (citiesSelected.text.isEmpty) {
      setState(() {
        _cityValidate = "Please enter the city";
        _isValidate = true;
      });
    } else {
      setState(() {
        _cityValidate = null;
        _isValidate = false;
      });
    }
    // Validation For state
    if (stateSelected.text.isEmpty) {
      setState(() {
        _stateValidate = "Please enter the state";
        _isValidate = true;
      });
    } else {
      setState(() {
        _stateValidate = null;
        _isValidate = false;
      });
    }
    // Validation For House No.
    if (_housenocontroller.text.isEmpty) {
      setState(() {
        _housenoValidate = "Please enter the house no.";
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
        _roadnameValidate = "Please enter the road name";
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
        _landmarkValidate = "Please enter the Landmark";
        _isValidate = true;
      });
    } else {
      setState(() {
        _landmarkValidate = null;
        _isValidate = false;
      });
    }
    if (isSelected == false && isSelected1 == false) {
      Fluttertoast.showToast(msg: "Please select address type");
      setState(() {
        _isValidate = true;
      });
    } else {
      setState(() {
        _isValidate = false;
      });
    }
    if (_isValidate != true) {
      if (temparay == 0) {
        setState(() {
          temparay = 1;
        });
        Fluttertoast.showToast(msg: "Please check own Address is correct");
      } else {
        setState(() {
          temparay = 0;
        });
        temp.add(Addresses(
            fullnameHolder: _fullnamecontroller.text.toString(),
            phonenumberHolder: _phonenumbercontroller.text.toString(),
            pincodeHolder: _pincodecontroller.text.toString(),
            cityholder: citiesSelected.text.toString(),
            stateholder: stateSelected.text.toString(),
            landmarkholder: _landmarkcontroller.text.toString(),
            roadholder: _roadnamecontroller.text.toString(),
            housenoholder: _housenocontroller.text.toString(),
            valueholder: data));
        if (widget.indexnumber != null) {
          temp.removeAt(widget.indexnumber);
        }

        Navigator.pop(context, () {
          setState(() {});
        });
      }
    }
  }
}
