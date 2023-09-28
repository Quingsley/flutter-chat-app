import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ui/features/add/data/models/new_contact_model.dart';

class AddContactDataSource {
  final http.Client client;
  final String baseUrl = "http://192.168.3.140:3000";

  AddContactDataSource({required this.client});

  Future<bool> addContact(NewContactModel contact) async {
    var requestBody = jsonEncode(contact.toJson());
    var response = await client
        .post(Uri.parse('$baseUrl/add-contact'), body: requestBody, headers: {
      'Content-Type': "application/json",
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception(data['message']);
    }
  }
}
