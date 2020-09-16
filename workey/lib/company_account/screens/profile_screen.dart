import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/company_account_model.dart';

import '../../general/providers/auth.dart';
import 'profile_screens/general_settings_screen.dart';
import 'profile_screens/payment_info_screen.dart';
import 'profile_screens/personal_info_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CompanyAccountModel userData;

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            color: Theme.of(context).primaryColor,
            child: TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: Theme.of(context).accentColor,
              indicatorColor: Theme.of(context).accentColor,
              tabs: [
                Tab(icon: Icon(Icons.person_outline)),
                Tab(icon: Icon(Icons.payment)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            PersonalInfoScreen(_auth),
            PaymentInfoScreen(),
            GeneralSettingsScreen(),
          ],
        ),
      ),
    );
  }
}
