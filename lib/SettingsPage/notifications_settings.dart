import 'package:flutter/material.dart';

class NotificationsSettings extends StatefulWidget {
  @override
  _NotificationsSettingsState createState() => _NotificationsSettingsState();
}

class _NotificationsSettingsState extends State<NotificationsSettings> {
  bool _value1 = false;
  // bool _value2 = false;
  // bool _value3=false;
  // bool _value4=false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications Settings"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Divider(),
              ListTile(
                enabled: true,
                isThreeLine: false,
                title: Text(
                  "Enable all",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("it will enable all the settings"),
                leading: Switch(
                  value: _value1,
                  onChanged: (value) {
                    setState(() {
                      _value1 = value;
                    });
                  },
                ),
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 4,
              ),
              // For Social Notifications
              ListView.builder(
                itemCount: notify.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    enabled: true,
                    leading: Switch(
                      value: notify[index].value3,
                      onChanged: (value) {
                        if (notify[index].number == 1) {
                          setState(() {
                            notify[index].value3 = value;
                          });
                        } else if (notify[index].number == 2) {
                          setState(() {
                            notify[index].value3 = value;
                          });
                        } else if (notify[index].number == 3) {
                          setState(() {
                            notify[index].value3 = value;
                          });
                        }
                      },
                    ),
                    isThreeLine: true,
                    title: Text(
                      notify[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      notify[index].subtitle,
                      style: TextStyle(),
                      maxLines: 3,
                    ),
                    trailing: Column(
                      children: [
                        Icon(
                          Icons.notifications_none_outlined,
                          color: Colors.black,
                        ),
                        Text(
                          "Push",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  );
                },
              ),

              MaterialButton(
                onPressed: () {},
                child: Text("Save Changes"),
                color: Colors.blue,
                elevation: 2,
                height: size.height * 0.05,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                minWidth: size.width * 0.9,
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Notificationslist {
  var title;
  var subtitle;
  var number;
  bool value3;

  Notificationslist({this.title, this.number, this.subtitle, this.value3});
}

List<Notificationslist> notify = [
  Notificationslist(
      number: 1,
      value3: false,
      subtitle:
          "Get Notified When Some one foolows your profile or when you get likes and comments on reviews and photoes",
      title: "Social Notifications"),
  Notificationslist(
      number: 2,
      value3: false,
      subtitle: "Recieve coupons,promotions and money-saving offers",
      title: "Promos and Offers"),
  Notificationslist(
      number: 3,
      value3: false,
      subtitle:
          "Recieve-updates related to your order status,membership,table bookings and more",
      title: "Orders and Purchases")
];
