import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:client/src/list_contacts.dart';
import 'package:client/src/api.dart';

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key key, this.title}) : super(key: key);

  final String title;
  final ContactsApi api = ContactsApi();

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List contacts = [];
  bool loading = true;

  // Understand this part better.
  @override
  void initState() {
    
    widget.api.getContacts().then((data) {
      setState(() {
        contacts = data;
        loading = false;
      });
    });

    super.initState();
  }

  void _addContact() {
    setState(() {
      final fakerObject = new Faker();
      final person = fakerObject.person;
      final fullName = '${person.firstName()} ${person.lastName()}';
      contacts.add({'name': fullName});
    });
  }

  void _deleteContact(String name) {
    setState(() {
      contacts.removeWhere((contact) => contact['name'] == name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListContacts(
              contacts: contacts, add: _addContact, delete: _deleteContact),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 30),
          FloatingActionButton(
            onPressed: _addContact,
            tooltip: 'Add New Contact',
            child: Icon(Icons.person_add),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Refresh List',
            child: Icon(Icons.refresh),
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
