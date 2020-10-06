import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/providers/auth.dart';

import './home_screen.dart';
import './group_screen.dart';
import './shifts_screen.dart';
import './profile_screen.dart';

class PersonalTabsScreen extends StatefulWidget {
  static const routeName = '/personal-tabs-screen';

  @override
  _PersonalTabsScreenState createState() => _PersonalTabsScreenState();
}

class _PersonalTabsScreenState extends State<PersonalTabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': HomeScreen(),
      'title': 'Home',
    },
    {
      'page': GroupScreen(),
      'title': 'My WorkGroup',
    },
    {
      'page': ShiftsScreen(),
      'title': 'Groups',
    },
    {
      'page': ProfileScreen(),
      'title': 'Profile',
    },
  ];

  var _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
        // Todo - Enter title text
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        unselectedItemColor: Colors.black,
        selectedItemColor: Theme.of(context).buttonColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text('WorkGroup'),
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.table),
            title: Text('Shifts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
