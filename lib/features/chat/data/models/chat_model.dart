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
  final String messageLabel;

  const Chat({
    required this.chatId,
    required this.message,
    required this.senderId,
    required this.recipientId,
    required this.sentAt,
    this.isRead,
    this.receivedAt,
    this.isMe = true,
    required this.messageLabel,
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
          'messageLabel': String messageLabel,
        }) {
      return Chat(
        chatId: chatId,
        message: message,
        senderId: senderId,
        recipientId: recipientId,
        sentAt: sentAt,
        isRead: isRead,
        receivedAt: receivedAt,
        messageLabel: messageLabel,
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
        'messageLabel': messageLabel,
      };

  @override
  List<Object?> get props => [chatId, senderId, recipientId];
}
