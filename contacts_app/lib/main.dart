import 'package:flutter/material.dart';
import 'ContactList.dart';
import 'AddContact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => ContactList(
              title: "Contact List",
            ),
        '/addcontact': (context) => AddContact(
              title: "Add Contact",
            ),
      },
    );
  }
}
