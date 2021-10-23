import 'dart:ui';

import 'package:appbuild/module/alertdialoge.dart';
import 'package:appbuild/styles/textfeild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String login_email = "";
  String login_password = "";
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
                image: AssetImage("Images/main.png"),
                height: MediaQuery.of(context).size.height * 0.38,
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
            child: Text(
              "Let's sign you in.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(13, 12, 0, 0),
            child: Text(
              "Walcome back.",
              style: TextStyle(fontSize: 16),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(13, 0, 0, 17),
            child: Text(
              "You have been missed!",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(13, 15, 13, 5),
            child: SizedBox(
              child: TextField(
                onChanged: (String value) {
                  login_email = value;
                },
                decoration: Custom(lable: "email").textFeildDecoration,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(13, 8, 13, 40),
            child: SizedBox(
              child: TextField(
                
                obscureText: true,
                onChanged: (String value) {
                  login_password = value;
                },
                decoration: Custom(lable: "password").textFeildDecoration,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account? "),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "SignUp");
                },
                child: const Text(
                  "Sign up",
                  style: TextStyle(color: Colors.amber),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 8, 13, 0),
            child: CupertinoButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: login_email, password: login_password)
                      .then((value) => Navigator.pushNamed(context, "Task"));
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    showDialog(
                        context: context,
                        builder: Alert('User not found', context));
                  } else if (e.code == 'wrong-password') {
                    showDialog(
                        context: context,
                        builder:
                            Alert('You have entered wrong password', context));
                  }
                }
              },
              child: const Text("Sign in"),
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}
