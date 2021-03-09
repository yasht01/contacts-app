import 'package:flutter/material.dart';

class NoContacts extends StatelessWidget {

  final VoidCallback add;
  NoContacts({this.add});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.person_sharp,
            color: Colors.amber,
            size: 100,
          ),
          Text('No contacts',
              style: TextStyle(
                fontSize: 30,
              )),
          SizedBox(height: 20),
          FlatButton(
              // color: Colors.teal,
              onPressed: add,
              child: Text(
                'Add a contact',
                style: TextStyle(fontSize: 22, color: Colors.teal),
              ))
        ],
      ),
    );
  }
}
