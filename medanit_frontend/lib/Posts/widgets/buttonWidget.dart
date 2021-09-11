import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
        child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
        shape: StadiumBorder(),
        color: Color.fromRGBO(209, 117, 129, 1),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        textColor: Colors.white,
        onPressed: onClicked,
      );
}
