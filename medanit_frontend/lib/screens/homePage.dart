import 'package:flutter/material.dart';
import 'package:medanit_frontend/User/screens/profilePage.dart';
import 'package:medanit_frontend/screens/addPostPage.dart';
import 'package:medanit_frontend/Posts/post.dart';

class HomePageScreen extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  _HomePageStateScreen createState() => _HomePageStateScreen();
}

class _HomePageStateScreen extends State<HomePageScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    List<Widget> _widgetOptions = <Widget>[
      Feed(),
      Text(
        'Index 2: Search',
        style: optionStyle,
      ),
      AddPostPage(),
      Text(
        'Index 2: Notification',
        style: optionStyle,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(209, 117, 129, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Doctor.routeName);
          },
          icon: Icon(Icons.person),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Color.fromRGBO(209, 117, 129, 1),
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.yellow))),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_add_outlined),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notification_add_outlined),
              label: 'Notification',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
