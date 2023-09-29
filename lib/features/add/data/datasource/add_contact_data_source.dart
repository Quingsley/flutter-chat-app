import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:ui/features/add/data/models/new_contact_model.dart';
import 'package:ui/shared/providers/shared_providers.dart';

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
      throw Exception(data['data']);
    }
  }
}

final addContactDataSourceProvider = Provider<AddContactDataSource>((ref) {
  var client = ref.watch(httpProvider);
  return AddContactDataSource(client: client);
});
