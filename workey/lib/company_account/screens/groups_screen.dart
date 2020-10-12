import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:workey/company_account/widgets/groups_tab_bar.dart';
import 'package:workey/company_account/widgets/groups_top_view.dart';
import 'package:workey/general/models/company_account_model.dart';
import 'package:workey/general/models/work_group_model.dart';
import 'package:workey/general/providers/auth.dart';
import 'package:workey/general/providers/company_groups.dart';

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  bool _isLoading = false;
  CompanyAccountModel _companyAccount;
  var _loadOnce = false;

  void getUserData(auth) async {
    _loadOnce = true;
    setState(() {
      _isLoading = true;
    });

    _companyAccount = await auth.getCurrUserData() as CompanyAccountModel;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);

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
