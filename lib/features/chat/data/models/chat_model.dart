import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final bool isMe;
  final String chatId;
  final String message;
  final String senderId;
  final String recipientId;
  final String sentAt;
  final bool? isRead;
  final String? receivedAt;

  const Chat({
    required this.chatId,
    required this.message,
    required this.senderId,
    required this.recipientId,
    required this.sentAt,
    this.isRead,
    this.receivedAt,
    required this.isMe,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'isRead': bool isRead,
          'receivedAt': String? receivedAt,
          'chatId': String chatId,
          'message': String message,
          'senderId': String senderId,
          'recipientId': String recipientId,
          'sentAt': String sentAt,
        }) {
      return Chat(
        isMe: false, //TODO: Check if theory is correct
        chatId: chatId,
        message: message,
        senderId: senderId,
        recipientId: recipientId,
        sentAt: sentAt,
        isRead: isRead,
        receivedAt: receivedAt,
      );
    } else {
      throw const FormatException('Invalid json format');
    }
  }

  Map<String, dynamic> toJson() => {
        'isRead': isRead,
        'receivedAt': receivedAt,
        'chatId': chatId,
        'message': message,
        'senderId': senderId,
        'recipientId': recipientId,
        'sentAt': sentAt,
      };

  @override
  List<Object?> get props => [chatId, senderId, recipientId];
}
