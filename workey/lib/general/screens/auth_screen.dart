import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/shift_model.dart';
import 'package:workey/general/providers/company_groups.dart';
import 'package:workey/general/providers/shifts.dart';

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
    try {
      await Provider.of<Auth>(context, listen: false).signin(
        email,
        password,
      );
      await Provider.of<CompanyGroups>(context, listen: false).getUserId();
      ShiftModel shiftModel = ShiftModel(
          date: DateTime.now(),
          startTime: DateTime.now(),
          endTime: DateTime.now().add(Duration(minutes: 800)));
      await Provider.of<Shifts>(context, listen: false)
          .addToFirebaseAndList(shiftModel, 'eSGvvbiuEhQiLkOOckj3acTZF9H2');
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        updateLoadingStatus(false);
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (err) {
      updateLoadingStatus(false);
      print(err);
    }
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
