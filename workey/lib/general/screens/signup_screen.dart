import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:workey/general/widgets/auth/signup_form.dart';
import '../providers/auth.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    // final _auth = FirebaseAuth.instance;

    void _submitAuthForm(
      String email,
      String password,
      String firstName,
      String lastName,
      BuildContext ctx,
      AccountTypeChosen accountTypeChosen,
    ) async {
      try {
        // await Provider.of<Auth>(context, listen: false).signup(
        //   email,
        //   password,
        //   firstName,
        //   lastName,
        //   accountTypeChosen,
        // );
      } on PlatformException catch (err) {
        var message = 'An error occurred, please check your credentials!';

        if (err.message != null) {
          message = err.message;
        }

        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(ctx).errorColor,
          ),
        );
      } catch (err) {
        print(err);
      }
      Navigator.of(context).pop();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SignUpForm(_submitAuthForm),
    );
  }
}
