import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:ui/features/chat/data/models/chat_model.dart';
import 'package:ui/services/stream_service.dart';

//single instance of socket across the app
class SocketIO {
  late final Socket socket;
  final StreamSocket<Chat> stream;

  SocketIO({required this.stream}) {
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

//NOTE: Investing  if long polling is working since I have set transport to only use web sockets
      engine.once("upgrade", (data) {
        // called when the transport is upgraded (i.e. from HTTP long-polling to WebSocket)
        debugPrint(engine.transport!.name); // in most cases, prints "websocket"
      });
    });
    socket.on('group-chat', (data) {
      debugPrint('in listener $data');
      var chat = jsonDecode(data[0]);

      stream.addResponse(Chat.fromJson(chat));
    });
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
  var stream = ref.watch(chatStreamSocketProvider);
  return SocketIO(stream: stream);
});
