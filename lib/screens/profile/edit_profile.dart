import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ffi';
import 'dart:io';
import 'package:feasturent_costomer_app/screens/profile/userProfile.dart';
import 'package:http/http.dart' as http;
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/components/auth/signup/signup.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _image;
  var photo;
  var emailid;
  int user;
  var username;
  int userid;

  String _authorization = '';
  String _refreshtoken = '';
// bool _isValidate = true;
  bool _isProcessing = false;
  // TextEditingController _lastnamecontroller = TextEditingController();
  // TextEditingController _namecontroller = TextEditingController();
  // TextEditingController _secondaryphonecontroller = TextEditingController();
  void initState() {
    super.initState();
    setState(() {
      getSession();
    });
  }

  getSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      var takeUser = prefs.getString('loginBy');
      print(takeUser);
      emailid = prefs.getString('userEmail');
      photo = prefs.getString('userProfile');
      username = prefs.getString('name');
      userid = prefs.getInt('userId');
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _image = image;
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  var _namevalidate;
  var _lastnamevalidate;
  var _phonevalidate;
  var _usernamevalidate;
  var _emailvalidate;
  bool _isvalidate = true;

  bool _isOtpSend = false;
  File _imagefile;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _textstyle = TextStyle(
        fontSize: size.height * 0.04,
        fontWeight: FontWeight.w500,
        color: Colors.white);
    var _iconsize = size.height * 0.035;
    var heightsize = size.height * 0.018;

    // TextField Varaible For Margin , style text , lable style

    var leftRightMargin = size.width * 0.05;
    var labelSize = size.height * 0.018;
    var fontSize = size.height * 0.018;
    var iconSize = size.height * 0.018;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: ArcClipper(),
                  child: Container(
                    height: size.height * 0.5,
                    color: Colors.blue,
                    child: Center(child: Text("")),
                  ),
                ),
                Column(children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: _iconsize,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                      child: username == null
                          ? Text(
                              "UserName",
                              style: TextStyle(
                                  fontSize: size.height * 0.034,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(username,
                              style: TextStyle(
                                  fontSize: size.height * 0.034,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)))
                ]),

                SizedBox(
                  height: size.height * 0.065,
                ),
                Container(
                  height: size.height * 0.2,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: size.height * 0.085,
                            child: photo == null
                                ? Container(
                                    width: size.width * 0.4,
                                    height: size.height * 0.4,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                "assets/images/avatar.png"))))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      photo,
                                      fit: BoxFit.cover,
                                      width: size.width * 0.33,
                                    ),
                                  )),
                      ),
                      Positioned(
                        left: size.width * 0.55,
                        top: size.height * 0.12,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container(
                                      height: size.height * 0.25,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () async =>
                                                  await getImageFromCamera(),
                                              child: Container(
                                                child: Center(
                                                  child: Text("Take Photo"),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Divider(),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () async =>
                                                  await getImageFromGallery(),
                                              child: Container(
                                                child: Center(
                                                  child: Text(
                                                      "Choose from Gallery"),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Divider(),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                  child: Center(
                                                child: Text("Cancel"),
                                              )),
                                            ),
                                          )
                                        ],
                                      )));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: leftRightMargin, right: leftRightMargin),
                  child: TextField(
                    autocorrect: false,
                    controller: _userNameController,
                    keyboardType: TextInputType.name,
                    readOnly: true,
                    style: TextStyle(fontSize: fontSize),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        LineAwesomeIcons.user_circle,
                        size: fontSize,
                      ),
                      hintText: username == null ? "UserName" : "$username",
                      errorText: _usernamevalidate,
                      labelStyle: TextStyle(fontSize: labelSize),
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(26.0),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: heightsize,
                ),
// Last Name TextField
                Container(
                  margin: EdgeInsets.only(
                      left: leftRightMargin, right: leftRightMargin),
                  child: TextField(
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    controller: _lastNameController,
                    style: TextStyle(fontSize: fontSize),
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(LineAwesomeIcons.user_circle_1, size: 25),
                      labelText: "Name",
                      errorText: _lastnamevalidate,
                      labelStyle: TextStyle(fontSize: labelSize),
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(26.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: heightsize,
                ),
// Last Name Textfield
                Container(
                  margin: EdgeInsets.only(
                      left: leftRightMargin, right: leftRightMargin),
                  child: TextField(
                    autocorrect: false,
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    style: TextStyle(fontSize: fontSize),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        LineAwesomeIcons.user,
                        size: size.height * 0.023,
                      ),
                      labelText: "Last Name",
                      labelStyle: TextStyle(fontSize: labelSize),
                      errorText: _namevalidate,
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(26.0),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: heightsize,
                ),
// Phone Controller
                Container(
                  margin: EdgeInsets.only(
                      left: leftRightMargin, right: leftRightMargin),
                  child: TextField(
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    style: TextStyle(fontSize: fontSize),
                    decoration: InputDecoration(
                      prefixIcon: Icon(LineAwesomeIcons.phone, size: fontSize),
                      labelText: "Phone",
                      errorText: _phonevalidate,
                      labelStyle: TextStyle(fontSize: labelSize),
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(26.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: heightsize,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: leftRightMargin, right: leftRightMargin),
                  child: TextField(
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    controller: _emailController,
                    style: TextStyle(fontSize: fontSize),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        size: size.height * 0.022,
                      ),
                      labelText: "Email",
                      errorText: _emailvalidate,
                      labelStyle: TextStyle(fontSize: labelSize),
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(26.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.022,
                ),

//Otp
                _isOtpSend == true
                    ? Container(
                        margin: EdgeInsets.only(
                            left: leftRightMargin, right: leftRightMargin),
                        child: TextField(
                          obscureText: false,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9.,]')),
                          ],
                          maxLength: 10,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(26.0),
                              ),
                            ),
                            labelText: 'Otp',
                            labelStyle: TextStyle(fontSize: labelSize),
                            contentPadding: EdgeInsets.only(
                              top: 10,
                              left: 20,
                              bottom: 10,
                            ),
                            counterText: "",
                          ),
                          controller: _otpController,
                        ),
                      )
                    : Container(),
                SizedBox(height: size.height * 0.022),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.blue,
                            Colors.cyan,
                          ])),
                  child: MaterialButton(
                    onPressed: () {
                      _isOtpSend == false ? _editProfile() : _verifyOtp();
                    },
                    child: _isOtpSend == false
                        ? Text("Edit Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.02))
                        : Text("Submit",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.02)),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8),
                    minWidth: size.width * 0.8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 2,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

// ignore: non_constant_identifier_names
  Future<void> _editProfile() async {
// for name
    if (_nameController.text.isEmpty) {
      setState(() {
        _namevalidate = "Name Cannot be Empty";
        _isvalidate = false;
      });
    } else {
      setState(() {
        _namevalidate = null;
        _isvalidate = true;
      });
    }

// for Last Name
    if (_lastNameController.text.isEmpty) {
      setState(() {
        _lastnamevalidate = "Last Name Cannot be empty";
        _isvalidate = false;
      });
    } else {
      setState(() {
        _lastnamevalidate = null;
        _isvalidate = true;
      });
    }

// for Phone

    if (_phoneController.text.isEmpty) {
      setState(() {
        _phonevalidate = "Phone Cannot be Empty ";
        _isvalidate = false;
      });
    } else if (_phoneController.text.length < 10) {
      setState(() {
        _phonevalidate = "Phone number should be equal to 10 ";
        _isvalidate = false;
      });
    } else {
      setState(() {
        _phonevalidate = null;
        _isvalidate = true;
      });
    }

    if (_emailController.text.isEmpty) {
      setState(() {
        _emailvalidate = "email cannot be empty";
        _isvalidate = false;
      });
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text)) {
      setState(() {
        _emailvalidate = "email should contain the @ symbol ";
        _isvalidate = false;
      });
    } else {
      setState(() {
        _emailvalidate = null;
        _isvalidate = true;
      });
    }
    if (_isvalidate) {
      final prefs = await SharedPreferences.getInstance();
      _authorization = prefs.getString('sessionToken');
      _refreshtoken = prefs.getString('refreshToken');
      user = prefs.getInt('userId');
      var response = await http
          .put('http://18.223.208.214/api/users/updateProfile/$user', body: {
        'name': _nameController.text,
        'lastname': _lastNameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text
      }, headers: {
        "authorization": _authorization,
        "refreshtoken": _refreshtoken
      });

      if (response.statusCode == 200) {
        setState(() {
          Fluttertoast.showToast(msg: "ok");
          _isOtpSend = false;
        });
      } else if (response.statusCode == 201) {
        setState(() {
          Fluttertoast.showToast(msg: "otp has been send to the mobile number");
          _isOtpSend = true;
        });
      } else {
        setState(() {
          Fluttertoast.showToast(msg: "Error to Validate");
        });
      }
    } else {
      setState(() {
        Fluttertoast.showToast(msg: "Unable to Edit");
      });
    }
  }

  Future<void> _verifyOtp() async {
    final prefs = await SharedPreferences.getInstance();
    user = prefs.getInt('userId');
    var response = await http.post(AUTH_API + 'verifyOtp', body: {
      'otp': _otpController.text,
      'userId': userid.toString(),
    }, headers: {
      "authorization": _authorization,
      "refreshtoken": _refreshtoken
    });
    if (response.statusCode == 200) {
      setState(() {
        print(userid);
        Fluttertoast.showToast(msg: "Verified");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserProfilePage()),
        );
      });
    } else {
      Fluttertoast.showToast(msg: "Not Verified");
      print(userid);
    }
  }
}
