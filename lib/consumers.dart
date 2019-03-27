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
        elevation: 2,
        title: Text(
          "Consumers",
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Text("Welcome Consumers"),
        ],
      ),
    );
  }
}
