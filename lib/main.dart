import 'package:feasturent_costomer_app/components/auth/login/login.dart';
import 'package:feasturent_costomer_app/components/splashScreen/splashScreen.dart';
import 'package:feasturent_costomer_app/socketConnection.dart';
import 'package:flutter/material.dart';
import 'package:feasturent_costomer_app/constants.dart';
import 'package:feasturent_costomer_app/screens/home/home-screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _messaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      IO.Socket socket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _messaging.getToken().then((token) {
      print("token is this ");
      print(token);
      connect();
    });

    socketConfig("default");
  }
void connect(){
  socket=IO.io("http://192.168.43.122:5000",<String,dynamic>{
    "transports":["websocket"],
    "autoConnect":false,
  });
  socket.connect();
  socket.onConnect((data){
    print("Connected",);
    print("///////");
    print(socket.id);
    print("///////");
    });
  print("socket.connected");
  // print(socket.id);
  socket.emit("/test","Hello World");
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
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            body1: TextStyle(color: ksecondaryColor),
            body2: TextStyle(color: ksecondaryColor),
          ),
        ),
        home: SplashScreenApp());
  }
}
