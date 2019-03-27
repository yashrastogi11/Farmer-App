import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/consumers.dart';
import 'package:farmer_app/farmers.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<String> _occupation = ['Farmer', 'Consumer'];
  String occ = "Choose your occupation";
  String val = '';

//  @override
//  void initState() {
//    if (occupation() == 'Farmer') {
//      Navigator.pop(context);
//
//      Navigator.pushReplacement(context,
//          MaterialPageRoute(builder: (BuildContext context) => Farmers()));
//    } else if (occupation() == 'Consumer') {
//      Navigator.pop(context);
//
//      Navigator.pushReplacement(context,
//          MaterialPageRoute(builder: (BuildContext context) => Consumers()));
//    }
//  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Choose your occupation"),
          DropdownButton(
            hint: Text(occ),
            items: _occupation.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
            onChanged: (String value) {
              setState(() {
                occ = value;
              });
            },
          ),
          RaisedButton(
            child: Text("Save"),
            color: Colors.lightGreen,
            onPressed: () {
              Firestore.instance
                  .collection('users')
                  .document('yash')
                  .updateData({"occupation": occ});
              if (occ == 'Farmer') {
                Navigator.pop(context);

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Farmers()));
              } else if (occ == 'Consumer') {
                Navigator.pop(context);

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Consumers()));
              } else if (occ == 'Choose your occupation') {
                setState(() {
                  val = "Please choose";
                });
              }
            },
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          SizedBox(
            height: 30,
          ),
          content(val),
        ],
      ),
    );
  }

  Widget content(String val) {
    return Text(val);
  }
}
