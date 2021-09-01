import 'package:flutter/material.dart';

class Doctor extends StatefulWidget {
  const Doctor({Key? key}) : super(key: key);

  @override
  DoctorState createState() => DoctorState();
}

class DoctorState extends State<Doctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Text("Doctor"),
    ));
  }
}
