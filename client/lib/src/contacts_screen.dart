import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:contacts/src/list_contacts.dart';
import 'package:contacts/src/api.dart';
import 'contact.dart';

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key key, this.title}) : super(key: key);

  final String title;
  final ContactsApi api = ContactsApi();

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> contacts = [];
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

  void _addContact() async {
    final fakerObject = new Faker();
    final person = fakerObject.person;
    final fullName = '${person.firstName()} ${person.lastName()}';

    final newContact = await widget.api.create(fullName);

    setState(() {
      contacts.add(newContact);
    });
  }

  void _deleteContact(String id) async {
    await widget.api.delete(id);
    setState(() {
      contacts.removeWhere((contact) => contact.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListContacts(
              contacts: contacts, add: _addContact, delete: _deleteContact),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _addContact,
            tooltip: 'Add New Contact',
            child: Icon(Icons.person_add),
          ),
        ],
      ),
    );
  }
}
