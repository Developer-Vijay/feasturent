import 'package:flutter/material.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:adhara_socket_io/manager.dart';

import 'constants.dart';

Future<void> socketConfig(String identifier) async {
  print('SOCKET PAGE');
  SocketIOManager manager = SocketIOManager();
  SocketIO socket = await manager.createInstance(SocketOptions(
      //Socket IO server URI
      SOCKET_URL,
      nameSpace: (identifier == "namespaced") ? "/adhara" : "/",
      //Query params - can be used for authentication
      query: {
        "auth": "--SOME AUTH STRING---",
        "info": "new connection from adhara-socketio",
        "timestamp": DateTime.now().toString()
      },
      //Enable or disable platform channel logging
      enableLogging: false,
      transports: [
        Transports.WEB_SOCKET /*, Transports.POLLING*/
      ] //Enable required transport
      )); //TODO change the port  accordingly
  socket.onConnect((data) {
    print("connected...");
    print(data);
    socket.emit("pushNotification", ["Hello world!"]);
  });
  socket.on("news", (data) {
    //sample event
    print("news");
    print(data);
  });
  socket.connect();

  ///disconnect using
  ///manager.
}
