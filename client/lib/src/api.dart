import 'dart:convert';
import 'package:http/http.dart' as http;
import 'contact.dart';

class ContactsApi {
  final String url = 'http://localhost:4049';

  Future<List<Contact>> getContacts() async {
    var response = await http.get(Uri.http("localhost:4049", ""));
    final jsonData = await jsonDecode(response.body.toString());

    return (jsonData['contacts'] as List)
        .map<Contact>((json) => Contact.fromJson(json))
        .toList();
  }

  Future<Contact> create(String name) async {
    final response = await http.post(Uri.http("localhost:4049", "register"), body: {'name': name});
    return Contact.fromJson(jsonDecode(response.body.toString()));
  }

  Future delete(String id) async {
    final response = await http.delete(Uri.http("localhost:4049", "/delete/$id"));
    return jsonDecode(response.body.toString());
  }
}
