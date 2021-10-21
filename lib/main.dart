import 'package:appbuild/flash.dart';
import 'package:appbuild/login.dart';
import 'package:appbuild/signup.dart';
import 'package:appbuild/task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  // Firebase.initializeApp();
  runApp(const Start());
}

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "Flash",
      routes: {
        "Flash": (context) => const Flash(),
        "Login": (context) => const Login(),
        "Task": (context) => const Task(),
        "SignUp": (context) => const Signup()
      },
    );
  }
}
