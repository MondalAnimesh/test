import 'package:appbuild/styles/textfeild.dart';
import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(),
      body: Container(
        child: Padding(padding: EdgeInsets.fromLTRB(20, 15, 15, 20), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              decoration: Custom(lable: "name").textFeildDecoration,
            ),
            TextField(
              decoration: Custom(lable: "Address").textFeildDecoration,
            ),
            TextField(
              decoration: Custom(lable: "mobile no.").textFeildDecoration,
            )
          ],
        ),),
      ),
    );
  }
}
