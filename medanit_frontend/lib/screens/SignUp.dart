import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medanit_frontend/Services/authenticate.dart';
import 'package:medanit_frontend/screens/SignIn.dart';
import '../../globals.dart' as globals;

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var name, username, email, password, birthdate, token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Fullname"),
              onChanged: (val) {
                name = val;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Username"),
              onChanged: (val) {
                username = val;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Email"),
              onChanged: (val) {
                email = val;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Date of birth"),
              onChanged: (val) {
                birthdate = val;
              },
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
              onChanged: (val) {
                password = val;
              },
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
                onPressed: (() {
                  //where we call AuthService()'s signin function and pass it our input values for authentication
                  //function returns token if credentials were valid. Returns nothing if not
                  AuthService()
                      .signup(name, username, email, password, birthdate)
                      .then((val) {
                    if (val.data != null) {
                      token = val.data;
                      globals.storage.setItem("token", token);
                    }
                  });
                }),
                child: Text('Register')),
            SizedBox(
              width: 30,
              height: 30,
            ),
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(text: "Already have an account?"),
              TextSpan(
                  text: " Sign in account",
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).popAndPushNamed(
                        SignInScreen.routeName,
                      );
                    }),
            ]))
          ]),
    );
  }
}
