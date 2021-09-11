import 'package:flutter/material.dart';
//routes
import './Notifications/notifications.dart';
import './Explore/explore.dart';
import './doctor/doctor_profile.dart';

class TabRoute extends StatefulWidget {
  static const routeName = "tab";
  @override
  _TabState createState() => _TabState();
}

enum Options {
  Settings,
  Logout,
}

class _TabState extends State<TabRoute> {
  List<Map<String, Object>>? _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': Explore(),
        'title': 'Explore',
      },
      {
        'page': Notifications(),
        'title': 'Notifications',
      },
      {
        'page': Doctor(),
        'title': 'Doctors',
      },
      // {
      //   'page': Notifications(),
      //   'title': 'Notifications',
      // },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(209, 117, 129, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.local_pharmacy_sharp),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {},
        ),
      ),
      body: _pages![_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).accentColor,
        backgroundColor: Color.fromRGBO(209, 117, 129, 1),
        currentIndex: _selectedPageIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.search,
          //   ),
          //   label: "Search",
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.add_circle,
          //   ),
          //   label: "Add",
          // ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
            ),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment_ind_rounded,
            ),
            label: "Doctor",
          ),
        ],
      ),
    );
  }
}
