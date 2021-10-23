import 'package:appbuild/styles/textfeild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  TextEditingController cloud = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .6,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.amber, width: 5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 25, 20, 20),
              child: ListView(
                children: [
                  Text("Current Task", style: Custom.heaDing),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: cloud,
                    decoration: Custom(lable: "name").textFeildDecoration,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: Custom(lable: "Address").textFeildDecoration,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: Custom(lable: "mobile no.").textFeildDecoration,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("loading"),
                      FloatingActionButton.extended(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Orders")
                              .doc("BV5AKDGBX5td5Xz9xqe3")
                              .get()
                              .then((value) {
                            print(value.data()!["Name"]);
                            print(value.data()!["Address"]);
                            print(value.data()!["Address"]);
                            cloud.text = value.data()!["Name"];
                          });
                        },
                        label: Text("status"),
                        backgroundColor: Colors.amber,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 0, 15),
            child: Text(
              "Upcoming task",
              style: Custom.heaDing2,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("data"),
                  FloatingActionButton.extended(
                    onPressed: () {},
                    label: Text("Start"),
                    backgroundColor: Colors.amber,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
