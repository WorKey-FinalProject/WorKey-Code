import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:workey/company_account/screens/groups_screen_pages/employees_list.dart';
import 'package:workey/company_account/screens/groups_screen_pages/settings_view.dart';
import 'package:workey/company_account/screens/groups_screen_pages/sub_groups_list.dart';

class GroupsTabBar extends StatefulWidget {
  @override
  _GroupsTabBarState createState() => _GroupsTabBarState();
}

class _GroupsTabBarState extends State<GroupsTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
              ),
              // boxShadow: [
              //   BoxShadow(
              //     offset: Offset(0, 5),
              //     blurRadius: 50,
              //     color: Color(0xFF12153D).withOpacity(0.2),
              //   )
              // ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: TabBar(
                // unselectedLabelColor: Theme.of(context).primaryColor,
                // labelColor: Theme.of(context).accentColor,
                // indicatorColor: Theme.of(context).accentColor,
                unselectedLabelColor: Colors.white,
                labelColor: Theme.of(context).primaryColor,
                indicatorColor: Theme.of(context).primaryColor,

                // indicator: UnderlineTabIndicator(
                //   insets: EdgeInsets.symmetric(horizontal: 16),
                // ),

                tabs: [
                  Tab(icon: Icon(Icons.group_work)),
                  Tab(icon: Icon(Icons.list)),
                  Tab(icon: Icon(Icons.settings)),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SubGroupsList(false),
            EmployeesList(),
            SettingsView(),
          ],
        ),
      ),
    );
  }
}
