import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/components/splashScreen/splashScreen.dart';
import 'package:feasturent_costomer_app/notificationsfiles.dart';
import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/home-screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

IO.Socket socket;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    connect();
  }

  void connect() {
    socket = IO.io("https://feasturent.in", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      "verify": true,
      'extraHeaders': {'Connection': 'Upgrade', 'Upgrade': 'websocket'},
      "path": '/socket/socket.io/'
    });
    socket.connect();
    socket.onConnect((data) {
      print(socket.id);
    });

    socket.onError((err) {
      print(err);
    });
    socket.onConnectError((err) {
      print(err);
    });

    socket.on("broadCastMessage", (socketdata) {
      print("&&&&&&&&&&&&&&&&&");
      print(socketdata);
      Notifications().scheduleNotification(socketdata['username'],socketdata['message'] );
      print("&&&&&&&&&&&&&&&&&&");
    });

    socket.on("pushNotification", (socketdata) {
      print("&&&&&&&&&&&&&&&&&");
      print(socketdata);
      Notifications()
          .scheduleNotification(socketdata['username'], socketdata['message']);
      print("&&&&&&&&&&&&&&&&&&");
    });
    print("socket.connected");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        //Add Route to the main Page.
        routes: {
          '/homePage': (context) => HomeScreen(),
          '/loginPage': (context) => LoginPage()
        },
        theme: ThemeData(
          fontFamily: 'Nunito',
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            // ignore: deprecated_member_use
            body1: TextStyle(color: ksecondaryColor),
            // ignore: deprecated_member_use
            body2: TextStyle(color: ksecondaryColor),
          ),
        ),
        home: SplashScreenApp());
  }
}
