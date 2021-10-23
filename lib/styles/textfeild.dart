import 'package:flutter/material.dart';

class Custom {
  String lable;
  Custom({this.lable = "password"});
  late InputDecoration textFeildDecoration = InputDecoration(
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    labelText: lable,
  );
}
