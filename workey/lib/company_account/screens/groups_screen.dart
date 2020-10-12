import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:workey/company_account/widgets/groups_tab_bar.dart';
import 'package:workey/company_account/widgets/groups_top_view.dart';
import 'package:workey/general/models/company_account_model.dart';
import 'package:workey/general/models/work_group_model.dart';
import 'package:workey/general/providers/auth.dart';

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  bool _isLoading = false;
  CompanyAccountModel _companyAccount;
  WorkGroupModel _currentWorkGroup;
  var _loadOnce = false;

  void getUserData(auth) async {
    _loadOnce = true;
    setState(() {
      _isLoading = true;
    });

    _companyAccount = await auth.getCurrUserData() as CompanyAccountModel;
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
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onMessage: (message) {
        print(message);
        return;
      },
      onLaunch: (message) {
        print(message);
        return;
      },
      onResume: (message) {
        print(message);
        return;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    if (!_loadOnce) {
      getUserData(_auth);
    }

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                height: constraints.maxHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: GroupsTopView(
                        constraints.maxHeight * 0.25,
                        constraints.maxWidth,
                        _companyAccount,
                        _currentWorkGroup,
                      ),
                    ),
                    Container(
                      height: constraints.maxHeight * 0.75,
                      child: GroupsTabBar(),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
