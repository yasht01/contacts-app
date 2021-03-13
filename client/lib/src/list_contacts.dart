import 'package:flutter/material.dart';
import 'package:contacts/src/no_contacts.dart';
import 'contact.dart';

class ListContacts extends StatelessWidget {
  final List<Contact> contacts;
  final VoidCallback add;
  final Function(String name) delete;

  ListContacts({this.contacts, this.add, this.delete});

  @override
  Widget build(BuildContext context) {
    return contacts.isEmpty
        ? NoContacts(
            add: add,
          )
        : ListView(children: [
            ...contacts
                .map<Widget>((contact) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Text(contact.initials,
                              style: TextStyle(fontSize: 23)),
                        ),
                        title: Text(
                          contact.name,
                          style: TextStyle(fontSize: 20),
                        ),
                        trailing: TextButton(
                          child:
                              Icon(Icons.delete, color: Colors.red, size: 30),
                          onPressed: () {
                            delete(contact.id);
                          },
                        ),
                      ),
                    ))
                .toList(),
            SizedBox(height: 80),
          ]);
  }
}
