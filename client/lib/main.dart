import 'package:client/src/contacts_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/src/server.dart' as server;
import 'dart:io';

void main() async {

  // Set the return type to Future<void>
  // Then use it to stop the flow until the server accepts the connection.
  await server.start();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ContactsScreen(title: 'Contacts List'),
    );
  }
}