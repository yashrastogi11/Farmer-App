import 'package:farmer_app/auth.dart';
import 'package:farmer_app/homepage.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/book.jpg"), fit: BoxFit.fill)),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            child: Text(
              "ORGANIC",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: Text(
              "One stop for all your food",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.3,
            width: MediaQuery.of(context).size.width - 120,
            left: 60,
            child: MaterialButton(
              onPressed: () {
                authService.googleSignIn();
                //         Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Image.asset("images/google.png"),
            ),
          ),

        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialButton(
            onPressed: () => authService.signOut(),
            color: Colors.red,
            textColor: Colors.white,
            child: Text('Signout'),
          );
        } else {
          return MaterialButton(
            onPressed: () => authService.googleSignIn(),
            color: Colors.red,
            textColor: Colors.white,
            child: Text('Login with Google'),
          );
        }
      },
    );
  }
}
