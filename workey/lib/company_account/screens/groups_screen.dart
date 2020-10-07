import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'groups_screen_pages/employees_list.dart';
import 'groups_screen_pages/settings_view.dart';
import 'groups_screen_pages/sub_groups_list.dart';
import '../../general/providers/company_groups.dart';
import '../../general/providers/auth.dart';
import '../../general/models/company_account_model.dart';
import '../../general/models/work_group_model.dart';

import 'package:workey/general/widgets/profile_picture.dart';

class GroupsScreen extends StatefulWidget {
  final Auth auth;

  GroupsScreen(this.auth);

  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  CompanyAccountModel _companyAccount;
  var _isLoading = false;
  WorkGroupModel _currentWorkGroup;
  //File _pickedImage;

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

  // void _selectImage(File pickedImage) {
  //   _pickedImage = pickedImage;
  // }

  void getUserData() async {
    setState(() {
      _isLoading = true;
    });
    _companyAccount =
        await widget.auth.getCurrUserData() as CompanyAccountModel;
    _currentWorkGroup = WorkGroupModel(
      workGroupName: _companyAccount.companyName,
      dateOfCreation: _companyAccount.dateOfCreation,
      logo: _companyAccount.companyLogo,
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getUserData();
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentWorkGroup =
        Provider.of<CompanyGroups>(context).getCurrentWorkGroup;

    if (currentWorkGroup != null) {
      _currentWorkGroup = currentWorkGroup;
    }

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : DefaultTabController(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: ProfilePicture(
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.14,
                                          isEditable: false,
                                          imageUrl: _currentWorkGroup == null
                                              ? _companyAccount.companyLogo
                                              : _currentWorkGroup.logo,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 22,
                                        ),
                                        child: currentWorkGroup == null
                                            ? Text(_companyAccount.companyName)
                                            : Text(
                                                _currentWorkGroup.workGroupName,
                                              ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                          bottom: 45,
                                        ),
                                        child: ProfilePicture(
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.14,
                                          isEditable: false,
                                          imageUrl: _currentWorkGroup == null
                                              ? _companyAccount.companyLogo
                                              : _currentWorkGroup.logo,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 40,
                                        ),
                                        child: currentWorkGroup == null
                                            ? Text(_companyAccount.companyName)
                                            : Text(
                                                _currentWorkGroup.workGroupName,
                                              ),
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
                          Tab(icon: Icon(Icons.group_work)),
                          Tab(icon: Icon(Icons.people)),
                          Tab(icon: Icon(Icons.settings)),
                        ],
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    SubGroupsList(_isShrink),
                    EmployeesList(),
                    SettingsView(),
                  ],
                ),
              ),
            ),
          );
  }
}
