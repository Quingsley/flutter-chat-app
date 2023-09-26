import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

//single instance of socket across the app
class SocketIO {
  late final Socket socket;
  static final SocketIO _instance = SocketIO._internal();

  factory SocketIO() {
    return _instance;
  }

  SocketIO._internal() {
    socket = io('http://192.168.3.140:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
  }
}

final socketProvider = Provider<Socket>((ref) {
  return SocketIO().socket;
});

// void connectToServer() {
//   try {
//     // Configure socket transports must be specified
//     Socket socket = io('http://192.168.3.57:3000', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     // Connect to websocket
//     socket.connect();

//     // Handle socket events
//     socket.on('connect', (_) => print('connect: ${socket.id}'));
//     // socket.on('location', handleLocationListen);
//     // socket.on('typing', handleTyping);
//     // socket.on('message', handleMessage);
//     socket.on('disconnect', (_) => print('disconnect'));
//     socket.on('fromServer', (_) => print(_));
//   } catch (e) {
//     print(e.toString());
//   }
// }

