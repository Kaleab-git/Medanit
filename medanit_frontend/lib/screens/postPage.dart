import 'package:flutter/material.dart';
class postPage extends StatefulWidget {
  const postPage({ Key? key }) : super(key: key);

  @override
  _postPageState createState() => _postPageState();
}

class _postPageState extends State<postPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xD17581)
,
        leading: Icon(    Icons.search  ),
        actions: <Widget>[
          Icon(Icons.search)
            
          
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            color: Colors.green,
          ),
          ListView.builder(itemBuilder: (BuildContext))
        ],
      ),
     
    );
  }
}