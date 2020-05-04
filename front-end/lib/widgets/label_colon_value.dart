import 'package:flutter/material.dart';

class LabelColonValue extends StatelessWidget { // displays stuff like 'Status: Confirmed' with seperate styling for the label and value.
  LabelColonValue({@required this.label, @required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(': '),
        Text(value),
      ],);
  }
}