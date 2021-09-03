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
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.redAccent, Colors.pinkAccent])),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Dr John",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 22.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "5200",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Upvotes",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "28.5K",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Downvotes",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "1300",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Johns Posts:",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontStyle: FontStyle.italic,
                        fontSize: 22.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'In publishing and graphic design, Lorem ipsum is a\n placeholder text commonly used to demonstrate\n the visual form of a document or a typeface without\n relying on meaningful content. Lorem ipsum may be\n used as a placeholder before final copy is available.',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 90,
                      ),
                      Icon(Icons.thumb_up_off_alt_outlined),
                      SizedBox(width: 5),
                      Text("34"),
                      SizedBox(
                        width: 60,
                      ),
                      Icon(Icons.thumb_down_off_alt_outlined),
                      SizedBox(width: 5),
                      Text("34"),
                      SizedBox(
                        width: 60,
                      ),
                      Icon(Icons.insert_comment_outlined),
                      SizedBox(width: 5),
                      Text("34"),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'In publishing and graphic design, Lorem ipsum is a\n placeholder text commonly used to demonstrate\n the visual form of a document or a typeface without\n relying on meaningful content. Lorem ipsum may be\n used as a placeholder before final copy is available.',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 90,
                      ),
                      Icon(Icons.thumb_up_off_alt_outlined),
                      SizedBox(width: 5),
                      Text("34"),
                      SizedBox(
                        width: 60,
                      ),
                      Icon(Icons.thumb_down_off_alt_outlined),
                      SizedBox(width: 5),
                      Text("34"),
                      SizedBox(
                        width: 60,
                      ),
                      Icon(Icons.insert_comment_outlined),
                      SizedBox(width: 5),
                      Text("34"),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 632.0,
          ),
        ],
      ),
    ));
  }
}
