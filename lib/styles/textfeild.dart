import 'package:flutter/material.dart';

class Custom {
  String lable;
  Custom({this.lable = "password"});
  late InputDecoration textFeildDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    labelText: lable,
  );
  static TextStyle heaDing =
      const TextStyle(fontSize: 26, fontWeight: FontWeight.bold);
  static TextStyle heaDing2 =
      const TextStyle(fontSize: 35, fontWeight: FontWeight.bold);
}
