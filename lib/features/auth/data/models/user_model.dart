class User {
  final String userName;
  final String userId;
  final String email;
  final List<String> contacts;
  final List<Chat> chats;

  User({
    this.contacts = const <String>[],
    this.chats = const <Chat>[],
    required this.email,
    required this.userName,
    required this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'userName': String userName,
          'userId': String userId,
          'email': String email,
          'contacts': List<dynamic> contacts,
          'chats': List<dynamic> chats,
        }) {
      return User(
        userName: userName,
        userId: userId,
        email: email,
        contacts: contacts.map((e) => e.toString()).toList(),
        chats: chats.map((e) => Chat.fromJson(e)).toList(),
      );
    } else {
      throw FormatException('Invalid json $json data format');
    }
  }
  toJson() {
    return {
      'userName': userName,
      'userId': userId,
      'email': email,
    };
  }
}

class Chat {
  final String chatId;
  final String message;
  final String senderId;
  final String recipientId;
  final String sentAt;
  final String receivedAt;
  final bool isRead;

  Chat({
    required this.chatId,
    required this.message,
    required this.senderId,
    required this.recipientId,
    required this.sentAt,
    required this.receivedAt,
    required this.isRead,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'chatId': String chatId,
          'message': String message,
          'senderId': String senderId,
          'recipientId': String recipientId,
          'sentAt': String sentAt,
          'receivedAt': String receivedAt,
          'isRead': bool isRead,
        }) {
      return Chat(
        chatId: chatId,
        message: message,
        senderId: senderId,
        recipientId: recipientId,
        sentAt: sentAt,
        receivedAt: receivedAt,
        isRead: isRead,
      );
    } else {
      throw FormatException('Invalid json $json data format');
    }
  }

  toJson() {
    return {
      'chatId': chatId,
      'message': message,
      'senderId': senderId,
      'recipientId': recipientId,
      'sentAt': sentAt,
      'receivedAt': receivedAt,
      'isRead': isRead,
    };
  }
}
