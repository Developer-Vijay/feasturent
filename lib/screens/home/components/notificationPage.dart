import 'package:flutter/material.dart';

class NotificationSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: NotificationBody(),
    ));
  }
}

class NotificationBody extends StatefulWidget {
  @override
  _NotificationBodyState createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/loginuser.png",
              ),
            ),
            title: Text("πWelcome to Feasturent ππ"),
            subtitle: Text("We are waiting our first order"),
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/loginuser.png",
              ),
            ),
            title: Text("Don't worry, Your food is in safe π"),
            subtitle:
                Text("Our Delivery boys wear mask and using Aarogya Setu App"),
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/loginuser.png",
              ),
            ),
            title: Text("Foodie, cravings can't wait ππ"),
            subtitle: Text("Lets Ketchup with Burger and Fries"),
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/loginuser.png",
              ),
            ),
            title: Text("Our birthday = No Cooking Weekend π"),
            subtitle: Text(
                "This weekend, take cooking off your task-list because itβs our birthday. Yayyy!"),
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/loginuser.png",
              ),
            ),
            title: Text("Happiness is something unexpected π€π₯°"),
            subtitle: Text(
                "Place order on feasturent, save time and money with exciting offers"),
          ),
        ),
        Divider(),
      ],
    );
  }
}
