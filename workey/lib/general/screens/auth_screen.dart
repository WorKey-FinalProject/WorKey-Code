import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:workey/general/widgets/auth/auth_form.dart';
import '../providers/auth.dart';
//import './signup_screen.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //final _auth = FirebaseAuth.instance;

  void _submitAuthForm(
    String email,
    String password,
    BuildContext ctx,
  ) async {
    try {
      // AuthResult authResult = await _auth.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      // await Firestore.instance
      //     .collection('users')
      //     .document(authResult.user.uid)
      //     .setData(
      //   {
      //     'email': email,
      //   },
      // );
      await Provider.of<Auth>(context, listen: false).signin(
        email,
        password,
      );
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthForm(_submitAuthForm),
    );
  }
}
