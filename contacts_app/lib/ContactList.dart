import 'package:flutter/material.dart';
import 'ContactModel.dart';
import 'Contact.dart';
import 'utils.dart';

class ContactList extends StatefulWidget {
  ContactList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final dbHelper = ContactModel.instance;

  Future returnFromPop(dynamic value) {
    setState(() {});
  }

  void _addcontactbutton() {
    Navigator.pushNamed(context, '/addcontact').then(returnFromPop);
  }

  void _deleteAllContacts(context) {
    dbHelper.deleteAllContacts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            tooltip: "Delete ALL Contacts.",
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              _deleteAllContacts(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Contact>>(
        future: dbHelper.getAllContacts(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Contact item = snapshot.data[index];
                return Container(
                    child: Container(
                        child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(item.userAvatarUrl),
                    child: Text(item.name.substring(0, 1)),
                  ),
                  title: Text(item.name +
                      " | " +
                      "(" +
                      item.phone.substring(0, 3) +
                      ") " +
                      item.phone.substring(3, 6) +
                      "-" +
                      item.phone.substring(6, item.phone.length)),
                  subtitle: Text(toMonthName(
                          int.parse(item.dateAdded.substring(5, 7))) +
                      " " +
                      toOrdinal(int.parse(item.dateAdded.substring(8, 10))) +
                      ", " +
                      item.dateAdded.substring(0, 4)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    tooltip: "Delete this Contact.",
                    onPressed: () {
                      dbHelper.deleteContactById(item.id);
                      setState(() {});
                    },
                  ),
                )));
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addcontactbutton,
        tooltip: 'Add Contact.',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  } // end of builder
} // end of class
