import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/providers/company_groups.dart';

import '../widgets/auth/auth_form.dart';
import '../providers/auth.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _submitAuthForm(
    String email,
    String password,
    Function updateLoadingStatus,
    BuildContext ctx,
  ) async {
    updateLoadingStatus(true);
    var message = 'An error occurred, please check your credentials!';
    ;
    try {
      await Provider.of<Auth>(context, listen: false).signin(
        email,
        password,
      );
      await Provider.of<CompanyGroups>(context, listen: false).getUserId();
    } on PlatformException catch (err) {
      if (err.message != null) {
        updateLoadingStatus(false);
        print(err.message.toString());
        message = err.message;
      }
    } catch (err) {
      updateLoadingStatus(false);
      print(err.toString());
      if (err.toString().contains('The password is invalid')) {
        message = 'Invalid Password';
      } else if (err.toString().contains('There is no user record')) {
        message = 'Invalid Email';
      }
    }
    Scaffold.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(ctx).errorColor,
      ),
    );
    updateLoadingStatus(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: AuthForm(_submitAuthForm),
      ),
    );
  }
}
