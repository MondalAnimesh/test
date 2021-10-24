// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';

class Dialoge {
  var context;
  String alert;
  Dialoge(this.alert, this.context);
  late var dialogeAlert = AlertDialog(
    title: const Text('AlertDialog Title'),
    content: SingleChildScrollView(
      child: ListBody(
        children: const <Widget>[
          Text('This is a demo alert dialog.'),
          Text('Would you like to approve of this message?'),
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: const Text('Approve'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

Alert(var alert, context) {
  return (BuildContext context) {
    return AlertDialog(
      title: const Text("Alert!!"),
      content: SingleChildScrollView(
        child: Text(alert),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Done'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  };
}
