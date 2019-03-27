import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/login.dart';
import 'package:farmer_app/settings.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmers App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
  //    home: occupation()=='NULL' ? Login() : Settings(),
      home: Login(),
    );
  }

  Widget occupation() {
    return StreamBuilder(
      stream:
          Firestore.instance.collection('users').document('yash').snapshots(),
      builder: (context, snapshot) {
        var document = snapshot.data;
        return Text(document["occupation"]);
      },
    );
  }
}
