import 'package:equatable/equatable.dart';
import 'package:ui/features/chat/data/models/chat_model.dart';

enum UserType { private, public }

class User extends Equatable {
  final String userName;
  final String userId;
  final String email;
  final List<String> contacts;
  final List<Chat> chats;
  final UserType type;

  const User({
    this.contacts = const <String>[],
    this.chats = const <Chat>[],
    required this.email,
    required this.userName,
    required this.userId,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'userName': String userName,
          'userId': String userId,
          'email': String email,
          'contacts': List<dynamic> contacts,
          'chats': List<dynamic> chats,
          'type': String type,
        }) {
      return User(
        userName: userName,
        userId: userId,
        email: email,
        contacts: contacts.map((e) => e.toString()).toList(),
        chats: chats.map((e) => Chat.fromJson(e)).toList(),
        type: type == 'private' ? UserType.private : UserType.public,
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
      'contacts': contacts,
      'chats': chats,
    };
  }

  @override
  List<Object?> get props => [userName, userId, email, type];
}
