import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactsApi {
  final String url = 'http://localhost:4049';

  Future<List> getContacts() async {
    // await Future<void>.delayed(Duration(seconds: 5));
    var response;

    try {
      response = await http.get(Uri.http("localhost:4049", "/"));
    } on Exception catch (e) {
      print("Error found at line 13 \"await http.get()\"");
      print('Error: $e');
    }

    final jsonData = await jsonDecode(response.body.toString());
    return (jsonData['contacts']);
  }
}
