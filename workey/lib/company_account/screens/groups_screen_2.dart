import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:workey/company_account/widgets/icons_row_pages/employees_list.dart';
import 'package:workey/company_account/widgets/icons_row_pages/settings_view.dart';
import 'package:workey/company_account/widgets/icons_row_pages/sub_groups_list.dart';

import 'package:workey/company_account/widgets/profile_screen_widgets/profile_picture.dart';
import 'package:workey/general/providers/global_sizes.dart';

class GroupsScreen2 extends StatefulWidget {
  @override
  _GroupsScreen2State createState() => _GroupsScreen2State();
}

class _GroupsScreen2State extends State<GroupsScreen2> {
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
        _scrollController.offset > (height - kToolbarHeight - 100);
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
    //var appBarHeight = Provider.of<GlobalSizes>(context).getAppBarHeight;

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
                toolbarHeight: 90,
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
                    Tab(icon: Icon(MdiIcons.graph)),
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
