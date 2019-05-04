import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/auth.dart';
import 'package:farmer_app/login.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class Farmers extends StatefulWidget {
  @override
  _FarmersState createState() => _FarmersState();
}

class _FarmersState extends State<Farmers> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final quantityController = TextEditingController();

  List<String> _product = ['coffee', 'corn', 'rice', 'sugarcane', 'tea'];
  String prod = "Choose your crop";

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
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text(
          "Farmers",
          textAlign: TextAlign.center,
        ),
        elevation: 2,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          Form(
            key: _formKey,
            child: Theme(
              data: ThemeData(
                  inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                      ),
                      labelStyle: TextStyle(fontSize: 15))),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 25, right: 25),
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  //          TextFormField(
                  //            controller: nameController,
                  //            decoration: InputDecoration(
                  //              labelText: "Product Name",
                  //              labelStyle: TextStyle(fontSize: 18),
                  //            ),
                  //            validator: (value) {
                  //              if (value.isEmpty) {
                  //                return 'Please enter some text';
                  //              }
                  //            },
                  //          ),
                  DropdownButtonFormField(
                    hint: Text(prod),
                    items: _product.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        prod = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      labelText: "Quantity of above product",
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some number';
                      }
                    },
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  ButtonTheme(
                    minWidth: 80,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.lightGreen,
                      child: Text(
                        "Enter",
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      ),
                      onPressed: () {
                        if (prod != "Choose your crop" &&
                            quantityController.text != "") {
                          Firestore.instance
                              .collection('items')
                              .document(prod)
                              .updateData({
                            "name": prod,
                            "quantity": quantityController.text,
                          });
                          Flushbar(
                            message: "Data has been saved",
                            leftBarIndicatorColor: Colors.lightGreen,
                            title: "Successfully saved",
                            duration: Duration(seconds: 4),
                            isDismissible: true,
                          )..show(context);
                          setState(() {
                            prod = "Choose your crop";
                            quantityController.text = "";
                          });
                          FocusScope.of(context).requestFocus(FocusNode());
                        } else {
                          Flushbar(
                            message: "Data empty",
                            leftBarIndicatorColor: Colors.red,
                            title: "Please enter some data",
                            duration: Duration(seconds: 4),
                            isDismissible: true,
                          )..show(context);
                          setState(() {
                            prod = "Choose your crop";
                            quantityController.text = "";
                          });
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
