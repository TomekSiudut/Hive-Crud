import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud/models/contact_model.dart';
import 'package:hive_crud/widgets/new_contact_form.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hive Tutorial'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildListView()),
            NewContactForm(),
          ],
        ));
  }

  Widget _buildListView() {
    return WatchBoxBuilder(
        box: Hive.box("contacts"),
        builder: (BuildContext context, contactsBox) {
          return ListView.builder(
            itemCount: contactsBox.length,
            itemBuilder: (context, index) {
              final contact = contactsBox.getAt(index) as Contact;
              return ListTile(
                title: Text(contact.name),
                subtitle: Text(contact.age.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}
