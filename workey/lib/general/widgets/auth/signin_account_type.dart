import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/personal_account_model.dart';
import 'package:workey/general/providers/feed_list.dart';
import 'package:workey/general/providers/monthly_shift_summery_list.dart';
import 'package:workey/general/providers/shifts.dart';

import '../../../general/providers/company_groups.dart';
import '../../../general/screens/auth_screen.dart';
import '../../../general/widgets/auth/waiting_screen.dart';
import '../../../company_account/screens/tabs_screen.dart';
import '../../../general/widgets/auth/signup_type.dart';
import '../../../personal_account/screens/personal_tabs_screen.dart';
import '../../providers/auth.dart';

class SignInAccountType extends StatefulWidget {
  @override
  _SignInAccountTypeState createState() => _SignInAccountTypeState();
}

class _SignInAccountTypeState extends State<SignInAccountType> {
  AccountTypeChosen accountTypeChosen;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final _companyGroupsProvider =
        Provider.of<CompanyGroups>(context, listen: false);
    final _feedProvider = Provider.of<FeedList>(context, listen: false);
    final _shiftsProvider = Provider.of<Shifts>(context, listen: false);
    final _monthlyProvider =
        Provider.of<MonthltShiftSummeryList>(context, listen: false);

    final _auth = Provider.of<Auth>(context, listen: false);

    Future<void> findAccountType() async {
      User user = FirebaseAuth.instance.currentUser;
      _auth.findCurrAccountType(user).then(
        (accountType) async {
          accountTypeChosen = accountType;
          await _auth.getCurrUserData();
          if (accountTypeChosen == AccountTypeChosen.company) {
            await _shiftsProvider.fetchAndSetToListForCompany();
            await _companyGroupsProvider.fetchAndSetToLists(true);
            await _feedProvider.fetchAndSetToList(_auth.user.uid);
            await _monthlyProvider.fetchAndSetToListForCompany();
          } else if (accountTypeChosen == AccountTypeChosen.personal) {
            final personalAccountModel =
                _auth.getDynamicUser as PersonalAccountModel;
            await _feedProvider
                .fetchAndSetToList(personalAccountModel.companyId);
            await _shiftsProvider
                .fetchAndSetToListForPersonal(personalAccountModel.companyId);
            await _companyGroupsProvider.fetchAndSetToLists(false);
            await _monthlyProvider.fetchAndSetToListForPersonal(
                personalAccountModel.companyId, _auth.user.uid);
          }
          setState(() {
            _isLoading = false;
          });
        },
      );
    }

    return Scaffold(
      body: _isLoading == true
          ? WaitingScreen(findAccountType)
          : accountTypeChosen == AccountTypeChosen.company
              ? TabsScreen()
              : accountTypeChosen == AccountTypeChosen.personal
                  ? PersonalTabsScreen()
                  : AuthScreen(),
    );
  }
}
