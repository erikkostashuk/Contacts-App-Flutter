import 'package:flutter/material.dart';
import 'ContactModel.dart';
import 'Contact.dart';
import 'utils.dart';
import 'package:validators/validators.dart';

class AddContact extends StatefulWidget {
  AddContact({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _formKey = GlobalKey<FormState>();
  final dbHelper = ContactModel.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userAvatarUrlController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a contact name.';
                  } else if (value.length > 50) {
                    return 'Please enter a contact name less than 50 characters.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                validator: (value) {
                  if (value.isEmpty ||
                      value.length != 10 ||
                      !isNumeric(value) ||
                      int.parse(value) < 0) {
                    return 'Please enter a phone number. Format: 1234445555';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: userAvatarUrlController,
                decoration: const InputDecoration(
                  labelText: 'Avatar Image Url',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter an avatar url image.';
                  }
                  return null;
                },
              ),
              TextFormField(
                readOnly: true,
                enableInteractiveSelection: true,
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'Date Added:',
                ),
                onTap: () async {
                  var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));

                  if (date != null) {
                    dateController.text = date.toString();
                  }
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please pick a date.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Contact myContact = Contact.noID(
                nameController.text,
                dateController.text,
                phoneController.text,
                userAvatarUrlController.text);

            dbHelper.insertContact(myContact);

            nameController.clear();
            phoneController.clear();
            userAvatarUrlController.clear();
            dateController.clear();

            Navigator.pop(context);
          }
        },
        tooltip: 'Add a contact.',
        child: Icon(Icons.check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
