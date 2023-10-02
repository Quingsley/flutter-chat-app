import 'package:flutter/material.dart';
import 'package:ui/features/auth/data/models/user_model.dart';
import 'package:ui/features/chat/data/models/chat_model.dart';

String formatChatTime(DateTime messageTime) {
  // Format the time in your preferred way
  final hour = messageTime.hour.toString().padLeft(2, '0');
  final minute = messageTime.minute.toString().padLeft(2, '0');
  return '$hour:$minute'; // Customize this format as needed
}

List<Chat> distinguishChats(User currentUser, User contact, List<Chat> chats) {
  if (contact.type == UserType.public) {
    return chats.where((chat) => chat.recipientId == contact.userId).toList();
  }
  var c = chats
      .where((chat) =>
          (chat.senderId == currentUser.userId &&
              chat.recipientId == contact.userId) ||
          (chat.senderId == contact.userId &&
              chat.recipientId == currentUser.userId))
      .toList();

  return c;
}
