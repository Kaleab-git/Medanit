import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medanit_frontend/Posts/post.dart';
import 'package:medanit_frontend/Services/authenticate.dart';
import 'package:medanit_frontend/screens/SignIn.dart';
import '../globals.dart' as globals;

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String fullname = "";
  String username = "";
  String email = "";
  DateTime selectedDate = DateTime.now();
  String password = "";
  String confirm_password = "";
  String token = "";
  String _error = "";

  void display_error(String message) async {
    setState(() {
      _error = message;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    List lastDate = "${selectedDate.toLocal()}".split(' ')[0].split('-');

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(int.parse(lastDate[0]), int.parse(lastDate[1]),
            int.parse(lastDate[2])));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
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
                  labelText: "Full Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                validator: (value) {
                  if (value!.length == 0) {
                    return 'Full Name cannot be empty!';
                  }

                  return null;
                },
                maxLines: 1,
                onSaved: (value) => setState(() {
                  fullname = value!;
                }),
              ),
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
                    return "Username must be at least 5 characters long";
                  }
                  if (value.length > 15) {
                    return "Username must not be more than 15 characters long";
                  }

                  return null;
                },
                maxLines: 1,
                onSaved: (value) => setState(() {
                  username = value!;
                }),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                validator: (value) {
                  if (value!.length == 0) {
                    return 'Email cannot be empty!';
                  }
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (!emailValid) {
                    return "Invalid Email address";
                  }

                  return null;
                },
                maxLines: 1,
                onSaved: (value) => setState(() {
                  email = value!;
                }),
              ),
              SizedBox(
                height: 13,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("${selectedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(fontSize: 16))),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.calendar_today_sharp),
                      onPressed: () => _selectDate(context),
                      label: Text('Select date'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 13,
              ),
              TextFormField(
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
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
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
                  String birthday = "${selectedDate.toLocal()}".split(' ')[0];
                  if (password != confirm_password) {
                    display_error(
                        "Confirm password doesn't match with password");
                  } else {
                    AuthService()
                        .SignUp(fullname, username, email, birthday, password)
                        .then((dynamic response) {
                      if (response['message'] == "success") {
                        Navigator.of(context).popAndPushNamed(
                          SignInScreen.routeName,
                        );
                      } else {
                        display_error(response['message']);
                      }
                    });
                  }
                  // AuthService().signIn(username, password).then((response) {
                  //   if (response) {
                  //     Navigator.popAndPushNamed(context, '/feed');
                  //   } else {
                  //     display_error("Error Message Placeholder");
                  //   }
                  // });
                }
              }),
              child: Text('Create Account')),
          SizedBox(
            width: 30,
            height: 30,
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: "Already have an account?"),
                TextSpan(
                    text: " Sign in",
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).popAndPushNamed(
                          SignInScreen.routeName,
                        );
                      }),
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
