import 'dart:io';

import 'package:adhara_socket_io/adhara_socket_io.dart';

class SocketUtils {
  static String _serverIP =
      Platform.isAndroid ? 'https://localhost' : 'https//10.0.2.2';
  static const int SERVER_PORT = 6000;
  static String _connectUrl = '$_serverIP:$SERVER_PORT';

//Events
  static const String _ON_MESSAGE_RECEIVED = 'recieve_message';
  static const String _IS_USER_ONLINE_EVENT = 'check_onlune';

// status

  static const int STATUS_MESSAGE_NOT_SENT = 10001;
  static const int STATUS_MESSAGE_SENT = 10002;

  SocketIO _socket;
  SocketIOManager _manager;

  initSocket() async {
    print('Connecting...');
  }

  _init() async {
    _manager = SocketIOManager();
    _socket = await _manager.createInstance(_socketOptions());
  }

  _socketOptions() {
    final Map<String, String> userMap = {};
  }

  setOnConnectListner(Function onConnect) {
    _socket.onConnect((data) {
      onConnect(data);
    });
  }

  setOnConnectionErrorTImeOutListner(Function onConnectionTimeout) {
    _socket.onConnectTimeout((data) {
      onConnectionTimeout(data);
    });
  }

  
}
