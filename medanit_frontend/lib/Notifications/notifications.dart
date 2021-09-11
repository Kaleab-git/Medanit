import 'package:flutter/material.dart';
import 'package:medanit_frontend/Posts/Screens/postPage.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notifications",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("All"))
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  print("IIIII HAAAAVEEE HEREEE BY BEEN TAPED");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostPage()),
                  );
                  // setState(() {
                  //   // Toggle light when tapped.
                  //   // _lightIsOn = !_lightIsOn;
                  // });
                },
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (ctx, index) => Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    margin: EdgeInsets.symmetric(vertical: 3),
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.blue,
                            ),
                            Text(
                                "James Camry upvoted your post: Ginger for Fever")
                          ],
                        ),
                        Text("just now")
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
