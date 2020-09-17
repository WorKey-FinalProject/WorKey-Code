import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:workey/company_account/widgets/groups_screen_bottom_pages/employees_list.dart';
import 'package:workey/company_account/widgets/groups_screen_bottom_pages/settings_view.dart';
import 'package:workey/company_account/widgets/groups_screen_bottom_pages/sub_groups_list.dart';

import 'package:workey/company_account/widgets/profile_picture.dart';

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  ScrollController _scrollController;
  bool lastStatus = true;
  double height;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (height - kToolbarHeight - 150);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (ctx, innerBoxIsScrolled) {
            height = MediaQuery.of(ctx).size.height * 0.35;

            return <Widget>[
              SliverAppBar(
                expandedHeight: height,
                toolbarHeight: MediaQuery.of(context).size.height * 0.16,
                pinned: true,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: SingleChildScrollView(
                    child: AnimatedSwitcher(
                      switchInCurve: Curves.easeInSine,
                      switchOutCurve: Curves.easeInSine,
                      duration: Duration(milliseconds: 200),
                      child: !_isShrink
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: ProfilePicture(
                                    imageUrl:
                                        'https://pbs.twimg.com/profile_images/1192101281252495363/c_xL2w3j.jpg',
                                    size: MediaQuery.of(context).size.height *
                                        0.14,
                                    isEditable: false,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 22,
                                  ),
                                  child: Text('text'),
                                ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    right: 10,
                                    left: 10,
                                    bottom: 45,
                                  ),
                                  child: ProfilePicture(
                                    imageUrl:
                                        'https://pbs.twimg.com/profile_images/1192101281252495363/c_xL2w3j.jpg',
                                    size: MediaQuery.of(context).size.height *
                                        0.14,
                                    isEditable: false,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 40,
                                  ),
                                  child: Text('text'),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                bottom: TabBar(
                  unselectedLabelColor: Colors.white,
                  labelColor: Theme.of(context).accentColor,
                  indicatorColor: Theme.of(context).accentColor,
                  tabs: [
                    Tab(icon: Icon(Icons.settings)),
                    Tab(icon: Icon(Icons.group_work)),
                    Tab(icon: Icon(Icons.people)),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              SettingsView(),
              SubGroupsList(_isShrink),
              EmployeesList(),
            ],
          ),
        ),
      ),
    );
  }
}
