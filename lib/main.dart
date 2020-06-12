import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(
    title: 'Native contact picker',
    home: ContactPickerDemo(),
  ));
}

class ContactPickerDemo extends StatefulWidget {
  @override
  _ContactPickerDemoState createState() => _ContactPickerDemoState();
}

class _ContactPickerDemoState extends State<ContactPickerDemo> {
  Contact selectedContact = Contact();

  void pickContactFromNativeContact() async {
    if (await checkAppPermissionsToContacts() == PermissionStatus.granted) {
      selectedContact = await ContactsService.openDeviceContactPicker();
      setState(() {});
    }
  }

  Future<PermissionStatus> checkAppPermissionsToContacts() async {
    final PermissionStatus permission =
        await Permission.contacts.status; //Check status of Contacts Permission.
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      //If permission has not been granted or denied.
      final Map<Permission, PermissionStatus> permissionStatus = await [
        Permission.contacts
      ].request(); //Request for Permission to access contacts
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission; //Return Contacts Permission status
    }
  }

  String convertIteratorValuesToString(Iterator iterator) {
    String stringFromIterable = '';
    if (iterator != null)
      while (iterator.moveNext()) {
        stringFromIterable += iterator.current.value + " , ";
      }
    return stringFromIterable;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Device Contact Picker demo',
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                InfoDisplay(
                  label: 'Display Name',
                  data: selectedContact.displayName,
                ),
                InfoDisplay(
                    label: 'Phones',
                    data: convertIteratorValuesToString(
                        selectedContact.phones?.iterator)),
                InfoDisplay(
                    label: 'Emails',
                    data: convertIteratorValuesToString(
                        selectedContact.emails?.iterator)),
                InfoDisplay(
                  label: 'Birthday',
                  data: selectedContact.birthday.toString(),
                ),
              ],
            ),
            FlatButton(
              onPressed: () {
                pickContactFromNativeContact();
              },
              child: Text('Select Contact'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  width: 0.5,
                  color: Colors.deepOrange,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InfoDisplay extends StatelessWidget {
  InfoDisplay({@required this.label, @required this.data});
  final String label;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(label ?? ''),
        Container(
          padding: const EdgeInsets.all(5),
          child: Text(data ?? '', maxLines: 5),
          // height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(),
          ),
        ),
      ],
    );
  }
}
