import 'package:feasturent_costomer_app/SettingsPage/notifications_settings.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: settingpanel.length,
          itemBuilder: (context, index) {
            return ListTile(
              enabled: true,
              onTap: () {
                if (settingpanel[index].number == 3) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationsSettings()));
                }
              },
              title: Text(settingpanel[index].title),
              subtitle: Text(settingpanel[index].subtitle),
              leading: Container(
                child: settingpanel[index].icon,
              ),
            );
          },
        ),
      ),
    );
  }
}
