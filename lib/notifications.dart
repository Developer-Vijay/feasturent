// import 'package:feasturent_costomer_app/screens/home/home-screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotficationsTest extends StatefulWidget {
//   @override
//   _NotficationsTestState createState() => _NotficationsTestState();
// }

// class _NotficationsTestState extends State<NotficationsTest> {
  
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   @override
//   void initState() {
//     super.initState();
//     var initializationsSettingsAndroid =
//         AndroidInitializationSettings('feasturent');
//     var initializationsSetiingsIos = IOSInitializationSettings();
//     var initSettings = InitializationSettings(
//         android: initializationsSettingsAndroid,
//         iOS: initializationsSetiingsIos);
//     flutterLocalNotificationsPlugin.initialize(initSettings,
//         onSelectNotification: onselectNotification);
//   }

//   Future onselectNotification(String payload) {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => HomeScreen(
//                   payload: payload,
//                 )));
//   }
// // Show Notifications
//   showNotification() async {
//     var android = new AndroidNotificationDetails(
//         'id', 'channel ', 'description',
//         priority: Priority.high, importance: Importance.max);
//     var iOS = new IOSNotificationDetails();
//     var platforms = new NotificationDetails(android: android, iOS: iOS);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'hi', 'Flutter Local Notification Demo', platforms,
//         payload: 'Welcome to the Local Notification demo ');
//   }
// // Schudule Notifications
//  Future<void> scheduleNotification() async {
//     var scheduledNotificationDateTime =
//         DateTime.now().add(Duration(seconds: 5));
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'channel id',
//       'channel name',
//       'channel description',
//       icon: 'feasturent',
//       largeIcon: DrawableResourceAndroidBitmap('feasturent'),
//     );
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.schedule(
//         0,
//         'scheduled title',
//         'scheduled body',
//         scheduledNotificationDateTime,
//         platformChannelSpecifics);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           RaisedButton(
//             onPressed: () {
//               showNotification();
//             },
//             child: Text("Try"),
//           ),
//           SizedBox(
//             height: 12,
//           ),
//           RaisedButton(
//             onPressed: () {
//               scheduleNotification();
//             },
//             child: Text("Tryit"),
//           ),
//           SizedBox(
//             height: 12,
//           ),
//           RaisedButton(
//             onPressed: () {},
//             child: Text("Tryityou"),
//           ),
//           SizedBox(
//             height: 12,
//           ),
//         ],
//       ),
//     );
//   }
// }
