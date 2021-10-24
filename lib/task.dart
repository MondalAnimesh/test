// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:appbuild/module/alertdialoge.dart';
import 'package:appbuild/styles/textfeild.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  TextEditingController Currentname = TextEditingController(text: "");

  TextEditingController Currentaddress = TextEditingController(text: "");

  TextEditingController Currentnumber = TextEditingController(text: "");

  String Curruntfrom = "Loading";
  var latitude;
  var longitude;
  late String curruntStatus;
  @override
  void initState() {
    super.initState();
    curruntTask();
  }

  curruntTask({String docID = "null"}) {
    if (docID == "null") {
      Currentname.text = "Please select a task to continue";
      Currentaddress.text = "Please select a task to continue";
      Currentnumber.text = "Please select a task to continue";
      Curruntfrom = "Please select a task to continue";
      latitude = "Please select a task to continue";
      longitude = "Please select a task to continue";
      curruntStatus = "Unknown";
      setState(() {});
    } else {
      FirebaseFirestore.instance
          .collection("Orders")
          .doc(docID)
          .get()
          .then((value) {
        Currentname.text = value.data()!["Name"];
        Currentaddress.text = value.data()!["Address"];
        Currentnumber.text = value.data()!["Mobile number"];
        Curruntfrom =
            value.data()!["From name"] + ", " + value.data()!["From Address"];
        latitude = value.data()!["end latitude"];
        longitude = value.data()!["end longitude"];
        curruntStatus = value.data()!["Status"];
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const Drawer(),
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
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
              child: ListView(
                children: [
                  Text("Current Task", style: Custom.heaDing),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: Currentname,
                    decoration: Custom(lable: "name").textFeildDecoration,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: Currentaddress,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () async {
                          String map =
                              'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                          if (await canLaunch(map)) {
                            await launch(map);
                          } else {
                            throw 'Could not open the map.';
                          }
                        },
                        icon: const Icon(Icons.map),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: "Address",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: Currentnumber,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () async {
                          String call = "tel:${Currentnumber.text}";
                          if (await canLaunch(call)) {
                            await launch(call);
                          } else {
                            throw 'Could not open the map.';
                          }
                        },
                        icon: const Icon(Icons.call),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: "Mobile no.",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Text(
                        "from: " + Curruntfrom,
                        style: Custom.heaDing3,
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: Alert(curruntStatus, context));
                        },
                        label: const Text("status"),
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
          SizedBox(
            height: MediaQuery.of(context).size.height * .6,
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("Orders").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.done ||
                    snapshot.connectionState == ConnectionState.active) {
                  return ListView(
                    children: snapshot.data!.docs.map(
                      (DocumentSnapshot dataa) {
                        Map<dynamic, dynamic> document =
                            dataa.data() as Map<dynamic, dynamic>;

                        return Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 15),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      document["Address"],
                                      style: Custom.heaDing3,
                                    ),
                                    const Icon(Icons.arrow_downward),
                                    Text(
                                      document["From Address"],
                                      style: Custom.heaDing3,
                                    )
                                  ],
                                ),
                                FloatingActionButton.extended(
                                  onPressed: () {
                                    curruntTask(docID: dataa.id);
                                  },
                                  label: const Text("Start"),
                                  backgroundColor: Colors.amber,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  );
                } else {
                  return Column(children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                    const SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Loading data ...'),
                    )
                  ]);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
