import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:ui/features/add/data/models/new_contact_model.dart';
import 'package:ui/features/chat/data/models/chat_model.dart';
import 'package:ui/services/stream_service.dart';
import 'package:ui/shared/providers/shared_providers.dart';

//single instance of socket across the app
class SocketIO extends AsyncNotifier<void> {
  late final Socket socket;

  SocketIO() {
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

    //group chat listener
    socket.on('group-chat', (data) {
      var stream = ref.read(chatStreamSocketProvider);
      debugPrint('in listener $data');
      var chat = jsonDecode(data[0]);

      stream.addResponse(Chat.fromJson(chat));
    });

    socket.on('new-contact-added', (data) {
      // need to refresh contacts list
      debugPrint(data.toString());
      var currentUser = ref.read(currentUserProvider);
      ref.invalidate(contactsFutureProvider(currentUser!.email));
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

  void newContactAdded(NewContactModel contact) {
    socket.emit('new-contact', contact.toJson()); // to join rooms in server
  }

  @override
  FutureOr<void> build() {}
}

final socketProvider = AsyncNotifierProvider<SocketIO, void>(SocketIO.new);
