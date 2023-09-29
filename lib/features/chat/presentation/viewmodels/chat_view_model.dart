import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/features/chat/data/models/chat_model.dart';
import 'package:ui/services/socket.dart';
import 'package:ui/shared/providers/shared_providers.dart';

class ChatViewModel extends AsyncNotifier<void> {
  void sendChat(Chat chat) {
    var user = ref.read(currentUserProvider);
    user!.chats.add(chat);
    ref.read(currentUserProvider.notifier).state = user;
    ref.read(socketProvider.notifier).sendChat(chat);
  }

  @override
  FutureOr<void> build() {}
}

final chatViewModelProvider =
    AsyncNotifierProvider<ChatViewModel, void>(ChatViewModel.new);
