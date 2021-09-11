import 'package:flutter/material.dart';
import 'package:medanit_frontend/Posts/post.dart';

class PostPage extends StatefulWidget {
  static const routeName = 'PostDetail';

  final Post post;

  PostPage({required this.post});

  @override
  _postPageState createState() => _postPageState();
}

class _postPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(209, 117, 129, 1),
        leading: Icon(Icons.search),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.person, size: 50),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: (Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Segni A',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("@segnigodson")
                                  ],
                                ))),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(Icons.bookmark_border))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 50, right: 50, bottom: 10, top: 10),
                    child: Text('ECTS: ${this.widget.post.description}'),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 50, right: 100),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.thumb_up_outlined),
                                Text("70")
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.thumb_down_outlined),
                                Text("60")
                              ],
                            ),
                            Row(children: [
                              Icon(Icons.comment_outlined),
                              Text("80")
                            ])
                          ]))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.person),
                      title: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Text('Segni A')),
                          Text('@segnigoson')
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                                'lorem ipsum lorem ipsum lorem ipsum lorem ipsum'),
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.thumb_up_outlined),
                                      Text('30')
                                    ],
                                  )),
                              Row(
                                children: [
                                  Icon(Icons.thumb_down_outlined),
                                  Text('40')
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(209, 117, 129, 1),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'notifications'),
        ],
      ),
    );
  }
}
