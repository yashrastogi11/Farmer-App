import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/auth.dart';
import 'package:farmer_app/login.dart';
import 'package:flutter/material.dart';

class Consumers extends StatefulWidget {
  @override
  _ConsumersState createState() => _ConsumersState();
}

class _ConsumersState extends State<Consumers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              authService.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text("Logout"),
          )
        ],
        elevation: 2,
        title: Text(
          "Consumers",
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(height: 10),
          Text("Sugarcane"),
          sugarcane(),
          Divider(),
          SizedBox(height: 10),
          Text("Coffee"),
          coffee(),
          Divider(),
          SizedBox(height: 10),
          Text("Corn"),
          corn(),
          Divider(),
          SizedBox(height: 10),
          Text("Rice"),
          rice(),
          Divider(),
          SizedBox(height: 10),
          Text("Tea"),
          tea(),
          Divider(),
        ],
      ),
    );
  }

  Widget sugarcane() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('items')
          .document('sugarcane')
          .snapshots(),
      builder: (context, snapshot) {
        var document = snapshot.data;
        return Text(document["quantity"]);
      },
    );
  }

  Widget coffee() {
    return StreamBuilder(
      stream:
          Firestore.instance.collection('items').document('coffee').snapshots(),
      builder: (context, snapshot) {
        var document = snapshot.data;
        return Text(document["quantity"]);
      },
    );
  }

  Widget corn() {
    return StreamBuilder(
      stream:
          Firestore.instance.collection('items').document('corn').snapshots(),
      builder: (context, snapshot) {
        var document = snapshot.data;
        return Text(document["quantity"]);
      },
    );
  }

  Widget rice() {
    return StreamBuilder(
      stream:
          Firestore.instance.collection('items').document('rice').snapshots(),
      builder: (context, snapshot) {
        var document = snapshot.data;
        return Text(document["quantity"]);
      },
    );
  }

  Widget tea() {
    return StreamBuilder(
      stream:
          Firestore.instance.collection('items').document('tea').snapshots(),
      builder: (context, snapshot) {
        var document = snapshot.data;
        return Text(document["quantity"]);
      },
    );
  }
}
