import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Signup> {
  String emailId = "";
  String passWord = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.width * 0.05,
                left: MediaQuery.of(context).size.width * 0.04,
                child: Icon(Icons.arrow_back),
              ),
              Image(
                image: const AssetImage("Images/main.png"),
                height: MediaQuery.of(context).size.height * 0.38,
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
            child: Text(
              "Welcome to delisol",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(13, 8, 0, 0),
            child: Text(
              "Let's create your account",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 15, 13, 5),
            child: SizedBox(
              child: TextField(
                onChanged: (String value) {
                  emailId = value;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Email"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 8, 13, 05),
            child: SizedBox(
              child: TextField(
                onChanged: (String value) {
                  passWord = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: "Password",
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(13, 8, 13, 05),
            child: SizedBox(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: "Confirm Password",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 10, 13, 0),
            child: CupertinoButton(
              onPressed: () async {
                //  Navigator.pushNamed(context, "Task");
                await Firebase.initializeApp();
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailId, password: passWord);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: const Text("Sign Up"),
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}
