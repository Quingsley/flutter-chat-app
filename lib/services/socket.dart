import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:ui/features/chat/data/models/chat_model.dart';

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

  bool get isConnected => socket.connected;
//connect to socket
  connectUser() {
    socket.connect();
    socket.on("connect", (data) {
      debugPrint('${socket.id.toString()} connected');
      var engine = socket.io.engine;
      debugPrint(engine!.transport!.name); // in most cases, prints "polling"

      engine.once("upgrade", (data) {
        // called when the transport is upgraded (i.e. from HTTP long-polling to WebSocket)
        debugPrint(engine.transport!.name); // in most cases, prints "websocket"
      });
    });
    socket.on('group-chat', (data) => debugPrint(data.toString()));
    socket.on(
        'disconnect',
        (reason) => debugPrint(
            '${socket.id} disconnected with the following reason $reason'));
  }

  void sendChat(Chat chat) {
    socket.emitWithAck('chat', chat.toJson(), ack: (data) {
      debugPrint(data.toString());
    });
  }
}

final socketProvider = Provider<SocketIO>((ref) {
  return SocketIO();
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

//     socket.on('fromServer', (_) => print(_));
//   } catch (e) {
//     print(e.toString());
//   }
// }

