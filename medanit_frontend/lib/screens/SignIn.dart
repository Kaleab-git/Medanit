import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medanit_frontend/Posts/post.dart';
import 'package:medanit_frontend/Services/authenticate.dart';
import 'package:medanit_frontend/screens/SignUp.dart';
import '../globals.dart' as globals;

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin';

  var status = "Sign In";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String username = "";
  String password = "";
  String token = "";
  String _error = "";

  void display_error() async {
    setState(() {
      _error = "Invalid username or password";
    });
  }

  @override
  Widget build(BuildContext context) {
    // var status = widget.status;
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Column(
        children: <Widget>[
          showAlert(),
          SizedBox(height: 130),
          RichText(
              text: TextSpan(
                  text: "Medanit App",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 15.0,
                        offset: Offset(3.0, 3.0),
                      ),
                      // Shadow(
                      //   color: Colors.blue,
                      //   blurRadius: 10.0,
                      //   offset: Offset(-5.0, 5.0),
                      // ),
                    ],
                  ))),
          SizedBox(height: 30.0),
          Form(
            key: formKey,
            child: Column(children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                validator: (value) {
                  if (value!.length == 0) {
                    return 'Username cannot be empty!';
                  }
                  if (value.length < 5) {
                    return "Username must contain at least 5 characters";
                  }
                  if (value.length > 15) {
                    return "Username must not contain more than 15 characters";
                  }
                  return null;
                },
                maxLines: 1,
                onSaved: (value) => setState(() {
                  username = value!;
                }),
              ),
              SizedBox(height: 1.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                validator: (value) {
                  if (value!.length == 0) {
                    return 'Password cannot be empty!';
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters long";
                  }
                  if (value.length > 20) {
                    return "Password must not be more than 20 characters long";
                  }

                  return null;
                },
                maxLines: 1,
                onSaved: (value) => setState(() {
                  password = value!;
                }),
              ),
            ]),
          ),
          SizedBox(height: 30.0),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(209, 117, 129, 1), // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: (() {
                //where we call AuthService()'s signin function and pass it our input values for authentication
                //function returns token if credentials were valid. Returns nothing if not
                final isValid = formKey.currentState!.validate();
                // FocusScope.of(context).unfocus();
                if (isValid) {
                  formKey.currentState!.save();
                  AuthService().SignIn(username, password).then((response) {
                    if (response) {
                      Navigator.popAndPushNamed(context, '/home');
                    } else {
                      display_error();
                    }
                  });
                }
              }),
              child: Text('Authenticate')),
          SizedBox(
            width: 30,
            height: 30,
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: "Dont have an account?"),
                TextSpan(
                  text: " Create an account",
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).popAndPushNamed(
                        SignUpScreen.routeName,
                      );
                    },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget showAlert() {
    if (_error != "") {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.error_outline)),
            Expanded(
              child: Text(_error),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    _error = "";
                  });
                },
                icon: Icon(Icons.close))
          ],
        ),
      );
    }
    return SizedBox(
      height: 55,
    );
  }
}
