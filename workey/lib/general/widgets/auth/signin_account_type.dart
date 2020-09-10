import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/screens/auth_screen.dart';
import 'package:workey/general/widgets/auth/waiting_screen.dart';

import '../../../company_account/screens/tabs_screen.dart';
import '../../../general/screens/splash_screen.dart';
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
    final _auth = Provider.of<Auth>(context, listen: false);

    Future<void> findAccountType() async {
      await FirebaseAuth.instance.currentUser().then(
        (user) {
          _auth.findCurrAccountType(user).then(
            (accountType) {
              accountTypeChosen = accountType;
              print('$accountType ----- findAccountType!');
              setState(() {
                _isLoading = false;
              });
            },
          );
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
