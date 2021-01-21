import 'package:feasturent_costomer_app/components/bottom_nav_bar.dart';
import 'package:feasturent_costomer_app/components/common/common.dart';
import 'package:feasturent_costomer_app/screens/profile/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  var _namevalidate;
  var _lastnamevalidate;
  var _phonevalidate;
  var _usernamevalidate;
  var _emailvalidate;
  bool _isvalidate = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // height of Sizebox variable
    var heightsize = size.height * 0.018;

    // TextField Varaible For Margin , style text , lable style

    var leftRightMargin = size.width * 0.05;
    var labelSize = 15.0;
    var fontSize = 18.0;
    var iconSize = 12.0;

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    // Oval Design
                    ClipPath(
                      clipper: OvalBottomBorderClipper(),
                      child: Container(
                        height: size.height * 0.3,
                        width: size.width * 0.9994,
                        color: Colors.blue,
                        child: Column(children: [
                          // Arrow back Icon
                          Container(
                              margin: EdgeInsets.only(
                                  left: size.width * 0.02,
                                  top: size.height * 0.03),
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_sharp,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Bottomnavbar()),
                                  );
                                },
                              )),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Container(
                              child: Text(
                            "Nicolas Adams",
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))
                        ]),
                      ),
                    ),
                    Stack(
                      children: [
                        Align(
                          heightFactor: size.height * 0.0032,
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                            radius: 55,
                            child: Image.asset("assets/images/avatar.png"),
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            heightFactor: size.height * 0.0088,
                            widthFactor: size.width * 0.0173,
                            child: CircleAvatar(
                                backgroundColor: Theme.of(context).accentColor,
                                child: Icon(
                                  LineAwesomeIcons.user_edit,
                                  color: Colors.white,
                                )))
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: heightsize,
                ),
                // Name TextField
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
                        size: iconSize,
                      ),
                      labelText: "Name",
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
                      labelText: "Last Name",
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
                // Phone Textfield
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
                // User Name Controller
                Container(
                  margin: EdgeInsets.only(
                      left: leftRightMargin, right: leftRightMargin),
                  child: TextField(
                    autocorrect: false,
                    controller: _userNameController,
                    keyboardType: TextInputType.name,
                    style: TextStyle(fontSize: fontSize),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        LineAwesomeIcons.user_circle,
                        size: fontSize,
                      ),
                      labelText: "User Name",
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
                        size: 22,
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
                      _EditProfile();
                      Fluttertoast.showToast(msg: "Profile Edited");
                    },
                    child: Text("Edit Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
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
          )),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> _EditProfile() async {
    // for name
    if (_nameController.text.isEmpty) {
      setState(() {
        _namevalidate = lastname;
      });
    } else {
      setState(() {
        _namevalidate = null;
      });
    }

    // for Last Name
    if (_lastNameController.text.isEmpty) {
      setState(() {
        _lastnamevalidate = lastname;
      });
    } else {
      setState(() {
        _lastnamevalidate = null;
      });
    }

    // for Phone

    if (_phoneController.text.isEmpty) {
      setState(() {
        _phonevalidate = phone;
      });
    } else if (_phoneController.text.length < 10) {
      setState(() {
        _phonevalidate = phonenumbersize;
      });
    } else {
      setState(() {
        _phonevalidate = null;
      });
    }
    // for user Name
    if (_userNameController.text.isEmpty) {
      setState(() {
        _usernamevalidate = username;
      });
    } else {
      setState(() {
        _usernamevalidate = null;
      });
    }

    // For Email Validation
    if (_emailController.text.isEmpty) {
      setState(() {
        _emailvalidate = email;
      });
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text)) {
      setState(() {
        _emailvalidate = validemail;
      });
    } else {
      setState(() {
        _emailvalidate = null;
      });
    }
  }
}
