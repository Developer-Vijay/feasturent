import 'package:flutter/material.dart';

class ViewAllPopular extends StatefulWidget {
  @override
  _ViewAllPopularState createState() => _ViewAllPopularState();
}

class _ViewAllPopularState extends State<ViewAllPopular> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular on feasturent"),
      ),
    );
  }
}
