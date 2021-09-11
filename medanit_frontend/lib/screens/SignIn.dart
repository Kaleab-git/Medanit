import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medanit_frontend/Posts/post.dart';
import 'package:medanit_frontend/Services/authenticate.dart';
import 'package:medanit_frontend/screens/SignUp.dart';
import '../globals.dart' as globals;

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var username, password, token;
  void _onPressedHandler(String message, String status) {
    setState(() {
      status = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    String status = "Sign In";
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("$status"),
            TextField(
              decoration: InputDecoration(labelText: "Username"),
              onChanged: (val) {
                username =
                    val; // ensuring we have stored in username latest value inside field
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
                  AuthService().signin(username, password).then((val) {
                    if (val == null) {
                      _onPressedHandler("Incorrect Credentials", status);
                    } else {
                      token = val.data;
                      globals.storage.setItem("token", token);
                      Navigator.pushNamed(context, Feed.routeName);
                    }
                  });
                }),
                child: Text('Authenticate')),
            SizedBox(
              width: 30,
              height: 30,
            ),
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(text: "Dont have an account?"),
              TextSpan(
                  text: " Create an account",
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).popAndPushNamed(
                        SignUpScreen.routeName,
                      );
                    }),
            ]))
          ]),
    );
  }
}
