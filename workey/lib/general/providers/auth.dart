import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workey/general/widgets/auth/signup_form.dart';

class Auth with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  final dbRef = FirebaseDatabase.instance.reference();

  Future<void> signup(
    String email,
    String password,
    String firstName,
    String lastName,
    AccountTypeChosen accountTypeChosen,
  ) async {
    AuthResult authResult = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (accountTypeChosen == AccountTypeChosen.company) {
      // await Firestore.instance
      //     .collection('users')
      //     .document(authResult.user.uid)
      //     .setData(
      //   {
      //     'email': email,
      //     'firstName': firstName,
      //     'lastName': lastName,
      //   },
      // );
      await dbRef
          .child('users')
          .child('company_accounts')
          .child(authResult.user.uid)
          .set(
        {
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
        },
      );
    }
    if (accountTypeChosen == AccountTypeChosen.personal) {
      // await Firestore.instance
      //     .collection('users')
      //     .document(authResult.user.uid)
      //     .setData(
      //   {
      //     'email': email,
      //     'firstName': firstName,
      //     'lastName': lastName,
      //   },
      // );
      await dbRef
          .child('users')
          .child('personal_accounts')
          .child(authResult.user.uid)
          .set(
        {
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
        },
      );
    }
  }

  Future<void> signin(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
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
  }
}
