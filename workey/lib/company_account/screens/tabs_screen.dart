import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:workey/company_account/screens/groups_screen.dart';
import 'package:workey/general/providers/auth.dart';
import 'package:workey/general/providers/global_sizes.dart';
import 'package:workey/general/providers/monthly_shift_summery_list.dart';

import './home_screen.dart';
import './profile_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);

    final List<Map<String, Object>> _pages = [
      {
        'page': HomeScreen(),
        'title': 'Home',
      },
      {
        'page': GroupsScreen(),
        'title': 'Groups',
      },
      {
        'page': ProfileScreen(_auth),
        'title': 'Profile',
      },
    ];
    final appBar = AppBar(
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
              _auth.logout();
            }
          },
        )
      ],
      // Todo - Enter title text
      title: Text(_pages[_selectedPageIndex]['title']),
    );

    Provider.of<GlobalSizes>(context).setAppBarHeight(appBar.preferredSize);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar,
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
            title: Text('Groups'),
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
