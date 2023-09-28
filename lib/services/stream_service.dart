import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/features/chat/data/models/chat_model.dart';

class StreamSocket<T> {
  final _socketResponse = StreamController<T>();
  void Function(T) get addResponse => _socketResponse.sink.add;
  Stream<T> get getResponse => _socketResponse.stream;
}

final chatStreamSocketProvider = Provider<StreamSocket<Chat>>((ref) {
  return StreamSocket();
});

final groupChatStreamProvider =
    StreamProvider((ref) => ref.watch(chatStreamSocketProvider).getResponse);
