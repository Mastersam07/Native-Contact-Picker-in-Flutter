import 'package:flutter/material.dart';

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
  String displayName = '2020 is a great year';
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
                  InfoDisplay(label: 'label', data: 'data'),
                ],
              ),
              FlatButton(
                onPressed: () {},
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
        ));
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
          child: Text(data ?? ''),
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(),
          ),
        ),
      ],
    );
  }
}
