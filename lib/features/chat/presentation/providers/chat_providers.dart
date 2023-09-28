import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/features/auth/data/models/user_model.dart';
import 'package:ui/features/chat/data/models/chat_model.dart';
import 'package:ui/shared/providers/shared_providers.dart';

class ChatList extends StateNotifier<List<Chat>> {
  final User currentUser;
  ChatList({required this.currentUser}) : super([]);

  List<Chat> get chats => state;

  addChat(Chat chat) {
    var updatedChat = Chat(
      chatId: chat.chatId,
      message: chat.message,
      senderId: chat.senderId,
      recipientId: chat.recipientId,
      sentAt: chat.sentAt,
      messageLabel: chat.messageLabel,
      isMe: chat.senderId == currentUser.userId,
      receivedAt: chat.receivedAt,
    );

    state = [...state, updatedChat];
  }
}

final chatListProvider = StateNotifierProvider<ChatList, List<Chat>>((ref) {
  var user = ref.watch(currentUserProvider);
  return ChatList(currentUser: user!);
});
