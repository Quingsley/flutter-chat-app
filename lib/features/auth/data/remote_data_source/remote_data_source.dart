import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:http/http.dart' as http;
import 'package:ui/features/auth/data/models/user_model.dart';

import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class RemoteDataSource {
  final Socket socket;
  final http.Client client;
  final String baseUrl = "http://192.168.3.140:3000";

  RemoteDataSource({required this.socket, required this.client});
  void connect() {
    socket.connect();
    socket.on("connect", (data) => print('${socket.id} connected'));
  }

  Future<User> signIn(String email) async {
    var requestBody = jsonEncode({
      'email': email,
    });
    var response = await client
        .post(Uri.parse('$baseUrl/sign-in'), body: requestBody, headers: {
      'Content-Type': "application/json",
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(data['data']);
    } else {
      throw Exception(data['message']);
    }
  }

  Future<User> signUp(String userName, String email) async {
    var requestBody =
        jsonEncode({'userName': userName, 'email': email, 'userId': uuid.v4()});
    var response = await client
        .post(Uri.parse('$baseUrl/sign-up'), body: requestBody, headers: {
      'Content-Type': "application/json",
    });
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      return User.fromJson(data['data']);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<List<User>> getContacts(String email) async {
    var requestBody = jsonEncode({
      'email': email,
    });
    var response = await client
        .post(Uri.parse('$baseUrl/contacts'), body: requestBody, headers: {
      'Content-Type': "application/json",
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['contacts'].map<User>((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load user');
    }
  }
}
