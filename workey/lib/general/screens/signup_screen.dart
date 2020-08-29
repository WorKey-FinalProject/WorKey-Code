import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:workey/general/widgets/auth/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    void _submitAuthForm(
      String email,
      String password,
      String firstName,
      String lastName,
      BuildContext ctx,
      AccountTypeChosen accountTypeChosen,
    ) async {
      try {
        AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (accountTypeChosen == AccountTypeChosen.company) {
          await Firestore.instance
              .collection('users')
              .document(authResult.user.uid)
              .setData(
            {
              'email': email,
              'firstName': firstName,
              'lastName': lastName,
            },
          );
        }
        if (accountTypeChosen == AccountTypeChosen.personal) {
          await Firestore.instance
              .collection('users')
              .document(authResult.user.uid)
              .setData(
            {
              'email': email,
              'firstName': firstName,
              'lastName': lastName,
            },
          );
        }
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
