import 'package:flutter/material.dart';

import './tabroute.dart';
import 'signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medanit - Traditional Medicine',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
