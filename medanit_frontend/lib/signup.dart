import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

@override
LoginPage createState() {
  return LoginPage();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final blueColor = Color(0XFFFF8A80);
  final yellowColor = Color(0XFFFF8A80);

  late TapGestureRecognizer _tapGestureRecognizer;
  late bool _showSignIn;

  @override
  void initState() {
    super.initState();
    _showSignIn = true;
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          _showSignIn = !_showSignIn;
          print("Hello");
        });
      };
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          body: Stack(
        children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          buildBackgroundTopCircle(),
          buildBackgroundBottomCircle(),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 40),
                child: Column(
                  children: [
                    Text(
                      _showSignIn ? "SIGN IN" : "CREATE ACCOUNT",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    buildAvatarContainer(),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOutBack,
                      height: _showSignIn ? 240 : 400,
                      margin: EdgeInsets.only(top: _showSignIn ? 40 : 30),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: Offset(0, 1),
                            )
                          ]),
                      child: SingleChildScrollView(
                        child: _showSignIn
                            ? buildSignInTextFieldSection()
                            : buildSignUpTextFieldSection(),
                      ),
                    ),
                    _showSignIn
                        ? buildSingInBottomSection()
                        : buildSingUpBottomSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Container buildSingInBottomSection() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              print("Forget Password");
            },
            child: Text(
              "Forget Password ?",
              style: TextStyle(
                color: blueColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          RaisedButton(
            color: blueColor,
            elevation: 10,
            padding: EdgeInsets.symmetric(horizontal: 70, vertical: 12),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_right,
                  color: yellowColor,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          RichText(
            text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: "Create an Account",
                      recognizer: _tapGestureRecognizer,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: blueColor,
                        fontWeight: FontWeight.bold,
                      ))
                ]),
          )
        ],
      ),
    );
  }

  Container buildSingUpBottomSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          RaisedButton(
            color: yellowColor,
            elevation: 10,
            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_right,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          RichText(
            text: TextSpan(
                text: "Already have an account? ",
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: "Sign in",
                      recognizer: _tapGestureRecognizer,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: blueColor,
                        fontWeight: FontWeight.bold,
                      ))
                ]),
          )
        ],
      ),
    );
  }

  Column buildSignInTextFieldSection() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
              border: UnderlineInputBorder(), labelText: 'Enter your username'),
        ),
        SizedBox(
          height: 30,
        ),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              border: UnderlineInputBorder(), labelText: 'Enter your password'),
        ),
      ],
    );
  }

  Column buildSignUpTextFieldSection() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
              border: UnderlineInputBorder(), labelText: 'Enter your username'),
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          decoration: const InputDecoration(
              border: UnderlineInputBorder(), labelText: 'user@gmail.com'),
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          decoration: const InputDecoration(
              border: UnderlineInputBorder(), labelText: 'Phone Number'),
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              border: UnderlineInputBorder(), labelText: 'Enter your password'),
        ),
      ],
    );
  }

  Container buildTextField(
      String labelText, String placeholder, bool isPassword) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(color: blueColor, fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                filled: true,
                fillColor: Colors.grey[200],
                hintText: placeholder,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ))
        ],
      ),
    );
  }

  Container buildAvatarContainer() {
    return Container(
      margin: EdgeInsets.only(top: 24),
      width: 158,
      height: 130,
      decoration: BoxDecoration(
          color: _showSignIn ? yellowColor : Colors.grey[800],
          borderRadius: BorderRadius.circular(65),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 20,
            ),
          ]),
      child: Center(
        child: Stack(
          children: [
            Positioned(
                left: 3.0,
                top: 3.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: Image.asset('assets/img/logo.png'),
                )),
          ],
        ),
      ),
    );
  }

  Positioned buildBackgroundBottomCircle() {
    return Positioned(
      top: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.width,
      right: MediaQuery.of(context).size.width / 2,
      child: Container(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: blueColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width,
            )),
      ),
    );
  }

  Positioned buildBackgroundTopCircle() {
    return Positioned(
      top: 0,
      child: Transform.translate(
        offset: Offset(0.0, -MediaQuery.of(context).size.width / 1.3),
        child: Transform.scale(
          scale: 1.35,
          child: Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: _showSignIn ? Colors.grey[800] : blueColor,
                borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width,
                )),
          ),
        ),
      ),
    );
  }
}
